package com.frame.resource.loadtypes
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

    public class ImageItem extends Load
    {
        protected var loader:Loader;
        protected var context:LoaderContext;

        public function ImageItem()
        {
        }

        override public function load() : void
        {
            this.loader = new Loader();
            this.loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandle);
            this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onCompleteHandle);
            this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
            this.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);
            this.context = new LoaderContext();
            this.context.checkPolicyFile = true;
            try
            {
                this.loader.load(new URLRequest(vo.url), this.context);
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
                cacheData(Bitmap(this.loader.content).bitmapData);
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
            if (this.loader)
            {
                this.loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgressHandle);
                this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onCompleteHandle);
                this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
                this.loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);
            }
        }

        override public function destroy() : void
        {
            super.destroy();
            this.loader = null;
            this.context = null;
        }

    }
}
