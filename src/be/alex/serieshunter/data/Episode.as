/**
 * Created by IntelliJ IDEA.
 * User: Alex
 * Date: 30/04/11
 * Time: 12:30
 * To change this template use File | Settings | File Templates.
 */
package be.alex.serieshunter.data {
import be.alex.serieshunter.util.Strings;

import flash.filesystem.File;

[RemoteClass]
public class Episode {

    private var _season:int;

    private var _number:int;

    private var _name:String;

    private var _airDate:Date;

    private var _status:String = "wanted";

    private var _filePath:String;

    public function get season():int {
        return _season;
    }

    public function set season(value:int):void {
        _season = value;
    }

    public function get number():int {
        return _number;
    }

    public function set number(value:int):void {
        _number = value;
    }

    public function get name():String {
        return _name;
    }

    public function set name(value:String):void {
        _name = value;
    }


    public function get airDate():Date {
        return _airDate;
    }

    public function set airDate(value:Date):void {
        _airDate = value;
    }

    public function get code():String {
        return "S" + Strings.padLeft("" + season, '0', 2) + "E" + Strings.padLeft("" + number, '0', 2)
    }


    public function get status():String {
        return _status;
    }


    public function set status(value:String):void {
        _status = value;
    }


    public function toString():String {
        return code + " - " + name;
    }

    public function get isAired():Boolean {
        return airDate < new Date();
    }


    public function get filePath():String {
        return _filePath;
    }

    public function set filePath(value:String):void {
        _filePath = value;
    }

    public function get fileName():String {
        if(filePath != null) {
            return new File(filePath).name
        }
        else {
            return null
        }
    }
}


}
