import qualified Data.Map as M
import XMonad
import XMonad.Config.Xfce
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizeScreen
import XMonad.Layout.ToggleLayouts
import XMonad.Util.Run

baseConfig = xfceConfig

myWorkSpaces = ["1", "2", "3", "4", "5", "6"]

-- Find name to put here with `xprop | grep WM_CLAS`
myManageHook = composeAll
    [ resource  =? "Do"      --> doIgnore
    , stringProperty "WM_WINDOW_ROLE" =? "gimp-toolbox-color-dialog" --> doFloat
    ]

myKeys (XConfig {modMask = modm}) = M.fromList $
    [ ((modm,               xK_p), spawn "gnome-do")
    , ((modm .|. shiftMask, xK_m), sendMessage ToggleLayout)
    , ((modm,               xK_b), sendMessage ToggleStruts)
    ]

--myLayoutHook = withNewRectangle (Rectangle 0 0 1280 720) (noBorders Full)
--recordmydesktop -x 1 -y 1 --width 1281 --height 721 -o foo.ogv
myLayoutHook = smartBorders $ toggleLayouts (avoidStruts Full) (avoidStruts (tiled ||| Mirror tiled))
    where
        tiled = Tall nmaster delta ratio
        nmaster = 1
        ratio = 6/10
        delta = 3/100
        d = 20
        shrink = resizeHorizontal d . resizeHorizontalRight d . resizeVertical d . resizeVerticalBottom d

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

main = do
    --pipe <- spawnPipe "dzen2 -w 500 -ta l -y 0 -fg '#777777' -bg '#222222' -fn 'monospace:bold:size=11'"
    --conky <- spawnPipe "conky -c ~/.xmonad/conkyrc | dzen2 -x 500 -ta r -y 0 -fg '#777777' -bg '#222222' -fn 'monospace:bold:size=11'"
    --safeSpawn "stalonetray" ["-d", "all", "-p", "-t"]
    xmonad baseConfig {
        --logHook            = dynamicLogWithPP $ dzenStuff pipe,
        manageHook         = manageDocks <+> myManageHook <+> manageHook baseConfig,
        --handleEventHook    = docksEventHook <+> handleEventHook baseConfig,
        layoutHook         = myLayoutHook,
        keys               = \c -> myKeys c `M.union` keys baseConfig c,
        workspaces         = myWorkSpaces,
        startupHook        = setWMName "LG3D",
        borderWidth        = 2,
        focusedBorderColor = "#3399ff"
    }
