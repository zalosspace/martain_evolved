import QtQuick 2.0
import SddmComponents 2.0

Rectangle {
    id: root
    width: 640
    height: 480
    color: "#E700EF"
    
    property date currentTime: new Date()
    property int sessionIndex: sessionSelector.index

    TextConstants { id: textConstants }

    function doLogin() {
        errorMessage.text = ""
        var username = userModel.lastUser
        sddm.login(username, password.text, sessionIndex)
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: currentTime = new Date()
    }

    Background {
        anchors.fill: parent
        source: "assets/login_bg.png"
        fillMode: Image.PreserveAspectCrop
        opacity: 0.85
    }

    // Time
    Text {
        text: Qt.formatDateTime(currentTime, "h:mm")
        font.pixelSize: 169
        font.family: "JetBrains Mono"
        color: "#FFFFFF"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -220
    }

    // Date
    Text {
        text: Qt.formatDateTime(currentTime, "dddd, MMMM d")
        font.pixelSize: 30
        font.family: "JetBrains Mono"
        color: "#FFFFFF"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -120
    }

    // Profile picture
    ShaderEffect {
        id: profilePic
        width: 170
        height: 170
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 30

        property variant source: Image {
            source: "assets/profile.jpg"
            fillMode: Image.PreserveAspectCrop
            smooth: true
        }

        fragmentShader: "
        uniform sampler2D source;
        varying vec2 qt_TexCoord0;
        void main() {
            vec2 c = qt_TexCoord0 - vec2(0.5);
            if (length(c) > 0.5)
            discard;
            gl_FragColor = texture2D(source, qt_TexCoord0);
        }
        "
    }

    // Username text 
    Text {
        id: userSelector
        text: userModel.lastUser
        color: "#FFFFFF"
        font.pixelSize: 16
        font.family: "JetBrains Mono"
        font.bold: true
        anchors.top: profilePic.bottom
        anchors.topMargin: 8
        anchors.horizontalCenter: parent.horizontalCenter
    }

    // Password field
    Rectangle {
        id: passwordRect
        width: 250
        height: 40
        radius: 15
        color: "#FFFFFF"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 180

        PasswordBox {
            id: password
            anchors.fill: parent
            anchors.margins: 5 
            font.letterSpacing: 4
            font.pixelSize: 16
            borderColor: "transparent"
            focusColor: "transparent"
            hoverColor: "transparent"
            font.family: "JetBrains Mono"
            
            Keys.onPressed: {
                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                    doLogin()
                    event.accepted = true
                }
            }
        }
    }

    // Show / Hide password
    Text {
        id: showPasswordText
        text: showPassword.checked ? "Hide" : "Show"
        color: "#FFFFFF"
        font.pixelSize: 12
        font.family: "JetBrains Mono"
        anchors.top: passwordRect.bottom
        anchors.topMargin: 8
        anchors.horizontalCenter: parent.horizontalCenter
        
        MouseArea {
            id: showPassword
            property bool checked: false
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                checked = !checked
                password.echoMode = checked ? TextInput.Normal : TextInput.Password
            }
        }
    }

    // Caps Lock warning
    Text {
        text: keyboard.capsLock ? "CAPS LOCK ON" : ""
        color: "#FFD166"
        font.pixelSize: 12
        font.family: "JetBrains Mono"
        anchors.top: showPasswordText.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
    }

    // Session selector
    ComboBox {
        id: sessionSelector
        model: sessionModel
        index: sessionModel.lastIndex
        width: 250
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 260
        font.pixelSize: 14
        font.family: "JetBrains Mono"
    }

    // Error message
    Text {
        id: errorMessage
        text: ""
        color: "#FF4D4D"
        font.pixelSize: 14
        font.family: "JetBrains Mono"
        horizontalAlignment: Text.AlignHCenter
        width: parent.width
        anchors.top: sessionSelector.bottom
        anchors.topMargin: 20
        opacity: text === "" ? 0 : 1
        
        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }
    }

    // Power menu
    Row {
        spacing: 25
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            text: "⏻"
            color: "#FFFFFF"
            font.pixelSize: 32
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: sddm.powerOff()
            }
        }
        
        Text {
            text: "↻"
            color: "#FFFFFF"
            anchors.top: parent.top
            anchors.topMargin: 4
            font.pixelSize: 26
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: sddm.reboot()
            }
        }
    }

    Connections {
        target: sddm
        
        onLoginFailed: {
            password.text = ""
            errorMessage.text = "Wrong password"
            password.focus = true
        }
        
        onInformationMessage: {
            errorMessage.text = message
        }
    }

    Component.onCompleted: {
        password.focus = true
    }
}
