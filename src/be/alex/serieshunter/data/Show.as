package be.alex.serieshunter.data {
import be.alex.serieshunter.util.Arrays;

import flash.filesystem.File;

[RemoteClass]
public class Show {

    private var _path:String

    private var _epguidesUrl:String

    private var _name:String

    private var _episodes:Array = []

    public function Show() {
    }

    public function get episodes():Array {
        return _episodes;
    }


    public function set episodes(value:Array):void {
        _episodes = value;
    }

    public function get name():String {
        return _name;
    }

    public function set name(value:String):void {
        _name = value;
    }


    public function get path():String {
        return _path;
    }

    public function set path(value:String):void {
        _path = value;
    }

    public function get epguidesUrl():String {
        return _epguidesUrl;
    }

    public function set epguidesUrl(value:String):void {
        _epguidesUrl = value;
    }

    public function get numberOfEpisodesWanted():int {
        return Arrays.count(_episodes, function(episode:Episode) {
            return episode.status == "wanted" && episode.isAired
        })
    }

    public function get nextAirDate():Date {
        var unaired:Array = Arrays.findAll(_episodes, function(episode:Episode) {
            return !episode.isAired
        })

        return Arrays.min(unaired, function(episode:Episode) {
            return episode.airDate
        })
    }

    public function getEpisode(season:int, number:int):Episode {
        return Arrays.find(_episodes, function(episode:Episode):Boolean {
            return episode.season == season && episode.number == number
        })
    }

    public function addEpisodes(episodes:Array):void {
        trace("Adding " + episodes.length + " episodes to " + name)

        Arrays.eachWithIndex(episodes, function(episode:Episode, index:int) {
            trace("Adding episode " + index + "/" + episodes.length + " to " + name + ": " + episode.code)

            var existingEpisode:Episode = getEpisode(episode.season, episode.number);

            if (existingEpisode == null) {
                _episodes.push(episode)
            }
            else {
                existingEpisode.airDate = episode.airDate
                existingEpisode.name = episode.name
            }
        })
    }

    public function get pathExists():Boolean {
        return new File(path).exists;
    }
}

}
