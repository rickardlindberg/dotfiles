import System.Exit
import XMonad
import XMonad.Actions.SpawnOn
import XMonad.Config.Gnome
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout
import XMonad.Layout.Circle
import XMonad.Layout.IM
import XMonad.Layout.Maximize
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Layout.ResizeScreen
import XMonad.Layout.ToggleLayouts
import XMonad.ManageHook
import XMonad.Util.Run

import qualified Data.Map as M

myWorkSpaces = ["1", "2", "3", "4", "5", "6"]

-- Find name to put here with `xprop | grep WM_CLAS`
myManageHook = composeAll
    [ resource  =? "Do"      --> doIgnore
    , className =? "Kompare" --> doFullFloat
    , className =? "Hgk"     --> doFullFloat
    , className =? "Gitk"    --> doFullFloat
    ]

myKeys (XConfig {modMask = modm}) = M.fromList $
    [ ((modm,               xK_p), spawn "gnome-do")
    , ((modm .|. shiftMask, xK_m), sendMessage ToggleLayout)
    , ((modm,               xK_b), sendMessage ToggleStruts)
    ]

--myLayoutHook = withNewRectangle (Rectangle 0 0 1280 720) (noBorders Full)
myLayoutHook = smartBorders $ toggleLayouts Full (avoidStruts (tiled ||| Mirror tiled))
    where
        tiled = Tall nmaster delta ratio
        nmaster = 1
        ratio = 6/10
        delta = 3/100
        d = 20
        shrink = resizeHorizontal d . resizeHorizontalRight d . resizeVertical d . resizeVerticalBottom d

main = do
    pipe <- spawnPipe "dzen2 -w 500 -ta l -y 0 -fg '#777777' -bg '#222222' -fn 'monospace:bold:size=11'"
    conky <- spawnPipe "conky -c ~/.xmonad/conkyrc | dzen2 -x 500 -ta r -y 0 -fg '#777777' -bg '#222222' -fn 'monospace:bold:size=11'"
    --safeSpawn "stalonetray" ["-d", "all", "-p", "-t"]
    xmonad defaultConfig {
        logHook            = dynamicLogWithPP $ dzenStuff pipe,
        manageHook         = manageDocks <+> myManageHook <+> manageHook defaultConfig,
        --handleEventHook    = docksEventHook <+> handleEventHook defaultConfig,
        layoutHook         = myLayoutHook,
        keys               = \c -> myKeys c `M.union` keys defaultConfig c,
        workspaces         = myWorkSpaces,
        borderWidth        = 2,
        focusedBorderColor = "#3399ff"
    }

dzenStuff pipe = dzenPP
    { ppOutput          = hPutStrLn pipe
    , ppCurrent         = dzenColor "#3399ff" "" . wrap " " ""
    , ppHidden          = dzenColor "#dddddd" "" . wrap " " ""
    , ppHiddenNoWindows = dzenColor "#777777" "" . wrap " " ""
    , ppUrgent          = dzenColor "#ff0000" "" . wrap " " ""
    , ppSep             = " | "
    , ppLayout          = const ""
    , ppTitle           = dzenColor "#ffffff" "" . dzenEscape
    }
