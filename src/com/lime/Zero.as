/**
 * Created by linming on 14-11-5.
 */
package com.lime {
import flash.utils.Dictionary;

public class Zero {
    public var control:Observer;
    public var view:Observer;
    public var model:ProxyPool;

    /**
     * 将中介进行分组，同组的中介只会有一个在激活状态
     */
    public var mediatorKeyGroup:Dictionary;

    public function Zero() {
        control = new Observer(this);
        view = new Observer(this);
        model = new ProxyPool();
    }

    /**
     * 添加命令
     *
     * @param key          命令的枚举值
     * @param commandClass 所要添加的命令类的反射对象(如 Object.class)
     */
    public function addCommand(key:Object, commandClass:Class):void {
        control.addListener(key, commandClass);
    }

    /**
     * 移除命令
     *
     * @param key          命令的枚举值
     * @param commandClass 所要添加的命令类的反射对象(如 Object.class)
     */
    public function removeCommand(key:Object, commandClass:Class):void {
        control.removeListener(key, commandClass);

    }

    /**
     * 添加中介
     *
     * @param key           中介的枚举值
     * @param mediatorClass 所要添加的中介类的反射对象(如 Object.class)
     */
    public function addMediator(key:Object, mediatorClass:Class):void {
        view.addListener(key, mediatorClass);

    }

    /**
     * 移除中介
     *
     * @param key           中介的枚举值
     * @param mediatorClass 所要添加的中介类的反射对象(如 Object.class)
     */
    public function removeMediator(key:Object, mediatorClass:Class):void {
        view.removeListener(key, mediatorClass);

    }

    /**
     * 灭活中介
     *
     * @param key 中介的枚举值
     */
    public function inactivate(key:Object):void {
        view.notifys(key, false);
    }

    /**
     * 激活中介
     *
     * @param key 中介的枚举值
     */
    public function activate(key:Object):void {
        view.notifys(key, true);

    }

    /**
     * 派发命令
     *
     * @param key  命令的枚举值
     * @param date 派发命令的参数数据
     */
    public function command(key:Object, ...arg):void {
        control.notify(key, arg);

    }
}
}
