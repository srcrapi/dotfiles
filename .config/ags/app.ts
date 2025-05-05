import { App } from "astal/gtk3";
import style from "./style/main.scss"
import Bar from "./widget/bar/main";
import NotificationPopups from "./widget/notifications/NotificationPopups";

const a = [Bar, NotificationPopups]

App.start({
	instanceName: "bar",
	css: style,
	icons: "./assets/icons",
	main() {
		App.get_monitors().map((monitor) => a.map(b => b(monitor)));
	},
});
