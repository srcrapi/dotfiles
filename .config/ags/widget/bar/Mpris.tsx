import Mpris from "gi://AstalMpris";
import { bind } from "astal";

const MAX_CHARACTERS = 28

const mpris = Mpris.get_default();
const excludePlayers = ["firefox", "zen"];
const priority = ["tidal", "spotify"];

const players = bind(mpris, "players");

const player = players.as((playersList) => {
	const filtered = playersList.filter(
		(p) => !excludePlayers.some((ex) => p.identity.toLowerCase().includes(ex)),
	);

	for (const preferred of priority) {
		const match = filtered.find((p) =>
			p.identity.toLowerCase().includes(preferred),
		);
		if (match) return match;
	}

	return filtered[0] || null
});

export default function Music() {
	return player.as(p => {
		if (!p) return ""; 

		const status = bind(p, "playbackStatus").as((s) => (s ? "" : ""));
		const title = bind(p, "title").as((t) => t.length > MAX_CHARACTERS ? t.slice(0, MAX_CHARACTERS - 3) + "..." : t);

		return (
			<box className="mpris container">
				<button onClick={() => p.play_pause()}>
					{status.as(icon => <label label={icon} />)}
				</button>
				{title.as(t => <label label={t} />)}
			</box>
		)
	});
}
