package logic.managers
{
import logic.Game;
import logic.Place;

public class PlaceManager
{
    [Embed(source="/assets/data/places.json", mimeType="application/octet-stream")]
    private static const placesJson:Class;

    private static var _instance:PlaceManager;
    public var places:Array;

    public function PlaceManager()
    {
        if (_instance)
            throw new Error("Singletons can only have one instance");
        _instance = this;
    }

    public static function get instance():PlaceManager
    {
        if (!_instance)
            new PlaceManager();
        return _instance;
    }

    public function initPlaces(callback:Function):void
    {
        places = [];
        var arr:Array = JSON.parse(new placesJson()) as Array;
        for each (var u:Object in arr)
            places.push(Place.fromObject(u));

        for (var placeId:String in Game.instance.knownPlaces)
        {
            var p:Place = getPlace(placeId);
            p.state = Game.instance.knownPlaces[placeId];
        }

        callback.apply();
    }

    public function getPlace(id:String):Place
    {
        for each (var p:Place in places)
            if (p.id == id)
                return p;
        return null;
    }
}
}
