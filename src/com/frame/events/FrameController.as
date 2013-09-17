package com.frame.events
{
	import com.frame.commands.ICommand;
	
	import flash.utils.getQualifiedClassName;

    public class FrameController extends Object
    {
        private var commands:Object;
        private static var instance:FrameController;

        public function FrameController()
        {
            this.commands = {};
        }

        public function addCommand(cls:Class, useWeak:Boolean = true) : void
        {
            var cmd:String = getCommandName(cls);
            if (commands[cmd] != null)
            {
                return;
            }
            commands[cmd] = cls;
            FrameEventDispatcher.getInstance().addEventListener(cmd, executeCommand, false, 0, useWeak);
        }

        public function removeCommand(cmd:String) : void
        {
            if (commands[cmd] === null)
            {
                return;
            }
            FrameEventDispatcher.getInstance().removeEventListener(cmd, executeCommand);
            commands[cmd] = null;
            delete commands[cmd];
        }

        public function hasCommand(name:String) : Boolean
        {
            return commands[name] != null;
        }

        protected function executeCommand(event:FrameEvent) : void
        {
            var cls:Class = getCommand(event.type);
            var cmd:ICommand = new cls;
			cmd.execute(event);
        }

        protected function getCommand(name:String) : Class
        {
            var cmd:Class = commands[name];
            if (cmd == null)
            {
                throw new Error("命令列表中没有找到" + name + "所对应的类");
            }
            return cmd;
        }

        protected function getCommandName(cls:Class) : String
        {
            var str:String= cls["commandName"];
            if (str && str.length > 0)
            {
                return str;
            }
			str = getQualifiedClassName(cls);
            var hasClassName:int = str.indexOf("::");
            if (hasClassName != -1)
            {
				str = str.substr(hasClassName + 2);
            }
            return str;
        }

        public static function getInstance() : FrameController
        {
            if (!instance)
            {
                instance = new FrameController;
            }
            return instance;
        }

    }
}
