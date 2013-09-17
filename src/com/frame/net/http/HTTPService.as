package com.frame.net.http
{
	
	import flash.net.URLRequest;
	import flash.net.URLVariables;

    public class HTTPService extends Object
    {
        protected var serviceList:Object;
        protected var config:IHTTPConfig;
        protected var errorFun:Function;
        protected var progressFun:Function;
        private static var instance:HTTPService;

        public function HTTPService()
        {
            serviceList = {};
            config = new DefaultConfig();
        }

        public function setConfig(conf:IHTTPConfig) : void
        {
            config = conf;
        }

        public function getConfig() : IHTTPConfig
        {
            return config;
        }

        public function setErrorFun(errorFunc:Function) : void
        {
            errorFun = errorFunc;
        }

        public function setProgressFun(progFun:Function) : void
        {
            progressFun = progFun;
        }

        public function call(url:String, callFun:Function = null, data:Object = null) : void
        {
            if (config.getURL(url) == "")
            {
                throw new Error(url + "远程地址不存在");
            }
            var vo:HttpVO = config.createHttpVO(url, data);
            var request:URLRequest= new URLRequest();
            new URLRequest().url = vo.url;
			request.data = vo.sendData;
			request.contentType = config.getContentType(url);
			request.method = config.getMethod(url);
           	getService(url).send(vo, request, callFun);
        }

        public function call1(url:String, callFun:Function = null, data:Object = null) : void
        {
            if (this.config.getURL(url) == "")
            {
                throw new Error(url + "远程地址不存在");
            }
            var vo:HttpVO= config.createHttpVO(url, data);
            var requs:URLRequest = new URLRequest();
            var rotes:Array = vo.url.split("/");
            var sUrl:Array = Global.serviceUrlVcard.split("/");
			rotes[2] = sUrl[2];
            var tem_url:String = "";
            var i:int = 0;
            while (i < rotes.length)
            {
                
                if (i == (rotes.length - 1))
                {
					tem_url = tem_url + rotes[i];
                }
                else
                {
					tem_url = tem_url + (rotes[i] + "/");
                }
                i++;
            }
			requs.url = tem_url;
			requs.data = vo.sendData;
			requs.contentType = this.config.getContentType(url);
			requs.method = this.config.getMethod(url);
            getService(url).send(vo, requs, callFun);
        }

        public function callvo(vo:HttpVO, func:Function = null) : void
        {
            if (vo.command == "" || vo.isComplete)
            {
                if (func is Function)
                {
                    if (func.length == 1)
                    {
						func(vo);
                    }
                    else
                    {
						func();
                    }
                }
                return;
            }
            if (vo.url == "")
            {
				vo.url = this.config.getURL(vo.command);
            }
            if (vo.url == "")
            {
                throw new Error(vo.command + "远程地址不存在");
            }
            if (vo.sendData && !(vo.sendData is URLVariables))
            {
                throw new Error("发送数据格式应该为URLVariables");
            }
            var request:URLRequest = new URLRequest();
			request.url = vo.url;
			request.data = vo.sendData;
			request.contentType = config.getContentType(vo.command);
			request.method = config.getMethod(vo.command);
            getService(vo.command).send(vo, request, func);
        }

        public function callList(urls:Array, func:Function = null) : void
        {
            new HTTPBatching(urls, func);
        }

        public function callvoList(vos:Vector.<HttpVO>, func:Function = null) : void
        {
            new HTTPBatchingVO(vos, func);
        }

        public function isSend(url:String) : Boolean
        {
            var service:* = serviceList[url];
            if (service == null)
            {
                return false;
            }
            return service.connect;
        }

        public function logout(url:String) : Boolean
        {
            var service:* = serviceList[url];
            if (service == null)
            {
                return false;
            }
			service.destroy();
            delete this.serviceList[url];
            return true;
        }

        private function getService(url:String) : URLItem
        {
            var service:URLItem= serviceList[url];
            if (service == null)
            {
				service = register(url);
            }
            return service;
        }

        private function register(url:String) : URLItem
        {
            var item:URLItem = new URLItem(config.getDataFormat(url));
			item.setErrorFun(errorFun);
			item.setProgressFun(progressFun);
            serviceList[url] = item;
            return item;
        }

        public static function getInstance() : HTTPService
        {
            if (!instance)
            {
                instance = new HTTPService;
            }
            return instance;
        }

    }
}
