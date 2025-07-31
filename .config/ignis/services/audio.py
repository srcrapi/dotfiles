import asyncio

from ignis import widgets, utils
from ignis.services.audio import AudioService


class Audio(widgets.Box):
    def __init__(self):
        audio = AudioService.get_default()

        self.volume_icon = widgets.Icon(pixel_size=16)
        self.volume_label = widgets.Label(css_classes=["audio-text"])
        self.revealer = widgets.Revealer(
            child=self.volume_label,
            transition_duration=300,
            reveal_child=True,
        )

        super().__init__(
            css_classes=["audio-container"],
            vertical=True,
            spacing=4,
            child=[
                widgets.EventBox(
                    vertical=True,
                    child=[
                        self.volume_icon,
                        self.revealer,
                    ],
                    on_click=lambda *_: asyncio.create_task(utils.exec_sh_async("pavucontrol")),
                    on_scroll_up=lambda *_: audio.speaker.set_volume(audio.speaker.get_volume() - 1),
                    on_scroll_down=lambda *_: audio.speaker.set_volume(audio.speaker.get_volume() + 1)
                )
            ]
        )

        self.volume_label.set_label(audio.speaker.bind_many(
                ["volume", "is_muted"],
                self._set_volume,
            )
        )

    def _set_volume(self, volume: int, is_muted: bool) -> str:
        if is_muted:
            self.volume_icon.set_image("volume-off-symbolic")
            self.revealer.set_reveal_child(False)
            return ""

        if volume >= 50:
            self.volume_icon.set_image("volume-2-symbolic")
        elif volume >= 20:
            self.volume_icon.set_image("volume-1-symbolic")
        else:
            self.volume_icon.set_image("volume-symbolic")

        self.revealer.set_reveal_child(True)
        return str(volume)
