package logic.managers
{
import flash.events.Event;
import flash.filesystem.File;

import logic.Story;

public class StoryManager
{
    private static var _instance:StoryManager;
    public var stories:Array;

    public function StoryManager()
    {
        if (_instance)
            throw new Error("Singletons can only have one instance");
        _instance = this;
    }

    public static function get instance():StoryManager
    {
        if (!_instance)
            new StoryManager();
        return _instance;
    }

    public function initStories(callback:Function):void
    {
        // Load all the stories
        var files:Array = File.applicationDirectory.resolvePath("assets/data/stories").getDirectoryListing();
        var downloads:Object = {};
        for each (var f:File in files)
        {
            f.addEventListener(Event.COMPLETE, onLoaded);
            downloads[f.name] = {file: f, complete: false};
        }

        for each (var d:Object in downloads)
            File(d.file).load();

        function onLoaded(event:Event):void
        {
            downloads[event.target.name].complete = true;

            // Are all downloads complete?
            for each (var d:Object in downloads)
                if (!d.complete)
                    return;

            trace("stories initialized");
            callback.apply();
        }
    }

    public function getStory(id:String):Story
    {
        for each (var t:Story in stories)
            if (t.id == id)
                return t;
        return null;
    }
}
}
