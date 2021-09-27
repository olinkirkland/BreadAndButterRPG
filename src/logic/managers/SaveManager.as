package logic.managers
{
import components.modals.popups.InfoPopup;

import global.SharedProperty;
import global.Utils;

import logic.*;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import logic.GameState;

public class SaveManager extends EventDispatcher
{
    [Embed(source="/assets/data/newGame.json", mimeType="application/octet-stream")]
    private static const newGame:Class;

    public static const GAME_SAVED:String = "GAME_SAVED";
    public static const GAME_LOADED:String = "GAME_LOADED";

    private static var _instance:SaveManager;
    private var saves:Array = [];

    public function SaveManager()
    {
        if (_instance)
            throw new Error("Singletons can only have one instance");
        _instance = this;
    }

    public static function get instance():SaveManager
    {
        if (!_instance)
            new SaveManager();
        return _instance;
    }

    public function saveGame(name:String = "Auto-save", overwrite:Boolean = false):void
    {
        // Save by name
        var data:Object = GameState.instance.toObject();
        data.time = new Date().time;

        var f:File;
        var i:int = 0;
        do
        {
            var str:String = "saves/" + GameState.instance.characterName + "/" + name;
            if (i > 0)
                str += " (" + i + ")";

            f = File.applicationStorageDirectory.resolvePath(str + ".json");
            i++;
        } while (f.exists && !overwrite);

        data.name = Utils.stringSegment(f.name, ".");

        var stream:FileStream = new FileStream();
        stream.open(f, FileMode.WRITE);
        stream.writeUTFBytes(JSON.stringify(data));
        stream.close();

        // Store this as the most recent character
        Utils.setProperty(SharedProperty.LAST_PLAYED_AS_CHARACTER, GameState.instance.characterName);

        dispatchEvent(new Event(GAME_SAVED));
    }

    public function loadGame(data:Object):void
    {
        // Load by name
        GameState.instance.fromObject(data);
        dispatchEvent(new Event(GAME_LOADED));

        var popup:InfoPopup = new InfoPopup();
        popup.title = "Game loaded";
        popup.body = data.characterName + "\n" + data.name;
        PopupManager.open(popup);
    }

    public function loadNewGame():void
    {
        loadGame(JSON.parse(new newGame()));
    }

    public function getSaves(characterName:String, callback:Function):void
    {
        var d:File = File.applicationStorageDirectory.resolvePath("saves/" + characterName);
        if (!d.exists)
            d.createDirectory();
        var files:Array = d.getDirectoryListing();

        var arr:Array = [];
        load(null);

        function load(event:Event):void
        {
            if (event)
            {
                // Load
                var f:File = event.target as File;
                try
                {
                    var save:Save = Save.fromObject(JSON.parse(String(f.data)));
                    save.file = f;
                    arr.push(save);
                } catch (error:Error)
                {
                    // There was a problem loading a file
                    throw new Error("Invalid save: " + f.url);
                }
            }

            if (files.length == 0)
            {
                saves = arr;
                callback.apply(null, [saves]);
                return;
            }

            f = files.shift();
            f.addEventListener(Event.COMPLETE, load);
            f.load();
        }
    }
}
}