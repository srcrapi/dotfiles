import os
import shutil
import json
import subprocess


class HyprConfigGen:
    """
    Generates hyprland configutation file
    """

    def __init__(self, home: str):
        self.home = home

        self.hypr_dir = f"{self.home}/.config/hypr"
        self.templates_dir = f"{self.hypr_dir}/templates"
        self.global_config = f"{self.home}/.config/ryarch.json"
        self.hypr_conf_temp = f"{self.templates_dir}/hyprland.conf"
        self.cache_dir = f"{self.templates_dir}/.cache"

        self.directorys = [self.templates_dir, self.cache_dir, self.hypr_dir]

    @staticmethod
    def create_directory(path: str) -> None:
        if not os.path.exists(path):
            os.makedirs(path, exist_ok=True)

    @staticmethod
    def copy_file(source: str, destination: str) -> None:
        shutil.copy2(source, destination)

    @staticmethod
    def load_json(file_path: str):
        with open(file_path, "r") as f:
            return json.load(f)

    @staticmethod
    def save_json(file_path: str, data) -> None:
        with open(file_path, "w") as f:
            json.dump(data, f, indent=4)

    def select_option_yes_no(self, prompt: str) -> bool:
        """Auxiliar function to ask yes and no"""

        while True:
            option = input(prompt).strip().lower()

            match option:
                case "yes" | "y" | "":
                    return True
                case "no" | "n":
                    return False
                case _:
                    print(":: Please choose only yes or no")

    def select_option_int(self, prompt: str) -> int:
        """Auxiliar function to ask numbers"""

        while True:
            try:
                option = int(input(prompt))
                return option
            except ValueError:
                print(":: You can only use numbers")

    def generate_data(self, config) -> None:
        rounded_corners = self.select_option_yes_no(
            ":: Do you want rounded corners (yes/no): "
        )
        border_size = self.select_option_int(
            ":: What border size do you want (0 means none): "
        )
        shadow = self.select_option_yes_no(":: Do you want shadows (yes/no): ")
        key_layouts = self.select_option_yes_no(
            ":: Do you want to add more keyboard layouts (default: us)? (yes/no) "
        )

        keyboard_layouts = ["us"]

        if key_layouts:
            custom_layouts = input(":: Add custom layouts: ").strip().lower().split()
            keyboard_layouts.extend(custom_layouts)

        hyprland_data = {
            "rounded_corners": rounded_corners,
            "border_size": border_size,
            "shadow": shadow,
            "keyboard_layouts": keyboard_layouts,
        }

        config["hyprland"] = hyprland_data

        self.save_json(self.global_config, config)

    def reload_config(self, hyprland: dict[str, str | bool | list[str]]) -> None:
        border_radius = 20 if hyprland["rounded_corners"] else 0
        border_size = hyprland["border_size"]
        shadow = "true" if hyprland["shadow"] else "false"
        keyboard_layouts = hyprland["keyboard_layouts"]
        keyboard_layouts = ",".join(keyboard_layouts)

        values = {
            "b_radius": border_radius,
            "d_shadow": shadow,
            "k_layouts": keyboard_layouts,
            "b_size": border_size,
        }

        hypr_conf_cache = os.path.join(self.cache_dir, "hyprland.conf")
        hypr_conf_dir = os.path.join(self.hypr_dir, "hyprland.conf")

        for key, value in values.items():
            subprocess.run(
                ["sed", "-i", f"s/{{{{ {key} }}}}/{value}/g", hypr_conf_cache]
            )

        self.copy_file(hypr_conf_cache, hypr_conf_dir)

    def generate(self) -> None:
        for dir in self.directorys:
            self.create_directory(dir)

        self.copy_file(self.hypr_conf_temp, self.cache_dir)

        if not os.path.exists(self.global_config):
            data = {"hyprland": {}}

            self.save_json(self.global_config, data)

        ryach_config = self.load_json(self.global_config)
        hyprland = ryach_config.get("hyprland")

        if not hyprland:
            self.generate_data(ryach_config)
            ryach_config = self.load_json(self.global_config)
            hyprland = ryach_config.get("hyprland")

        self.reload_config(hyprland)


if __name__ == "__main__":
    home = os.getenv("HOME")

    HyprConfigGen(home).generate()
