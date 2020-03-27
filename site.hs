--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll


--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    match "assets/img/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "assets/js/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "assets/css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "versions/*/*.version" $ do
        compile getResourceBody

    match "downloads/*" $ do
        route   idRoute
        compile $ do
           packs_versions <- recentFirst =<< loadAll "versions/packs/*.version"
           kics2_versions <- recentFirst =<< loadAll "versions/kicks2/*.version*"
           let indexCtx =
                    listField "packs_versions" defaultContext (return packs_versions) `mappend`
                    listField "kics2_versions" defaultContext (return kics2_versions) `mappend`
                    defaultContext

           getResourceBody
               >>= applyAsTemplate indexCtx
               >>= relativizeUrls

    match "imprint/*" $ do
        route   idRoute
        compile $ do
           let indexCtx =  defaultContext

           getResourceBody
               >>= applyAsTemplate indexCtx
               >>= relativizeUrls

    match "privacy/*" $ do
        route   idRoute
        compile $ do
           let indexCtx =  defaultContext

           getResourceBody
               >>= applyAsTemplate indexCtx
               >>= relativizeUrls

    match "index.html" $ do
        route idRoute
        compile $ do
            let indexCtx =  defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler


