package com.frame.net.http
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

    public class URLItem extends Object
    {
        private var _connect:Boolean = false;
        protected var loader:URLLoader;
        protected var completeFun:Function;
        protected var errorFun:Function;
        protected var progressFun:Function;
        protected var vo:HttpVO;

        public function URLItem(format:String)
        {
            loader = new URLLoader();
            loader.dataFormat = format;
        }

        public function get connect() : Boolean
        {
            return _connect;
        }

        public function setErrorFun(err:Function) : void
        {
            errorFun = err;
        }

        public function setProgressFun(prog:Function) : void
        {
            progressFun = prog;
        }

        public function send(vo:HttpVO, request:URLRequest, func:Function = null) : void
        {
            vo = vo;
            completeFun = func;
            addEvent();
            loader.load(request);
        }

        public function destroy() : void
        {
            removeEvent();
            completeFun = null;
            errorFun = null;
            progressFun = null;
            loader.close();
            loader = null;
            vo = null;
        }

        private function addEvent() : void
        {
            loader.addEventListener(Event.OPEN, openHandle);
            loader.addEventListener(Event.COMPLETE, completeHandle);
            loader.addEventListener(IOErrorEvent.IO_ERROR, IOErrorHandle);
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandle);
            loader.addEventListener(ProgressEvent.PROGRESS, progressHandle);
        }

        private function removeEvent() : void
        {
            if (loader)
            {
                loader.removeEventListener(Event.OPEN, openHandle);
                loader.removeEventListener(Event.COMPLETE, completeHandle);
                loader.removeEventListener(IOErrorEvent.IO_ERROR, IOErrorHandle);
                loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandle);
                loader.removeEventListener(ProgressEvent.PROGRESS, progressHandle);
            }
        }

        private function openHandle(event:Event) : void
        {
            _connect = true;
        }

        private function completeHandle(event:Event) : void
        {
            _connect = false;
            removeEvent();
            vo.isComplete = true;
            vo.requestData = this.loader.data;
            if (completeFun is Function)
            {
                completeFun(vo);
            }
        }

        private function IOErrorHandle(event:IOErrorEvent) : void
        {
            event.stopPropagation();
            errorHandle();
        }

        private function securityErrorHandle(event:SecurityErrorEvent) : void
        {
            event.stopPropagation();
            errorHandle();
        }

        private function progressHandle(event:ProgressEvent) : void
        {
            if (progressFun is Function)
            {
                if (progressFun.length == 1)
                {
                    progressFun(event.bytesLoaded / event.bytesTotal);
                }
                else if (progressFun.length == 0)
                {
                    progressFun();
                }
            }
        }

        private function errorHandle() : void
        {
            _connect = false;
            removeEvent();
            if (errorFun is Function)
            {
                if (errorFun.length == 1)
                {
                    errorFun(vo);
                }
                else if (errorFun.length == 0)
                {
                    errorFun();
                }
            }
        }

    }
}
