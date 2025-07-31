import datetime
import os
import asyncio

from ignis import widgets, utils
from ignis.window_manager import WindowManager

from .widgets import Workspaces, border
from services import Audio, Tray

window_manager = WindowManager.get_default()


class Clock(widgets.Label):
    def __init__(self):
        super().__init__(label="", css_classes=["clock"])
        utils.Poll(1000, lambda x: self.update_time())

    def update_time(self):
        text = datetime.datetime.now().strftime("%I\n%M\n%p")
        self.set_label(text)


class Bar(widgets.Window):
    def __init__(self, monitor: int):
        super().__init__(
            namespace=f"rybalika_BAR_{monitor}",
            monitor=monitor,
            anchor=["left", "top", "bottom"],
            css_classes=["unset"],
            exclusivity="exclusive",
            child=widgets.CenterBox(
                vertical=True,
                css_classes=["bar", "unset"],
                start_widget=widgets.Box(
                    valign="center",
                    halign="center",
                    vertical=True,
                    spacing=15,
                    child=[
                        widgets.EventBox(
                            child=[
                                widgets.Icon(
                                    image="os-icon-symbolic",
                                    pixel_size=16,
                                    css_classes=["os-icon"]
                                ),
                            ],
                            on_click=lambda *_: asyncio.create_task(utils.exec_sh_async(os.path.expanduser("~/.config/hypr/scripts/rofi_launcher.sh -d"))),
                        ),
                        Tray()
                    ]
                ),
                center_widget=widgets.Box(
                    valign="center",
                    halign="center",
                    spacing=8,
                    child=[Workspaces()]
                ),
                end_widget=widgets.Box(
                    css_classes=["module-right"],
                    vertical=True,
                    valign="center",
                    halign="center",
                    spacing=8,
                    child=[
                        Audio(),
                        Clock(),
                        widgets.Button(
                            on_click=lambda x: window_manager.toggle_window("rybelika_POWERMENU"),
                            child=widgets.Icon(image="circle-power-symbolic", pixel_size=18),
                            css_classes=["powermenu-launch", "unset"]
                        )
                    ]
                ),
            ),
        )
