/**
 * Created by IntelliJ IDEA.
 * User: Alex
 * Date: 1/05/11
 * Time: 16:52
 * To change this template use File | Settings | File Templates.
 */
package be.alex.serieshunter.util {
import be.alex.serieshunter.data.Episode;
import be.alex.serieshunter.data.Show;

import flash.filesystem.File;

public class EpisodeFinder {

    private var _show:Show;

    private var _episodesOnDisk:Array

    public function EpisodeFinder(show:Show) {
        _show = show;
    }

    public function updateEpisodes():void {
        determinesEpisodesOnDisk()

        Arrays.each(_show.episodes, function(episode:Episode) {
            var episodeOnDisk:Episode = getEpisodeOnDisk(episode);

            if (episodeOnDisk) {
                episode.status = "present"
                episode.filePath = episodeOnDisk.filePath
            }
            else {
                if (episode.status != "archived") {
                    episode.status = "wanted"
                }

                episode.filePath = null
            }

            trace(episode + " => " + episode.status)
        })
    }

    public function determinesEpisodesOnDisk():void {
        _episodesOnDisk = []

        var files:Array = fetchAllFiles(new File(_show.path))

        for each (var file:File in files) {
            if(file.name.match(/(srt|txt|idx|sub)$/i)) {
                trace("Skipping " + file.name)
            }
            else {
                trace("Examining " + file.name)

                var episode:Episode = findEpisode(file)

                if (episode) {
                    episode.filePath = file.nativePath
                    _episodesOnDisk.push(episode)
                }
            }
        }
    }

    public function getEpisodeOnDisk(episode:Episode):Episode {
        var index:int = _episodesOnDisk.indexOf(episode);

        if(index > -1) {
            return _episodesOnDisk[index]
        }
        else {
            return null
        }
    }

    private function findEpisode(file:File):Episode {
        var episodeNumber = extractEpisodeNumber(file)

        if (episodeNumber) {
            return _show.getEpisode(episodeNumber.season, episodeNumber.number)
        }
        else {
            return null;
        }
    }

    private var expressions = [
        /\b(\d+)x(\d+)\b/i, // 01x02
        /S(\d+)E(\d+)/i, // S01E02
        /\b(\d\d?)(\d\d)/ // (0)102
    ]

    private function extractEpisodeNumber(file:File):Object {
        for (var i:int = 0; i < expressions.length; i++) {
            var expression:RegExp = expressions[i]

            var match = file.name.match(expression)

            if (match) {
                return { season: parseInt(match[1].replace(/^0/, "")), number: parseInt(match[2].replace(/^0/, "")) }
            }
        }

        return null
    }

    private function fetchAllFiles(folder:File):Array {
        trace("Fetching files in " + folder.nativePath)

        var files:Array = []

        Arrays.each(folder.getDirectoryListing(), function(file:File) {

            if (file.isDirectory) {
                Arrays.each(fetchAllFiles(file), function(subFile:File) {
                    files.push(subFile)
                })
            }
            else {
                files.push(file)
            }
        })

        return files
    }
}
}
