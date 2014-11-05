/**
 * Created by linming on 14-11-5.
 */
package com.lime {
public interface IMediator {

    /**
     * 需要实现 当中介类激活时所要处理的逻辑
     */
    function activate():void;


    /**
     * 需要实现 当所关注的数据代理更新时所要处理的逻辑
     * 数据代理 支持重载
     *
     * @param proxy 添加所要关注的数据代理！
     */
    function update(proxy:Proxy):void;

    /**
     * 需要实现 当中介类灭活时所要处理的逻辑
     */
    function inactivate():void;
}
}
