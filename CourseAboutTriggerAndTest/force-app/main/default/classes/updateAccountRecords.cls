public class updateAccountRecords {

    public void updateAccount() {
        List<Account> accToBeUpdated = new List<Account>();
        Set<Id> accIdSet = new Set<Id>();
        
        for(Contact con : [SELECT Id, Account.Id FROM Contact WHERE Name LIKE '%TEST%' AND Account.Id != NULL]) {
            if(!accIdSet.contains(con.account.Id)) {
                Account acc = new Account();
                acc.Id = con.Account.Id;
                acc.Active__c = 'Yes';
                acc.Rating = 'Cold';
                accToBeUpdated.add(acc);
                accIdSet.add(con.account.id);
            }
        }
        
        if(!accToBeUpdated.isEmpty())
            update accToBeUpdated;
    }
}