package com.frame.net.http
{
    public class HTTPBatchingVO extends Object
    {
        protected var fun:Function;
        protected var list:Vector.<HttpVO>;
        protected var index:int = 0;

        public function HTTPBatchingVO(param1:Vector.<HttpVO>, param2:Function)
        {
            this.list = param1;
            this.fun = param2;
            this.index = 0;
            this.nextLoad();
            return;
        }

        protected function nextLoad() : void
        {
            if (this.index >= this.list.length)
            {
                this.allComplete();
                return;
            }
            HTTPService.getInstance().callvo(this.list[this.index], this.indexLoadComplete);
            return;
        }

        protected function indexLoadComplete(param1:HttpVO) : void
        {
            index = index + 1;
            this.nextLoad();
            return;
        }

        protected function allComplete() : void
        {
            if (this.fun is Function)
            {
                if (this.fun.length == 1)
                {
                    this.fun(this.list);
                }
                else if (this.fun.length == 0)
                {
                    this.fun();
                }
            }
            this.fun = null;
            this.list = null;
        }

    }
}
