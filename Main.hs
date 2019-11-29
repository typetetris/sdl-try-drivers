{-# LANGUAGE OverloadedStrings #-}
module Main where

import Foreign.C.Types (CInt)
import Control.Monad.IO.Class (MonadIO)
import Control.Exception (catch, SomeException)

import Text.Pretty.Simple (pPrintNoColor)
import SDL

myPPrint :: (Show a, MonadIO m) => a -> m ()
myPPrint = pPrintNoColor

checkRenderDriver :: Window -> (CInt, RendererInfo) -> IO ()
checkRenderDriver window driver = do
  maybeRenderer <- tryRenderDriver window driver
  case maybeRenderer of
    (Just renderer) -> destroyRenderer renderer
    Nothing -> return ()

tryRenderDriver :: Window -> (CInt, RendererInfo) -> IO (Maybe Renderer)
tryRenderDriver window (idx, info) = catch (do
        putStrLn "== trying driver:"
        myPPrint info
        -- if idx is given, defaultRenderer is ignored
        -- the documentation of the haskell packages sdl2 doesn't mention this
        -- but the sdl2 documentation itself does, see: https://wiki.libsdl.org/SDL_CreateRenderer
        renderer <- createRenderer window idx defaultRenderer
        putStrLn "** success"
        return (Just renderer))
        (\e -> do
                  putStrLn ("-- couldn't load driver number "  ++ show idx ++ ":")
                  myPPrint (e :: SomeException)
                  return Nothing)

checkRenderDrivers :: Window -> IO ()
checkRenderDrivers window = do
  drivers <- zip [0 ..] <$> getRenderDriverInfo
  putStrLn ("there are " ++ show (length drivers) ++ " drivers to check")
  mapM_ (checkRenderDriver window) drivers

main :: IO ()
main = do
  initializeAll
  window <- createWindow "sdl-try-drivers" defaultWindow {windowResizable = True}
  checkRenderDrivers window
  destroyWindow window

