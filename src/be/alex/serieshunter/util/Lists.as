/**
 * Created by IntelliJ IDEA.
 * User: Alex
 * Date: 30/04/11
 * Time: 18:44
 * To change this template use File | Settings | File Templates.
 */
package be.alex.serieshunter.util {
import mx.collections.IList;

public class Lists {

    public static function each(list:IList, callback:Function) {
        for (var i = 0; i < list.length; i++) {
            callback(list.getItemAt(i))
        }
    }

    public static function eachWithIndex(list:IList, callback:Function) {
        for (var i = 0; i < list.length; i++) {
            callback(list.getItemAt(i), i)
        }
    }

    public static function find(list:IList, predicate:Function):* {
        for (var i = 0; i < list.length; i++) {
            if (predicate(list.getItemAt(i))) {
                return list.getItemAt(i)
            }
        }

        return null;
    }
}
}
