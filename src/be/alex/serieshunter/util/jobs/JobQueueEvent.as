/**
 * Created by IntelliJ IDEA.
 * User: Alex
 * Date: 1/05/11
 * Time: 16:34
 * To change this template use File | Settings | File Templates.
 */
package be.alex.serieshunter.util.jobs {
import flash.events.Event;

public class JobQueueEvent extends Event {
    private var _job:Job;

    public function JobQueueEvent(job:Job, type:String) {
        super(type)
        _job = job;
    }


    public function get job():Job {
        return _job;
    }
}
}
