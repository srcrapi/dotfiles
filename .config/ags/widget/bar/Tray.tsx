import Tray from "gi://AstalTray";
import { bind, Variable } from "astal";


export default function SysTray() {
	const tray = Tray.get_default();
	const existTray = Variable(false)

	return (
		<>
			<label className="separator" label={existTray((value: boolean) => value ? "•" : "")}/>
			<box className="tray">
				{bind(tray, "items").as(items => {
					const activeItems = items.filter((item) => item.status === 1)
					existTray.set(activeItems.length > 0)

					return activeItems.map(item => (
						<menubutton
							className="tray-icon"
							usePopover={false}
							tooltip_markup={bind(item, "tooltipMarkup")}
							actionGroup={bind(item, "action-group").as((ag) => ["dbusmenu", ag])}
							menu_model={bind(item, "menu-model")}
						>
							<icon gicon={bind(item, "gicon")} />
						</menubutton>
					))
				})}
			</box>
		</>
	);
}
