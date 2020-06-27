{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty
import Text.Pandoc
import qualified Data.Text.Lazy as L
import qualified Data.Text.Lazy.IO as L.IO
import qualified Data.Text as T
import Control.Monad.Trans (liftIO)

main :: IO ()
main = scotty 3000 $ do
  get "/:page" $ do
    page <- param "page"
    content <- liftIO $ L.IO.readFile $ mconcat ["./test/", page, ".tex"] 
    html $ content

texToHTML :: PandocMonad m => T.Text -> m T.Text
texToHTML str = readLaTeX def str >>= writeHtml5String def