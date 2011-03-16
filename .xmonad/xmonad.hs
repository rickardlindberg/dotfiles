import XMonad
import XMonad.Actions.SpawnOn
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Layout
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.Maximize
import XMonad.Layout.IM
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.ManageHook
import XMonad.Config.Gnome
import System.Exit

import qualified Data.Map as M

myWorkSpaces = ["1", "2", "3", "4", "5", "6"]

-- Find name to put here with `xprop | grep WM_CLAS`
myManageHook = composeAll
    [ resource  =? "Do"      --> doIgnore
    , className =? "Kompare" --> doFullFloat
    , className =? "Hgk"     --> doFullFloat
    ]

myKeys (XConfig {modMask = modm}) = M.fromList $
    [ ((modm,               xK_p), spawn "gnome-do")
    , ((modm .|. shiftMask, xK_m), sendMessage ToggleLayout)
    ]

myLayoutHook = avoidStruts (smartBorders (toggleLayouts Full (tiled ||| Mirror tiled)))
    where
        tiled = Tall nmaster delta ratio
        nmaster = 1
        ratio = 6/10
        delta = 3/100

main = xmonad gnomeConfig {
    manageHook         = manageHook gnomeConfig <+> myManageHook,
    layoutHook         = myLayoutHook,
    keys               = \c -> myKeys c `M.union` keys gnomeConfig c,
    workspaces         = myWorkSpaces,
    borderWidth        = 2,
    focusedBorderColor = "#f36f6f"
}
