package 
{

    public class Reflect extends Object
    {

        public function Reflect()
        {
            return;
        }

        public static function hasField(obj:*, field:String) : Boolean
        {
            return obj.hasOwnProperty(field);
        }

        public static function field(obj:*, str:String):Function
        {
            var o:* = obj;
            var field:* = str;
            return function ():Object
            {
                var $r:*;
                try
                {
                    $r = o[field];
                }
                catch (e)
                {
                    $r;
                }
                return $r;
            };
        }

        public static function setField(obj:*, str:String,obj1:*) : void
        {
			obj[str] = obj1;
        }

        public static function getProperty(obj:*, str:String):Object
        {
            var o:* = obj;
            var field:* = str;
            try
            {
                var _loc_4:* = o;
                return _loc_4.o["get_" + field]();
            }
            catch (e)
            {
                return o[field];
                ;
            }
            catch (e1:Error)
            {
                return null;
            }
            return null;
        }

        public static function setProperty(param1, param2:String, param3) : void
        {
            var o:* = param1;
            var field:* = param2;
            var value:* = param3;
            try
            {
                var _loc_5:* = o;
                _loc_5.o["set_" + field](value);
            }
            catch (e)
            {
                o[field] = value;
            }
            return;
        }

        public static function callMethod(param1, param2, param3:Array):Object
        {
            return param2.apply(param1, param3);
        }

        public static function fields(param1) : Array
        {
            var o:* = param1;
            if (o == null)
            {
                return new Array();
            }
            var a:* = function () : Array
            {
                var _loc_1:* = undefined;
                var _loc_2:* = undefined;
                _loc_1 = new Array();
                for (_loc_2 in o)
                {
                    
                    _loc_1.push(_loc_2);
                }
                return _loc_1;
            };
            var i:int;
            while (i < a.length)
            {
                
                if (!o.hasOwnProperty(a[i]))
                {
                    a.splice(i, 1);
                    continue;
                }
                i = (i + 1);
            }
            return a;
        }

        public static function isFunction(param1) : Boolean
        {
            return typeof(param1) == "function";
        }

        public static function compare(param1, param2) : int
        {
            var _loc_3:* = param1;
            var _loc_4:* = param2;
            return _loc_3 == _loc_4 ? (0) : (_loc_3 > _loc_4 ? (1) : (-1));
        }

        public static function compareMethods(param1, param2) : Boolean
        {
            return param1 == param2;
        }

        public static function isObject(param1) : Boolean
        {
            if (param1 == null)
            {
                return false;
            }
            var _loc_2:* = typeof(param1);
            if (_loc_2 == "object")
            {
                try
                {
                    if (param1.__enum__ == true)
                    {
                        return false;
                    }
                }
                catch (e)
                {
                }
                return true;
            }
            return _loc_2 == "string";
        }

        public static function deleteField(param1, param2:String) : Boolean
        {
            if (param1.hasOwnProperty(param2) != true)
            {
                return false;
            }
            delete param1[param2];
            return true;
        }

        public static function copy(param1):Object
        {
            var _loc_5:String = null;
            var _loc_2:* = {};
            var _loc_3:int = 0;
            var _loc_4:* = Reflect.fields(param1);
            while (_loc_3 < _loc_4.length)
            {
                
                _loc_5 = _loc_4[_loc_3];
                _loc_3++;
                Reflect.setField(_loc_2, _loc_5, Reflect.field(param1, _loc_5));
            }
            return _loc_2;
        }

        public static function makeVarArgs(param1:Function):Object
        {
            var f:* = param1;
            return function (param1:Array):Object
            {
                return f(param1);
            }
            ;
        }

    }
}
