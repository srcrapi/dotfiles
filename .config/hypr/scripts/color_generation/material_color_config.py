import gi
import sys
import os
import json

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, Gio


class App(Gtk.Application):
    def __init__(self):
        super().__init__(
            application_id="ryo.config.material-color",
            flags=Gio.ApplicationFlags.FLAGS_NONE,
        )

        self.config_path = os.path.expanduser("~/.cache/material-colors/config.json")
        self.config = self.load_json()

        self.connect("activate", self.on_active)

    def on_active(self, _):
        win = Gtk.ApplicationWindow(application=self)
        win.set_title("Material Color Configuration")

        win.set_border_width(15)
        win.set_default_size(300, 100)

        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        win.add(main_box)

        box_darkmode = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        box_darkmode.set_halign(Gtk.Align.START)
        box_darkmode.set_valign(Gtk.Align.CENTER)

        darkmode_label = Gtk.Label(label="Dark Mode", halign=Gtk.Align.START)
        darkmode_label.set_margin_end(50)
        box_darkmode.pack_start(darkmode_label, False, False, 0)

        darkmode_toggle = Gtk.Switch()
        darkmode_toggle.connect("notify::active", self.on_toggle_darkmode)

        box_darkmode.pack_start(darkmode_toggle, False, False, 0)
        main_box.pack_start(box_darkmode, False, False, 0)

        box_scheme = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        box_scheme.set_halign(Gtk.Align.START)
        box_scheme.set_valign(Gtk.Align.CENTER)

        scheme_label = Gtk.Label(label="Scheme", halign=Gtk.Align.START)
        scheme_label.set_margin_end(70)
        box_scheme.pack_start(scheme_label, False, False, 0)

        scheme_select = Gtk.ComboBoxText()
        scheme_select.set_entry_text_column(0)
        scheme_select.connect("changed", self.on_scheme_select)

        scheme_select.append_text("neutral")
        scheme_select.append_text("expressive")
        scheme_select.append_text("fruit")
        scheme_select.append_text("monochrome")
        scheme_select.append_text("rainbow")
        scheme_select.append_text("fidelity")
        scheme_select.append_text("vibrant")
        scheme_select.append_text("tonal-spot")
        scheme_select.append_text("content")

        box_scheme.pack_start(scheme_select, False, False, 0)
        main_box.pack_start(box_scheme, False, False, 0)

        box_opaque = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        box_opaque.set_halign(Gtk.Align.START)
        box_opaque.set_valign(Gtk.Align.CENTER)

        opaque_label = Gtk.Label(label="Opaque", halign=Gtk.Align.START)
        opaque_label.set_margin_end(72)
        box_opaque.pack_start(opaque_label, False, False, 0)

        opaque_toggle = Gtk.Switch()
        opaque_toggle.connect("notify::active", self.on_opaque_toggle)

        box_opaque.pack_start(opaque_toggle, False, False, 0)
        main_box.pack_start(box_opaque, False, False, 0)

        darkmode_toggle.set_active(self.config["darkmode"])
        opaque_toggle.set_active(self.config["opaque"])

        win.show_all()

    def load_json(self) -> dict:
        with open(self.config_path, "r") as file:
            return json.load(file)

    def save_json(self) -> None:
        with open(self.config_path, "w") as file:
            json.dump(self.config, file, indent=4)

    def on_toggle_darkmode(self, darkmode, _):
        self.config["darkmode"] = darkmode.get_active()
        self.save_json()

    def on_scheme_select(self, scheme):
        scheme_name = scheme.get_active_text()

        if not scheme_name:
            return

        self.config["scheme"] = scheme_name
        self.save_json()

    def on_opaque_toggle(self, opaque, _):
        self.config["opaque"] = opaque.get_active()
        self.save_json()


app = App()
app.run(None)
