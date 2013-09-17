package com.frame.resource
{
	import flash.system.ApplicationDomain;

    public class LoadingVO extends Object
    {
        public var type:int;
        public var name:String;
        public var url:String;
        public var domain:ApplicationDomain;
        public var summary:String = "";
        public var size:int = 10000;
        public var Totle:int;
        public var Index:int;
        public static const IMAGE:int = 1;
        public static const SWF:int = 2;
        public static const XML:int = 3;
        public static const BINARY:int = 4;
        public static const SOUND:int = 5;
        public static const JSON:int = 6;
        public static const VIDEO:int = 7;

        public function LoadingVO(name:String = "", url:String = "", type:int = 1)
        {
            this.name = name;
            this.url = url;
            this.type = type;
            this.domain = new ApplicationDomain();
        }

    }
}
