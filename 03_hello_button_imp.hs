import Graphics.UI.Gtk
import Control.Monad.Trans(liftIO)

main :: IO()

helloAgainCallback b = do
    putStrLn $ "Hello again - " ++ show b ++ " was pressed"

deleteEventHandler = do
    mainQuit
    return False

main = do
    initGUI
    window <- windowNew
    on window deleteEvent $ liftIO deleteEventHandler
    set window [containerBorderWidth := 10, windowTitle := "Hello Buttons!"]

    box1 <- hBoxNew False 0
    containerAdd window box1

    button <- buttonNewWithLabel "Button 1"
    on button buttonActivated $ helloAgainCallback "button 1"
    boxPackStart box1 button PackGrow 0
    widgetShow button

    -- Haskell     | (expand,fill) C
    -- -----------------------------
    -- PackGrow    = (True,True)
    -- PackRepel   = (True,False)
    -- PackNatural = (False,False)

    button <- buttonNewWithLabel "Button 2"
    on button buttonActivated $ helloAgainCallback "button 2"
    boxPackStart box1 button PackGrow 0
    widgetShow button

    widgetShow box1
    widgetShow window

    mainGUI
