/**
 * Created by linming on 14-11-5.
 */
package com.lime {
import flash.utils.Dictionary;

public class Mediator {
    /**
     * 将中介进行分组，同组的中介只会有一个在激活状态
     */
    private var group:Object;
    private var type:Object;
    private var zero:Zero;

    private var pool:Dictionary;

    /**
     * 中介类！
     *
     * @param group 将中介进行分组的识标建议使用枚举，同组的中介只会有一个在激活状态
     */
    public function Mediator(group:Object = null) {
        this.group = group;
        pool = new Dictionary();
    }

    /**
     * 获取数据代理
     *
     * @param proxyClass 所要获取数据代理类的反射对象(如 Object.class)
     * @param <TProxy>   数据代理类的类型
     * @return 获取到的数据代理类
     */
    public function getProxy(proxyClass:Class):Proxy {
        return zero.model.getProxy(proxyClass);
    }

    /**
     * 中介类
     *
     * @param isActive
     */
    public function execute(isActive:Boolean):void {


        if (isActive) {
            if (group != null) {
                if (zero.mediatorKeyGroup[group] != null) {
                    if (zero.mediatorKeyGroup[group] != type) {
                        zero.inactivate(zero.mediatorKeyGroup[group]);
                        zero.mediatorKeyGroup[group] = type
                    }
                } else {
                    zero.mediatorKeyGroup[group] = type
                }
            }
            this["activate"]();
        } else {
            if (group != null && zero.mediatorKeyGroup[group] != null && zero.mediatorKeyGroup[group] == type) {
                delete zero.mediatorKeyGroup[group];
            }
            this["inactivate"]();
        }

    }

    /**
     * 初始化
     *
     * @param zero 对主类的引用
     * @param type 实例化对应识标
     */
    public function initExecute(zero:Zero, type:Object):void {
        this.zero = zero;
        this.type = type;
    }

    /**
     * 派发命令
     *
     * @param key  派发的命令识标
     * @param date 派发的数据对象
     */
    public function command(key:Object, ...arg):void {
        zero.control.notify(key, arg);
    }

    /**
     * 添加所要关注的数据代理！
     * 当数据代理进行更新时会执行 子类的update;
     * updtae方法 支持重载
     *
     * @param proxy 添加所要关注的数据代理！
     */
    public function addProxy(proxy:Proxy):void {
        proxy.bind(this);
        pool[proxy] = proxy;
    }

    public function removeProxy(proxy:Proxy):void {
        proxy.unbind(this);
        pool[proxy] = proxy;
    }

    public function clearProxy():void {
        for each (var proxy:Proxy in pool) {
            removeProxy(proxy);
        }
    }

    /**
     * 释放
     * 移除观察者中介类的实例的引用！
     * 释放不会立即生效！
     */
    public function dispose():void {
        zero.view.dispose(type);
        zero.inactivate(type);
    }

}
}
