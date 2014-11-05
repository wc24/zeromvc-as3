/**
 * Created by linming on 14-11-5.
 */
package com.lime {
import flash.utils.Dictionary;

public class Observer {

    private var target:Object;
    private var pool:Dictionary = new Dictionary();
    private var instancePool:Dictionary = new Dictionary();

    /**
     * 观察者
     *
     * @param target 派发通知时的目标对象
     */
    public function Observer(target:Object = null) {
        if (target == null) {
            this.target = this;
        } else {
            this.target = target;
        }
        init();
    }

    private function init():void {
        pool = new Dictionary();
        instancePool = new Dictionary();
    }

    /**
     * 判断标识下是否存在监听
     * @param type 监听标识
     * @param className
     * @return
     */
    private function hasListener(type:Object, className:Class = null):Boolean {
        if (className == null) {
            return pool[type] != null;
        } else {
            return pool[type] != null && pool[type][className] != null;
        }
    }

    /**
     * 添加监听
     *
     * @param type      监听标识
     * @param classType 监听执行类的反射对象(如 Object.class)
     * @return
     */
    public function addListener(type:Object, classType:Class):Boolean {
        var out:Boolean = false;
        if (!hasListener(type, classType)) {
            pool[type] = new Dictionary();
        }
        if (!hasListener(type, classType)) {
            pool[type][classType] = classType;
            out = true;
        }
        return out;
    }

    /**
     * 移除监听
     *
     * @param type      监听标识
     * @param classType 监听执行类的反射对象(如 Object.class)
     * @return
     */
    public function removeListener(type:Object, classType:Class):Boolean {
        var out:Boolean = false;
        if (hasListener(type)) {
            delete pool[type][classType];
        }
        return out;
    }

    /**
     *消除标识下所有监听
     * @param type 监听标识
     * @return 是否消除成功
     */
    public function clearListener(type:Object):Boolean {
        var out:Boolean = false;
        if (hasListener(type)) {
            delete pool[type];
            out = true;
        }
        return out;
    }

    /**
     * 释放
     * @param type 监听标识
     * @return
     */
    public function dispose(type:Object):Boolean {
        if (instancePool[type]) {
            delete instancePool[type];
            return true;
        } else {
            return false;
        }

    }

    /**
     * 通知
     * @param type 监听标识
     * @param data 监听函数
     * @return 执行次数
     */

    public function notifys(type:Object, ...arg):int {
        return notify(type, arg);
    }

    public function notify(type:Object, arg:Array):int {
        var out:int;
        if (hasListener(type)) {
            for each (var classType in pool[type]) {
                var neure:Object = instancePool[classType];
                if (neure != null) {
                    neure["execute"].apply(null,arg);
                } else {
                    neure = new classType();
                    neure["initExecute"](target, type);
                    instancePool[classType] = neure;
                    neure["execute"].apply(null,arg);
                    out++;
                }
            }
        }
        return out;
    }
}
}
