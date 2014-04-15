import Graphics.UI.Gtk
import Control.Monad.Trans(liftIO)

main :: IO()
main = do
    initGUI

    window <- windowNew
    on window objectDestroy mainQuit
    windowSetTitle window "Label"

    vbox <- vBoxNew False 5
    hbox <- hBoxNew False 5
    containerAdd window hbox
    boxPackStart hbox vbox PackNatural 0
    containerSetBorderWidth window 5

    frame <- frameNew
    frameSetLabel frame "Normal Label"
    label <- labelNew (Just "This is a Normal label")
    containerAdd frame label
    boxPackStart vbox frame PackNatural 0

    frame <- frameNew
    frameSetLabel frame "Multi-line Label"
    label <- labelNew (Just "This is a Multi-line label.\nSecond line\nThird line")
    containerAdd frame label
    boxPackStart vbox frame PackNatural 0

    frame <- frameNew
    frameSetLabel frame "Left Justified Label"
    label <- labelNew (Just "This is a Left-Justified\nMulti-line label.\nThird      line")
    labelSetJustify label JustifyLeft
    containerAdd frame label
    boxPackStart vbox frame PackNatural 0

    frame <- frameNew
    frameSetLabel frame "Right Justified Label"
    label <- labelNew (Just "This is a Right-Justified\nMulti-line label.\nFourth line, (j/k)")
    labelSetJustify label JustifyRight
    containerAdd frame label
    boxPackStart vbox frame PackNatural 0


    vbox <- vBoxNew False 5
    boxPackStart hbox vbox PackNatural 0
    frame <- frameNew
    frameSetLabel frame "Line wrapped label"
    label <- labelNew (Just "This is an example of a line-wrapped label.  It \
        \should not be taking up the entire             \
        \width allocated to it, but automatically \
        \wraps the words to fit.  \
        \The time has come, for all good men, to come to \
        \the aid of their party.  \
        \The sixth sheik's six sheep's sick.\n\
        \     It supports multiple paragraphs correctly, \
        \and  correctly   adds \
        \many          extra  spaces. ")
    labelSetLineWrap label True
    containerAdd frame label
    boxPackStart vbox frame PackNatural 0

    frame <- frameNew
    frameSetLabel frame "Filled, wrapped label"
    label <- labelNew (Just "This is an example of a line-wrapped, filled label.  \
        \It should be taking \
        \up the entire              width allocated to it.  \
        \Here is a sentence to prove \
        \my point.  Here is another sentence. \
        \Here comes the sun, do de do de do.\n\
        \    This is a new paragraph.\n\
        \    This is another newer, longer, better \
        \paragraph.  It is coming to an end, \
        \unfortunately.")
    labelSetJustify label JustifyFill
    labelSetLineWrap label True
    containerAdd frame label
    boxPackStart vbox frame PackNatural 0

    frame <- frameNew
    frameSetLabel frame "Underlined label"
    label <- labelNew (Just "This label is underlined!\n\
        \This one is underlined in quite a funky fashion")
    labelSetJustify label JustifyLeft
    -- 25 _, then 1 space, then 1 _, then 1 space, etc
    labelSetPattern label [25,1,1,1,9,1,1,1,6,5,2,1,7,1,3]
    -- TODO: underlining not working
    containerAdd frame label
    boxPackStart vbox frame PackNatural 0

    widgetShowAll window

    mainGUI
