/**
 * Created by linming on 14-11-5.
 */
package com.lime {
public class Command {
    protected var type:Object;
    protected var zero:Zero;

    public function Command() {
    }

    public function initExecute(zero:Zero, type:Object):void {
        this.zero = zero;
        this.type = type;
        this["init"]();
    }

    protected function activate(key:Object):void {
        zero.activate(key);
    }


    protected function inactivate(key:Object):void {
        zero.inactivate(key);
    }

    public function dispose():void {
        zero.control.dispose(type);
    }


    public function command(key:Object, ...arg):void {
        zero.control.notify(key, arg);
    }

    public function getProxy(proxyClass:Class):Proxy {
        return zero.model.getProxy(proxyClass);
    }

}
}
