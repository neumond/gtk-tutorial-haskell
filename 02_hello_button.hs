import Graphics.UI.Gtk
import Control.Monad.Trans(liftIO)

main :: IO()

helloClick = do
    putStrLn "Hello World!"

deleteEventHandler = do
    putStrLn "Delete event occured"
    return True

destroyEventHandler = do
    mainQuit

main = do
    initGUI
    window <- windowNew
    on window deleteEvent $ liftIO deleteEventHandler
    on window objectDestroy $ destroyEventHandler  -- objectDestroy instead of destroyEvent!
    set window [containerBorderWidth := 10]
    button <- buttonNewWithLabel "Hello world"

    on button buttonActivated $ helloClick
    -- buttonActivated not in deprecated, checks "clicked"

    on button buttonActivated $ widgetDestroy window
    containerAdd window button

    widgetShow button
    widgetShow window
    -- you can use just
    -- widgetShowAll window

    mainGUI
