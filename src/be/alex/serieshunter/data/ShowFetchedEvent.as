/**
 * Created by IntelliJ IDEA.
 * User: Alex
 * Date: 30/04/11
 * Time: 18:48
 * To change this template use File | Settings | File Templates.
 */
package be.alex.serieshunter.data {
import flash.events.Event;

public class ShowFetchedEvent extends Event {
    private var _show:Show;
    private var _index:int;
    private var _total:int;

    public function ShowFetchedEvent(show:Show, index:int, total:int) {
        super("showFetch")

        _show = show;
        _index = index;
        _total = total;
    }


    public function get show():Show {
        return _show;
    }

    public function get index():int {
        return _index;
    }

    public function get total():int {
        return _total;
    }
}
}
