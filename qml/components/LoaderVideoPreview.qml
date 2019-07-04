import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.prostogram.cache 1.0

Rectangle{
    width: parent.width
    height: parent.height

    CacheImage {
        id:cache
    }

    Image {
        id: mainImage
        anchors.fill: parent
        source: cache.getFromCache(item.image_versions2.candidates[1].url)
    }

    Image{
        source: "../images/volume-off.svg"
        width: parent.width/15
        height: parent.width/15

        sourceSize.height: height
        sourceSize.width: height

        anchors{
            left: parent.left
            leftMargin: parent.width/25
            bottom: parent.bottom
            bottomMargin: parent.width/25
        }
    }
}
