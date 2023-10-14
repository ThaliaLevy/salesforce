public with sharing class AccountTriggerHandler {

    /* 
    class 3: 
    public static void insertBefore(List<Account> newAccounts) {
        for(Account account : newAccounts) {
            account.description = 'Test';
        }
    }
    */

    /*
    class 4:
    public static void updateAccRating(List<Account> newAccounts) {
        if(!newAccounts.isEmpty()) {
            for(Account account : newAccounts) {
                if(account.Industry == 'Energy') {
                    account.Rating = 'Hot';
                } else {
                    account.Rating = 'Cold';
                }
            }
        }
    }

    public static void createOppOnAcc(List<Account> newAccounts) {
        List<Opportunity> oppList = new List<Opportunity>();

        if(!newAccounts.isEmpty()) {
            for(Account account : newAccounts) {
                Opportunity opp = new Opportunity();
                opp.Name = account.Name;
                opp.CloseDate = System.today();
                opp.StageName = 'Prospecting';
                opp.AccountId = account.Id;
                oppList.add(opp);
            }
        }

        if(!oppList.isEmpty()) {
            insert oppList;
        }
    } 
    */
}