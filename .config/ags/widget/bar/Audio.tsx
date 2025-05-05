import { Gtk } from "astal/gtk3";
import Wp from "gi://AstalWp";
import { bind, exec } from "astal";

const speaker = Wp.get_default()?.defaultSpeaker!

export default function Audio() {
	return <box className="audio">
		<button onClick={() => exec("bash -c 'pavucontrol'")} cursor="pointer">
			<icon icon={bind(speaker, "volumeIcon")}/>
		</button>
		<slider 
			vertical
			heightRequest={15}
			widthRequest={3}
			valign={Gtk.Align.CENTER}
			onDragged={({ value }) => speaker.volume = value}
			value={bind(speaker, "volume")}
		/>
	</box>
}
