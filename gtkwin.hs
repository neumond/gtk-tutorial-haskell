import Graphics.UI.Gtk
import Control.Monad.Trans(liftIO)

main :: IO()

deleteEventHandler = do
    putStrLn "Delete event occured"
    return True

destroyEventHandler = do
    mainQuit

helloClick = do
    putStrLn "Hello World!"

main = do
    initGUI
    window <- windowNew
    on window deleteEvent $ liftIO deleteEventHandler
    on window objectDestroy $ destroyEventHandler
    containerSetBorderWidth window 10
    button <- buttonNewWithLabel "Hello world"
    on button buttonActivated $ helloClick
    on button buttonActivated $ widgetDestroy window
    containerAdd window button
    widgetShowAll window
    mainGUI
