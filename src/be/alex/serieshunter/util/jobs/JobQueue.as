/**
 * Created by IntelliJ IDEA.
 * User: Alex
 * Date: 1/05/11
 * Time: 16:20
 * To change this template use File | Settings | File Templates.
 */
package be.alex.serieshunter.util.jobs {
import flash.events.Event;
import flash.events.EventDispatcher;

public class JobQueue extends EventDispatcher {
    private static var _instance:JobQueue = new JobQueue()

    public static function get instance() {
        return _instance
    }

    private var _jobs:Array = []

    private var _status:String = "idle"

    public function schedule(job:Job) {
        _jobs.push(job)

        work()
    }

    private function work():void {
        if (_status == "idle") {
            executeNextJob()
        }
    }

    private function set status(status:String) {
        this._status = status

        dispatchEvent(new Event(status))
    }

    private function executeNextJob():void {
        if (haveJobs) {
            status = "working"

            var job:Job = _jobs.shift()

            job.addEventListener("done", function(event:Event) {
                jobDone(job)
            })

            job.work(job)

            dispatchEvent(new JobQueueEvent(job, "jobStarted"))
        }
        else {
            status = "idle"
        }
    }

    private function get haveJobs():Boolean {
        return _jobs.length > 0;
    }

    private function jobDone(job:Job):void {
        dispatchEvent(new JobQueueEvent(job, "done"))

        executeNextJob()
    }

    public function get lastJob():Job {
        return _jobs[_jobs.length - 1]
    }
}
}
