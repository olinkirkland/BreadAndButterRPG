package logic.managers
{
    import logic.*;
    import logic.events.PageEvent;

    import components.modals.pages.Page;

    public class PageManager
    {
        public static function open(page:Page):void
        {
            page.setFocus();
            Signal.instance.dispatch(new PageEvent(PageEvent.OPEN, page));
        }
    }
}
