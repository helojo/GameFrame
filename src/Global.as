package
{
	import flash.display.Stage;
	
	import starling.display.Sprite;
	import starling.display.Stage;
	
	public class Global extends Object
	{
		public static var version:String = "0.0.0.1";
		public static var ServerName:String = "";
		public static var company:String = "helojo";
		public static var welcome:String = "欢迎进入helojo";
		public static var debug:Boolean = true;
		public static var showLog:Boolean = true;
		public static var showWaiting:Boolean = false;
		public static var hasConfig:Boolean = false;
		public static var stage:starling.display.Stage;
		public static var app:Sprite;
		public static var origStage:flash.display.Stage;
		public static var loadCumulative:int = 0;
		public static var loadPercentage:int = 100;
		public static var loadOwnerName:String = "";
		public static var loadComplete:Boolean = false;
		public static var GameHost:String = "112.124.22.242";
		public static var GamePort:int = 8066;
		public static var OpenfireHost:String = "112.124.22.242";
		public static var OpenfireProt:int = 5222;
		public static var isoem:int = 0;
		public static var GameNameList:Array = [];
		public static var GameHttpList:Array = [];
		public static var GameHostList:Array = [];
		public static var maxPeople:int = 50;
		public static var Ping:String = "0";
		public static var Fps:Number = 60;
		private static var _MassageCMD:Boolean = false;
		public static var battleCommand:Boolean = true;
		public static var resUrl:String = "";
		public static var resMap:String = "res/map/";
		public static var resConfig:String = "res/database/configs/";
		public static var resDefaultBitmap:String = "res/database/tilesets/";
		public static var resAutoBitmap:String = "res/database/autotiles/";
		public static var resConfigs:String = "res/configs/";
		public static var resAction:String = "res/action/";
		public static var resSound:String = "res/sound/";
		public static var gridSize:int = 16;
		public static var gameWidth:int = 608;
		public static var gameHeight:int = 576;
		public static var halfGameWidth:int = 304;
		public static var halfGameHeight:int = 288;
		public static var minimapWidth:int = 180;
		public static var minimapHeight:int = 220;
		public static var cacheMap:int = 2;
		public static var serviceUrl:String = "http://112.124.22.242:8880/";
		public static var serviceUrlVcard:String = "http://112.124.22.242:8880/";
		public static var GameTime:String = "0-23";
		public static var serverIsLink:Boolean = false;
		public static var templateCount:int = 0;
		public static var newplayer:int = 1;
		public static var heartbeat:Boolean = true;
		public static var u:String;
		public static var p:String;
		public static var token:String;
		public static var uid:String;
		public static var nickname:String;
		public static var figureurl:String;
		public static var pf:String;
		public static var is_yellow_vip:int;
		public static var is_yellow_year_vip:int;
		public static var yellow_vip_level:int;
		public static var is_yellow_high_vip:int;
		public static var province:String;
		public static var city:String;
		public static var guest:int;
		public static var operatetype:String = "local";
		public static var isHz:int;
		public static var isHzYear:int;
		public static var HzLv:int;
		public static var isHzLuxury:int;
		public static var local:String = "Host:game.helojo.com";
		private static var stringList:Array = ["u", "p", "token", "uid", "nickname", "figureurl", "pf", "is_yellow_vip", "is_yellow_year_vip", "yellow_vip_level", "is_yellow_high_vip", "province", "local", "city", "operatetype", "guest", "GameHost", "GamePort", "resUrl", "serviceUrl", "serviceUrlVcard", "version", "showLog", "maxPeople", "GameTime", "OpenfireHost", "OpenfireProt"];
		private static var arrayList:Array = ["GameNameList", "GameHttpList", "GameHostList"];
		private static var booleanList:Array = ["isoem", "debug", "showWaiting"];
		
		public static function set data($data:Object) : void
		{
			var i:int = 0;
			var str:String = null;
			Global.hasConfig = true;
			i = 0;
			while (i < stringList.length)
			{
				
				str = stringList[i];
				if ($data.hasOwnProperty(str))
				{
					Global[str] = $data[str];
				}
				Log.addLog(str + ":" + $data[str]);
				i++;
			}
			Log.addLog("operatetype:" + operatetype);
			Log.addLog("GameHost:" + GameHost);
			Log.addLog("GamePort:" + GamePort);
			Log.addLog("operatetype:" + operatetype);
			Log.addLog("local:" + local);
//			Log.addLog("local1:" + local1);
			i = 0;
			while (i < arrayList.length)
			{
				
				str = arrayList[i];
				if ($data.hasOwnProperty(str))
				{
					Global[str] = $data[str].split(",");
				}
				i++;
			}
			i = 0;
			while (i < booleanList.length)
			{
				
				str = booleanList[i];
				if ($data.hasOwnProperty(str))
				{
					Global[str] = int($data[str]) > 0;
				}
				i++;
			}
			Log.showLog = Global.showLog;
		}
		
	}
}

