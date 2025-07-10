import QtQuick 2.12
import QtQuick.Controls 2.12
import SddmComponents 2.0
import "SimpleControls" as Simple

Rectangle {
    property var defaultFont: Qt.font({ pointSize: 16, family: "Noto Sans" })

    readonly property color backgroundColor: Qt.rgba(0, 0, 0, 0.4)
    readonly property color hoverBackgroundColor: Qt.rgba(0, 0, 0, 0.6)
    
    width: 640
    height: 480
    
    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    TextConstants { id: textConstants }
    
    Connections {
        target: sddm
        
        function onLoginSucceeded() {}
        
        function onLoginFailed() {
            pw_entry.clear()
            pw_entry.focus = true
            
            errorMsgContainer.visible = true
        }
    }
    
    Background {
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
        onStatusChanged: {
            if (status == Image.Error && source != config.defaultBackground) {
                source = config.defaultBackground
            }
        }
    }

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10

        Simple.ComboBox {
            id: user_entry
            model: userModel
            currentIndex: userModel.lastIndex
            textRole: "realName"
	    width: 250
	    padding: 4
	    background: Rectangle {
                implicitWidth: 100
                implicitHeight: 30
                color: pw_entry.activeFocus ? hoverBackgroundColor : backgroundColor
                border.color: Qt.rgba(1, 1, 1, 0.4)
		radius: 10
            }
	    font: defaultFont
            KeyNavigation.backtab: session
            KeyNavigation.tab: pw_entry
        }

        TextField {
            id: pw_entry
	    color: "white"
	    font: defaultFont
            echoMode: TextInput.Password
            focus: true
            placeholderText: textConstants.promptPassword
            width: 250
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 30
                color: pw_entry.activeFocus ? hoverBackgroundColor : backgroundColor
                border.color: Qt.rgba(1, 1, 1, 0.4)
                radius: 10
            }
            onAccepted: sddm.login(user_entry.getValue(), pw_entry.text, session.currentIndex)
            KeyNavigation.backtab: user_entry
            KeyNavigation.tab: loginButton
        }

        Simple.Button {
            id: loginButton
	    text: textConstants.login
	    font: defaultFont
            width: 250
	    background: Rectangle {
                implicitWidth: 100
                implicitHeight: 30
                color: pw_entry.activeFocus ? hoverBackgroundColor : backgroundColor
                border.color: Qt.rgba(1, 1, 1, 0.4)
                radius: 10
            }  
	    onClicked: sddm.login(user_entry.getValue(), pw_entry.text, session.currentIndex)
            KeyNavigation.backtab: pw_entry
            KeyNavigation.tab: suspend
        }
        
        Rectangle {
            id: errorMsgContainer
            width: 250
            height: loginButton.height
            color: "#F44336"
            clip: true
            visible: false
            
            Label {
                anchors.centerIn: parent
		text: textConstants.loginFailed
		font: defaultFont
                width: 240
                color: "white"
                elide: Qt.locale().textDirection == Qt.RightToLeft ? Text.ElideLeft : Text.ElideRight
                horizontalAlignment: Qt.AlignHCenter
            }
        }

    }

    Row {
        anchors {
            bottom: parent.bottom
            bottomMargin: 10
            horizontalCenter: parent.horizontalCenter
        }

        spacing: 5
        
        Simple.Button {
            id: suspend
	    text: textConstants.suspend
	    font: defaultFont
	    onClicked: sddm.suspend()
            visible: sddm.canSuspend
            KeyNavigation.backtab: loginButton
	    KeyNavigation.tab: hibernate
	    background: Rectangle {
                implicitWidth: 100
                implicitHeight: 30
                color: pw_entry.activeFocus ? hoverBackgroundColor : backgroundColor
                border.color: Qt.rgba(1, 1, 1, 0.4)
                radius: 10
            }
        }

        Simple.Button {
            id: hibernate
	    text: textConstants.hibernate
	    font: defaultFont
	    background: Rectangle {
                implicitWidth: 100
                implicitHeight: 30
                color: pw_entry.activeFocus ? hoverBackgroundColor : backgroundColor
                border.color: Qt.rgba(1, 1, 1, 0.4)
                radius: 10
            }
	    onClicked: sddm.hibernate()
            visible: sddm.canHibernate
            KeyNavigation.backtab: suspend
            KeyNavigation.tab: restart
        }
        
        Simple.Button {
            id: restart
	    text: textConstants.reboot
	    font: defaultFont
	    background: Rectangle {
                implicitWidth: 100
                implicitHeight: 30
                color: pw_entry.activeFocus ? hoverBackgroundColor : backgroundColor
                border.color: Qt.rgba(1, 1, 1, 0.4)
                radius: 10
            }
	    onClicked: sddm.reboot()
            visible: sddm.canReboot
            KeyNavigation.backtab: suspend; KeyNavigation.tab: shutdown
        }
        
        Simple.Button {
            id: shutdown
	    text: textConstants.shutdown
	    font: defaultFont
	    background: Rectangle {
                implicitWidth: 100
                implicitHeight: 30
                color: pw_entry.activeFocus ? hoverBackgroundColor : backgroundColor
                border.color: Qt.rgba(1, 1, 1, 0.4)
                radius: 10
            }
	    onClicked: sddm.powerOff()
            visible: sddm.canPowerOff
            KeyNavigation.backtab: restart; KeyNavigation.tab: session
        }
    }

    Simple.ComboBox {
        id: session
        anchors {
            left: parent.left
            leftMargin: 10
            top: parent.top
            topMargin: 10
        }
        currentIndex: sessionModel.lastIndex
        model: sessionModel
	textRole: "name"
	font: defaultFont
        width: 200
	padding: 4
	background: Rectangle {
                implicitWidth: 100
                implicitHeight: 30
                color: pw_entry.activeFocus ? hoverBackgroundColor : backgroundColor
                border.color: Qt.rgba(1, 1, 1, 0.4)
		radius: 10
	}
	visible: sessionModel.rowCount() > 1
        KeyNavigation.backtab: shutdown
        KeyNavigation.tab: user_entry
    }

    Rectangle {
        id: timeContainer
        anchors {
            top: parent.top
            right: parent.right
            topMargin: 10
            rightMargin: 10
        }
        color: backgroundColor
        width: timelb.width + 10
        height: session.height

        Label {
            id: timelb
            anchors.centerIn: parent
    	    text: Qt.formatDateTime(new Date(), " HH:mm ")
	        font: defaultFont
            color: "white"
	        horizontalAlignment: Text.AlignHCenter
	        padding: 4
	        background: Rectangle {
                implicitWidth: 50
                implicitHeight: 30
                color: pw_entry.activeFocus ? hoverBackgroundColor : backgroundColor
		        border.color: Qt.rgba(1, 1, 1, 0.4)
		        radius: 10
            }
        }
    }

    Timer {
        id: timetr
        interval: 500
        repeat: true
	running: true
        onTriggered: {
            timelb.text = Qt.formatDateTime(new Date(), " HH:mm ")
        }
    }
}
