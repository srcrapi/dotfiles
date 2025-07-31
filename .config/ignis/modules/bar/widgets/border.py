from ignis.widgets.window import Window

from configuration.UI import UIConfig
import math

# Which corner to cut: choose from "top-left", "top-right", "bottom-left", "bottom-right"
from gi.repository import Gtk, cairo


class CurvedCornerShape(Gtk.DrawingArea):
    def __init__(self, corner="top-left"):
        super().__init__()
        self._border = {
            "0": 0,
            "sm": 4,
            "md": 8,
            "lg": 16,
            "xl": 32,
        }
        self.set_content_width(self._border[UIConfig.bar.border_radius])
        self.set_content_height(self._border[UIConfig.bar.border_radius])
        self._corner = corner
        self.set_draw_func(self.draw_shape)
        UIConfig.bar.connect_option("border_radius", self.refresh)
        UIConfig.colorscheme.connect_option("surface", self.refresh)
        self.refresh()

    def refresh(self, *_):
        self.set_content_width(self._border[UIConfig.bar.border_radius])
        self.set_content_height(self._border[UIConfig.bar.border_radius])
        self.queue_draw()

    def draw_shape(self, widget, cr, width, height):
        radius = self._border[UIConfig.bar.border_radius]
        rgba = self.get_surface_rgba() or (0, 0, 0, 0)
        # Clear background to transparent
        cr.set_source_rgba(*rgba)
        cr.paint()

        # Draw black rectangle covering entire area
        cr.set_source_rgba(*rgba)
        cr.rectangle(0, 0, width, height)
        cr.fill()

        # Use CLEAR operator to make circular segment transparent
        cr.set_operator(cairo.Operator.CLEAR)

        if self._corner == "bottom-right":
            # Draw clockwise arc from bottom to right
            cr.arc(0, 0, radius, 0, math.pi / 2)
            cr.line_to(0, 0)
        elif self._corner == "bottom-left":
            # Draw clockwise arc from bottom to left
            cr.arc(width, 0, radius, math.pi / 2, math.pi)
            cr.line_to(width, 0)
        elif self._corner == "top-right":
            # Draw clockwise arc from top to right
            cr.arc(0, height, radius, 3 * math.pi / 2, 0)
            cr.line_to(0, height)
        elif self._corner == "top-left":
            # Draw clockwise arc from top to left
            cr.arc(width, height, radius, math.pi, 3 * math.pi / 2)
            cr.line_to(width, height)

        cr.fill()

        # Restore default operator
        cr.set_operator(cairo.Operator.OVER)

    def get_surface_rgba(self):
        """
        Read a color file and extract the primary color as RGBA values (0-1 range)

        Args:
            file_path (str): Path to the color file

        Returns:
            tuple: (r, g, b, a) values in 0-1 range
        """

        hex_color = UIConfig.colorscheme.surface
        if hex_color.startswith("#"):
            hex_color = hex_color[1:]
        # Convert hex to RGBA (0-1 range)
        if len(hex_color) == 6:  # RRGGBB
            r = int(hex_color[0:2], 16) / 255.0
            g = int(hex_color[2:4], 16) / 255.0
            b = int(hex_color[4:6], 16) / 255.0
            return (r, g, b, 1.0)  # Alpha defaults to 1.0
        elif len(hex_color) == 8:  # RRGGBBAA
            r = int(hex_color[0:2], 16) / 255.0
            g = int(hex_color[2:4], 16) / 255.0
            b = int(hex_color[4:6], 16) / 255.0
            a = int(hex_color[6:8], 16) / 255.0
            return (r, g, b, a)


class Border(Window):
    def __init__(self, side="top"):
        super().__init__(
            anchor=[side]
            + (
                ["top", "bottom"]
                if side in ["left", "right"]
                else ["left", "right"]
                if side in ["top", "bottom"]
                else []
            ),
            css_classes=["bg-surface"],
            namespace=f"border_{side}",
            exclusivity="exclusive",
            width_request=UIConfig.bar.margin
            if side in ["left", "right"] and side != UIConfig.bar.position
            else -1,
            height_request=UIConfig.bar.margin
            if side in ["top", "bottom"] and side != UIConfig.bar.position
            else -1,
            visible=UIConfig.bar.all_sides,
        )
        self._side = side
        UIConfig.bar.connect_option("position", self.refresh)
        UIConfig.bar.connect_option("border_radius", self.refresh)
        UIConfig.bar.connect_option("all_sides", self.refresh)
        UIConfig.bar.connect_option("margin", self.refresh)

    def refresh(self, *_):
        self.width_request = (
            UIConfig.bar.margin
            if self._side in ["left", "right"] and self._side != UIConfig.bar.position
            else -1
        )
        self.height_request = (
            UIConfig.bar.margin
            if self._side in ["top", "bottom"] and self._side != UIConfig.bar.position
            else -1
        )
        self.visible = UIConfig.bar.all_sides


class Corner(Window):
    def __init__(self, corner="top-left"):
        super().__init__(
            anchor=corner.split("-")
            + (
                ["top", "bottom"]
                if corner in ["left", "right"]
                else ["left", "right"]
                if corner in ["top", "bottom"]
                else []
            ),
            namespace=f"corner_{corner}",
            visible=UIConfig.bar.all_sides,
            css_classes=["bg-none"],
        )

        self.set_decorated(False)
        self.child = CurvedCornerShape(corner=corner)
        UIConfig.bar.connect_option("all_sides", self.refresh)

    def refresh(self, *_):
        self.visible = UIConfig.bar.all_sides


Border(side="top")
Border(side="bottom")
Border(side="left")
Border(side="right")

Corner(corner="top-left")
Corner(corner="top-right")
Corner(corner="bottom-left")
Corner(corner="bottom-right")
