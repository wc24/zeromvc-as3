/**
 * Created by linming on 14-11-5.
 */
package com.lime {
import flash.utils.Dictionary;

public class Proxy {

    private var pool:Dictionary;

    public function Proxy():void {
        pool = new Dictionary();
    }

    /**
     * 更新数据，用于通知中介
     */
    public function update():void {
        for each (var mediator:Mediator in pool) {
            mediator["update"](this);
        }

    }

    /**
     * 绑定中介！中介关注时调用的方法
     * 不需要手机调用
     *
     * @param mediator
     */
    public function bind(mediator:Mediator):void {
        pool[mediator] = mediator;
    }

    /**
     * 解除绑定中介！
     * 不需要手机调用
     *
     * @param mediator
     */
    public function unbind(mediator:Mediator):void {
        delete pool[mediator]
    }
}
}
