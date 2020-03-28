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

        match ("versions/*_versions.html" .||. "versions/*/*.version" .||. "features/*.html") $ do
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
                features <- chronological =<< loadAll "features/*.html"
                let indexCtx =
                        listField "features" defaultContext (return features) `mappend`
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