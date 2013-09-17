package com.frame.net.http
{
	import flash.net.URLVariables;

    public class DefaultConfig extends Object implements IHTTPConfig
    {

        public function DefaultConfig()
        {
        }

        public function getURL(url:String) : String
        {
            return url;
        }

        public function getDataFormat(format:String = null) : String
        {
            return "text";
        }

        public function getContentType(type:String = null) : String
        {
            return "application/x-www-form-urlencoded";
        }

        public function getMethod(name:String = null) : String
        {
            return "GET";
        }

        public function formatSendData(data:Object = null) : Object
        {
            if (data == null)
            {
				data = new URLVariables();
            }
            return data;
        }

        public function createHttpVO(url:String, data:Object) : HttpVO
        {
            var vo:HttpVO;
			vo = new HttpVO();
			vo.command = url;
			vo.url = getURL(url);
			vo.sendData = formatSendData(data);
            return vo;
        }

    }
}
