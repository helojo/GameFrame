package com.frame.resource.loadtypes
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;

    public class SoundItem extends Load
    {
        protected var loader:Sound;
        protected var context:SoundLoaderContext;

        public function SoundItem()
        {
        }

        override public function load() : void
        {
            this.loader = new Sound();
            this.loader.addEventListener(ProgressEvent.PROGRESS, onProgressHandle);
            this.loader.addEventListener(Event.COMPLETE, this.onCompleteHandle);
            this.loader.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
            this.context = new SoundLoaderContext();
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
                cacheData(this.loader);
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
                this.loader.removeEventListener(ProgressEvent.PROGRESS, onProgressHandle);
                this.loader.removeEventListener(Event.COMPLETE, this.onCompleteHandle);
                this.loader.removeEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
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
