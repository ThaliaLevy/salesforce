@isTest
public class ValidarCPFTriggerTest {
    
    @testSetup
    static void setup() {
        Account acc = new Account(Name = 'Test', Cpf__c = '08990364060');
        insert acc;
    }
    
    @isTest
    static void shouldToBeValidCPF() {
        Account acc = [SELECT Id, Name, Cpf__c FROM Account WHERE Name = 'Test' LIMIT 1];

        System.assertEquals('08990364060', acc.Cpf__c);
    }
    
    @isTest
    static void shouldRejectInvalidCPFNoNumbers() {
        Account acc = [SELECT Id, Name, Cpf__c FROM Account WHERE Name = 'Test' LIMIT 1];
        acc.Cpf__c = 'asasasasasa';
        
        try{
            update acc;
        } catch (Exception e) {
            System.Assert(e.getMessage().contains('CPF deve conter apenas caracteres numéricos'));
        }
    }
   
    @isTest
    static void shouldRejectInvalidCPFNoElevenNumbers() {
        Account acc = [SELECT Id, Name, Cpf__c FROM Account WHERE Name = 'Test' LIMIT 1];
        acc.Cpf__c = '1255';
        
        try{
            update acc;
        } catch (Exception e) {
            System.Assert(e.getMessage().contains('CPF deve conter 11 dígitos'));
        }
    }
    
    @isTest
    static void shouldRejectIfCpfHasSequenceOfNumbers() {
        Account acc = [SELECT Id, Name, Cpf__c FROM Account WHERE Name = 'Test' LIMIT 1];
        acc.Cpf__c = '01234567890';
        
        try{
            update acc;
        } catch (Exception e) {
            System.Assert(e.getMessage().contains('CPF com números sequenciais ' + acc.Cpf__c + ' não é válido'));
        }
    }
    
    @isTest
    static void shouldRejectIfCpfHasSequenceOfEgualNumbers() {
        Account acc = [SELECT Id, Name, Cpf__c FROM Account WHERE Name = 'Test' LIMIT 1];
        acc.Cpf__c = '11111111111';
        
        try{
            update acc;
        } catch (Exception e) {
            System.Assert(e.getMessage().contains('CPF com sequencia de número único não é válido'));
        }
    }  
        
    @isTest
    static void shouldRejectIfCpfHasNoValidFirstVerifyingDigit() {
        Account acc = [SELECT Id, Name, Cpf__c FROM Account WHERE Name = 'Test' LIMIT 1];
        acc.Cpf__c = '08990364050';
        
        try{
            update acc;
        } catch (Exception e) {
            System.Assert(e.getMessage().contains('CPF não é consistente'));
        }
    }
    
    @isTest
    static void shouldRejectIfCpfHasNoValidSecondVerifyingDigit() {
        Account acc = [SELECT Id, Name, Cpf__c FROM Account WHERE Name = 'Test' LIMIT 1];
        acc.Cpf__c = '08990364069';
        
        try{
            update acc;
        } catch (Exception e) {
            System.Assert(e.getMessage().contains('CPF não é consistente'));
        }
    }
        
    @isTest
    static void shouldToCalculateVerifyingDigit() {
        Account acc = [SELECT Id, Name, Cpf__c FROM Account WHERE Name = 'Test' LIMIT 1];
        acc.Cpf__c = '08990364069';
        
        try{
            update acc;
        } catch (Exception e) {
            System.Assert(e.getMessage().contains('CPF não é consistente'));
        }
    }
}