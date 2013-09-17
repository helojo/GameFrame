package com.frame.resource
{

    public class ProgressData extends Object
    {
        public var bytesLoaded:uint;
        public var bytesTotal:uint;
        public var task:LoadingTask;

        public function ProgressData()
        {
            this.bytesLoaded = 0;
            this.bytesTotal = 1;
        }

        public function get percentage() : Number
        {
            return (this.bytesLoaded / this.bytesTotal + this.task.indexNum - 1) / this.task.loadNum * 100;
        }

        public function get percentageString() : String
        {
            return this.percentage.toFixed(2);
        }
		
		public function get message() : String
		{
			if (!this.task)
			{
				return "";
			}
			if (!this.task.indexVO)
			{
				return "";
			}
			return this.task.indexVO.summary;
		}

        public static function createInstance() : ProgressData
        {
            return new ProgressData;
        }

    }
}

