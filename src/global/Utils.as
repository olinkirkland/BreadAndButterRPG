package global
{
import flash.net.SharedObject;

public class Utils
{
    private static var shared:SharedObject;
    private static var defaultProperties:Object = {
        lastPlayedAsCharacter: null
    };

    public function Utils()
    {
    }

    public static function stringSegment(str:String, seg:String, lastIndexOf:Boolean = true):String
    {
        // Returns the segment of the string that comes before the first or last occurrence of 'seg'
        return str.substr(0, lastIndexOf ? str.lastIndexOf(seg) : str.indexOf(seg));
    }

    public static function setProperty(key:String, data:Object):void
    {
        shared.data.properties[key] = data;
    }

    public static function getProperty(key:String):Object
    {
        return shared.data.properties[key];
    }

    public static function setDefaults():void
    {
        shared.data.properties = defaultProperties;
        shared = SharedObject.getLocal("properties");
    }

    public static function initSharedObject():void
    {
        shared = SharedObject.getLocal("properties");
        if (!shared.data.properties)
            setDefaults();
    }
}
}
