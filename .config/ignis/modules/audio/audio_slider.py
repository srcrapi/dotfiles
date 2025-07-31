from ignis import widgets
from ignis.services.audio import AudioService


class AudioSlider(widgets.Window):
    def __init__(self):
        audio = AudioService.get_default()

        self.volume_icon = widgets.Icon(css_classes=["audio-slider-icon", "unset"], pixel_size=16)
        self.volume_icon.set_image(audio.speaker.bind_many(
                ["volume", "is_muted"],
                self._set_icon
            )
        )

        main_box = widgets.Box(
            vertical=True,
            valign="center",
            css_classes=["unset", "audio-slider-container"],
            child=[
                self.volume_icon,
                widgets.Scale(
                    css_classes=["audio-slider", "unset"],
                    vertical=True,
                    min=0,
                    max=100,
                    step=5,
                    value=audio.speaker.bind("volume", lambda volume: volume),
                    on_change=lambda x: audio.speaker.set_volume(x.value),
                    draw_value=True,
                    value_pos="bottom"
                )
            ],
        )

        self.revealer = widgets.Revealer(
            visible=False,
            child=main_box,
            transition_type="slide_right",
            transition_duration=400,
            reveal_child=False,
        )

        self.hover_box = widgets.EventBox(
            css_classes=["audio-slider-eventbox"],
            child=[self.revealer],
            on_hover=self._on_hover,
            on_hover_lost=self._on_leave,
        )

        super().__init__(
            namespace="rybelika_AUDIOSLIDER",
            anchor=["right"],
            css_classes=["unset"],
            exclusivity="ignore",
            child=self.hover_box,
        )

    def _set_icon(self, volume: int, is_muted: bool) -> str:
        if is_muted:
            return "volume-off-symbolic"

        if volume >= 50:
            icon = "volume-2-symbolic"
        elif volume >= 20:
            icon = "volume-1-symbolic"
        else:
            icon = "volume-symbolic"

        return icon

    def _on_hover(self, *_):
        self.hover_box.add_css_class("expanded")
        self.revealer.set_visible(True)
        self.revealer.set_reveal_child(True)

    def _on_leave(self, *_):
        self.hover_box.remove_css_class("expanded")
        self.revealer.set_visible(False)
        self.revealer.set_reveal_child(False)
