package com.frame.resource
{

    public class LoadingTask extends Object
    {
        public var key:String = "";
        public var startTime:int = 0;
        public var loadNum:int = 0;
        public var indexNum:int = 0;
        public var indexVO:LoadingVO;
        public var loadingList:Vector.<LoadingVO>;
        public var completeFun:Function;

        public function LoadingTask()
        {
            loadingList = new Vector.<LoadingVO>;
            loadNum = 0;
            indexNum = 0;
        }

        public function addLoadingVO(vo:LoadingVO) : void
        {
            if (this.hasLoadingVO(vo.name))
            {
                return;
            }
            loadingList.push(vo);
            loadNum = loadNum + 1;
        }

        public function addLoadingVOList(list:Vector.<LoadingVO>) : void
        {
            var i:int = 0;
            while (i < list.length)
            {
                
                addLoadingVO(list[i]);
                i++;
            }
        }

        public function getLoadingVO() : LoadingVO
        {
            if (isComplete())
            {
                return null;
            }
            indexNum = indexNum + 1;
            indexVO = loadingList.shift();
            return indexVO;
        }

        public function hasLoadingVO(name:String) : Boolean
        {
            var vo:LoadingVO;
            var i:int = 0;
            while (i < loadingList.length)
            {
                
                vo = loadingList[i];
                if (vo.name == name)
                {
                    return true;
                }
                i++;
            }
            return false;
        }

        public function isComplete() : Boolean
        {
            return loadingList.length == 0;
        }

        public function getLoadingCount() : int
        {
            return loadingList.length;
        }

        public function executionCompleteFun() : void
        {
            if (completeFun is Function)
            {
                if (completeFun.length == 1)
                {
                    completeFun(key);
                }
                else
                {
                    completeFun();
                }
            }
            destroy();
        }

        public function destroy() : void
        {
            indexVO = null;
            loadingList = null;
            completeFun = null;
        }

    }
}
