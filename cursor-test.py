import sys
import gi

gi.require_version("Gtk", "4.0")
from gi.repository import GLib, Gtk, Gdk

def on_activate(app):
    win = Gtk.ApplicationWindow(application=app)
    win.set_default_size(300, 300)
    grid = Gtk.Grid()

    btn = Gtk.Button(label="progress")
    btn.set_cursor_from_name("progress")
    grid.attach(btn, 0, 0, 1, 1)

    btn = Gtk.Button(label="wait")
    btn.set_cursor_from_name("wait")
    grid.attach(btn, 1, 0, 1, 1)

    btn = Gtk.Button(label="help")
    btn.set_cursor_from_name("help")
    grid.attach(btn, 2, 0, 1, 1)

    btn = Gtk.Button(label="pointer")
    btn.set_cursor_from_name("pointer")
    grid.attach(btn, 3, 0, 1, 1)

    btn = Gtk.Button(label="context-menu")
    btn.set_cursor_from_name("context-menu")
    grid.attach(btn, 4, 0, 1, 1)

    btn = Gtk.Button(label="cell")
    btn.set_cursor_from_name("cell")
    grid.attach(btn, 5, 0, 1, 1)

    btn = Gtk.Button(label="crosshair")
    btn.set_cursor_from_name("crosshair")
    grid.attach(btn, 0, 1, 1, 1)

    btn = Gtk.Button(label="text")
    btn.set_cursor_from_name("text")
    grid.attach(btn, 1, 1, 1, 1)

    btn = Gtk.Button(label="vertical-text")
    btn.set_cursor_from_name("vertical-text")
    grid.attach(btn, 2, 1, 1, 1)

    btn = Gtk.Button(label="alias")
    btn.set_cursor_from_name("alias")
    grid.attach(btn, 3, 1, 1, 1)

    btn = Gtk.Button(label="copy")
    btn.set_cursor_from_name("copy")
    grid.attach(btn, 4, 1, 1, 1)

    btn = Gtk.Button(label="no-drop")
    btn.set_cursor_from_name("no-drop")
    grid.attach(btn, 5, 1, 1, 1)

    btn = Gtk.Button(label="move")
    btn.set_cursor_from_name("move")
    grid.attach(btn, 0, 2, 1, 1)

    btn = Gtk.Button(label="not-allowed")
    btn.set_cursor_from_name("not-allowed")
    grid.attach(btn, 1, 2, 1, 1)

    btn = Gtk.Button(label="grab")
    btn.set_cursor_from_name("grab")
    grid.attach(btn, 2, 2, 1, 1)

    btn = Gtk.Button(label="grabbing")
    btn.set_cursor_from_name("grabbing")
    grid.attach(btn, 3, 2, 1, 1)

    btn = Gtk.Button(label="all-scroll")
    btn.set_cursor_from_name("all-scroll")
    grid.attach(btn, 4, 2, 1, 1)

    btn = Gtk.Button(label="col-resize")
    btn.set_cursor_from_name("col-resize")
    grid.attach(btn, 5, 2, 1, 1)

    btn = Gtk.Button(label="row-resize")
    btn.set_cursor_from_name("row-resize")
    grid.attach(btn, 0, 3, 1, 1)

    btn = Gtk.Button(label="n-resize")
    btn.set_cursor_from_name("n-resize")
    grid.attach(btn, 1, 3, 1, 1)

    btn = Gtk.Button(label="e-resize")
    btn.set_cursor_from_name("e-resize")
    grid.attach(btn, 2, 3, 1, 1)

    btn = Gtk.Button(label="s-resize")
    btn.set_cursor_from_name("s-resize")
    grid.attach(btn, 3, 3, 1, 1)

    btn = Gtk.Button(label="w-resize")
    btn.set_cursor_from_name("w-resize")
    grid.attach(btn, 4, 3, 1, 1)

    btn = Gtk.Button(label="ne-resize")
    btn.set_cursor_from_name("ne-resize")
    grid.attach(btn, 5, 3, 1, 1)

    btn = Gtk.Button(label="nw-resize")
    btn.set_cursor_from_name("nw-resize")
    grid.attach(btn, 0, 4, 1, 1)

    btn = Gtk.Button(label="sw-resize")
    btn.set_cursor_from_name("sw-resize")
    grid.attach(btn, 1, 4, 1, 1)

    btn = Gtk.Button(label="se-resize")
    btn.set_cursor_from_name("se-resize")
    grid.attach(btn, 2, 4, 1, 1)

    btn = Gtk.Button(label="ew-resize")
    btn.set_cursor_from_name("ew-resize")
    grid.attach(btn, 3, 4, 1, 1)

    btn = Gtk.Button(label="ns-resize")
    btn.set_cursor_from_name("ns-resize")
    grid.attach(btn, 4, 4, 1, 1)

    btn = Gtk.Button(label="nesw-resize")
    btn.set_cursor_from_name("nesw-resize")
    grid.attach(btn, 5, 4, 1, 1)

    btn = Gtk.Button(label="nwse-resize")
    btn.set_cursor_from_name("nwse-resize")
    grid.attach(btn, 0, 5, 1, 1)

    btn = Gtk.Button(label="zoom-in")
    btn.set_cursor_from_name("zoom-in")
    grid.attach(btn, 1, 5, 1, 1)

    btn = Gtk.Button(label="zoom-out")
    btn.set_cursor_from_name("zoom-out")
    grid.attach(btn, 2, 5, 1, 1)

    win.set_child(grid)
    win.present()

app = Gtk.Application(application_id='com.oxygenplus.cursortest')
app.connect('activate', on_activate)
app.run(None)
