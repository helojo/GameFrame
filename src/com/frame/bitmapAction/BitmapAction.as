package com.frame.bitmapAction
{
	import flash.display.BitmapData;

    public class BitmapAction extends Object
    {
        private var _currentFrame:int = 1;
        private var _totalFrames:int = 1;
        private var _playing:Boolean = true;
        public var x:int = 0;
        public var y:int = 0;
        public var source:BitmapData;
        public var repeat:Boolean = true;
        public var playCount:int = 0;
        protected var frameList:Vector.<BitmapFrame>;
        protected var time:int = 0;

        public function BitmapAction()
        {
            frameList = new Vector.<BitmapFrame>;
        }

        public function get currentFrame() : int
        {
            return _currentFrame;
        }

        public function get totalFrames() : int
        {
            return _totalFrames;
        }

        public function get playing() : Boolean
        {
            return _playing;
        }

        public function get currentBitmapFrame() : BitmapFrame
        {
            return frameList[(_currentFrame - 1)];
        }

        public function get totalTime() : int
        {
            var frame:int = 0;
            var i:int = 0;
            while (i < frameList.length)
            {
                
				frame = frame + frameList[i].duration;
                i++;
            }
            return frame;
        }

        public function play() : void
        {
            _playing = true;
            time = 0;
            return;
        }

        public function stop() : void
        {
            _playing = false;
            time = 0;
            return;
        }

        public function gotoAndPlay(frame:int) : void
        {
            _currentFrame = frame;
            if (_currentFrame > _totalFrames)
            {
                _currentFrame = _totalFrames;
            }
            if (_currentFrame < 1)
            {
                _currentFrame = 1;
            }
            _playing = true;
            time = 0;
            return;
        }

        public function gotoAndStop(frame:int) : void
        {
            _currentFrame = frame;
            if (_currentFrame > _totalFrames)
            {
                _currentFrame = _totalFrames;
            }
            if (_currentFrame < 1)
            {
                _currentFrame = 1;
            }
            _playing = false;
            time = 0;
            return;
        }

        public function clone() : BitmapAction
        {
            var action:BitmapAction = new BitmapAction();
			action.setBitmapFrameList(frameList);
			action.source = source;
			action.repeat = repeat;
            return action;
        }

        public function getFrame(frame:int) : BitmapFrame
        {
            if (frame > _totalFrames)
            {
				frame = _totalFrames;
            }
            if (frame < 1)
            {
				frame = 1;
            }
            return frameList[(frame - 1)];
        }

        public function run(frame:int) : void
        {
            if (!_playing)
            {
                return;
            }
            time = time + frame;
            forward();
            return;
        }

        public function draw(frame:BitmapData) : void
        {
//			if(source)
           		currentBitmapFrame.draw(frame, x, y, source);
        }

        public function drawAlpha(frame:BitmapData, param2:uint = 255) : void
        {
            if (param2 == 0)
            {
                return;
            }
            if (param2 >= 255)
            {
                draw(frame);
                return;
            }
            currentBitmapFrame.drawAlpha(frame, x, y, source, param2);
            return;
        }

        public function destroy(param1:Boolean = false) : void
        {
            source = null;
            frameList = null;
            return;
        }

        public function setXMlData(param1:XML) : void
        {
            var _loc_3:BitmapFrame = null;
            if (frameList.length > 0)
            {
                return;
            }
            var _loc_2:* = param1.children();
            _totalFrames = _loc_2.length();
            var _loc_4:int = 0;
            while (_loc_4 < _totalFrames)
            {
                
                _loc_3 = new BitmapFrame();
                _loc_3.setXMlData(_loc_2[_loc_4]);
                frameList.push(_loc_3);
                _loc_4++;
            }
            return;
        }

        public function setObjectData(param1:Info) : void
        {
            var bmp:BitmapFrame = null;
            if (frameList.length > 0)
            {
                return;
            }
            _totalFrames = param1.frameinfo.length;
            var i:int = 0;
            while (i < _totalFrames)
            {
                
				bmp = new BitmapFrame();
				bmp.setObjectData(param1.frameinfo[i]);
                frameList.push(bmp);
                i++;
            }
        }

        public function setBitmapFrameList(param1:Vector.<BitmapFrame>) : void
        {
            _totalFrames = param1.length;
            frameList = param1;
            return;
        }

        private function forward() : void
        {
            var _loc_1:* = currentBitmapFrame;
            if (_loc_1.isStop)
            {
                return;
            }
            if (time >= _loc_1.duration)
            {
                time = time - _loc_1.duration;
                if (_loc_1.gotoFrame > 0)
                {
                    _currentFrame = _loc_1.gotoFrame;
                }
                else
                {
                    _currentFrame = _currentFrame + 1;
                }
                if (_currentFrame > _totalFrames)
                {
                    if (repeat)
                    {
                        _currentFrame = _currentFrame - _totalFrames;
                    }
                    else
                    {
                        _currentFrame = _totalFrames;
                    }
                    playCount = _currentFrame + 1;
                }
                forward();
            }
            return;
        }

    }
}
