pragma Singleton

import Quickshell
import QtQuick

Singleton {
	id: root
	property string time: {
		Qt.formatDateTime(clock.date, "hh:mm AP dddd dd/MM")
	}

	SystemClock {
		id: clock
		precision: SystemClock.Minutes
	}
}
