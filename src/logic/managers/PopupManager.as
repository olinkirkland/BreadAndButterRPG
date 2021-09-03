package logic.managers
{
    import logic.*;
    import logic.events.PopupEvent;

    import components.modals.popups.Popup;

    public class PopupManager
    {
        public static function open(popup:Popup):void
        {
            Signal.instance.dispatch(new PopupEvent(PopupEvent.OPEN, popup));
        }
    }
}
