package logic
{
public class Place
{
    public static const HIDDEN:String = "hidden";
    public static const REVEALED:String = "revealed";
    public static const LOCKED:String = "locked";

    public var id:String;
    public var name:String;
    public var icon:String;
    public var state:String;

    public function Place()
    {
    }

    public static function fromObject(u:Object):Place
    {
        var p:Place = new Place();
        p.id = u.id;
        p.name = u.icon;
        p.icon = u.icon;

        return p;
    }
}
}
