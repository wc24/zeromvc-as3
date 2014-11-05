/**
 * Created by linming on 14-11-5.
 */
package com.lime {
import flash.utils.Dictionary;

public class ProxyPool {
    /**
     * 存放数据代理容器
     */
    public var pool:Dictionary;

    /**
     * 数据代理管理类
     */
    public function ProxyPool() {
        pool = new Dictionary();
    }

    /**
     * 释放 数据代理对象
     *
     * @param proxy
     * @return
     */
    public function dispose(proxy:Proxy):Boolean {
        if (pool[proxy] != null) {
            delete  pool[proxy];
            return true;
        } else {
            return false;
        }
    }

    /**
     * 获取数据代理
     * @param proxyClass
     * @return
     */
    public function getProxy(proxyClass:Class):Proxy {
        if (pool[proxyClass] == null) {
            pool[proxyClass] = new proxyClass();

        }
        return pool[proxyClass];
    }
}
}
