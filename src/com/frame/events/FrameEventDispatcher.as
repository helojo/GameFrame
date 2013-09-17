package com.frame.events
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

    public class FrameEventDispatcher extends Object
    {
        private var eventDispatcher:IEventDispatcher;
        private static var instance:FrameEventDispatcher;

        public function FrameEventDispatcher(event:IEventDispatcher = null)
        {
            eventDispatcher = new EventDispatcher(event);
        }

        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
        {
            eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
        }

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            eventDispatcher.removeEventListener(param1, param2, param3);
        }

        public function dispatchEvent(event:Event) : Boolean
        {
            return eventDispatcher.dispatchEvent(event);
        }

        public function hasEventListener(param1:String) : Boolean
        {
            return eventDispatcher.hasEventListener(param1);
        }

        public function willTrigger(param1:String) : Boolean
        {
            return eventDispatcher.willTrigger(param1);
        }

        public static function getInstance() : FrameEventDispatcher
        {
            if (instance == null)
            {
                instance = new FrameEventDispatcher;
            }
            return instance;
        }

    }
}
