import Network from "gi://AstalNetwork";
import { bind } from "astal";

const network = Network.get_default();
const wifi = bind(network, "wifi");

export default function Wifi() {
	return (
		<box visible={wifi.as(Boolean)}>
			{wifi.as(
				(wifi) =>
					wifi && (
						<icon
							tooltipText={bind(wifi, "ssid").as(String)}
							className="wifi"
							icon={bind(wifi, "iconName")}
						/>
					),
			)}
		</box>
	);
}
