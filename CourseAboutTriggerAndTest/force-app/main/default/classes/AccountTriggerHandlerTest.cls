@isTest
private class AccountTriggerHandlerTest {

   /* 
     class 19 (is incompleted)
     
     @testSetup
    static void setup() {
        List<Account> accList = new List<Account>();
        
        for(Integer i = 0; i < 2; i++) {
            Account acc = new Account();
            acc.Name = 'Test ' + i;
            acc.BillingCity = 'TestCity';
            acc.BillingCountry = 'TestCountry';
            acc.BillingState = 'TestState';
            acc.BillingStreet = 'TestStreet';
            acc.BillingPostalCode = 'TestPostalCode';
            
            if(i == 0)
                //acc.CopyBillingToShipping__c = true;
            
            accList.add(acc);
        }
    }
        
    @isTest
    private static void copyBillingToShippingInsertTest() {
        /*test.startTest();
        insert accList;
        test.stopTest();
    }*/
    
    /* class 25
    @isTest
    private static void createOppOnAccTest() {
        Account acc = new Account(Name = 'Test');
        
        insert acc;
        
        List<Opportunity> oppList = [SELECT Id FROM Opportunity WHERE AccountId =: acc.Id LIMIT 1];

        System.Assert(oppList != null, 'Opportunity must be created');
    }
	*/
}