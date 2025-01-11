default_border normal 3

set $mod Mod1

font pango:monospace 8
floating_modifier $mod

bindsym $mod+Return exec xfce4-terminal

bindsym $mod+Shift+c kill

bindsym $mod+p exec rlselect-launch

bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

bindsym $mod+space split toggle

bindsym $mod+Shift+m fullscreen toggle

bindsym $mod+Shift+space layout toggle all

bindsym $mod+f focus mode_toggle
bindsym $mod+Shift+f floating toggle

bindsym $mod+1 workspace 1
bindsym $mod+2 workspace 2
bindsym $mod+3 workspace 3
bindsym $mod+4 workspace 4
bindsym $mod+5 workspace 5
bindsym $mod+6 workspace 6
bindsym $mod+7 workspace 7
bindsym $mod+8 workspace 8
bindsym $mod+9 workspace 9
bindsym $mod+0 workspace 10

bindsym $mod+Shift+1 move container to workspace 1
bindsym $mod+Shift+2 move container to workspace 2
bindsym $mod+Shift+3 move container to workspace 3
bindsym $mod+Shift+4 move container to workspace 4
bindsym $mod+Shift+5 move container to workspace 5
bindsym $mod+Shift+6 move container to workspace 6
bindsym $mod+Shift+7 move container to workspace 7
bindsym $mod+Shift+8 move container to workspace 8
bindsym $mod+Shift+9 move container to workspace 9
bindsym $mod+Shift+0 move container to workspace 10

bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

mode "resize" {
    bindsym h resize shrink width 10 px or 10 ppt
    bindsym j resize grow height 10 px or 10 ppt
    bindsym k resize shrink height 10 px or 10 ppt
    bindsym l resize grow width 10 px or 10 ppt
    bindsym Return mode "default"
    bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"
bindsym $mod+Shift+u exec i3lock

bar {
    # RL_DOTFILE_BAR_OUTPUT
    status_command ~/bin/my-i3-status
    font pango:monospace 11
    tray_padding 0
    colors {
        background #002b36
    }
}

exec_always xmodmap ~/.Xmodmap
exec redshift-gtk -l 59.33:18.05
exec dunst
exec nm-applet

# Find name to put here with `xprop | grep WM_CLAS`
for_window [class="Git-cola"] fullscreen enable
for_window [class="git-cola"] fullscreen enable
for_window [class="Gitk"] fullscreen enable
for_window [class="Kompare"] fullscreen enable
for_window [class="Qct"] fullscreen enable
for_window [class="Hgk"] fullscreen enable
for_window [class="Rlselect"] floating toggle
for_window [class="Meld"] fullscreen enable
for_window [class="Timeline.py"] floating enable

workspace 1 output HDMI-1
workspace 2 output HDMI-1
workspace 3 output HDMI-1
workspace 4 output HDMI-1
