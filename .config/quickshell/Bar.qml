import Quickshell
import QtQuick


//Scope {
//	Variants {
//		model: Quickshell.screens;
//		
//		PanelWindow {
//			property var modelData
//			screen: modelData
//
//			anchors {
//				top: true
//				left: true
//				right: true
//			}
//
//			implicitHeight: 35
//
//			ClockWidget {
//				anchors.centerIn: parent
//			}
//		}
//		
//		PanelWindow {
//			property var modelData
//			screen: modelData
//
//			anchors {
//				bottom: true
//				left: true
//				right: true
//			}
//
//			implicitHeight: 35
//
//			ClockWidget {
//				anchors.centerIn: parent
//			}
//		}
//	}
//}


import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id: win
    width: 80
    height: 400
    visible: true
    color: "transparent"
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    title: "Dock"

    Rectangle {
        id: dock
        anchors.fill: parent
        color: "#f8f1f0"
        border.color: "#ccc"
        // Arredondar canto superior esquerdo e inferior esquerdo
        radius: 0
        topLeftRadius: 30
        bottomLeftRadius: 30
        // Isso simula a curva "para fora" da direita
        // Mas em QML só curva "para dentro", então:
        // Usa um Canvas ou imagem SVG se quiser fazer exatamente como na imagem
    }
}

