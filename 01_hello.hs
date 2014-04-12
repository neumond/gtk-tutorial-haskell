import Graphics.UI.Gtk

main :: IO()

main = do
    initGUI
    window <- windowNew  -- GTK_WINDOW_TOPLEVEL included
    widgetShow window
    mainGUI

-- You should kill app using shell
-- killall ghc
