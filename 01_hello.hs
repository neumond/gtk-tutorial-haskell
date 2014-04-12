import Graphics.UI.Gtk
import Control.Monad.Trans(liftIO)

main :: IO()

deleteEventHandler = do
    putStrLn "Delete event occured"
    mainQuit
    return False

main = do
    initGUI
    window <- windowNew
    button <- buttonNewWithLabel "Hello world!"
    on window deleteEvent $ liftIO deleteEventHandler
    widgetShowAll window
    mainGUI
