--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
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

        match "templates/*" $ compile templateBodyCompiler

        match "code/*" $ do
            dep <- makePatternDependency "syntax_definitions/*.xml"
            rulesExtraDependencies [dep] $
                compile $ do

                   let indexCtx =  defaultContext

                   getResourceBody
                        >>= applyAsTemplate indexCtx
                        >>= renderPandocWith defaultHakyllReaderOptions (pandocWriterOptions syntaxAdditions)
                        >>= compileTemplateItem
                        >>= makeItem

--------------------------------------------------------------------------------

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

headerCtx = groupCtx "header" "link" "link_groups/header.desc" "link_groups/header/*.link"  chronological
footerCtx = do

        footer          <- load "link_groups/footer.desc"
        documentation   <- groupCtx "categorie" "links" "link_groups/footer/documentation.desc"   "link_groups/footer/documentation/*.link" chronological
        implementations <- groupCtx "categorie" "links" "link_groups/footer/implementations.desc" "link_groups/footer/implementations/*.link" chronological
        libraries       <- groupCtx "categorie" "links" "link_groups/footer/libraries.desc"       "link_groups/footer/libraries/*.link" chronological
        tools           <- groupCtx "categorie" "links" "link_groups/footer/tools.desc"           "link_groups/footer/tools/*.link" chronological
        misc            <- groupCtx "categorie" "links" "link_groups/footer/misc.desc"            "link_groups/footer/misc/*.link" chronological

        categories <-  mapM makeItem [documentation,implementations,libraries,tools,misc]

        return $
            listField "footer" (fieldContext "categories" footer) (return categories) `mappend`
            defaultContext

fieldContext :: String -> Item a -> Context (Context a)
fieldContext key item = Context $ \k _ i -> if k == key then return $ ListField (itemBody i) [item] else fail $ "Invalid key " ++ k


learnMoreCtx :: String -> Compiler (Context String)
learnMoreCtx name = let
        elementsName = "elements"
        descriptionPattern = fromFilePath ("learn_more/" ++ name ++ "_desc.html")
        elementPattern = fromGlob $ "learn_more/" ++ name ++ "/*.html"
    in
        groupCtx name elementsName descriptionPattern elementPattern chronological

toolVersionsCtx :: String -> Compiler (Context String)
toolVersionsCtx name = let
        elementsName = "versions"
        descriptionPattern = fromFilePath ("versions/" ++ name ++ "_versions.html")
        elementPattern = fromGlob $ "versions/" ++ name ++ "/*.version"
    in
        groupCtx name elementsName descriptionPattern elementPattern recentFirst

-- copy of metadataField except the source of i
itemMetaDataField :: Item  a ->  Context a
itemMetaDataField i = Context $ \k _ _ -> do
    let id = itemIdentifier i
        empty' = noResult $ "No '" ++ k ++ "' field in metadata " ++
                "of item " ++ show id
    value <- getMetadataField id k
    maybe empty' (return . StringField) value

groupCtx :: String -> String -> Identifier -> Pattern -> ([Item String] -> Compiler [Item String]) -> Compiler (Context String)
groupCtx = groupCtxWith defaultContext

groupCtxWith :: Context String -> String -> String -> Identifier -> Pattern -> ([Item String] -> Compiler [Item String]) -> Compiler (Context String)
groupCtxWith context groupName elementsName groupDescriptionPattern groupElementPattern sorting = do
        groupDesc <- load groupDescriptionPattern
        groupElements <- sorting =<< loadAll  groupElementPattern
        let groupCtx =
                listField elementsName (defaultContext `mappend` itemMetaDataField groupDesc) (return groupElements) `mappend`
                context
        return $ listField groupName groupCtx (return [groupDesc])

pandocWriterOptions :: SyntaxMap -> WriterOptions
pandocWriterOptions syntaxAdditions = def
    {
    writerExtensions =  Ext_smart `enableExtension` pandocExtensions
    ,
    writerHighlightStyle = Just haddock
    ,
    writerSyntaxMap =  syntaxAdditions `union` defaultSyntaxMap
    }