import Graphics.UI.Gtk
import Control.Monad.Trans(liftIO)

helloAgainCallback b = do
    putStrLn $ "Hello again - " ++ show b ++ " was pressed"

deleteEventHandler = do
    mainQuit
    return False

main :: IO()
main = do
    initGUI

    window <- windowNew
    windowSetTitle window "Table"
    on window deleteEvent $ liftIO deleteEventHandler
    set window [containerBorderWidth := 20]

    table <- tableNew 2 2 True
    containerAdd window table

    button <- buttonNewWithLabel "button 1"
    on button buttonActivated $ helloAgainCallback "button 1"
    tableAttachDefaults table button 0 1 0 1
    widgetShow button

    button <- buttonNewWithLabel "button 2"
    on button buttonActivated $ helloAgainCallback "button 2"
    tableAttachDefaults table button 1 2 0 1
    widgetShow button

    button <- buttonNewWithLabel "Quit"
    on button buttonActivated $ mainQuit
    tableAttachDefaults table button 0 2 1 2
    widgetShow button

    widgetShow table
    widgetShow window

    mainGUI
