--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll
import           Text.Pandoc
import           Text.Pandoc.Highlighting
import           Skylighting (defaultSyntaxMap)
import           Skylighting.Types (SyntaxMap)
import           Skylighting.Loader (loadSyntaxesFromDir)
import           Data.Map (empty, union)


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

        match ("versions/*_versions.html" .||. "versions/*/*.version" .||. "learn_more/*_desc.html" .||. "learn_more/*/*.html") $
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
defaultCompile ctx =
                getResourceBody
                    >>= applyAsTemplate ctx
                    >>= loadAndApplyTemplate "templates/default.html" ctx
                    >>= relativizeUrls

-- copy of metadataField except the source of i
itemMetaDataField :: Item  a ->  Context a
itemMetaDataField i = Context $ \k _ _ -> do
    let id = itemIdentifier i
        empty' = noResult $ "No '" ++ k ++ "' field in metadata " ++
                "of item " ++ show id
    value <- getMetadataField id k
    maybe empty' (return . StringField) value

learnMoreCtx :: String -> Compiler (Context String)
learnMoreCtx name = do
        topic <- load  (fromFilePath ("learn_more/" ++ name ++ "_desc.html")) :: Compiler (Item String)
        elements <- chronological =<< loadAll  (fromGlob $ "learn_more/" ++ name ++ "/*.html")
        let topicCtx =
                listField "elements" (learnMoreElementsCtx topic) (return elements) `mappend`
                defaultContext
        return $ listField name topicCtx (return [topic])

learnMoreElementsCtx :: Item String -> Context String
learnMoreElementsCtx i =
    defaultContext `mappend`
    itemMetaDataField i

toolVersionsCtx :: String -> Compiler (Context String)
toolVersionsCtx name = do
        tool <- load  (fromFilePath ("versions/" ++ name ++ "_versions.html")) :: Compiler (Item String)
        packs_versions <- recentFirst =<< loadAll  (fromGlob $ "versions/" ++ name ++ "/*.version")
        let toolCtx =
                listField "versions" defaultContext (return packs_versions) `mappend`
                defaultContext
        return $ listField name toolCtx (return [tool])

pandocWriterOptions :: SyntaxMap -> WriterOptions
pandocWriterOptions syntaxAdditions = def
    {
    writerExtensions =  Ext_smart `enableExtension` pandocExtensions
    ,
    writerHighlightStyle = Just haddock
    ,
    writerSyntaxMap =  syntaxAdditions `union` defaultSyntaxMap
    }