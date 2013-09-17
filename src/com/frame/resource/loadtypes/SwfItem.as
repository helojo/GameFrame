package com.frame.resource.loadtypes
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;

    public class SwfItem extends Load
    {
        protected var urlloader:URLLoader;
        protected var swfloader:Loader;
        protected var swfContext:LoaderContext;

        public function SwfItem()
        {
        }

        override public function load() : void
        {
            this.urlloader = new URLLoader();
            this.urlloader.dataFormat = URLLoaderDataFormat.BINARY;
            this.urlloader.addEventListener(ProgressEvent.PROGRESS, onProgressHandle);
            this.urlloader.addEventListener(Event.COMPLETE, this.onCompleteHandle);
            this.urlloader.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
            this.urlloader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);
            this.swfloader = new Loader();
            this.swfloader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.swfCompleteHandle);
            this.swfContext = new LoaderContext();
			swfContext.allowLoadBytesCodeExecution = true; 
            this.swfContext.applicationDomain = vo.domain;
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
            var e:* = event;
            try
            {
                this.swfloader.loadBytes((this.urlloader.data), this.swfContext);
            }
            catch (e:Error)
            {
                onSecurityErrorHandler(createErrorEvent(e));
            }
        }

        protected function swfCompleteHandle(event:Event) : void
        {
            var e:* = event;
            this.cleanListeners();
            try
            {
                cacheData(this.swfloader.contentLoaderInfo.applicationDomain);
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
            if (this.swfloader)
            {
                this.swfloader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.swfCompleteHandle);
            }
        }

        override public function destroy() : void
        {
            super.destroy();
            this.urlloader = null;
            this.swfloader = null;
            this.swfContext = null;
        }

    }
}
