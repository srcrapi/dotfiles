from ignis.options_manager import OptionsManager, OptionsGroup, TrackedList
import os
from pathlib import Path

path = Path(os.path.expanduser("~/.cache/ignis/UI.json"))
material_colors_path = Path(os.path.expanduser("~/.cache/material-colors/material-colors.scss"))

if not path.parent.exists():
    path.parent.mkdir(parents=True)

if not path.exists():
    path.write_text("{}")


def extract_color(file: str) -> dict[str, str] | str:
    colors = {}

    with open(file, "r") as f:
        for line in f:
            line = line.strip()

            key = line.split(":", 1)[0].strip("$")
            value = line.split(":", 1)[1].strip().rstrip(';')

            colors[key] = value

        return colors

    return "#000000"


material_colors = extract_color(material_colors_path)


class UIConfig(OptionsManager):
    def __init__(self):
        super().__init__(file=os.path.expanduser("~/.cache/ignis/UI.json"))

    class ColorScheme(OptionsGroup):
        name: str = "Dynamic Dark"
        variant: str = "scheme-tonal-spot"
        primary: str = material_colors.get("primary")
        surface: str = material_colors.get("background")

    class Workspaces(OptionsGroup):
        number: int = 5

    class Bar(OptionsGroup):
        position: str = "left"
        all_sides: bool = True
        full: bool = False
        width: int = 800
        margin: int = 16
        border_radius: str = "xl"
        modules_start: TrackedList[str] = ["workspaces"]  # type: ignore
        modules_center: TrackedList[str] = ["music"]  # type: ignore
        modules_end: TrackedList[str] = [
            "tray",
            "separator",
            "battery",
            "wifi",
            "separator",
            "time",
        ]  # type: ignore

    class MainMenu(OptionsGroup):
        position: list[str] = ["top"]

    class Notifications(OptionsGroup):
        position: list[str] = ["top"]

    class User(OptionsGroup):
        name: str = "ryfenri"

    class Wallpaper(OptionsGroup):
        path: Path = Path(os.path.expanduser("~/Pictures/wallpapers"))

    bar = Bar()
    mainMenu = MainMenu()
    user = User()
    colorscheme = ColorScheme()
    notifications = Notifications()
    workspaces = Workspaces()


UIConfig()
