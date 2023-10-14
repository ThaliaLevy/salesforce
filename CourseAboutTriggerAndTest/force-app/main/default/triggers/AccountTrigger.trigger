trigger AccountTrigger on Account (before insert, after insert) {

    //class 3: AccountTriggerHandler.insertBefore(Trigger.New);

    /*
    class 4:
    if(Trigger.isBefore) {
        if(Trigger.isInsert) {
            AccountTriggerHandler.updateAccRating(Trigger.New);
        } 
    } 
    
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            AccountTriggerHandler.createOppOnAcc(Trigger.New);
        }
    }
    */
}