package logic
{
    public class GameState
    {
        private static var _instance:GameState;

        public var characterName:String;

        public function GameState()
        {
            if (_instance)
                throw new Error("Singletons can only have one instance");
            _instance = this;
        }

        public static function get instance():GameState
        {
            if (!_instance)
                new GameState();
            return _instance;
        }

        public function fromObject(data:Object):void
        {
            characterName = data.characterName;
        }

        public function toObject():Object
        {
            return {
                characterName: characterName
            };
        }
    }
}
