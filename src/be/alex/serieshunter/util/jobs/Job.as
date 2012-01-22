/**
 * Created by IntelliJ IDEA.
 * User: Alex
 * Date: 1/05/11
 * Time: 16:22
 * To change this template use File | Settings | File Templates.
 */
package be.alex.serieshunter.util.jobs {
import flash.events.Event;
import flash.events.EventDispatcher;

public class Job extends EventDispatcher {
    private var _work:Function;
    private var _title:String;

    public function Job(title:String, work:Function) {
        _work = work;
        _title = title;
    }

    public function done() {
        dispatchEvent(new Event("done"))
    }

    public function get work():Function {
        return _work;
    }

    public function get title():String {
        return _title;
    }
}
}
