/**
 * Created by IntelliJ IDEA.
 * User: Alex
 * Date: 30/04/11
 * Time: 18:44
 * To change this template use File | Settings | File Templates.
 */
package be.alex.serieshunter.util {
public class Arrays {

    public static function each(array:Array, callback:Function) {
        for (var i = 0; i < array.length; i++) {
            callback(array[i])
        }
    }

    public static function eachWithIndex(array:Array, callback:Function) {
        for (var i = 0; i < array.length; i++) {
            callback(array[i], i)
        }
    }

    public static function find(array:Array, predicate:Function) {
        for (var i = 0; i < array.length; i++) {
            if (predicate(array[i])) {
                return array[i]
            }
        }

        return null;
    }

    public static function findAll(array:Array, predicate:Function):Array {
        var found = []

        for (var i = 0; i < array.length; i++) {
            if (predicate(array[i])) {
                found.push(array[i])
            }
        }

        return found;
    }

    public static function count(array:Array, predicate:Function):int {
        var count:int = 0;

        each(array, function(item:Object) {
            if (predicate(item)) {
                count++
            }
        })

        return count
    }

    public static function max(array:Array, callback:Function):Date {
        var max = null

        each(array, function(item:Object) {
            var value = callback(item)

            if (value > max) {
                max = value
            }
        })

        return max
    }


    public static function min(array:Array, callback:Function):Date {
        var min = null

        each(array, function(item:Object) {
            var value = callback(item)

            if (min == null || value < min) {
                min = value
            }
        })

        return min
    }

}
}
