package com.frame.resource.loadtypes
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

    public class XmlItem extends Load
    {
        protected var urlloader:URLLoader;

        public function XmlItem()
        {
        }

        override public function load() : void
        {
            this.urlloader = new URLLoader();
            this.urlloader.dataFormat = URLLoaderDataFormat.TEXT;
            this.urlloader.addEventListener(ProgressEvent.PROGRESS, onProgressHandle);
            this.urlloader.addEventListener(Event.COMPLETE, this.onCompleteHandle);
            this.urlloader.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
            this.urlloader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);
            try
            {
                this.urlloader.load(new URLRequest(vo.url));
            }
            catch (e:Error)
            {
                onSecurityErrorHandler(createErrorEvent(e));
            }
        }

        protected function onCompleteHandle(event:Event) : void
        {
            var e:Event = event;
            cleanListeners();
            try
            {
                cacheData(new XML(urlloader.data));
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
