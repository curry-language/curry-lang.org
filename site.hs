--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings, PartialTypeSignatures #-}

import Control.Applicative (empty)
import Control.Monad (forM)
import Data.Bifunctor (first)
import Data.Map (Map, empty, fromList, lookup, union)
import Data.List (isInfixOf)
import Data.Monoid (mappend)
import Hakyll
import qualified Hakyll.Core.Item
import Hakyll.Core.Compiler.Internal (compilerTellDependencies)
import Skylighting (defaultSyntaxMap)
import Skylighting.Loader (loadSyntaxesFromDir)
import Skylighting.Types (SyntaxMap)
import Text.Pandoc
import Text.Pandoc.Highlighting
import qualified Text.HTML.TagSoup as TS

--------------------------------------------------------------------------------
main :: IO ()
main =
    hakyll $ do
        match ("assets/js/**" .||. "assets/img/**" .||. "assets/files/**") $ do
            route idRoute
            compile copyFileCompiler
        match "assets/css/*" $ do
            route idRoute
            compile compressCssCompiler
        match ("versions/**" .||. "learn_more/**" .||. "link_groups/**") $
            -- only used as metadata no routes needed
            compile getResourceBody
        match "downloads/*.html" $ do
            route idRoute
            compile $ do
                packs <- toolVersionsCtx "packs"
                kics2 <- toolVersionsCtx "kics2"
                let downloadsCtx =
                        packs `mappend` kics2 `mappend` defaultContext
                defaultCompile downloadsCtx
        match "index.html" $ do
            route idRoute
            compile $ do
                features <- learnMoreCtx "features"
                ecosystem <- learnMoreCtx "ecosystem"
                let indexCtx =
                        features `mappend` ecosystem `mappend` defaultContext
                defaultCompile indexCtx
        match ("imprint/index.md" .||. "privacy/index.md") defaultMarkdownRules
        match "tools/**.md" defaultMarkdownRules
        match "test/**.md" defaultMarkdownRules
        match "test/**.html" defaultHtmlRules
        match "templates/**.html" $ compile templateBodyCompiler
        match "templates/**.md" $ do
            withSyntaxAdditions <- loadSyntaxFromDir "syntax_definitions"
            compile $ withSyntaxAdditions >>= templateCompileMarkdown

--------------------------------------------------------------------------------
{-|
 The rules usually used for .html files 
-}
defaultHtmlRules :: Rules ()
defaultHtmlRules = do
    route idRoute
    compile $ defaultCompile defaultContext

{-|
 The rules usually used for .md files 
-}
defaultMarkdownRules :: Rules ()
defaultMarkdownRules = do
    route $ setExtension "html"
    withSyntaxAdditions <- loadSyntaxFromDir "syntax_definitions"
    compile $ withSyntaxAdditions >>= defaultCompileMarkdown defaultContext

{-|
  Loads additional syntax definitions from the provided directory
-}
{-
  Needs to be a rule so that we have access to preprocess for IO
  Returns the result inside an Compiler Monad to guarantee that the dependency is registered
-}
loadSyntaxFromDir :: FilePath -> Rules (Compiler SyntaxMap)
loadSyntaxFromDir dir = do
    loadResult <- preprocess $ loadSyntaxesFromDir dir
    let syntaxAdditions =
            case loadResult of
                (Right smap) -> smap
                (Left _) -> mempty
    pure $ do
        dep <- makePatternDependency $ fromGlob $ dir <> "/*.xml"
        compilerTellDependencies [dep]
        pure syntaxAdditions

{-|
  The compile pipeline used for Markdown templates.
  Takes a SyntaxMap of changed/added syntax definitions that will be used by Pandoc.
-}
templateCompileMarkdown :: SyntaxMap -> Compiler (Item Hakyll.Template)
templateCompileMarkdown syntaxAdditions = do
    let indexCtx = defaultContext
    getResourceBody >>= applyAsTemplate indexCtx >>=
        renderPandocWith
            defaultHakyllReaderOptions
            (pandocWriterOptions syntaxAdditions) >>=
        loadAndApplyTemplate "templates/markdown.html" indexCtx >>=
        compileTemplateItem >>=
        makeItem

{-|
  A version of 'defaultCompile' that works on Markdown files instead.
  Taking a SyntaxMap of changed/added syntax definitions that will be used by Pandoc.
  See 'templateCompileMarkdown' for compiling Markdown templates.
-}
defaultCompileMarkdown :: Context String -> SyntaxMap -> Compiler (Item String)
defaultCompileMarkdown ctx syntaxAdditions = do
    templateCtx <- templateContext ctx
    getResourceBody >>= applyAsTemplate ctx >>=
        renderPandocWith
            defaultHakyllReaderOptions
            (pandocWriterOptions syntaxAdditions) >>=
        loadAndApplyTemplate "templates/markdown.html" ctx >>=
        loadAndApplyTemplate "templates/default.html" templateCtx >>=
        relativizeUrls >>= markExternalLinks

{-|
  The compiler pipeline used for most routs.
  See 'defaultCompileMarkdown' for a version handling Markdown files.
-}
defaultCompile :: Context String -> Compiler (Item String)
defaultCompile ctx = do
    templateCtx <- templateContext ctx
    getResourceBody >>= applyAsTemplate ctx >>=
        loadAndApplyTemplate "templates/default.html" templateCtx >>=
        relativizeUrls >>= markExternalLinks

markExternalLinks :: Item String -> Compiler (Item String)
markExternalLinks = return . fmap markExternalLinks'

markExternalLinks' :: String -> String
markExternalLinks' = withTags marker
  where
    marker :: TS.Tag String -> TS.Tag String
    marker tag = case tag of
        TS.TagOpen "a" attr -> TS.TagOpen "a" $ markerAttributes attr
        _                   -> tag

    getAttrId :: String -> [TS.Attribute String] -> Maybe String
    getAttrId _  []                 = Nothing
    getAttrId id ((id', content):t) | id == id'
                                    = Just content
                                    | otherwise
                                    = getAttrId id t

    mapAttrId :: String ->  (String -> String) -> [TS.Attribute String] -> [TS.Attribute String]
    mapAttrId id fun list = fmap (\attr@(id', content) -> if id == id' then (id', fun content) else attr) list

    {-| 
      all internal urls are expected to be relative and normalized
      therefor an internal url should not contain // 
      external urls shpould contain // as part of the protocol specifier or be protocol relative
      e.g.  https://uni-kiel.de  or //uni-kiel.de
    -}
    isExternal :: String -> Bool
    isExternal url = "//" `isInfixOf` url

    addElement :: String -> String -> String
    addElement element c = if  (' ' : element ++ " ") `isInfixOf` (' ' : c ++ " ") then c else element ++ ' ' : c

    markerAttributes :: [TS.Attribute String] -> [TS.Attribute String]
    markerAttributes attrs =
      case getAttrId "href" attrs of
        Nothing -> attrs
        Just href ->
          if isExternal href then
            let
              -- make sure attributes rel and target exist
              attrs1 = case getAttrId "rel" attrs of
                Nothing -> ("rel", "") : attrs
                Just _  -> attrs
              attrs2 = case getAttrId "target" attrs of
                Nothing -> ("target", "") : attrs1
                Just _  -> attrs1
              -- adjust content of rel and target
              attrs3 = mapAttrId "rel"    (addElement "external" . addElement "noopener" . addElement "noreferrer") attrs2
              attrs4 = mapAttrId "target" (const "_blank") attrs3
            in attrs4
          else
            attrs

{-| 
The context used by `defaultCompile` and `defaultCompileMarkdown`
for loading and applying the default.html template

Contains the metadata used for generating the header and footer section
-}
templateContext :: Context String -> Compiler (Context String) 
templateContext ctx = do
    header <- headerCtx
    footer <- footerCtx
    let templateCtx' = ctx `mappend` footer `mappend` header
    pure templateCtx'

{-|
  The context for the header
-}
headerCtx :: Compiler (Context String)
headerCtx =
    groupCtxWith
        defaultContext
        "header"
        "link"
        "link_groups/header.desc"
        "link_groups/header/*.link"
        chronological

{-|
  The context for the footer
-}
footerCtx :: Compiler (Context String)
footerCtx = do
    ctx <-
        subGroupCtxWith
            defaultContext
            "footer_categories"
            "categorie"
            "links"
            "link_groups/footer.desc"
            "link_groups/footer/*.desc"
            (\capture ->
                 fromGlob $ "link_groups/footer/" ++ capture ++ "/*.link")
            chronological
    return $ ctx `mappend` defaultContext

{-|
  Create the context for learn more section on the main page
  parameter
    - name of the section, used as the subfolder name in the learn_more folder
                         , as well as the prefix for the description file
-}
learnMoreCtx :: String -> Compiler (Context String)
learnMoreCtx name =
    let elementsName = "elements"
        descriptionPattern =
            fromFilePath ("learn_more/" ++ name ++ "_desc.html")
        elementPattern = fromGlob $ "learn_more/" ++ name ++ "/*.html"
     in groupCtxWith
            defaultContext
            name
            elementsName
            descriptionPattern
            elementPattern
            chronological

{-|
  Create the context for generating the version tables on the download page
  parameter
    - name of the tool, used as the subfolder name in the versions folder
                      , as well as the prefix for the description file
-}
toolVersionsCtx :: String -> Compiler (Context String)
toolVersionsCtx name =
    let elementsName = "versions"
        descriptionPattern =
            fromFilePath ("versions/" ++ name ++ "_versions.html")
        elementPattern = fromGlob $ "versions/" ++ name ++ "/*.version"
     in groupCtxWith
            defaultContext
            name
            elementsName
            descriptionPattern
            elementPattern
            recentFirst

{-|
  copy of metadataField,
  but uses the parameter as source for the fields
  instead of the item passed to the context function
-}
itemMetaDataField :: Item a -> Context a
itemMetaDataField i =
    Context $ \k _ _ -> do
        let id = itemIdentifier i
            empty' =
                noResult $
                "No '" ++ k ++ "' field in metadata " ++ "of item " ++ show id
        value <- getMetadataField id k
        maybe empty' (return . StringField) value

{-|
  Create a Grouping
  parameters:
   - base context
   - main field name
   - name for the groups
   - identifier for file containing the main fields context
   - pattern for the files containing the group definitions
   - function for sorting the groups and subgroups inside their parent
-}
groupCtxWith ::
       Context String
    -> String
    -> String
    -> Identifier
    -> Pattern
    -> ([Item String] -> Compiler [Item String])
    -> Compiler (Context String)
groupCtxWith context groupName elementsName groupDescriptionPattern groupElementPattern sorting = do
    groupDesc <- load groupDescriptionPattern
    groupElements <- sorting =<< loadAll groupElementPattern
    let listCtx =
            listField
                elementsName
                (defaultContext `mappend` itemMetaDataField groupDesc)
                (return groupElements) `mappend`
            context
    return $ listField groupName listCtx (return [groupDesc])

{-|
  Create a Grouping with Subgroups
  parameters:
   - base context
   - main field name
   - name for the groups
   - name for the sub groups
   - identifier for file containing the main fields context
   - pattern for the files containing the group definitions
   - function for creating a pattern from each matched group definition file
   - function for sorting the groups and subgroups inside their parent
-}
subGroupCtxWith ::
       Context String
    -> String
    -> String
    -> String
    -> Identifier
    -> Pattern
    -> (String -> Pattern)
    -> ([Item String] -> Compiler [Item String])
    -> Compiler (Context String)
subGroupCtxWith context groupName subGroupName elementsName groupDescriptionPattern groupElementPattern patternFactory sorting = do
    groupDesc <- load groupDescriptionPattern
    groupElements <- sorting =<< loadAll groupElementPattern
    subGroupElements <-
        forM
            groupElements
            (\i -> do
                 let result = capture groupElementPattern $ itemIdentifier i
                 case result of
                     Just [capture] ->
                         (\item -> return (i, item)) =<<
                         sorting =<< loadAll (patternFactory capture)
                     _ -> Control.Applicative.empty)
    let groupCtx = itemMetaDataField groupDesc
    let subGroupMap =
            map
                (\(g, items) ->
                     ( g
                     , listField
                           elementsName
                           (defaultContext `mappend` itemMetaDataField g `mappend`
                            groupCtx)
                           (return items)))
                subGroupElements
    let listCtx =
            groupField
                subGroupName
                subGroupMap
                (defaultContext `mappend` groupCtx) `mappend`
            context
    return $ listField groupName listCtx (return [groupDesc])

{-|
  Similar to listField but each item is used with the corresponding context
  parameters:
   - a name for the field
   - a list containing item context pairs
   - a base context
-}
groupField :: String -> [(Item a, Context a)] -> Context a -> Context b
groupField key contextMap base =
    let contextMap' = map (first itemIdentifier) contextMap
        items = map fst contextMap
     in listField
            key
            (Context $ \k a i ->
                 case Prelude.lookup (itemIdentifier i) contextMap' of
                     Nothing -> Control.Applicative.empty
                     Just ctx -> unContext (ctx `mappend` base) k a i)
            (return items)

{-|
  The pandoc options used with a parameter to override  default syntax definitions or add new ones
-}
pandocWriterOptions :: SyntaxMap -> WriterOptions
pandocWriterOptions syntaxAdditions =
    def
        { writerExtensions = Ext_smart `enableExtension` pandocExtensions
        , writerHighlightStyle = Just haddock
        , writerSyntaxMap = syntaxAdditions `union` defaultSyntaxMap
        }
