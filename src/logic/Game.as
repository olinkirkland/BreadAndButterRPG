package logic
{
import components.modals.popups.LoadingPopup;

import flash.utils.setTimeout;

import logic.managers.PlaceManager;
import logic.managers.PopupManager;
import logic.managers.StoryManager;

public class Game
{
    /**
     * Contains current game state
     * Performs game actions to bridge between manager classes
     */


    private static var _instance:Game;

    public var characterName:String;
    public var currentPlace:String; // The id of the current place
    public var knownPlaces:Object; // Known places & their states

    public function Game()
    {
        if (_instance)
            throw new Error("Singletons can only have one instance");
        _instance = this;
    }

    public static function get instance():Game
    {
        if (!_instance)
            new Game();
        return _instance;
    }

    public function fromObject(data:Object):void
    {
        characterName = data.characterName;
        currentPlace = data.place;
        knownPlaces = data.knownPlaces;
    }

    public function initialize():void
    {
        var popup:LoadingPopup = new LoadingPopup();
        PopupManager.open(popup);

        PlaceManager.instance.initPlaces(onInitPlaces);

        function onInitPlaces():void
        {
            trace("initialized: places");
            StoryManager.instance.initStories(onInitStories);
        }

        function onInitStories():void
        {
            trace("initialized: stories");
            setTimeout(popup.close, 500);
        }
    }

    public function toObject():Object
    {
        return {
            characterName: characterName,
            currentPlace: currentPlace,
            knownPlaces: knownPlaces
        };
    }
}
}
