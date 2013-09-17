package com.frame.net.http
{

    public class HTTPBatching extends Object
    {
        protected var fun:Function;
        protected var list:Array;
        protected var volist:Vector.<HttpVO>;

        public function HTTPBatching(arr:Array, func:Function)
        {
            volist = new Vector.<HttpVO>;
            list = arr;
            fun = func;
            nextLoad();
        }

        protected function nextLoad() : void
        {
            if (list.length < 2)
            {
                allComplete();
                return;
            }
            var _loc_1:* = list.shift();
            var _loc_2:* = list.shift();
            HTTPService.getInstance().call(_loc_1, this.indexLoadComplete, _loc_2);
            return;
        }

        protected function indexLoadComplete(param1:HttpVO) : void
        {
            this.volist.push(param1);
            this.nextLoad();
            return;
        }

        protected function allComplete() : void
        {
            if (this.fun is Function)
            {
                if (this.fun.length == 1)
                {
                    this.fun(this.volist);
                }
                else if (this.fun.length == 0)
                {
                    this.fun();
                }
            }
            this.fun = null;
            this.list = null;
            this.volist = null;
            return;
        }

    }
}
