public with sharing class AccountTriggerHandler {

    public static void insertBefore(List<Account> newAccounts) {
        for(Account account : newAccounts) {
            account.description = 'Test';
        }
    }
}