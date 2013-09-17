package com.frame.bitmapAction
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

    public class BitmapFrame extends Object
    {
        public var cutx:int = 0;
        public var cuty:int = 0;
        public var cutw:int = 1;
        public var cuth:int = 1;
        public var regx:int = 0;
        public var regy:int = 0;
        public var duration:int = 20;
        public var isStop:Boolean = false;
        public var gotoFrame:int = 0;
        public var EventType:int = 0;
        public var rect:Rectangle;
        public var p:Point;

        public function BitmapFrame()
        {
            rect = new Rectangle();
            p = new Point();
            return;
        }

        public function draw(bmp:BitmapData, param2:int, param3:int, bmp2:BitmapData) : void
        {
            p.x = param2 - regx;
            p.y = param3 - regy;
			bmp.copyPixels(bmp2, rect, p, null, null, true);
        }

        public function drawAlpha(param1:BitmapData, param2:int, param3:int, param4:BitmapData, param5:uint = 255) : void
        {
            p.x = param2 - regx;
            p.y = param3 - regy;
            var _loc_6:* = new BitmapData(param4.width, param4.height, true, param5 << 24);
            param1.copyPixels(param4, rect, p, _loc_6, new Point(), true);
        }

        public function setXMlData(param1:XML) : void
        {
            cutx = param1.@cx;
            cuty = param1.@cy;
            cutw = param1.@cw;
            cuth = param1.@ch;
            regx = param1.@px;
            regy = param1.@py;
            duration = param1.@t;
            isStop = int(param1.@s) > 0;
            gotoFrame = param1.@p;
            EventType = param1.@e;
            rect.x = cutx;
            rect.y = cuty;
            rect.width = cutw;
            rect.height = cuth;
        }

        public function setObjectData(param1:FrameInfo) : void
        {
            cutx = param1.cutx;
            cuty = param1.cuty;
            cutw = param1.cutw;
            cuth = param1.cuth;
            regx = param1.regx;
            regy = param1.regy;
            duration = param1.duration;
            isStop = param1.isStop;
            gotoFrame = param1.gotoFrame;
            EventType = param1.EventType;
            rect.x = cutx;
            rect.y = cuty;
            rect.width = cutw;
            rect.height = cuth;
        }

        public function clone(param1:Boolean = false) : BitmapFrame
        {
            var frame:* = new BitmapFrame();
			frame.cutx = cutx;
			frame.cuty = cuty;
			frame.cutw = cutw;
			frame.cuth = cuth;
			frame.regx = regx;
			frame.regy = regy;
			frame.duration = duration;
			frame.isStop = isStop;
			frame.gotoFrame = gotoFrame;
			frame.rect.x = cutx;
			frame.rect.y = cuty;
			frame.rect.width = cutw;
			frame.rect.height = cuth;
            return frame;
        }

    }
}
