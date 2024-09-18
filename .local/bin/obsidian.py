import argparse
import os
import platform
import json
import sys
import subprocess
from datetime import datetime
from typing import Any


def parse_arguments() -> tuple[argparse.ArgumentParser, argparse.Namespace]:
    parser = argparse.ArgumentParser(
        description="Obsidian CLI tool to create fast notes on any location"
    )

    parser.add_argument(
        "--sync",
        "-sn",
        choices=["push", "pull"],
        default=None,
        type=str,
        help="Sync notes with your github repo",
    )
    parser.add_argument(
        "--study", "-s", type=str, help="Creates a note in the study's subdirectory"
    )
    parser.add_argument(
        "--project", "-p", type=str, help="Creates a note in the project's subdirectory"
    )
    parser.add_argument(
        "--note",
        "-n",
        type=str,
        help="Creates a regular note with date in the note's subdirectory",
    )

    return parser, parser.parse_args()


class Obsidian:
    def __init__(
        self,
        args: argparse.Namespace,
        config_file: str,
        vault: str,
        filename: str | None = None,
        store_dir: str | None = None,
    ) -> None:
        self.args = args
        self.filename = filename
        self.store_dir = store_dir
        self.config_file = config_file
        self.vault = vault

    def create_note_with_date(self) -> None:
        date_today = datetime.today().strftime("%d-%m-%Y")
        formated_filename = f"{date_today}_{self.filename}.md"

        if self.store_dir is None:
            print(":: Error: Directory is null")
            sys.exit(1)

        create_directory(self.store_dir)

        file_path = os.path.join(self.store_dir, formated_filename)

        with open(file_path, "w") as _:
            pass

        subprocess.run(["nvim", file_path])

    def create_note(self) -> None:
        if self.store_dir is None:
            print(":: Error: Directory is null")
            sys.exit(1)

        create_directory(self.store_dir)

        file_path = os.path.join(self.store_dir, f"{self.filename}.md")

        with open(file_path, "w") as _:
            pass

        subprocess.run(["nvim", file_path])

    def sync(self) -> None:
        if not os.path.exists(os.path.join(self.vault, ".git")):
            print(":: Error: You need to inicialize git in your vault's directory")
            sys.exit(1)

        config_data: dict[str, Any] = load_json(self.config_file)
        obsidian_data = config_data.get("obsidian", {})

        git_user = obsidian_data.get("git_user")
        if git_user is None:
            git_user = str(input(":: Enter your git username: "))

        git_repo = obsidian_data.get("git_repo")
        if git_repo is None:
            git_repo = str(input(":: Enter your git repo: "))

        obsidian_data["git_user"] = git_user
        obsidian_data["git_repo"] = git_repo

        config_data["obsidian"] = obsidian_data

        save_json(self.config_file, config_data)

        if self.args.sync == "pull":
            print(":: Pulling...")
            result = subprocess.run(["git", "pull"], cwd=self.vault)

            if result.returncode != 0:
                print(":: Error: Failed to pull the repo")
                return

            print(":: Successfully pulled the repo")
            return

        print(f":: Adding {self.vault}")
        subprocess.run(["git", "add", "."], cwd=self.vault)
        print(":: Commiting...")
        subprocess.run(
            [
                "git",
                "commit",
                "-m",
                f"vault backup: {datetime.today().strftime("%d-%m-%Y %H:%M:%S")}",
            ],
            cwd=self.vault,
        )
        print(":: Pushing...")
        subprocess.run(["git", "push"], cwd=self.vault)


def load_json(file_path: str) -> dict[str, Any]:
    with open(file_path, "r") as file:
        return json.load(file)


def save_json(file_path: str, data: dict[str, Any], mode: str = "w") -> None:
    with open(file_path, mode) as file:
        json.dump(data, file, indent=4)


def create_directory(dir: str) -> None:
    if not os.path.exists(dir):
        os.makedirs(dir, exist_ok=True)


def file_location_path() -> str:
    os_name = platform.system()

    if os_name == "Windows" or os_name == "Darwin":
        return os.path.join(os.path.expanduser("~"), "obsidian.json")

    return os.path.expanduser("~/.config/ryarch.json")


def vault_location(config_file: str) -> None:
    data = load_json(config_file)
    obsidian_data = data.get("obsidian", {})

    vault_dir = str(input(":: Enter your vault's directory: "))

    if not vault_dir:
        sys.exit(1)

    vault_dir = vault_dir.replace("~", os.path.expanduser("~"))

    obsidian_data["vault"] = vault_dir
    data["obsidian"] = obsidian_data

    save_json(config_file, data)


def main():
    parser, args = parse_arguments()
    config_file = file_location_path()

    if not os.path.exists(config_file):
        vault_dir = str(input(":: Enter your vault's directory: "))

        if not vault_dir:
            sys.exit(1)

        vault_dir = vault_dir.replace("~", os.path.expanduser("~"))

        data = {"obsidian": {"vault": vault_dir}}

        save_json(config_file, data)

    file = load_json(config_file)
    obsidian_json = file.get("obsidian")

    if obsidian_json is None:
        vault_location(config_file)
        file = load_json(config_file)
        obsidian_json = file.get("obsidian")

    vault_dir = obsidian_json.get("vault")

    if vault_dir is None:
        print(":: Error: From obsidian object is missing vault")
        sys.exit(1)

    if args.sync:
        obsidian = Obsidian(args, config_file, vault_dir)
        obsidian.sync()

        return

    arg_name = next(
        (arg for arg in ["note", "study", "project", "sync"] if getattr(args, arg)),
        None,
    )

    if arg_name is None:
        parser.print_help()
        sys.exit(1)

    filename: str = args.project or args.note or args.study
    filename = filename.replace(" ", "-")

    store_dir = os.path.join(
        vault_dir,
        arg_name if arg_name == "study" else arg_name + "s",
    )

    obsidian = Obsidian(args, config_file, vault_dir, filename, store_dir)

    if args.note:
        obsidian.create_note_with_date()
    else:
        obsidian.create_note()


if __name__ == "__main__":
    main()
