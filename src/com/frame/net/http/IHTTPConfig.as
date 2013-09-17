package com.frame.net.http
{

    public interface IHTTPConfig
    {

        function getURL(url:String) : String;

        function getDataFormat(param1:String = null) : String;

        function getContentType(type:String = null) : String;

        function getMethod(method:String = null) : String;

        function formatSendData(data:Object = null) : Object;

        function createHttpVO(url:String, data:Object) : HttpVO;

    }
}
