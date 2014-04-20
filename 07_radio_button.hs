import Graphics.UI.Gtk
import Control.Monad.Trans(liftIO)

deleteEventHandler = do
    mainQuit
    return False


main :: IO()
main = do
    initGUI

    window <- windowNew
    on window deleteEvent $ liftIO deleteEventHandler
    set window [windowTitle := "radio buttons", containerBorderWidth := 0]

    box1 <- vBoxNew False 0
    containerAdd window box1
    widgetShow box1

    box2 <- vBoxNew False 10
    set box2 [containerBorderWidth := 10]
    boxPackStart box1 box2 PackGrow 0
    widgetShow box2

    button <- radioButtonNewWithLabel "button1"
    boxPackStart box2 button PackGrow 0
    widgetShow button

    -- it cannot be done as in tutorial here
    group <- radioButtonGetGroup button
    button <- radioButtonNewWithLabel "button2"
    -- separate setting of group
    set button [radioButtonGroup := head group, toggleButtonActive := True]
    boxPackStart box2 button PackGrow 0
    widgetShow button

    button <- radioButtonNewWithLabelFromWidget button "button3"
    boxPackStart box2 button PackGrow 0
    widgetShow button

    separator <- hSeparatorNew
    boxPackStart box1 separator PackNatural 0
    widgetShow separator

    box2 <- vBoxNew False 10
    set box2 [containerBorderWidth := 10]
    boxPackStart box1 box2 PackNatural 0
    widgetShow box2

    button <- buttonNewWithLabel "close"
    on button buttonActivated $ mainQuit
    boxPackStart box2 button PackGrow 0
    set button [widgetCanDefault := True]
    widgetGrabDefault button
    widgetShow button
    widgetShow window

    mainGUI
