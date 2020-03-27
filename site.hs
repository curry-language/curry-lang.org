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

    match "downloads/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "imprint/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "privacy/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "index.html" $ do
        route idRoute
        compile $ do
            let indexCtx =  defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler


