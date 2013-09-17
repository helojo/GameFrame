package 
{
	import com.frame.net.http.HTTPService;
	
	import flash.net.URLVariables;

    public class Log extends Object
    {
        public static var logList:Vector.<LogNode>;
        public static var showLog:Boolean = true;

        public function Log()
        {
            return;
        }

        public static function addLog(str:String, toServer:Boolean = false) : void
        {
            var variable:URLVariables = null;
            if (!showLog)
            {
                return;
            }
            logList = logList || new Vector.<LogNode>;
            logList.push(new LogNode(str));
			trace(str);
            if (toServer)
            {
				variable = new URLVariables();
				variable.username = Global.u;
				variable.log = str;
                HTTPService.getInstance().call("clientlog", null, variable);
            }
            return;
        }

    }
}
import flash.utils.getTimer;

final class LogNode extends Object
{
	public var time:int;
	public var message:String;
	public function LogNode(msg:String)
	{
		time= getTimer();
		message=msg;
	}
}
