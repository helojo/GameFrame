package com.frame.resource
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.media.Sound;
    import flash.system.ApplicationDomain;
    import flash.utils.ByteArray;

    public class Resource extends Object
    {
        public static var image:Object = {};
        public static var swf:Object = {};
        public static var xml:Object = {};
        public static var binary:Object = {};
        public static var sound:Object = {};
        public static var json:Object = {};
        public static var video:Object = {};
        public static var UIDomain:ApplicationDomain = new ApplicationDomain();
        public static var CodeDomain:ApplicationDomain = ApplicationDomain.currentDomain;

        public function Resource()
        {
            return;
        }

        public static function typeToString(type:int) : String
        {
            var str:String = null;
            switch(type)
            {
                case 1:
                {
					str = "image";
                    break;
                }
                case 2:
                {
					str = "swf";
                    break;
                }
                case 3:
                {
					str = "xml";
                    break;
                }
                case 4:
                {
					str = "binary";
                    break;
                }
                case 5:
                {
					str = "sound";
                    break;
                }
                case 6:
                {
					str = "json";
                    break;
                }
                case 7:
                {
					str = "video";
                    break;
                }
                default:
                {
					str = "binary";
                    break;
                }
            }
            return str;
        }

        public static function hasResource(type:int, name:String) : Boolean
        {
            var store:* = [typeToString(type)];
            if (store[name])
            {
                return true;
            }
            return false;
        }

        public static function cacheResource(type:int, name:String, data:Object) : void
        {
            var store:* = Resource[typeToString(type)];
			store[name] = data;
		}

        public static function getBitmapData(name:String) : BitmapData
        {
            return image[name] as BitmapData;
        }

        public static function getBitmap(name:String) : Bitmap
        {
            var bmp:BitmapData = getBitmapData(name);
            if (bmp == null)
            {
                return null;
            }
            return new Bitmap(bmp);
        }

        public static function getDomain(name:String) : ApplicationDomain
        {
            return swf[name] as ApplicationDomain;
        }

        public static function getSwfClass(domain:String, name:String) : Class
        {
            var dm:ApplicationDomain = getDomain(domain);
            if (dm == null)
            {
                return null;
            }
            if (dm.hasDefinition(name))
            {
                return Class(dm.getDefinition(name));
            }
            return null;
        }

        public static function getSwfDefinition(domain:String, name:String) : Object
        {
            var dm:ApplicationDomain = getDomain(domain);
            if (dm == null)
            {
                return null;
            }
            if (dm.hasDefinition(name))
            {
                return dm.getDefinition(name);
            }
            return null;
        }

        public static function getSwfInstance(domain:String, name:String) : Object
        {
            var cls:Class = getSwfClass(domain, name);
            if (cls)
            {
                return new cls;
            }
            return null;
        }

        public static function getXMLData(name:String) : XML
        {
            return xml[name] as XML;
        }
		
        public static function getJsonData(name:String) :Object
        {
            return json[name] as Object;
        }

        public static function getXMLDataCopy(name:String) : XML
        {
            var xml:XML = getXMLData(name);
            if (xml == null)
            {
                return null;
            }
            return xml.copy();
        }

        public static function getBinary(name:String) : ByteArray
        {
            return binary[name] as ByteArray;
        }

        public static function getSound(name:String) : Sound
        {
            return sound[name] as Sound;
        }

    }
}
