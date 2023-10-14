trigger AccountTrigger on Account (before insert) {

    AccountTriggerHandler.insertBefore(Trigger.New);
}