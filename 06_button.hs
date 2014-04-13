import Graphics.UI.Gtk
import Control.Monad.Trans(liftIO)

xpmLabelBox :: String -> String -> IO HBox
xpmLabelBox xpmFilename labelText = do
    box <- hBoxNew False 0
    containerSetBorderWidth box 2

    image <- imageNewFromFile xpmFilename
    label <- labelNew $ Just labelText

    boxPackStart box image PackNatural 3
    boxPackStart box label PackNatural 3

    widgetShow image
    widgetShow label

    return box


helloAgainCallback b = do
    putStrLn $ "Hello again - " ++ b ++ " was pressed"


deleteEventHandler = do
    mainQuit
    return False


main :: IO()
main = do
    initGUI

    window <- windowNew
    windowSetTitle window "Pixmap'd Buttons!"
    on window deleteEvent $ liftIO deleteEventHandler
    on window objectDestroy $ mainQuit
    containerSetBorderWidth window 10

    button <- buttonNew
    on button buttonActivated $ helloAgainCallback "cool button"

    box <- xpmLabelBox "fileopen.gif" "cool button"
    widgetShow box
    containerAdd button box
    widgetShow button
    containerAdd window button
    widgetShow window

    mainGUI
