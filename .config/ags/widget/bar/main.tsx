import { App, Astal, Gdk, Gtk } from "astal/gtk3";
import Workspaces from "./Workspaces";
import Tray from "./Tray";
import Music from "./Mpris";
import Bat from "./Battery";
import Wifi from "./Network";
import Audio from "./Audio";
import { execAsync, Variable } from "astal";

const date = Variable("").poll(1000, ["date", "+%I:%M %p • %A, %d/%m"])

export default function Bar(gdkmonitor: Gdk.Monitor) {
	const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

	return (
		<window
			name="Bar"
			className="Bar"
			gdkmonitor={gdkmonitor}
			exclusivity={Astal.Exclusivity.EXCLUSIVE}
			anchor={TOP | LEFT | RIGHT}
			application={App}
		>
			<centerbox>
				<box className="left">
					<button
					className="logo"
					cursor="pointer" 
					onClick={async () => {
						try {
							await execAsync(["bash", "-c" ,"pkill -x rofi || rofi -show drun"])
						} catch(err) {
							logError(err)
						}
					}}
					>
						<label label=""/>	
					</button>
					<Workspaces gdkmonitor={gdkmonitor} count={5}/>
					<Tray />
				</box>
				<box className="center" widthRequest={200} expand>
					<Music />
					<label label={date()} className="date container" />
					<Bat />
				</box>
				<box className="right" halign={Gtk.Align.END}>
					<Wifi />
					<Audio />
				</box>
			</centerbox>
		</window>
	);
}
