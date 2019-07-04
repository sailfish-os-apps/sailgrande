import QtQuick 2.0
import Sailfish.Silica 1.0

BackgroundItem {
    id: userInfo

    property var item

    height: 100
    width: parent.width

    Image {
        id: profilpicture
        anchors.left: parent.left

        anchors.top: parent.top
        height: parent.height
        width: height
        source: item.profile_pic_url
    }

    Label {
        id:username
        text: item.username
        anchors.left: profilpicture.right
        anchors.leftMargin: Theme.paddingMedium
        anchors.verticalCenter: parent.verticalCenter
        truncationMode: TruncationMode.Fade
        color: Theme.primaryColor
    }

    onClicked: {
        pageStack.push(Qt.resolvedUrl("../pages/UserProfilPage.qml"),{user:item});
    }
}
