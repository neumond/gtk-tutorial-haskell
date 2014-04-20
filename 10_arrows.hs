import Graphics.UI.Gtk

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
    on window objectDestroy mainQuit
    set window [windowTitle := "Arrow Buttons", containerBorderWidth := 10]

    box <- hBoxNew False 0
    set box [containerBorderWidth := 2]
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
