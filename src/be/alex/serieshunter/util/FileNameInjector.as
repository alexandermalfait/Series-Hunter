/**
 * Created by IntelliJ IDEA.
 * User: Alex
 * Date: 22/01/12
 * Time: 12:40
 * To change this template use File | Settings | File Templates.
 */
package be.alex.serieshunter.util {
import be.alex.serieshunter.data.Episode;

import flash.filesystem.File;

public class FileNameInjector {
    private var _episode:Episode;

    public function FileNameInjector(episode:Episode) {
        _episode = episode;
    }

    public function injectTitle():void {
        var file:File = new File(_episode.filePath)

        var match:Array = file.name.match(/(.+)\.(.+?)$/)

        if(match) {
            var baseName:String = match[1]
            var extension:String = match[2]

            Arrays.each(file.parent.getDirectoryListing(), function(relatedFile:File) {
                if(relatedFile.name.indexOf(baseName) == 0) {
                    renameFile(relatedFile);
                }
            })
        }
    }

    private function renameFile(file:File):void {
        var relatedMatch:Array = file.name.match(/(.+)\.(.+?)$/)

        var relatedBaseName:String = relatedMatch[1]
        var relatedExtension:String = relatedMatch[2]

        var newName = cleanFileName(relatedBaseName + " - " + _episode.name + "." + relatedExtension)

        var target:File = file.parent.resolvePath(newName)

        file.moveTo(target, false)

        _episode.filePath = target.nativePath
    }

    private function cleanFileName(fileName:String):String {
        return fileName.replace(/\/|\\|\*|\?|:|!/g, "_")
    }
}
}
