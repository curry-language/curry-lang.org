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

groupElementsCtx :: Item String -> Context String
groupElementsCtx i =
    defaultContext `mappend`
    itemMetaDataField i

groupCtx :: String -> String -> Identifier -> Pattern -> ([Item String] -> Compiler [Item String]) -> Compiler (Context String)
groupCtx groupName elementsName groupDescriptionPattern groupElementPattern sorting = do
        groupDesc <- load groupDescriptionPattern
        groupElements <- sorting =<< loadAll  groupElementPattern
        let groupCtx =
                listField elementsName (groupElementsCtx groupDesc) (return groupElements) `mappend`
                defaultContext
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