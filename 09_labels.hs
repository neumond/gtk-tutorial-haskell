import Graphics.UI.Gtk

main :: IO()
main = do
    initGUI

    window <- windowNew
    on window objectDestroy mainQuit
    set window [windowTitle := "Label"]

    vbox <- vBoxNew False 5
    hbox <- hBoxNew False 5
    containerAdd window hbox
    boxPackStart hbox vbox PackNatural 0
    set window [containerBorderWidth := 5]

    frame <- frameNew
    set frame [frameLabel := "Normal Label"]
    label <- labelNew (Just "This is a Normal label")
    containerAdd frame label
    boxPackStart vbox frame PackNatural 0

    frame <- frameNew
    set frame [frameLabel := "Multi-line Label"]
    label <- labelNew (Just "This is a Multi-line label.\nSecond line\nThird line")
    containerAdd frame label
    boxPackStart vbox frame PackNatural 0

    frame <- frameNew
    set frame [frameLabel := "Left Justified Label"]
    label <- labelNew (Just "This is a Left-Justified\nMulti-line label.\nThird      line")
    set label [labelJustify := JustifyLeft]
    containerAdd frame label
    boxPackStart vbox frame PackNatural 0

    frame <- frameNew
    set frame [frameLabel := "Right Justified Label"]
    label <- labelNew (Just "This is a Right-Justified\nMulti-line label.\nFourth line, (j/k)")
    set label [labelJustify := JustifyRight]
    containerAdd frame label
    boxPackStart vbox frame PackNatural 0


    vbox <- vBoxNew False 5
    boxPackStart hbox vbox PackNatural 0
    frame <- frameNew
    set frame [frameLabel := "Line wrapped label"]
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
    set label [labelLineWrap := True]
    containerAdd frame label
    boxPackStart vbox frame PackNatural 0

    frame <- frameNew
    set frame [frameLabel := "Filled, wrapped label"]
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
    set label [labelJustify := JustifyFill,
               labelLineWrap := True]
    containerAdd frame label
    boxPackStart vbox frame PackNatural 0

    frame <- frameNew
    set frame [frameLabel := "Underlined label"]
    label <- labelNew (Just "This label is underlined!\n\
        \This one is underlined in quite a funky fashion")
    set label [labelJustify := JustifyLeft]
    -- 25 _, then 1 space, then 1 _, then 1 space, etc
    labelSetPattern label [25,1,1,1,9,1,1,1,6,5,2,1,7,1,3]
    -- TODO: underlining not working
    containerAdd frame label
    boxPackStart vbox frame PackNatural 0

    widgetShowAll window

    mainGUI
