import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Suru 2.2
import Lomiri.Components 1.3 as LUITK

Column {
    id: iconSelectItem

    readonly property var radioButton: radioButton
    property alias text: radioButton.text
    property string helpText: ""
    property string placeholderIconName: ""
    property string source: ""
    property string sourcePrefix: ""
    property bool loading: false
    property alias checked: radioButton.checked

    signal iconClicked();

    Item {
        anchors.horizontalCenter: parent.horizontalCenter
        implicitWidth: Suru.units.gu(8)
        implicitHeight: Suru.units.gu(8)

        LUITK.LomiriShape {
            anchors.fill: parent

            backgroundColor: iconImage.source == "" ? Suru.neutralColor : "white"
            aspect: LUITK.LomiriShape.Inset

            source: Image {
                id: iconImage
                sourceSize.width: Suru.units.gu(8)
                sourceSize.height: Suru.units.gu(8)
                cache: false
                source: iconSelectItem.source !== "" ? iconSelectItem.sourcePrefix + iconSelectItem.source : ""
            }

            LUITK.Icon {
                anchors.centerIn: parent
                visible: placeholderIconName !== "" && iconImage.source == ""
                name: placeholderIconName
                width: Suru.units.gu(4)
                height: Suru.units.gu(4)
                color: "white"
            }

            BusyIndicator {
                id: busyIndicator
                anchors.centerIn: parent
                running: iconImage.status == Image.Loading || iconSelectItem.loading
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                radioButton.checked = true
                iconSelectItem.iconClicked();
            }
        }
    }

    Row {
        RadioButton {
            id: radioButton
            anchors.verticalCenter: parent.verticalCenter
        }

        IconButton {
            visible: helpText !== ""
            anchors.verticalCenter: parent.verticalCenter
            iconName: "help"
            onClicked: ToolTip.show(helpText, 3000)
        }
    }
}
