import { Gtk } from "astal/gtk3";
import Battery from "gi://AstalBattery";
import { bind, Variable } from "astal";

const battery = Battery.get_default();

export default function Bat() {
	const percentage = bind(battery, "percentage")
	const percentageLabel = Variable.derive([percentage], (percentage) => {
		return Math.round(percentage * 100).toString() + "%"
	})
	const charging = Variable.derive(
		[bind(battery, "charging"), percentage],
		(charging, percentage) => charging && percentage < 1 ? "󱐌" : ""
	)

	return (
		<box className="battery container" visible={bind(battery, "isPresent")}>
			<label label={bind(charging)} className="icon"/>
			<label label={bind(percentageLabel)} className="percentage"/>
			<label label="󰁹" className="battery-icon"/>
			<levelbar 
				className="battery-level"
				vexpand
				valign={Gtk.Align.CENTER}
				value={percentage}
				heightRequest={15}
				widthRequest={3}
			/>
		</box>
	);
}
