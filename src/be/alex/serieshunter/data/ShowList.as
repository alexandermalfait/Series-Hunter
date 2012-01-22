/**
 * Created by IntelliJ IDEA.
 * User: Alex
 * Date: 30/04/11
 * Time: 16:04
 * To change this template use File | Settings | File Templates.
 */
package be.alex.serieshunter.data {
import be.alex.serieshunter.util.EpGuide;
import be.alex.serieshunter.util.EpisodeFinder;
import be.alex.serieshunter.util.Lists;
import be.alex.serieshunter.util.jobs.Job;
import be.alex.serieshunter.util.jobs.JobQueue;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.filesystem.File;
import flash.net.SharedObject;

import mx.collections.ArrayList;

public class ShowList extends EventDispatcher {

    private static var _instance = new ShowList()

    public static function get instance():ShowList {
        return _instance;
    }

    private var sharedObject:SharedObject;

    function ShowList() {
        sharedObject = SharedObject.getLocal("SeriesHunter")
    }

    public function saveShow(show:Show) {
        if (!sharedObject.data.shows) {
            sharedObject.data.shows = new ArrayList()
        }

        var existingShow:Show = Lists.find(sharedObject.data.shows, function(existingShow:Show) {
            return existingShow.path == show.path
        })

        if (existingShow) {
            sharedObject.data.shows.setItemAt(show, sharedObject.data.shows.getItemIndex(existingShow))
        }
        else {
            sharedObject.data.shows.addItem(show)
        }

        sharedObject.flush()

        dispatchEvent(new Event("savedShow"))
    }

    public function get shows():ArrayList {
        if (sharedObject.data.shows) {
            return sharedObject.data.shows
        }
        else {
            return new ArrayList()
        }
    }



    public function removeShow(show:Show):void {
        delete sharedObject.data.shows.removeItem(show)
    }

    public function get lastShowPath():String {
        return sharedObject.data.lastShowPath
    }

    public function set lastShowPath(value:String) {
        sharedObject.data.lastShowPath = value
        sharedObject.flush()
    }

    public function updateShows():void {
        if (shows.length > 0) {
            Lists.eachWithIndex(shows, function(show:Show, index) {
                if(show.pathExists) {
                    JobQueue.instance.schedule(new Job("Fetching " + show.name, function(job:Job) {
                        var epGuide:EpGuide = new EpGuide(show.epguidesUrl)

                        epGuide.fetchEpisodes(function(episodes:Array) {
                            if (episodes) {
                                show.addEpisodes(episodes)

                                var finder:EpisodeFinder = new EpisodeFinder(show)

                                finder.updateEpisodes()

                                dispatchEvent(new ShowFetchedEvent(show, index, shows.length))

                                saveShow(show)

                                job.done()
                            }
                        })
                    }))
                }
            })
        }
    }
}
}
