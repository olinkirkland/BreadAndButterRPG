package logic
{
public class Story
{
    public var id:String;

    public function Story()
    {
    }

    public static function fromObject(u:Object):Story
    {
        var t:Story = new Story();
        t.id = u.id;

        return t;
    }
}
}
