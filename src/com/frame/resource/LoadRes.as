package com.frame.resource
{
	import com.frame.resource.loadtypes.BinaryItem;
	import com.frame.resource.loadtypes.ILoad;
	import com.frame.resource.loadtypes.ImageItem;
	import com.frame.resource.loadtypes.JsonItem;
	import com.frame.resource.loadtypes.SoundItem;
	import com.frame.resource.loadtypes.SwfItem;
	import com.frame.resource.loadtypes.VideoItem;
	import com.frame.resource.loadtypes.XmlItem;

    public class LoadRes extends Object implements ILoadRes
    {
        protected var taskList:Vector.<LoadingTask>;
        protected var indexTask:LoadingTask;
        protected var _isLoading:Boolean = false;
        protected var progressFun:Function;
        protected var errorFun:Function;
        private static var instance:LoadRes;
		private static var typeClasses:Object = {image:ImageItem, swf:SwfItem, xml:XmlItem, binary:BinaryItem, sound:SoundItem, json:JsonItem, video:VideoItem};

        public function LoadRes()
        {
            taskList = new Vector.<LoadingTask>;
        }

        public function load(vo:LoadingVO, complete:Function = null, key:String = "", index:int = 0) : void
        {
            var tast:LoadingTask = new LoadingTask();
			tast.addLoadingVO(vo);
			tast.completeFun = complete;
			tast.key = key;
            addTask(tast, index);
            if (!_isLoading)
            {
                recursionLoadTask();
            }
        }

        public function loadList(list:Vector.<LoadingVO>, complete:Function = null, key:String = "", index:int = 0) : void
        {
            var task:LoadingTask = new LoadingTask();
			task.addLoadingVOList(list);
			task.completeFun = complete;
			task.key = key;
            addTask(task, index);
            if (!_isLoading)
            {
                recursionLoadTask();
            }
        }

        public function addLoad(key:String, vo:LoadingVO, complete:Function = null) : Boolean
        {
            var task:LoadingTask;
            if (indexTask && indexTask.key == key)
            {
                indexTask.addLoadingVO(vo);
                return true;
            }
            var i:int = 0;
            while (i < taskList.length)
            {
                
				task = taskList[i];
                if (task.key == key)
                {
					task.addLoadingVO(vo);
                    return true;
                }
                i++;
            }
            return false;
        }

        public function addLoadList(key:String, list:Vector.<LoadingVO>, complete:Function = null) : Boolean
        {
            var task:LoadingTask;
            if (indexTask && indexTask.key == key)
            {
                indexTask.addLoadingVOList(list);
                return true;
            }
            var i:int = 0;
            while (i < taskList.length)
            {
                
				task = this.taskList[i];
                if (task.key == key)
                {
					task.addLoadingVOList(list);
                    return true;
                }
                i++;
            }
            return false;
        }

        public function allocationFun(progress:Function, loaderr:Function) : void
        {
            progressFun = progress;
            errorFun = loaderr;
        }

        public function filtrateLoad(param1:LoadingVO) : Boolean
        {
            return hasRes(param1);
        }

        public function filtrateLoadList(voList:Vector.<LoadingVO>) : Vector.<LoadingVO>
        {
            var vos:Vector.<LoadingVO> = new Vector.<LoadingVO>;
            var i:int = 0;
            while (i < voList.length)
            {
                
                if (!this.hasRes(voList[i]))
                {
					vos.push(voList[i]);
                }
                i++;
            }
            return vos;
        }

        public function start() : void
        {
            if (!_isLoading)
            {
                recursionLoadTask();
            }
        }

        public function get taskCount() : int
        {
            return taskList.length;
        }

        public function get loadingCount() : int
        {
            var count:int = 0;
            var i:int = 0;
            while (i < taskList.length)
            {
                
				count = count + taskList[i].getLoadingCount();
                i++;
            }
            return count;
        }

        public function get isLoading() : Boolean
        {
            return _isLoading;
        }

        protected function addTask(task:LoadingTask, index:int) : void
        {
            if (index == 1)
            {
                taskList.unshift(task);
            }
            else if (index == 2)
            {
                taskList.unshift(task);
            }
            else
            {
                taskList.push(task);
            }
        }

        protected function getLoading(index:int) : ILoad
        {
            return new typeClasses[Resource.typeToString(index)] as ILoad;
        }

        protected function hasRes(vo:LoadingVO) : Boolean
        {
            return Resource.hasResource(vo.type, vo.name);
        }

        protected function recursionLoadTask() : void
        {
            if (indexTask)
            {
                recursionLoadVO();
                return;
            }
            if (taskList.length == 0)
            {
                _isLoading = false;
                return;
            }
            _isLoading = true;
            indexTask = taskList.shift();
            recursionLoadVO();
        }

        protected function recursionLoadVO() : void
        {
            var load:ILoad = null;
            if (!indexTask)
            {
                recursionLoadTask();
                return;
            }
            if (indexTask.isComplete())
            {
                indexTask.executionCompleteFun();
                indexTask = null;
                recursionLoadTask();
                return;
            }
            indexTask.getLoadingVO();
            if (this.hasRes(indexTask.indexVO))
            {
                recursionLoadVO();
                return;
            }
			load = getLoading(indexTask.indexVO.type);
			load.allocationFun(completeFun, errorFun, progressFun);
			load.setLoadingTesk(indexTask);
			load.setLoadingVO(indexTask.indexVO);
			load.load();
        }

        protected function completeFun(load:ILoad) : void
        {
			load.destroy();
            recursionLoadVO();
        }

        public static function getInstance() : LoadRes
        {
            if (!instance)
            {
                instance = new LoadRes;
            }
            return instance;
        }

    }
}
