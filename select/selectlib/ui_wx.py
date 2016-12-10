import wx


def wx_ui_run(config, controller):
    app = MyApp()
    main_frame = WxCurses(app, config, controller)
    main_frame.Show()
    app.MainLoop()
    return app.get_result()


class MyApp(wx.App):

    def __init__(self):
        wx.App.__init__(self, False)
        self.set_result(None)

    def set_result(self, result):
        self._result = result

    def get_result(self):
        return self._result


class WxCurses(wx.Frame):

    def __init__(self, app, config, controller):
        wx.Frame.__init__(self, None, size=config.get_gui_size())
        self._screen = WxScreen(self, app, config, controller)


class WxScreen(wx.Panel):

    def __init__(self, parent, app, config, controller):
        wx.Panel.__init__(self, parent, style=wx.NO_BORDER | wx.WANTS_CHARS)
        self._app = app
        self._config = config
        self._controller = controller
        self._surface_bitmap = None
        self._commands = []
        self._init_fonts()
        self.SetBackgroundStyle(wx.BG_STYLE_CUSTOM)
        self.Bind(wx.EVT_CHAR, self._on_key_down)
        self.Bind(wx.EVT_PAINT, self._on_paint)
        wx.CallAfter(self._after_init)

    def _after_init(self):
        self._controller.setup(self)
        self._controller.render(self)

    def getmaxyx(self):
        ww, wh = self.GetSizeTuple()
        max_y = int(wh) / int(self._fh)
        max_x = int(ww) / int(self._fw)
        return (max_y, max_x)

    def erase(self):
        self._commands = []

    def addstr(self, y, x, text, style):
        self._commands.append((y, x, text, style))

    def refresh(self):
        width, height = self.GetSizeTuple()
        self._surface_bitmap = wx.EmptyBitmap(width, height)
        memdc = wx.MemoryDC()
        memdc.SelectObject(self._surface_bitmap)
        memdc.BeginDrawing()
        memdc.SetBackground(wx.Brush(
            self._config.get_rgb("BACKGROUND"), wx.SOLID
        ))
        memdc.SetBackgroundMode(wx.PENSTYLE_SOLID)
        memdc.Clear()
        for (y, x, text, style) in self._commands:
            if style == "highlight":
                memdc.SetFont(self._base_font_bold)
                fg = self._config.get_rgb(self._config.get_highlight_fg())
                bg = self._config.get_rgb(self._config.get_highlight_bg())
            elif style == "select":
                memdc.SetFont(self._base_font_bold)
                fg = self._config.get_rgb(self._config.get_selection_fg())
                bg = self._config.get_rgb(self._config.get_selection_bg())
            elif style == "status":
                memdc.SetFont(self._base_font_bold)
                fg = self._config.get_rgb("BACKGROUND")
                bg = self._config.get_rgb("FOREGROUND")
            else:
                memdc.SetFont(self._base_font)
                fg = self._config.get_rgb("FOREGROUND")
                bg = self._config.get_rgb("BACKGROUND")
            memdc.SetTextBackground(bg)
            memdc.SetTextForeground(fg)
            memdc.DrawText(text, x*self._fw, y*self._fh)
        memdc.EndDrawing()
        del memdc
        self.Refresh()
        self.Update()

    def _init_fonts(self):
        self._base_font = wx.Font(
            self._config.get_gui_font_size(),
            wx.FONTFAMILY_TELETYPE,
            wx.FONTSTYLE_NORMAL,
            wx.FONTWEIGHT_NORMAL
        )
        self._base_font_bold = self._base_font.Bold()
        self._find_text_size()

    def _find_text_size(self):
        bitmap = wx.EmptyBitmap(100, 100)
        memdc = wx.MemoryDC()
        memdc.SetFont(self._base_font)
        memdc.SelectObject(bitmap)
        self._fw, self._fh = memdc.GetTextExtent(".")

    def _on_key_down(self, evt):
        result = self._controller.process_input(unichr(evt.GetUnicodeKey()))
        if result:
            self._app.set_result(result)
            self.GetParent().Close()
        self._controller.render(self)

    def _on_paint(self, event):
        dc = wx.AutoBufferedPaintDC(self)
        dc.BeginDrawing()
        if self._surface_bitmap:
            dc.DrawBitmap(self._surface_bitmap, 0, 0, True)
        dc.EndDrawing()
