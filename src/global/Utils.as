package global
{
import flash.net.SharedObject;

public class Utils
{
    private static var shared:SharedObject;
    private static var defaultProperties:Object = {
        lastPlayedAsCharacter: null
    };

    private static var months:Array = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

    public function Utils()
    {
    }

    public static function stringSegment(str:String, seg:String, lastIndexOf:Boolean = true):String
    {
        // Returns the segment of the string that comes before the first or last occurrence of 'seg'
        return str.substr(0, lastIndexOf ? str.lastIndexOf(seg) : str.indexOf(seg));
    }

    public static function getProperty(key:String):Object
    {
        return shared.data.properties[key];
    }

    public static function setProperty(key:String, data:Object):String
    {
        return shared.data.properties[key] = data;
    }

    public static function setDefaults():void
    {
        shared.data.properties = defaultProperties;
        shared = SharedObject.getLocal("properties");
    }

    public static function initSharedObject():void
    {
        shared = SharedObject.getLocal("properties");
        trace(JSON.stringify(shared.data.properties));
        if (!shared.data.properties)
            setDefaults();
    }

    public static function toRelativeDate(n:Number):String
    {
        var d:Date = new Date();
        d.time = n;

        var days:int = daysSince(d);
        var hours:int = hoursSince(d);
        var minutes:int = minutesSince(d);

        if (days < 5)
        {
            if (hours < 24)
            {
                if (minutes < 60)
                {
                    if (minutes < 3)
                    {
                        // Just now
                        return "just now";
                    } else
                    {
                        // Minutes ago
                        return minutes + " minutes ago";
                    }
                } else
                {
                    // Hours ago
                    return hours + " hours ago";
                }
            } else
            {
                // Days ago
                return days + " days ago";
            }
        }

        // Don't use relative time
        if (days < 360)
            return months[d.month] + " " + d.date;

        // Include the year if it's that long ago
        return months[d.month] + " " + d.date + ", " + d.fullYear;
    }

    private static function secondsSince(d:Date):Number
    {
        return Number(((new Date().time - d.time) / 1000).toFixed(4));
    }

    private static function minutesSince(d:Date):Number
    {
        return secondsSince(d) / 60;
    }

    private static function hoursSince(d:Date):Number
    {
        return minutesSince(d) / 60;
    }

    private static function daysSince(d:Date):Number
    {
        return hoursSince(d) / 24;
    }
}
}
