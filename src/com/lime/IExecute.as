/**
 * Created by linming on 14-11-5.
 */
package com.lime {
public interface IExecute {

    /**
     * 执行
     * 当观察者派发通知时，接口实现类所注册的对应识标时执行本方法！
     *
     * @param tContent
     */
    function execute(...arg):void;

    /**
     * 释放
     * 移除观察对接口实现类的实例的引用！
     * 释放不会立即生效！
     */
    function dispose():void;

    function initExecute(target:Object, type:Object):void;
}
}
