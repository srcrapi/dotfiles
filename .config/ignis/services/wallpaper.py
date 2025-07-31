import asyncio
import os
from pathlib import Path

from ignis import widgets, utils
from PIL import Image

from configuration.UI import UIConfig


class WallpaperImage(widgets.Box):
    def __init__(self):
        self.thumb_dir = Path(f"{UIConfig.Wallpaper.path}/.thumbnails").expanduser()
        self.thumb_dir.mkdir(exist_ok=True)
        self.wallpapers = self._get_wallpapers()

        self.pictures = [
            widgets.Button(
                css_classes=["wallpaper-thumb-btn", "unset"],
                on_click=lambda *_, path=img: self._on_wallpaper_click(path),
                child=widgets.Picture(
                        image=str(self._make_thumbnail(img)),
                        content_fit="cover",
                        width=300,
                        height=150,
                        css_classes=["wallpaper-thumb", "unset"],
                    )
            )
            for img in self.wallpapers
        ]

        super().__init__(
            child=[
                widgets.Box(
                    css_classes=["unset", "wallpapers-container"],
                    child=[
                        widgets.Scroll(
                            css_classes=["wallpapers-scroll"],
                            child=widgets.Box(
                                css_classes=["wallpapers-box", "unset"],
                                child=self.pictures
                            )
                        )
                    ]
                )
            ]
        )

    def _on_wallpaper_click(self, img_path: Path):
        asyncio.create_task(utils.exec_sh_async(str(os.path.expanduser(f"~/.config/hypr/scripts/color_generation/config_generate.sh {img_path}"))))

    def _get_wallpapers(self):
        extensions = {".jpg", "jpeg", ".gif", ".png", ".jfif", ".webp"}

        return [
            file for file in UIConfig.Wallpaper.path.iterdir()
            if file.is_file() and file.suffix.lower() in extensions
        ]

    def _make_thumbnail(self, img_path: Path, size=(500, 250)):
        thumb_path = self.thumb_dir / img_path.name

        if not thumb_path.exists():
            with Image.open(img_path) as img:
                img.thumbnail(size, Image.LANCZOS)
                img.save(thumb_path)

        return thumb_path


class Wallpaper(widgets.Window):
    def __init__(self):
        self.icon = widgets.Icon(
            icon_name="system-search-symbolic",
            pixel_size=16,
            style="margin-left: 0.8rem; margin-right: 0.3rem;",
        )

        self.entry = widgets.Entry(
            css_classes=["search-wallpaper", "unset"],
            placeholder_text="Wallpaper",
            on_change=lambda search: search.text,
        )

        main_box = widgets.Box(
            halign="center",
            css_classes=["search-wallpaper-container", "unset"],
            child=[
                self.icon,
                self.entry
            ],
        )

        super().__init__(
            popup=True,
            kb_mode="on_demand",
            namespace="rybelika_WALLPAPER",
            anchor=["bottom"],
            visible=False,
            css_classes=["unset"],
            child=widgets.Box(
                vertical=True,
                css_classes=["wallpapers"],
                child=[
                    WallpaperImage(),
                    main_box
                ]
            )
        )
