import Graphics.UI.Gtk

progressTimeout check bar = do
    a <- get check toggleButtonActive
    if a then do
        progressBarPulse bar
    else do
        newVal <- get bar progressBarFraction
        let newVal2 = newVal + 0.01
        let newVal3 = if newVal2 > 1 then 0 else newVal2
        set bar [progressBarFraction := newVal3]
    return True

toggleShowText bar = do
    text <- get bar progressBarText
    let text2 = if text == Nothing || text == Just "" then "some text" else ""
    set bar [progressBarText := text2]

toggleActivityMode check bar = do
    a <- get check toggleButtonActive
    if a then do
        progressBarPulse bar
    else do
        set bar [progressBarFraction := 0]

toggleOrientation bar = do
    o <- get bar progressBarOrientation
    let o2 = if o == ProgressLeftToRight then ProgressRightToLeft else ProgressLeftToRight
    set bar [progressBarOrientation := o2]

destroyProgress timer = do
    timeoutRemove timer
    mainQuit

main :: IO()
main = do
    initGUI
    window <- windowNew
    set window [windowTitle := "GtkProgressBar",
                containerBorderWidth := 0,
                windowResizable := True]

    vbox <- vBoxNew False 5
    set vbox [containerBorderWidth := 10]
    containerAdd window vbox
    widgetShow vbox

    align <- alignmentNew 0.5 0.5 0 0
    boxPackStart vbox align PackNatural 5
    widgetShow align

    pbar <- progressBarNew
    containerAdd align pbar
    widgetShow pbar

    separator <- hSeparatorNew
    boxPackStart vbox separator PackNatural 0
    widgetShow separator

    table <- tableNew 2 3 False
    boxPackStart vbox table PackNatural 0
    widgetShow table

    check <- checkButtonNewWithLabel "Show text"
    tableAttach table check 0 1 0 1 [Expand,Fill] [Expand,Fill] 5 5
    on check buttonActivated $ toggleShowText pbar
    widgetShow check

    check <- checkButtonNewWithLabel "Activity mode"
    tableAttach table check 0 1 1 2 [Expand,Fill] [Expand,Fill] 5 5
    on check buttonActivated $ toggleActivityMode check pbar
    widgetShow check

    timer <- timeoutAdd (progressTimeout check pbar) 100
    on window objectDestroy $ destroyProgress timer

    check <- checkButtonNewWithLabel "Right to Left"
    tableAttach table check 0 1 2 3 [Expand,Fill] [Expand,Fill] 5 5
    on check buttonActivated $ toggleOrientation pbar
    widgetShow check

    button <- buttonNewWithLabel "close"
    on button buttonActivated $ widgetDestroy window
    boxPackStart vbox button PackNatural 0
    set button [widgetCanDefault := True]
    widgetGrabDefault button
    widgetShow button

    widgetShow window

    mainGUI
