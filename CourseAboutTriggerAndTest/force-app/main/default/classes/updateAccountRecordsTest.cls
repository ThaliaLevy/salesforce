@isTest
private class updateAccountRecordsTest {

    @isTest
    private static void updateAccountTest() {
        Account acc1 = new Account();
        acc1.Name = 'Test Account';
        acc1.Rating = 'Hot';
        insert acc1;
        
        Contact con1 = new Contact();
        con1.FirstName = 'Test';
        con1.LastName = 'Test';
        con1.AccountId = acc1.Id;
        insert con1;
        
        updateAccountRecords obj1 = new updateAccountRecords();
        obj1.updateAccount();
        
        List<Account> accList = [SELECT Id, Rating FROM Account WHERE Id=: acc1.id];
        System.assertEquals('Cold', accList[0].Rating);
    }
}