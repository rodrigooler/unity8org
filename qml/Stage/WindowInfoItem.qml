import QtQuick 2.4
import Ubuntu.Components 1.3

Item {
    id: root
    implicitWidth: Math.max(iconShape.width, titleLabel.width)
    implicitHeight: iconShape.height + titleLabel.height + labelMargin + iconMargin
    property alias title: titleLabel.text
    property alias iconSource: icon.source

    property real iconHeight: (height - titleLabel.height) * 0.65
    property real iconMargin: (height - titleLabel.height) * 0.25
    property real labelMargin: (height - titleLabel.height) * 0.1

    signal clicked()

    ProportionalShape {
        id: iconShape
        anchors {
            top: parent.top
            topMargin: iconMargin
            left: parent.left
        }
        height: iconHeight
        borderSource: "undefined"
        aspect: UbuntuShape.Flat
        source: Image {
            id: icon
            sourceSize.width: iconShape.width
            sourceSize.height: iconShape.height
            cache: false // see lpbug#1543290 why no cache
        }
    }

    MouseArea {
        anchors.fill: iconShape
        onClicked: root.clicked()
    }

    Label {
        id: titleLabel
        anchors {
            left: iconShape.left
            top: iconShape.bottom
            topMargin: labelMargin
        }
        width: iconShape.width * 1.5
        fontSize: 'small'
        color: 'white'
        elide: Label.ElideRight
    }
}
