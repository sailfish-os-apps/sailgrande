import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import "../components"
import "../Helper.js" as Helper
import "../MediaStreamMode.js" as MediaStreamMode


Page {
    allowedOrientations:  Orientation.All

    property var user
    property string next_id: ""
    property bool dataLoaded: false
    property int recentMediaSize: (width - 2 * Theme.paddingMedium) / 3

    onStatusChanged: {
        if (status === PageStatus.Active && !dataLoaded) {
            exploreData();
        }
    }

    SilicaFlickable {
        id: allView
        anchors.fill: parent
        contentHeight: column.height + header.height + 10
        contentWidth: parent.width

        PageHeader {
            id: header
            title: "Explore"
        }


        Column {
            anchors.top: header.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            id: column
            spacing: Theme.paddingSmall


            BusyIndicator {
                running: visible
                visible: !dataLoaded
                anchors.horizontalCenter: parent.horizontalCenter
            }


            GridView {
                width: parent.width
                height: allView.height
                cellWidth: width/3
                cellHeight: cellWidth

                clip: true



                anchors {
                    left: parent.left
                    right: parent.right
                }

                model: recentMediaModel

                delegate: Item {
                    property var item: model

                    width: parent.width/3
                    height: width

                    MainItemLoader{
                        id: mainLoader
                        anchors.fill: parent
                        width: parent.width
                        preview:true
                        clip: true

                        autoVideoPlay: false
                        isSquared: true
                    }

                    MouseArea {
                        id: mousearea
                        anchors.fill: parent
                        onClicked: {
                            if(item.special === 1) {
                                exploreData()
                                recentMediaModel.remove(model.index)
                            }
                            else pageStack.push(Qt.resolvedUrl("../pages/MediaDetailPage.qml"),{item:item});
                        }
                    }
                }

            }
        }
    }

    ListModel {
        id: recentMediaModel

    }

    function exploreData() {
        instagram.getExploreFeed(next_id);
    }

    Connections {
        target: instagram
        onExploreFeedDataReady:{
            //print(answer)
            var data = JSON.parse(answer);

            for(var i=1; i<data.items.length; i++) {
                recentMediaModel.append(data.items[i].media);
            }
            next_id = data.next_max_id
            dataLoaded=true;
            //data.items[0].image_version2.candidates[0].url= "../images/carusel.svg"
            data.items[0].media_type=1
            data.items[0].special=1
            recentMediaModel.append(data.items[0])
        }
    }
}
