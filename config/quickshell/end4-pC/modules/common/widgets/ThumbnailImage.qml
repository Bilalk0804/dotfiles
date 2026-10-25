import QtQuick
import Quickshell
import Quickshell.Io
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.common.functions

/**
 * Thumbnail image. It currently generates to the right place at the right size, but does not handle metadata/maintenance on modification.
 * See Freedesktop's spec: https://specifications.freedesktop.org/thumbnail-spec/thumbnail-spec-latest.html
 */
StyledImage {
    id: root

    property bool generateThumbnail: true
    required property string sourcePath
    property string thumbnailSizeName: Images.thumbnailSizeNameForDimensions(sourceSize.width, sourceSize.height)
    function thumbnailPathFor(sizeName: string): string {
        if (sourcePath.length == 0 || !sizeName) return "";
        const resolvedUrlWithoutFileProtocol = FileUtils.trimFileProtocol(`${Qt.resolvedUrl(sourcePath)}`);
        // resolvedUrl may already be percent-encoded. Decode first so spaces are not encoded twice.
        const encodedUrlWithoutFileProtocol = resolvedUrlWithoutFileProtocol.split("/").map(part => {
            let decoded = part;
            try { decoded = decodeURIComponent(part); } catch (e) {}
            return encodeURIComponent(decoded);
        }).join("/");
        const md5Hash = Qt.md5(`file://${encodedUrlWithoutFileProtocol}`);
        return `${Directories.genericCache}/thumbnails/${sizeName}/${md5Hash}.png`;
    }
    property string thumbnailPath: thumbnailPathFor(thumbnailSizeName)
    // Smaller cached thumbs, then the file itself, so a missing size still draws.
    fallbacks: {
        const order = ["xx-large", "x-large", "large", "normal"];
        const paths = [];
        for (let i = 0; i < order.length; i++) {
            if (order[i] === root.thumbnailSizeName) continue;
            const path = root.thumbnailPathFor(order[i]);
            if (path.length > 0) paths.push(path);
        }
        if (root.sourcePath.length > 0) paths.push(root.sourcePath);
        return paths;
    }
    source: thumbnailPath

    asynchronous: true
    smooth: true
    mipmap: false

    opacity: status === Image.Ready ? 1 : 0
    Behavior on opacity {
        animation: Appearance.animation.elementMoveFast.numberAnimation.createObject(this)
    }

    onSourceSizeChanged: {
        if (!root.generateThumbnail) return;
        thumbnailGeneration.running = false;
        thumbnailGeneration.running = true;
    }
    Process {
        id: thumbnailGeneration
        command: {
            const maxSize = Images.thumbnailSizes[root.thumbnailSizeName];
            const thumbPath = FileUtils.trimFileProtocol(root.thumbnailPath);
            return ["bash", "-c",
                `[ -f '${thumbPath}' ] && exit 0 || { tmp='${thumbPath}.$$.tmp.png'; magick '${root.sourcePath}' -resize ${maxSize}x${maxSize} '\${tmp}' && mv '\${tmp}' '${thumbPath}' && exit 1; exit 2; }`
            ]
        }
        onExited: (exitCode, exitStatus) => {
            if (exitCode === 1) {
                root.source = "";
                root.source = root.thumbnailPath;
            }
        }
    }
}
