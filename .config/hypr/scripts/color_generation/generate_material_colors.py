import os
import json

import argparse
from PIL import Image
from materialyoucolor.hct import Hct
from materialyoucolor.dynamiccolor.material_dynamic_colors import MaterialDynamicColors
from materialyoucolor.quantize import QuantizeCelebi
from materialyoucolor.score.score import Score


class GenerateMaterialColors:
    def __init__(self, cache_dir: str) -> None:
        self.cache_dir = cache_dir
        self.rgba_to_hex = lambda r, g, b, a=255: f"#{r:02x}{g:02x}{b:02x}"
        self.display_colors = (
            lambda r,
            g,
            b,
            a=255: f"\x1b[38;2;{r};{g};{b}m{"\x1b[7m     \x1b[7m"}\x1b[0m"
        )
        self.app_file_path = os.path.expanduser(
            "~/.local/share/applications/material-color.desktop"
        )

    def create_directory(self, dir: str) -> None:
        if not os.path.exists(dir):
            os.makedirs(dir, exist_ok=True)

    def parse_arguments(self) -> argparse.Namespace:
        parser = argparse.ArgumentParser(
            description="Generate material colors based on an image"
        )
        parser.add_argument(
            "--path",
            "-p",
            type=str,
            default=None,
            required=True,
            help="path to the image",
        )
        parser.add_argument(
            "--scheme", type=str, default="vibrant", help="scheme to be used"
        )
        parser.add_argument(
            "--transparency",
            "-t",
            type=str,
            default="opaque",
            choices=["opaque", "transparent"],
            help="choose between opaque and transparent (default value is opaque)",
        )
        parser.add_argument(
            "--mode",
            "-s",
            type=str,
            default="dark",
            choices=["dark", "light"],
            help="choose between light and dark mode (default value is dark)",
        )
        parser.add_argument(
            "--debug",
            "-d",
            action="store_true",
            default=False,
            help="active debug mode",
        )

        return parser.parse_args()

    def resize_image(self, width: int, height: int, size: int = 1000):
        aspect_ratio = width / height

        if width > height:
            new_width = size
            new_height = int(size / aspect_ratio)
        else:
            new_height = size
            new_width = int(size * aspect_ratio)

        return new_width, new_height

    def save_json(self, filepath: str, config: dict) -> None:
        with open(filepath, "w") as file:
            json.dump(config, file, indent=4)

    def create_desktop_file(self):
        user = os.getlogin()

        # Create .desktop file
        app_file = f"""[Desktop Entry]
        Name=Material Color Configs
        Comment=Material color configuration app
        Exec=python3 /home/{user}/.config/hypr/scripts/color_generation/material_color_config.py
        Icon=material-color
        Terminal=false
        Type=Application
        StartupWMClass=ryo.config.material-color
        Categories=Utility
        """

        with open(self.app_file_path, "w") as file:
            file.write(app_file)

    def generate_colors(self) -> None:
        if not os.path.exists(self.app_file_path):
            self.create_desktop_file()

        self.create_directory(self.cache_dir)

        if not os.path.exists(os.path.join(self.cache_dir, "config.json")):
            default_color_conf = {
                "darkmode": True,
                "scheme": "vibrant",
                "opaque": True,
                "neovim_colorscheme": "catppuccin_mocha",
            }

            self.save_json(
                os.path.join(self.cache_dir, "config.json"), default_color_conf
            )

        args = self.parse_arguments()

        mode: bool = args.mode == "dark"
        opaque: bool = args.transparency == "opaque"

        if args.path:
            image = Image.open(args.path)
            wsize, hsize = image.width, image.height

            new_wsize, new_hsize = self.resize_image(wsize, hsize)
            image = image.resize((new_wsize, new_hsize))

            colors = QuantizeCelebi(list(image.getdata()), 128)
            score = Score.score(colors)[0]
            hct = Hct.from_int(score)

        if args.scheme == "neutral":
            from materialyoucolor.scheme.scheme_neutral import SchemeNeutral as Scheme
        elif args.scheme == "expressive":
            from materialyoucolor.scheme.scheme_expressive import (
                SchemeExpressive as Scheme,
            )
        elif args.scheme == "fruit":
            from materialyoucolor.scheme.scheme_fruit_salad import (
                SchemeFruitSalad as Scheme,
            )
        elif args.scheme == "monochrome":
            from materialyoucolor.scheme.scheme_monochrome import (
                SchemeMonochrome as Scheme,
            )
        elif args.scheme == "rainbow":
            from materialyoucolor.scheme.scheme_rainbow import SchemeRainbow as Scheme
        elif args.scheme == "fidelity":
            from materialyoucolor.scheme.scheme_fidelity import SchemeFidelity as Scheme
        elif args.scheme == "vibrant":
            from materialyoucolor.scheme.scheme_vibrant import SchemeVibrant as Scheme
        elif args.scheme == "tonal-spot":
            from materialyoucolor.scheme.scheme_tonal_spot import (
                SchemeTonalSpot as Scheme,
            )
        elif args.scheme == "content":
            from materialyoucolor.scheme.scheme_content import SchemeContent as Scheme
        else:
            raise ValueError(f"Invalid scheme: {args.scheme}")

        scheme = Scheme(hct, mode, 0.0)

        material_colors = {}

        for color in vars(MaterialDynamicColors).keys():
            color_name = getattr(MaterialDynamicColors, color)

            if hasattr(color_name, "get_hct"):
                material_colors[color] = color_name.get_hct(scheme).to_rgba()

        hex_colors = {
            color_name: self.rgba_to_hex(*code)
            for color_name, code in material_colors.items()
        }

        if not args.debug:
            print(f"$darkmode: {mode};")
            print(f"$scheme: {args.scheme};")
            print(f"$opaque: {opaque};")

            config = {"darkmode": mode, "scheme": args.scheme, "opaque": opaque}

            config_path = os.path.join(self.cache_dir, "config.json")

            if not os.path.exists(config_path):
                self.save_json(config_path, config)

            for color_name, code in hex_colors.items():
                print(f"${color_name}: {code};")

            return

        print("\n-------------Color-------------")
        print(f"dark mode: {mode}")
        print(f"scheme: {args.scheme}")
        print(f"opaque: {opaque}")
        print(f"hct: {hct.hue:.2f} {hct.chroma:.2f} {hct.tone:.2f}")

        print("\n--------Material Colors--------")
        print(f"[ Color Name ]: [ Color ] [ Color Code ]\n")

        for color_name, code in material_colors.items():
            print(f"${color_name.ljust(32)}: {self.display_colors(*code)} {code}")


if __name__ == "__main__":
    GenerateMaterialColors(
        os.path.expanduser("~/.cache/material-colors")
    ).generate_colors()
