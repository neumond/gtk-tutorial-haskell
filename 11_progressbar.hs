import Graphics.UI.Gtk

progressTimeout check bar = do
    a <- toggleButtonGetActive check
    if a then do
        progressBarPulse bar
    else do
        newVal <- progressBarGetFraction bar
        let newVal2 = newVal + 0.01
        let newVal3 = if newVal2 > 1 then 0 else newVal2
        progressBarSetFraction bar newVal3
    return True

toggleShowText bar = do
    text <- progressBarGetText bar
    let text2 = if text == Nothing || text == Just "" then "some text" else ""
    progressBarSetText bar text2

toggleActivityMode check bar = do
    a <- toggleButtonGetActive check
    if a then do
        progressBarPulse bar
    else do
        progressBarSetFraction bar 0

toggleOrientation bar = do
    o <- progressBarGetOrientation bar
    let o2 = if o == ProgressLeftToRight then ProgressRightToLeft else ProgressLeftToRight
    progressBarSetOrientation bar o2

destroyProgress timer = do
    timeoutRemove timer
    mainQuit

main :: IO()
main = do
    initGUI
    window <- windowNew
    windowSetResizable window True
    windowSetTitle window "GtkProgressBar"
    containerSetBorderWidth window 0

    vbox <- vBoxNew False 5
    containerSetBorderWidth vbox 10
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
