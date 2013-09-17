package com.frame.resource.loadtypes
{
	import com.frame.resource.LoadingTask;
	import com.frame.resource.LoadingVO;
	import com.frame.resource.ProgressData;
	import com.frame.resource.Resource;
	
	import flash.events.ErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;

    public class Load extends Object implements ILoad
    {
        protected var completeFun:Function;
        protected var errorFun:Function;
        protected var progressFun:Function;
        protected var task:LoadingTask;
        protected var vo:LoadingVO;
        protected var maxTries:int = 1;
        protected var numTries:int = 0;

        public function Load()
        {
        }

        public function allocationFun(complete:Function, error:Function, progress:Function) : void
        {
            this.completeFun = complete;
            this.errorFun = error;
            this.progressFun = progress;
        }

        public function setLoadingTesk(task:LoadingTask) : void
        {
            this.task = task;
        }

        public function setLoadingVO(vo:LoadingVO) : void
        {
            this.vo = vo;
        }

        public function load() : void
        {
        }

        public function stop() : void
        {
        }

        public function destroy() : void
        {
            this.completeFun = null;
            this.errorFun = null;
            this.progressFun = null;
            this.task = null;
            this.vo = null;
        }

        protected function cacheData(data:Object) : void
        {
            Resource.cacheResource(vo.type, vo.name, data);
        }

        protected function createErrorEvent(param1:Error) : SecurityErrorEvent
        {
            return new SecurityErrorEvent("LoadingError", false, false, param1.message);
        }

        protected function onProgressHandle(event:ProgressEvent) : void
        {
            var pro:ProgressData;
            if (progressFun is Function)
            {
                if (progressFun.length == 1)
                {
					pro = ProgressData.createInstance();
					pro.bytesLoaded = event.bytesLoaded;
					pro.bytesTotal = event.bytesTotal;
					pro.task = this.task;
                    if (pro.bytesTotal == 0)
                    {
						pro.bytesTotal = this.vo.size;
                    }
                    progressFun(pro);
                }
                else if (progressFun.length == 0)
                {
                    progressFun();
                }
            }
        }

        protected function executeCompleteFun() : void
        {
            if (completeFun is Function)
            {
                completeFun(this);
            }
        }

        protected function errorHandle(event:ErrorEvent) : void
        {
            if (errorFun is Function)
            {
                if (errorFun.length == 1)
                {
                    errorFun(vo);
                }
                else if (errorFun.length == 0)
                {
                    errorFun();
                }
            }
            destroy();
        }

        protected function onIOErrorHandler(event:IOErrorEvent) : void
        {
            numTries = numTries + 1;
            Log.addLog("IOError:" + this.vo.name);
            event.stopPropagation();
            if (this.numTries < this.maxTries)
            {
                this.load();
            }
            else
            {
                this.errorHandle(event);
            }
        }

        protected function onSecurityErrorHandler(event:SecurityErrorEvent) : void
        {
            Log.addLog("安全错误" + this.vo.name);
            event.stopPropagation();
            this.errorHandle(event);
        }

    }
}
