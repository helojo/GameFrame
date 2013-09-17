package com.frame.net.http
{

    public class HttpVO extends Object
    {
        public var command:String = "";
        public var url:String = "";
        public var sendData:Object;
        public var requestData:Object;
        public var isComplete:Boolean = false;

        public function HttpVO()
        {
        }

    }
}
