import Graphics.UI.Gtk

cbPosMenuSelect :: (ScaleClass s1, ScaleClass s2) => s1 -> s2 -> PositionType -> IO ()
cbPosMenuSelect hScale vScale pos = do
    set hScale [scaleValuePos := pos]
    set vScale [scaleValuePos := pos]

cbUpdateMenuSelect :: (RangeClass s1, RangeClass s2) => s1 -> s2 -> UpdateType -> IO ()
cbUpdateMenuSelect hScale vScale policy = do
    set hScale [rangeUpdatePolicy := policy]
    set vScale [rangeUpdatePolicy := policy]

cbDigitsScale hScale vScale adj = do
    v <- adjustmentGetValue adj
    let i = truncate v
    set hScale [scaleDigits := i]
    set vScale [scaleDigits := i]

clampValue v lo up
    | v < lo = lo
    | v > up = up
    | otherwise = v

cbPageSize :: Adjustment -> Adjustment -> IO ()
cbPageSize getAdj setAdj = do
    v <- get getAdj adjustmentValue
    set setAdj [adjustmentPageSize := v, adjustmentPageIncrement := v]
    value <- get setAdj adjustmentValue
    lower <- get setAdj adjustmentLower
    upper <- get setAdj adjustmentUpper
    pageSize <- get setAdj adjustmentPageSize
    set setAdj [adjustmentValue := clampValue value lower (upper - pageSize)]
    adjustmentAdjChanged setAdj

cbDrawValue hScale vScale button = do
    a <- get button toggleButtonActive
    set hScale [scaleDrawValue := a]
    set vScale [scaleDrawValue := a]

makeMenuItem :: String -> IO () -> IO MenuItem
makeMenuItem name callback = do
    item <- menuItemNewWithLabel name
    on item menuItemActivate callback
    widgetShow item
    return item

scaleSetDefaultValues scale = do
    set scale [rangeUpdatePolicy := UpdateContinuous,
               scaleDigits := 1,
               scaleValuePos := PosTop,
               scaleDrawValue := True]

deleteEventHandler = do
    mainQuit
    return False

createRangeControls = do
    window <- windowNew
    on window objectDestroy mainQuit
    set window [windowTitle := "range controls"]

    box1 <- vBoxNew False 0
    containerAdd window box1
    widgetShow box1

    box2 <- hBoxNew False 10
    set box2 [containerBorderWidth := 10]
    boxPackStart box1 box2 PackGrow 0
    widgetShow box2

    adj1 <- adjustmentNew 0 0 101 0.1 1 1

    vscale <- vScaleNew adj1
    scaleSetDefaultValues vscale
    boxPackStart box2 vscale PackGrow 0
    widgetShow vscale

    box3 <- vBoxNew False 10
    boxPackStart box2 box3 PackGrow 0
    widgetShow box3

    hscale <- hScaleNew adj1
    widgetSetSizeRequest hscale 200 (-1)
    scaleSetDefaultValues hscale
    boxPackStart box3 hscale PackGrow 0
    widgetShow hscale

    scrollbar <- hScrollbarNew adj1
    set scrollbar [rangeUpdatePolicy := UpdateContinuous]
    boxPackStart box3 scrollbar PackGrow 0
    widgetShow scrollbar

    box2 <- hBoxNew False 10
    set box2 [containerBorderWidth := 10]
    boxPackStart box1 box2 PackGrow 0
    widgetShow box2

    button <- checkButtonNewWithLabel "Display value on scale widgets"
    set button [toggleButtonActive := True]
    on button toggled $ cbDrawValue hscale vscale button
    boxPackStart box2 button PackGrow 0
    widgetShow button

    box2 <- hBoxNew False 10
    set box2 [containerBorderWidth := 10]

    label <- labelNew (Just "Scale Value Position:")
    boxPackStart box2 label PackNatural 0
    widgetShow label

    opt <- optionMenuNew
    menu <- menuNew

    item <- makeMenuItem "Top" $ cbPosMenuSelect hscale vscale PosTop
    menuShellAppend menu item
    item <- makeMenuItem "Bottom" $ cbPosMenuSelect hscale vscale PosBottom
    menuShellAppend menu item
    item <- makeMenuItem "Left" $ cbPosMenuSelect hscale vscale PosLeft
    menuShellAppend menu item
    item <- makeMenuItem "Right" $ cbPosMenuSelect hscale vscale PosRight
    menuShellAppend menu item

    optionMenuSetMenu opt menu
    boxPackStart box2 opt PackGrow 0
    widgetShow opt

    boxPackStart box1 box2 PackGrow 0
    widgetShow box2

    box2 <- hBoxNew False 10
    set box2 [containerBorderWidth := 10]

    label <- labelNew (Just "Scale Update Policy:")
    boxPackStart box2 label PackNatural 0
    widgetShow label

    opt <- optionMenuNew
    menu <- menuNew

    item <- makeMenuItem "Continuous" $ cbUpdateMenuSelect hscale vscale UpdateContinuous
    menuShellAppend menu item
    item <- makeMenuItem "Discontinuous" $ cbUpdateMenuSelect hscale vscale UpdateDiscontinuous
    menuShellAppend menu item
    item <- makeMenuItem "Delayed" $ cbUpdateMenuSelect hscale vscale UpdateDelayed
    menuShellAppend menu item

    optionMenuSetMenu opt menu
    boxPackStart box2 opt PackGrow 0
    widgetShow opt

    boxPackStart box1 box2 PackGrow 0
    widgetShow box2

    box2 <- hBoxNew False 10
    set box2 [containerBorderWidth := 10]

    label <- labelNew (Just "Scale Digits:")
    boxPackStart box2 label PackNatural 0
    widgetShow label

    adj2 <- adjustmentNew 1 0 5 1 1 0
    -- 0.12.4 only old-style signals here
    onValueChanged adj2 $ cbDigitsScale hscale vscale adj2
    scale <- hScaleNew adj2
    set scale [scaleDigits := 0]
    boxPackStart box2 scale PackGrow 0
    widgetShow scale

    boxPackStart box1 box2 PackGrow 0
    widgetShow box2

    box2 <- hBoxNew False 10
    set box2 [containerBorderWidth := 10]

    label <- labelNew (Just "Scrollbar Page Size:")
    boxPackStart box2 label PackNatural 0
    widgetShow label

    adj2 <- adjustmentNew 1 1 101 1 1 0
    -- 0.12.4 only old-style signals here
    onValueChanged adj2 $ cbPageSize adj2 adj1
    scale <- hScaleNew adj2
    set scale [scaleDigits := 0]
    boxPackStart box2 scale PackGrow 0
    widgetShow scale

    boxPackStart box1 box2 PackGrow 0
    widgetShow box2

    separator <- hSeparatorNew
    boxPackStart box1 separator PackNatural 0
    widgetShow separator

    box2 <- vBoxNew False 10
    set box2 [containerBorderWidth := 10]
    boxPackStart box1 box2 PackNatural 0
    widgetShow box2
    
    button <- buttonNewWithLabel "Quit"
    on button buttonActivated mainQuit
    boxPackStart box2 button PackGrow 0
    set button [widgetCanDefault := True]
    widgetGrabDefault button
    widgetShow button

    widgetShow window


main :: IO()
main = do
    initGUI
    createRangeControls
    mainGUI
