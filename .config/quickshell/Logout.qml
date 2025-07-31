pragma Singleton

import Quickshell
import QtQuick

Variants {
	model: Quickshell.screens;

	Component {
		PanelWindow {
			required property var modelData
			screen: modelData

			property bool hovered: hoverHandler.hovered

			anchors.right: true
			exclusiveZone: 3
			implicitHeight: 200
			implicitWidth: hovered ? 75 : 12
			color: "transparent"

			HoverHandler {
				id: hoverHandler
				margin: 6
			}

			Rectangle {
				id: slidePanel
				anchors {
					top: parent.top
					bottom: parent.bottom
					right: parent.right
				}
				width: hovered ? 75 : 0
				color: "white"
				clip: true
				radius: 15

				Rectangle {
					anchors {
						top: parent.top
						bottom: parent.bottom
						right: parent.right
					}
					width: parent.radius
					color: parent.color
				}

				Behavior on width {
					NumberAnimation {
						duration: 200
						easing.type: Easing.OutCubic
					}
				}

				Column {
					anchors.centerIn: parent
					spacing: 10

					Text {
						text: "Logout"
						color: "white"
					}

					Text {
						text: "Logout"
						color: "white"
					}

					Text {
						text: "Logout"
						color: "white"
					}
				}
			}
		}
	}
}
