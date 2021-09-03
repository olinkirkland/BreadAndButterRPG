package logic.events
{
    import components.modals.popups.Popup;

    public class PopupEvent extends ModalEvent
    {
        public static const OPEN:String = "openPopup";
        public static const CLOSED:String = "closedPopup";

        public var popup:Popup;

        public function PopupEvent(type:String, popup:Popup = null)
        {
            super(type, popup);
            this.popup = popup;
        }
    }
}
