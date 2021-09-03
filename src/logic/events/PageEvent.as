package logic.events
{
    import components.modals.pages.Page;

    public class PageEvent extends ModalEvent
    {
        public static const OPEN:String = "openPage";
        public static const CLOSED:String = "closedPage";

        public var page:Page;

        public function PageEvent(type:String, page:Page = null)
        {
            super(type, page);
            this.page = page;
        }
    }
}
