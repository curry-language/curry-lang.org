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

        match "templates/**" $ compile templateBodyCompiler

        match "code/**" $ do
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

headerCtx :: Compiler (Context String)
headerCtx = groupCtxWith defaultContext "header" "link" "link_groups/header.desc" "link_groups/header/*.link"  chronological

footerCtx :: Compiler (Context String)
footerCtx = do
            ctx <- subGroupCtxWith defaultContext "footer_categories" "categorie" "links" "link_groups/footer.desc" "link_groups/footer/*.desc" (\capture -> fromGlob $ "link_groups/footer/" ++ capture ++ "/*.link") chronological
            return $ ctx `mappend` defaultContext

learnMoreCtx :: String -> Compiler (Context String)
learnMoreCtx name = let
        elementsName = "elements"
        descriptionPattern = fromFilePath ("learn_more/" ++ name ++ "_desc.html")
        elementPattern = fromGlob $ "learn_more/" ++ name ++ "/*.html"
    in
        groupCtxWith defaultContext name elementsName descriptionPattern elementPattern chronological

toolVersionsCtx :: String -> Compiler (Context String)
toolVersionsCtx name = let
        elementsName = "versions"
        descriptionPattern = fromFilePath ("versions/" ++ name ++ "_versions.html")
        elementPattern = fromGlob $ "versions/" ++ name ++ "/*.version"
    in
        groupCtxWith defaultContext name elementsName descriptionPattern elementPattern recentFirst

-- copy of metadataField except the source of i
itemMetaDataField :: Item  a ->  Context a
itemMetaDataField i = Context $ \k _ _ -> do
    let id = itemIdentifier i
        empty' = noResult $ "No '" ++ k ++ "' field in metadata " ++
                "of item " ++ show id
    value <- getMetadataField id k
    maybe empty' (return . StringField) value

groupCtxWith :: Context String -> String -> String -> Identifier -> Pattern -> ([Item String] -> Compiler [Item String]) -> Compiler (Context String)
groupCtxWith context groupName elementsName groupDescriptionPattern groupElementPattern sorting = do
        groupDesc <- load groupDescriptionPattern
        groupElements <- sorting =<< loadAll  groupElementPattern
        let listCtx =
                listField elementsName (defaultContext `mappend` itemMetaDataField groupDesc) (return groupElements) `mappend`
                context
        return $ listField groupName listCtx (return [groupDesc])

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

        let listCtx = groupField subGroupName subGroupMap (defaultContext `mappend` groupCtx) (return groupElements) `mappend`
                            context
        return $ listField groupName listCtx (return [groupDesc])

groupField :: String -> [(Item a , Context a)] -> Context a -> Compiler [Item a] -> Context b
groupField key contextMap base = let
        contextMap' = map (first itemIdentifier) contextMap
    in listField key (Context $ \k a i ->
        case Prelude.lookup (itemIdentifier i) contextMap' of
            Nothing -> Control.Applicative.empty
            Just ctx -> unContext (base `mappend` ctx) k a i
    )

pandocWriterOptions :: SyntaxMap -> WriterOptions
pandocWriterOptions syntaxAdditions = def
    {
    writerExtensions =  Ext_smart `enableExtension` pandocExtensions
    ,
    writerHighlightStyle = Just haddock
    ,
    writerSyntaxMap =  syntaxAdditions `union` defaultSyntaxMap
    }