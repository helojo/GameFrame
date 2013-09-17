package com.frame.events
{
	import flash.events.Event;

    public class FrameEvent extends Event
    {
        public var data:Object;

        public function FrameEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
        }

        public function dispatch() : Boolean
        {
            return FrameEventDispatcher.getInstance().dispatchEvent(this);
        }

    }
}
