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

    match "versions/packs_versions.html" $ do
        compile getResourceBody


    match "versions/kics2_versions.html" $ do
        compile getResourceBody

    match "downloads/*" $ do
        route   idRoute
        compile $ do
            packs <- load "versions/packs_versions.html"
            packs_versions <- recentFirst =<< loadAll "versions/packs/*.version"
            let packsCtx =
                    listField "versions" defaultContext (return packs_versions) `mappend`
                    defaultContext

            kics2 <- load "versions/kics2_versions.html"
            kics2_versions <- recentFirst =<< loadAll "versions/kics2/*.version"
            let kics2Ctx =
                    listField "versions" defaultContext (return kics2_versions) `mappend`
                    defaultContext

            let indexCtx =
                    listField "packs" packsCtx (return [packs]) `mappend`
                    listField "kics2" kics2Ctx (return [kics2]) `mappend`
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
