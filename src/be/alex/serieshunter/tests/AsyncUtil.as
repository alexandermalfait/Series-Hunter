/**
 * Created by IntelliJ IDEA.
 * User: Alex
 * Date: 30/04/11
 * Time: 13:08
 * To change this template use File | Settings | File Templates.
 */
package be.alex.serieshunter.tests {
import flash.events.Event;
import flash.events.EventDispatcher;

import org.flexunit.async.Async;

public class AsyncUtil extends EventDispatcher {

    public static const ASYNC_EVENT:String = "asyncEvent";

    private var _testCase:Object;
    private var _callback:Function;
    private var _passThroughArgs:Array;
    private var _callbackArgs:Array;

    public function AsyncUtil(testCase:Object, callback:Function, passThroughArgs:Array = null) {
        _testCase = testCase;
        _callback = callback;
        _passThroughArgs = passThroughArgs;
    }

    public static function asyncHandler(testCase:Object, callback:Function, passThroughArgs:Array = null, timeout:Number = 1500):Function {
        var asyncUtil:AsyncUtil = new AsyncUtil(testCase, callback, passThroughArgs);
        asyncUtil.addEventListener(ASYNC_EVENT, Async.asyncHandler(testCase, asyncUtil.asyncEventHandler, timeout));
        return asyncUtil.asyncCallbackHandler;
    }

    public function asyncEventHandler(ev:Event, flexUnitPassThroughArgs:Object = null):void {
        if (_passThroughArgs) {
            _callbackArgs = _callbackArgs.concat(_passThroughArgs);
        }
        _callback.apply(null, _callbackArgs);
    }

    public function asyncCallbackHandler(...args:Array):void {
        _callbackArgs = args;
        dispatchEvent(new Event(ASYNC_EVENT));
    }

}
}
