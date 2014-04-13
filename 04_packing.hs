import Graphics.UI.Gtk
import Control.Monad.Trans(liftIO)
import System.Environment(getArgs)

deleteEventHandler = do
    mainQuit
    return False


makeBox :: Bool -> Int -> Packing -> Int -> IO HBox
makeBox homogeneous spacing packing padding = do
    box <- hBoxNew homogeneous spacing

    button <- buttonNewWithLabel "gtk_box_pack"
    boxPackStart box button packing padding
    widgetShow button

    button <- buttonNewWithLabel "(box,"
    boxPackStart box button packing padding
    widgetShow button

    button <- buttonNewWithLabel "button,"
    boxPackStart box button packing padding
    widgetShow button

    button <- buttonNewWithLabel $ show packing ++ ","
    boxPackStart box button packing padding
    widgetShow button

    button <- buttonNewWithLabel $ show padding ++ ");"
    boxPackStart box button packing padding
    widgetShow button

    return box


getWhich :: [String] -> Int
getWhich args
    | length args == 1 = read $ head args
    | otherwise        = error "usage: packbox num, where num is 1, 2, or 3."


main :: IO()
main = do
    initGUI

    args <- getArgs
    let which = getWhich args

    window <- windowNew
    on window deleteEvent $ liftIO deleteEventHandler
    containerSetBorderWidth window 10

    box1 <- vBoxNew False 0

    case which of
        1 -> do
            -- label can be empty (Nothing)
            label <- labelNew $ Just "gtk_hbox_new (FALSE, 0);"
            miscSetAlignment label 0 0
            boxPackStart box1 label PackNatural 0
            widgetShow label

            box2 <- makeBox False 0 PackNatural 0
            boxPackStart box1 box2 PackNatural 0
            widgetShow box2

            box2 <- makeBox False 0 PackRepel 0
            boxPackStart box1 box2 PackNatural 0
            widgetShow box2

            box2 <- makeBox False 0 PackGrow 0
            boxPackStart box1 box2 PackNatural 0
            widgetShow box2

            separator <- hSeparatorNew
            boxPackStart box1 separator PackNatural 5
            widgetShow separator

            label <- labelNew $ Just "gtk_hbox_new (TRUE, 0);"
            miscSetAlignment label 0 0
            boxPackStart box1 label PackNatural 0
            widgetShow label

            box2 <- makeBox True 0 PackRepel 0
            boxPackStart box1 box2 PackNatural 0
            widgetShow box2

            box2 <- makeBox True 0 PackGrow 0
            boxPackStart box1 box2 PackNatural 0
            widgetShow box2

            separator <- hSeparatorNew
            boxPackStart box1 separator PackNatural 5
            widgetShow separator
        2 -> do
            label <- labelNew $ Just "gtk_hbox_new (FALSE, 10);"
            miscSetAlignment label 0 0
            boxPackStart box1 label PackNatural 0
            widgetShow label

            box2 <- makeBox False 10 PackRepel 0
            boxPackStart box1 box2 PackNatural 0
            widgetShow box2

            box2 <- makeBox False 10 PackGrow 0
            boxPackStart box1 box2 PackNatural 0
            widgetShow box2

            separator <- hSeparatorNew
            boxPackStart box1 separator PackNatural 5
            widgetShow separator

            label <- labelNew $ Just "gtk_hbox_new (FALSE, 0);"
            miscSetAlignment label 0 0
            boxPackStart box1 label PackNatural 0
            widgetShow label

            box2 <- makeBox False 0 PackRepel 10
            boxPackStart box1 box2 PackNatural 0
            widgetShow box2

            box2 <- makeBox False 0 PackGrow 10
            boxPackStart box1 box2 PackNatural 0
            widgetShow box2

            separator <- hSeparatorNew
            boxPackStart box1 separator PackNatural 5
            widgetShow separator
        3 -> do
            box2 <- makeBox False 0 PackNatural 0

            label <- labelNew $ Just "end"
            boxPackEnd box2 label PackNatural 0
            widgetShow label

            boxPackStart box1 box2 PackNatural 0
            widgetShow box2

            separator <- hSeparatorNew
            widgetSetSizeRequest separator 400 5
            boxPackStart box1 separator PackNatural 5
            widgetShow separator

    quitbox <- hBoxNew False 0
    button <- buttonNewWithLabel "Quit"
    on button buttonActivated $ mainQuit

    boxPackStart quitbox button PackRepel 0
    boxPackStart box1 quitbox PackNatural 0

    containerAdd window box1

    widgetShow button
    widgetShow quitbox
    widgetShow box1
    widgetShow window

    mainGUI
