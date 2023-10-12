@isTest
public class ViaCepApiTest {
/*
     @isTest
    static void testDoNotAddCepDataToCepDataWrapper() {
        String inputCep = '';

        try {
            CepDataWrapper result = ViaCepApi.addCepDataToCepDataWrapper(inputCep);
            System.assert(false, 'Deveria ter lançado uma exceção.');
        } catch (Exception e) {
            System.assertEquals('CEP não pode ser nulo', e.getMessage(), 'Deve lançar exceção para CEP nulo');
        }


      Test.startTest();

        CepDataWrapper result = ViaCepApi.addCepDataToCepDataWrapper(inputCep);

        Test.stopTest();

        System.AuraHandledException(result); //null, result, 'Não deve aceitar CEP nulo');
        
    }

    @IsTest
    static void testPositiveMocking() {
        HTTPMockFactory mock = new HTTPMockFactory('{"cep":"22040002","logradouro":"Rua B","bairro":"Bairro B","localidade":"Cidade B","uf":"UF B"}');
        Test.setMock(ViaCepApi.class, mock);
        Test.startTest();
        String result = getCepData('12345');
        Test.stopTest();

        Assert.areEqual('{"cep":"22040002","logradouro":"Rua B","bairro":"Bairro B","localidade":"Cidade B","uf":"UF B"}', result, 'Expected to receive mock response');
    }
    
    @isTest
    static void testAddCepDataToCepDataWrapper() {
        String inputCep = '22040002';

        Test.startTest();

        CepDataWrapper result = ViaCepApi.addCepDataToCepDataWrapper(inputCep);

        Test.stopTest();

        System.assertNotEquals(null, result, 'Deve preencher dados para CEP válido');
    }

    @isTest
    static void testSaveCepData() {
        Account testAccount = new Account(
            Name = 'Test Account',
            BillingStreet = 'Rua A',
            BillingCity = 'Cidade A',
            BillingState = 'Estado A',
            BillingPostalCode = '12345-678',
            BillingCountry = 'Brasil'
        );
        
        insert testAccount;

        String inputCepData = '{"cep":"22040","logradouro":"Rua B","bairro":"Bairro B","localidade":"Cidade B","uf":"UF B"}';
        Id accountId = testAccount.Id;
        String numberSaved = '123';

        // Crie uma instância da classe de teste
        Test.startTest();

        // Chame o método saveCepData
        String result = ViaCepApi.saveCepData(inputCepData, accountId, numberSaved);

        // Encerre o teste
        Test.stopTest();

        // Verifique se o resultado não é nulo
        System.assertNotEquals(null, result, 'O resultado da chamada ao saveCepData não deve ser nulo');

        // Verifique se os campos da conta foram atualizados corretamente
        Account updatedAccount = [SELECT BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry FROM Account WHERE Id = :accountId];
        System.assertEquals('Rua B, Bairro B - 123', updatedAccount.BillingStreet, 'A rua da conta não foi atualizada corretamente');
        System.assertEquals('Cidade B', updatedAccount.BillingCity, 'A cidade da conta não foi atualizada corretamente');
        System.assertEquals('UF B', updatedAccount.BillingState, 'O estado da conta não foi atualizado corretamente');
        System.assertEquals('87654-321', updatedAccount.BillingPostalCode, 'O CEP da conta não foi atualizado corretamente');
        System.assertEquals('Brasil', updatedAccount.BillingCountry, 'O país da conta não foi atualizado corretamente');
    }*/
}