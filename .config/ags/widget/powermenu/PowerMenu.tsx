#!/usr/bin/env -S ags run
import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import style from "../../style/power-menu.scss";
import { exec } from "astal/process";
import { Variable } from "astal";

const { TOP, BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor;
const { IGNORE} = Astal.Exclusivity;
const { EXCLUSIVE } = Astal.Keymode;
const { CENTER } = Gtk.Align;

const icons = "../../assets/icons"

export default function PowerMenu(gdkmonitor: Gdk.Monitor) {
	const hovered = Variable("")

	function powerMenu(option: string) {
		const options = {
			shutdown: "bash -c 'systemctl poweroff'",
			reboot: "bash -c 'systemctl reboot'",
			lock: "bash -c 'pidof ~/.config/hypr/scripts/setup_hyprlock.sh || ~/.config/hypr/scripts/setup_hyprlock.sh'",
			logout: "bash -c 'hyprctl dispatch exit 0'",
		}

		exec(options[option])
		App.quit()
	}

	function onKeyPress(_: Astal.Window, event: Gdk.Event) {
		if (event.get_keyval()[1] === Gdk.KEY_Escape|| event.get_keyval()[1] === Gdk.KEY_BackSpace) {
			App.quit()
		}
	}

	return (
		<window
			name="Power-Menu"
			className="Power-Menu"
			onKeyPressEvent={onKeyPress}
			exclusivity={IGNORE}
			gdkmonitor={gdkmonitor}
			keymode={EXCLUSIVE}
			anchor={TOP | BOTTOM | LEFT | RIGHT}
		>
			<box halign={CENTER} valign={CENTER} expand homogeneous>
				<box>
					<label />
					<button 
					className="shutdown" 
					onHoverLost={() => hovered.set("")} 
					onHover={() => hovered.set("shutdown")} 
					onClicked={() => powerMenu("shutdown")} expand
					>
						<icon icon={hovered(hover => hover === "shutdown" ? `${icons}/shutdown_black.png` : `${icons}/shutdown_white.png`)} />
					</button>
				</box>
				<box>
					<label />
					<button className="reboot"  onHoverLost={() => hovered.set("")} onHover={() => hovered.set("reboot")} onClicked={() => powerMenu("reboot")} expand>
						<icon icon={hovered(hover => hover === "reboot" ? `${icons}/reboot_black.png` : `${icons}/reboot_white.png`)} />
					</button>
				</box>
				<box>
					<label />
					<button className="lock"  onHoverLost={() => hovered.set("")} onHover={() => hovered.set("lock")} onClicked={() => powerMenu("lock")} expand>
						<icon icon={hovered(hover => hover === "lock" ? `${icons}/lock_black.png` : `${icons}/lock_white.png`)} />
					</button>
				</box>
				<box>
					<label />
					<button className="logout"  onHoverLost={() => hovered.set("")} onHover={() => hovered.set("logout")} onClicked={() => powerMenu("logout")} expand>
						<icon icon={hovered(hover => hover === "logout" ? `${icons}/logout_black.png` : `${icons}/logout_white.png`)} />
					</button>
				</box>
			</box>
		</window>
	);
}

App.start({
	instanceName: "power-menu",
	css: style,
	main() {
		App.get_monitors().map(PowerMenu)
	}
});
