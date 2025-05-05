import { Gdk, Gtk } from "astal/gtk3";
import { bind, Variable } from "astal";
import Hyprland from "gi://AstalHyprland";

const hyprland = Hyprland.get_default();

type WorkspacesProps = {
	gdkmonitor: Gdk.Monitor;
	count: number;
};

class Workspace {
	readonly id: number;
	readonly widget: Gtk.Widget;
	readonly active: ReturnType<typeof Variable<boolean>>;
	readonly occupied: ReturnType<typeof Variable<boolean>>;
	readonly className: ReturnType<typeof Variable<string>>;

	constructor(id: number) {
		this.id = id;
		this.active = Variable(false);
		this.occupied = Variable(false);
		this.className = Variable.derive(
			[this.active, this.occupied],
			(active, occupied) => {
				const result = ["workspace"];

				if (active) result.push("active");

				if (occupied) result.push("occupied");

				return result.join(" ");
			},
		);

		this.widget = (
			<button
				className={bind(this.className)}
				onClick={() => {
					try {
						hyprland.dispatch("workspace", this.id.toString());
					} catch (e) {
						console.error("Error dispatching workspace:", e);
					}
				}}
			>
				<label
					label={this.active((value) => (value ? "•" : this.id.toString()))}
				/>
			</button>
		);
	}

	setActive(value: boolean) {
		this.active.set(value);
	}

	setOccupied(value: boolean) {
		this.occupied.set(value);
	}
}

export default function Workspaces({ gdkmonitor, count }: WorkspacesProps) {
	const workspaces = Variable(HyprWorkspaces(gdkmonitor, count));
	workspaces
		.get()
		.find((ws) => ws.id === hyprland.focusedWorkspace.id)
		?.setActive(true);

	const updateOccupied = (ws: Workspace) => {
		const hws = hyprland.get_workspaces().find((hw) => hw.id === ws.id);

		if (hws) {
			ws.setOccupied(hws.get_clients().length > 0);
		}
	}

	for (const ws of workspaces?.get()) {
		updateOccupied(ws)
	}

	hyprland.connect("event", async (_, eventName, data) => {
		if (eventName === "workspacev2") {
			const workspaceId = parseInt(data.split(",")[1]);

			for (const ws of workspaces?.get()) {
				ws.setActive(ws.id === workspaceId);
				updateOccupied(ws)
			}
		}
	});

	return (
		<box className="container">{workspaces((workspace) => workspace.map((ws) => ws.widget))}</box>
	);
}

function HyprWorkspaces(monitor: Gdk.Monitor, count: number) {
	let workspaces = [...Array(count).keys()].map((i) => i + 1);

	return workspaces.map((ws) => new Workspace(ws));
}
