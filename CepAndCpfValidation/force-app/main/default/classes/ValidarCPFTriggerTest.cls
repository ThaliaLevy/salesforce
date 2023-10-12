@isTest
public class ValidarCPFTriggerTest {
    @isTest
    static Account test() {
        Account acc = new Account(Name = 'Test', CPF_funcional__c = '08990364060');
        insert acc;
        return acc;
    }
    
    @isTest
    static void testValidCPF() {
        Account acc = test();
        acc.Cpf__c = '08990364060';
        
        update acc;

        System.assertEquals('08990364060', acc.Cpf__c);
    }
    
    @isTest
    static void testInvalidCPFNoNumbers() {
        Account acc = test();
        acc.Cpf__c = 'asasasasasa';
        
        try{
            update acc;
        } catch (Exception e) {
            System.AssertEquals(e.getMessage(), 'CPF deve conter apenas caracteres numéricos');
        }
    }
    
    @isTest
    static void testInvalidCPFNoElevenNumbers() {
        Account acc = test();
        acc.Cpf__c = '1255';
        
        try{
            update acc;
        } catch (Exception e) {
            System.Assert(e.getMessage().contains('CPF deve conter 11 dígitos'));
        }
    }
}