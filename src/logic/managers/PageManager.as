package logic.managers
{
    import logic.*;
    import logic.events.PageEvent;

    import components.modals.pages.Page;

    public class PageManager
    {
        public static function open(page:Page):void
        {
            Signal.instance.dispatch(new PageEvent(PageEvent.OPEN, page));
        }
    }
}
