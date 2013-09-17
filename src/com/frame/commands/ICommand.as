package com.frame.commands
{
	import com.frame.events.FrameEvent;

    public interface ICommand
    {
        function execute(event:FrameEvent) : void;

    }
}
