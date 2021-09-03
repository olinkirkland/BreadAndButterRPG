package logic.events
{
    import flash.events.Event;

    import components.modals.Modal;

    public class ModalEvent extends Event
    {
        public static const OPEN:String = "openModal";
        public static const CLOSE:String = "closeModal";

        public var modal:Modal;

        public function ModalEvent(type:String, modal:Modal = null)
        {
            super(type, false, false);
            this.modal = modal;
        }
    }
}
