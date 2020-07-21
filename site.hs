--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Data.Bifunctor (first)
import           Control.Monad (forM)
import           Control.Applicative (empty)
import           Hakyll
import           Text.Pandoc
import           Text.Pandoc.Highlighting
import           Skylighting (defaultSyntaxMap)
import           Skylighting.Types (SyntaxMap)
import           Skylighting.Loader (loadSyntaxesFromDir)
import           Data.Map (empty, union, Map, lookup, fromList)


--------------------------------------------------------------------------------

main :: IO ()
main = do
    loadResult <- loadSyntaxesFromDir "syntax_definitions"
    let syntaxAdditions = case loadResult of
                                (Right smap) -> smap
                                (Left _) -> mempty
    hakyll $ do
        match ("assets/js/*" .||. "assets/img/*") $ do
            route   idRoute
            compile copyFileCompiler

        match "assets/css/*" $ do
            route   idRoute
            compile compressCssCompiler

        match ("versions/**" .||. "learn_more/**" .||. "link_groups/**") $
            compile getResourceBody

        match "downloads/*" $ do
            route   idRoute
            compile $ do
                packs <- toolVersionsCtx "packs"
                kics2 <- toolVersionsCtx "kics2"

                let downloadsCtx =
                        packs `mappend`
                        kics2 `mappend`
                        defaultContext

                defaultCompile downloadsCtx

        match ("imprint/*" .||. "privacy/*" ) $ do
            route   idRoute
            compile $ defaultCompile defaultContext

        match "index.html" $ do
            route idRoute
            compile $ do
                features <- learnMoreCtx "features"
                ecosystem <- learnMoreCtx "ecosystem"
                let indexCtx =
                        features `mappend`
                        ecosystem `mappend`
                        defaultContext
                defaultCompile indexCtx

        match "cpm/*.html" $ do
            route idRoute
            compile $ defaultCompile defaultContext

        match "templates/**.html" $ compile templateBodyCompiler

        match( "code/**" .||. "templates/**.md") $ do
            -- we need to tell hakyll explicitly about our dependency on custom syntax definitions
            -- otherwise hakyll won't rebuild on syntax definition changes unless using rebuild explicitly
            dep <- makePatternDependency "syntax_definitions/*.xml"
            rulesExtraDependencies [dep] $
                compile markdownCompile

--------------------------------------------------------------------------------
{-|
  The compile pipline used for markdown templates
-}
markdownCompile :: Compiler (Item String)
markdownCompile = do
   let indexCtx =  defaultContext

   getResourceBody
        >>= applyAsTemplate indexCtx
        -- the syntaxAdditions should to be added as dependencies in the rules monad outside the compile
        >>= renderPandocWith defaultHakyllReaderOptions (pandocWriterOptions syntaxAdditions)
        >>= loadAndApplyTemplate "templates/markdown.html" indexCtx
        >>= compileTemplateItem
        >>= makeItem

{-|
  The compiler pipeline used for most routs
-}
defaultCompile :: Context String -> Compiler (Item String)
defaultCompile ctx = do
                header <-  headerCtx
                footer <- footerCtx
                let templateCtx =
                        ctx `mappend`
                        footer `mappend`
                        header
                getResourceBody
                    >>= applyAsTemplate ctx
                    >>= loadAndApplyTemplate "templates/default.html" templateCtx
                    >>= relativizeUrls

{-|
  The context for the header
-}
headerCtx :: Compiler (Context String)
headerCtx = groupCtxWith defaultContext "header" "link" "link_groups/header.desc" "link_groups/header/*.link"  chronological

{-|
  The context for the footer
-}
footerCtx :: Compiler (Context String)
footerCtx = do
            ctx <- subGroupCtxWith defaultContext "footer_categories" "categorie" "links" "link_groups/footer.desc" "link_groups/footer/*.desc" (\capture -> fromGlob $ "link_groups/footer/" ++ capture ++ "/*.link") chronological
            return $ ctx `mappend` defaultContext

{-|
  Create the context for learn more section on the main page
  parameter
    - name of the section, used as the subfolder name in the learn_more folder
                         , as well as the prefix for the description file
-}
learnMoreCtx :: String -> Compiler (Context String)
learnMoreCtx name = let
        elementsName = "elements"
        descriptionPattern = fromFilePath ("learn_more/" ++ name ++ "_desc.html")
        elementPattern = fromGlob $ "learn_more/" ++ name ++ "/*.html"
    in
        groupCtxWith defaultContext name elementsName descriptionPattern elementPattern chronological

{-|
  Create the context for generating the version tables on the download page
  parameter
    - name of the tool, used as the subfolder name in the versions folder
                      , as well as the prefix for the description file
-}
toolVersionsCtx :: String -> Compiler (Context String)
toolVersionsCtx name = let
        elementsName = "versions"
        descriptionPattern = fromFilePath ("versions/" ++ name ++ "_versions.html")
        elementPattern = fromGlob $ "versions/" ++ name ++ "/*.version"
    in
        groupCtxWith defaultContext name elementsName descriptionPattern elementPattern recentFirst

{-|
  copy of metadataField,
  but uses the parameter as source for the fields
  instead of the item passed to the context function
-}
itemMetaDataField :: Item  a ->  Context a
itemMetaDataField i = Context $ \k _ _ -> do
    let id = itemIdentifier i
        empty' = noResult $ "No '" ++ k ++ "' field in metadata " ++
                "of item " ++ show id
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
groupCtxWith :: Context String -> String -> String -> Identifier -> Pattern -> ([Item String] -> Compiler [Item String]) -> Compiler (Context String)
groupCtxWith context groupName elementsName groupDescriptionPattern groupElementPattern sorting = do
        groupDesc <- load groupDescriptionPattern
        groupElements <- sorting =<< loadAll  groupElementPattern
        let listCtx =
                listField elementsName (defaultContext `mappend` itemMetaDataField groupDesc) (return groupElements) `mappend`
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
subGroupCtxWith :: Context String -> String -> String -> String -> Identifier -> Pattern -> (String -> Pattern) -> ([Item String] -> Compiler [Item String]) -> Compiler (Context String)
subGroupCtxWith context groupName subGroupName elementsName groupDescriptionPattern groupElementPattern patternFactory sorting = do
        groupDesc <- load groupDescriptionPattern
        groupElements <- sorting =<< loadAll  groupElementPattern
        subGroupElements <-  forM groupElements (\i -> do
                                                    let result = capture groupElementPattern $ itemIdentifier i
                                                    case result of
                                                        Just [capture] -> (\item -> return (i,item )) =<< sorting =<< loadAll (patternFactory capture)
                                                        _              -> Control.Applicative.empty
                                                )

        let groupCtx =  itemMetaDataField groupDesc

        let subGroupMap =  map  (\(g,items) -> (g,listField elementsName (defaultContext `mappend` itemMetaDataField g `mappend` groupCtx) (return items))) subGroupElements

        let listCtx = groupField subGroupName subGroupMap (defaultContext `mappend` groupCtx) `mappend`
                            context
        return $ listField groupName listCtx (return [groupDesc])

{-|
  Similar to listField but each item is used with the corresponding context
  parameters:
   - a name for the field
   - a list containing item context pairs
   - a base context
-}
groupField :: String -> [(Item a , Context a)] -> Context a -> Context b
groupField key contextMap base = let
        contextMap' = map (first itemIdentifier) contextMap
        items        = map fst contextMap
    in listField key (Context $ \k a i ->
        case Prelude.lookup (itemIdentifier i) contextMap' of
            Nothing -> Control.Applicative.empty
            Just ctx -> unContext (ctx `mappend` base) k a i
    ) (return items)

{-|
  The pandoc options used with a parameter to override  default syntax definitions or add new ones
-}
pandocWriterOptions :: SyntaxMap -> WriterOptions
pandocWriterOptions syntaxAdditions = def
    {
    writerExtensions =  Ext_smart `enableExtension` pandocExtensions
    ,
    writerHighlightStyle = Just haddock
    ,
    writerSyntaxMap =  syntaxAdditions `union` defaultSyntaxMap
    }