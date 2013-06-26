/*
 * Copyright 2013 Canonical Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import "../../../Components"
import "tst_DragHandle"
import Ubuntu.Components 0.1
import Ubuntu.Gestures 0.1

/*
  Two blue fullscreen Showables (a vertical and a horizontal one) with red handles you
  can use to drag them away and green handles to drag them in.

  A black vertical line marks the point where a drag needs no forward velocity to
  achieve auto-completion (i.e., get Showable.show() called after touch release).
 */
Item {
    id: root
    width: 700
    height: 500

    property var dragHandle

    VerticalShowable {
        onDragHandleRecognizedGesture: { root.dragHandle = dragHandle }
    }

    HorizontalShowable {
        onDragHandleRecognizedGesture: { root.dragHandle = dragHandle }
    }

    // Visually mark drag threshold
    Rectangle {
        color: "black"
        width: 2
        height: parent.height

        visible: dragHandle !== undefined && Direction.isHorizontal(dragHandle.direction)

        x: {
            if (dragHandle) {
                if (dragHandle.direction === Direction.Rightwards)
                    dragHandle.edgeDragEvaluator.dragThreshold
                else
                    parent.width - dragHandle.edgeDragEvaluator.dragThreshold
            } else {
                0
            }
        }
    }
    Rectangle {
        color: "black";
        height: 2
        width: parent.width

        visible: dragHandle !== undefined && Direction.isVertical(dragHandle.direction)

        y: {
            if (dragHandle) {
                if (dragHandle.direction === Direction.Downwards)
                    dragHandle.edgeDragEvaluator.dragThreshold
                else
                    parent.height - dragHandle.edgeDragEvaluator.dragThreshold
            } else {
                0
            }
        }
    }

    // Display velocities
    Rectangle {
        width: childrenRect.width
        height: childrenRect.height
        color: "white"
        opacity: 0.4
        Text {
            id: velocityText
            font.pixelSize: units.gu(2)
            text: {
                if (dragHandle !== undefined)
                    "Velocity: " + (dragHandle.edgeDragEvaluator.velocity * 1000)
                else
                    "Velocity: -"
            }
        }
        Text {
            anchors.top: velocityText.bottom
            font.pixelSize: units.gu(2)
            text: {
                if (dragHandle !== undefined)
                    "Minimum velocity: " + (dragHandle.edgeDragEvaluator.minVelocity * 1000)
                else
                    "Minimum velocity: -"
            }
        }
    }
}
