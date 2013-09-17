package com.frame.bitmapAction
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;

    public class RotationAction extends Object
    {

        public function RotationAction()
        {
            return;
        }

        public static function rotation(param1:BitmapAction, param2:int) : BitmapAction
        {
            if (param2 == 90)
            {
                return rotation90(param1);
            }
            if (param2 == 180)
            {
                return rotation180(param1);
            }
            if (param2 == 270)
            {
                return rotation270(param1);
            }
            return param1;
        }

        private static function rotation90(bac:BitmapAction) : BitmapAction
        {
            var frames:Vector.<BitmapFrame>;
            var nframe:BitmapFrame;
            var frame:BitmapFrame;
            var height:int = bac.source.height;
            var width:int = bac.source.width;
            var bmpd:BitmapData = new BitmapData(height, width, true, 0);
            var martr:Matrix = new Matrix();
			martr.rotate(Math.PI * 0.5);
			martr.translate(height, 0);
			bmpd.draw(bac.source, martr);
			frames = new Vector.<BitmapFrame>;
            var totalF:* = bac.totalFrames;
            var i:int = 1;
            while (i <= totalF)
            {
                
				frame = bac.getFrame(i);
				nframe = new BitmapFrame();
				nframe.cutx = height - frame.cuty - frame.cuth;
				nframe.cuty = frame.cutx;
				nframe.cutw = frame.cuth;
				nframe.cuth = frame.cutw;
				nframe.regx = frame.cuth - frame.regy;
				nframe.regy = frame.regx;
				nframe.duration = frame.duration;
				nframe.isStop = frame.isStop;
				nframe.gotoFrame = frame.gotoFrame;
				nframe.EventType = frame.EventType;
				nframe.rect.x = nframe.cutx;
				nframe.rect.y = nframe.cuty;
				nframe.rect.width = nframe.cutw;
				nframe.rect.height = nframe.cuth;
				frames.push(nframe);
                i++;
            }
            var baction:BitmapAction = new BitmapAction();
			baction.source = bmpd;
			baction.setBitmapFrameList(frames);
			baction.repeat = bac.repeat;
            return baction;
        }

        private static function rotation180(param1:BitmapAction) : BitmapAction
        {
            var _loc_8:BitmapFrame = null;
            var _loc_9:BitmapFrame = null;
            var _loc_2:* = param1.source.height;
            var _loc_3:* = param1.source.width;
            var _loc_4:* = new BitmapData(_loc_3, _loc_2, true, 0);
            var _loc_5:* = new Matrix();
            new Matrix().rotate(Math.PI);
            _loc_5.translate(_loc_3, _loc_2);
            _loc_4.draw(param1.source, _loc_5);
            var _loc_6:* = new Vector.<BitmapFrame>;
            var _loc_7:* = param1.totalFrames;
            var _loc_10:int = 1;
            while (_loc_10 <= _loc_7)
            {
                
                _loc_9 = param1.getFrame(_loc_10);
                _loc_8 = new BitmapFrame();
                _loc_8.cutx = _loc_3 - _loc_9.cutw - _loc_9.cutx;
                _loc_8.cuty = _loc_2 - _loc_9.cuth - _loc_9.cuty;
                _loc_8.cutw = _loc_9.cutw;
                _loc_8.cuth = _loc_9.cuth;
                _loc_8.regx = _loc_9.cutw - _loc_9.regx;
                _loc_8.regy = _loc_9.cuth - _loc_9.regy;
                _loc_8.duration = _loc_9.duration;
                _loc_8.isStop = _loc_9.isStop;
                _loc_8.gotoFrame = _loc_9.gotoFrame;
                _loc_8.EventType = _loc_9.EventType;
                _loc_8.rect.x = _loc_8.cutx;
                _loc_8.rect.y = _loc_8.cuty;
                _loc_8.rect.width = _loc_8.cutw;
                _loc_8.rect.height = _loc_8.cuth;
                _loc_6.push(_loc_8);
                _loc_10++;
            }
            var _loc_11:* = new BitmapAction();
            new BitmapAction().source = _loc_4;
            _loc_11.setBitmapFrameList(_loc_6);
            _loc_11.repeat = param1.repeat;
            return _loc_11;
        }

        private static function rotation270(param1:BitmapAction) : BitmapAction
        {
            var _loc_8:BitmapFrame = null;
            var _loc_9:BitmapFrame = null;
            var _loc_2:* = param1.source.height;
            var _loc_3:* = param1.source.width;
            var _loc_4:* = new BitmapData(_loc_2, _loc_3, true, 0);
            var _loc_5:* = new Matrix();
            new Matrix().rotate(Math.PI * 1.5);
            _loc_5.translate(0, _loc_3);
            _loc_4.draw(param1.source, _loc_5);
            var _loc_6:* = new Vector.<BitmapFrame>;
            var _loc_7:* = param1.totalFrames;
            var _loc_10:int = 1;
            while (_loc_10 <= _loc_7)
            {
                
                _loc_9 = param1.getFrame(_loc_10);
                _loc_8 = new BitmapFrame();
                _loc_8.cutx = _loc_9.cuty;
                _loc_8.cuty = _loc_3 - _loc_9.cutx - _loc_9.cutw;
                _loc_8.cutw = _loc_9.cuth;
                _loc_8.cuth = _loc_9.cutw;
                _loc_8.regx = _loc_9.regy;
                _loc_8.regy = _loc_9.cutw - _loc_9.regx;
                _loc_8.duration = _loc_9.duration;
                _loc_8.isStop = _loc_9.isStop;
                _loc_8.gotoFrame = _loc_9.gotoFrame;
                _loc_8.EventType = _loc_9.EventType;
                _loc_8.rect.x = _loc_8.cutx;
                _loc_8.rect.y = _loc_8.cuty;
                _loc_8.rect.width = _loc_8.cutw;
                _loc_8.rect.height = _loc_8.cuth;
                _loc_6.push(_loc_8);
                _loc_10++;
            }
            var _loc_11:* = new BitmapAction();
            new BitmapAction().source = _loc_4;
            _loc_11.setBitmapFrameList(_loc_6);
            _loc_11.repeat = param1.repeat;
            return _loc_11;
        }

    }
}
