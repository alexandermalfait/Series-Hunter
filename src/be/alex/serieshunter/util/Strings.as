/**
 * Created by IntelliJ IDEA.
 * User: Alex
 * Date: 30/04/11
 * Time: 17:17
 * To change this template use File | Settings | File Templates.
 */
package be.alex.serieshunter.util {
public class Strings {

    public static function padLeft(string:String, padChar:String, length:int):String {
        while (string.length < length) {
            string = padChar + string
        }

        return string
    }
}
}
