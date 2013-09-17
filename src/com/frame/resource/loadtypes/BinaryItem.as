package com.frame.resource.loadtypes
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;

    public class BinaryItem extends Load
    {
        protected var urlloader:URLLoader;

        public function BinaryItem()
        {
        }

        override public function load() : void
        {
            urlloader = new URLLoader();
            urlloader.dataFormat = URLLoaderDataFormat.BINARY;
            urlloader.addEventListener(ProgressEvent.PROGRESS, onProgressHandle);
            urlloader.addEventListener(Event.COMPLETE, onCompleteHandle);
            urlloader.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
            urlloader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);
            try
            {
                urlloader.load(new URLRequest(vo.url));
            }
            catch (e:Error)
            {
                onSecurityErrorHandler(createErrorEvent(e));
            }
        }

        protected function onCompleteHandle(event:Event) : void
        {
            var e:* = event;
            this.cleanListeners();
            try
            {
                cacheData(ByteArray(urlloader.data));
            }
            catch (e:Error)
            {
                onSecurityErrorHandler(createErrorEvent(e));
                return;
            }
            executeCompleteFun();
        }

        protected function cleanListeners() : void
        {
            if (this.urlloader)
            {
                this.urlloader.removeEventListener(ProgressEvent.PROGRESS, onProgressHandle);
                this.urlloader.removeEventListener(Event.COMPLETE, this.onCompleteHandle);
                this.urlloader.removeEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
                this.urlloader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);
            }
        }

        override public function destroy() : void
        {
            super.destroy();
            this.urlloader = null;
        }

    }
}
