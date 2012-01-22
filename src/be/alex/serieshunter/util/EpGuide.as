/**
 * Created by IntelliJ IDEA.
 * User: Alex
 * Date: 30/04/11
 * Time: 12:41
 * To change this template use File | Settings | File Templates.
 */
package be.alex.serieshunter.util {
import be.alex.serieshunter.data.Episode;

import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class EpGuide {
    private var _url:String;

    public function EpGuide(url:String) {
        _url = url;
    }

    public function fetchEpisodes(callback:Function):void {

        var loader:URLLoader = new URLLoader();
        var request:URLRequest = new URLRequest(_url);

        trace("Hitting " + _url)

        loader.addEventListener(Event.COMPLETE, function(event:Event) {
            loadPageComplete(event.target.data, callback)
        });

        loader.load(request);
    }

    private function loadPageComplete(html:String, callback:Function):void {
        callback.call(null, extractEpisodes(html))
    }

    private function extractEpisodes(html:String):Array {
        trace("Extracting episodes from " + _url)

        var pattern = /\d+\s+(\d+)\-(\d+)\s+.*\s+(\d+\/[a-z]+\/\d+)\s+<a.+?>(.+?)<\/a>\s*/ig

        var episodes = []

        var match = pattern.exec(html)

        while (match != null) {
            trace("Got match: " + match)

            var episode = new Episode()

            episode.season = parseInt(match[1])
            episode.number = parseInt(match[2].replace(/^0/, ""))
            episode.name = match[4]

            episode.airDate = parseAirDate(match[3])

            episodes.push(episode)

            match = pattern.exec(html)
        }

        trace("Done extracting episodes")

        return episodes
    }

    private function parseAirDate(string:String):Date {
        var months = { Jan: 1, Feb: 2, Mar: 3, Apr: 4, May: 5, Jun: 6, Jul: 7, Aug: 8, Sep: 9, Oct: 10, Nov: 11, Dec: 12 }

        var match = string.match(/(\d+)\/([a-z]+)\/(\d+)/i)

        return new Date(parseInt(match[3]) + 2000, months[match[2]] - 1, parseInt(match[1].replace(/^0/, "")))
    }

}
}
