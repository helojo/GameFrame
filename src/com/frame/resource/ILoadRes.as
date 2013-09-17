package com.frame.resource
{

    public interface ILoadRes
    {

        function load(vo:LoadingVO, complete:Function = null, key:String = "", index:int = 0) : void;

        function loadList(list:Vector.<LoadingVO>,  complete:Function = null, key:String = "", index:int = 0) : void;

        function addLoad(key:String, vo:LoadingVO, complete:Function = null) : Boolean;

        function addLoadList(key:String, voList:Vector.<LoadingVO>, complete:Function = null) : Boolean;

        function allocationFun(progress:Function, loaderr:Function) : void;

        function filtrateLoadList(list:Vector.<LoadingVO>) : Vector.<LoadingVO>;

        function filtrateLoad(vo:LoadingVO) : Boolean;

        function start() : void;

        function get taskCount() : int;

        function get loadingCount() : int;

        function get isLoading() : Boolean;

    }
}
