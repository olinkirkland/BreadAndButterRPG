package logic
{
    import flash.filesystem.File;

    public class Save
    {
        public var name:String;
        public var time:Number;
        public var data:Object;

        public var file:File;

        public function Save()
        {
        }

        public static function fromObject(u:Object):Save
        {
            var s:Save = new Save();
            s.name = u.name;
            s.time = u.time;
            s.data = u;

            return s;
        }
    }
}
