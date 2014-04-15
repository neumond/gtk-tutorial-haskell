import Graphics.UI.Gtk
import Control.Monad.Trans(liftIO)

createArrowButton arrowType shadowType = do
    button <- buttonNew
    arrow <- arrowNew arrowType shadowType
    containerAdd button arrow
    widgetShow button
    widgetShow arrow
    return button

main :: IO()
main = do
    initGUI
    window <- windowNew
    windowSetTitle window "Arrow Buttons"
    on window objectDestroy mainQuit
    containerSetBorderWidth window 10

    box <- hBoxNew False 0
    containerSetBorderWidth box 2
    containerAdd window box
    widgetShow box

    button <- createArrowButton ArrowUp ShadowIn
    boxPackStart box button PackNatural 3

    button <- createArrowButton ArrowDown ShadowOut
    boxPackStart box button PackNatural 3

    button <- createArrowButton ArrowLeft ShadowEtchedIn
    boxPackStart box button PackNatural 3

    button <- createArrowButton ArrowRight ShadowEtchedOut
    boxPackStart box button PackNatural 3

    widgetShow window

    mainGUI
