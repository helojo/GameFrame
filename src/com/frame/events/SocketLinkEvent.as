package com.frame.events
{

    public class SocketLinkEvent extends FrameEvent
    {
        public var cmdType:int;

        public function SocketLinkEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
        }

    }
}
