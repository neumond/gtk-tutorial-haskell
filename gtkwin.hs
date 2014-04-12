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
    on window deleteEvent $ liftIO deleteEventHandler
    widgetShowAll window
    mainGUI
