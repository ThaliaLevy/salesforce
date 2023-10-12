@isTest
public class CepDataTest {

    @isTest
    static public void shouldGetCepData() {
        Test.setMock(HttpCalloutMock.class, new ViaCepApiCalloutMock());
        Map<String, Object> parsedData = (Map<String, Object>) JSON.deserializeUntyped(ViaCepApi.getCepData('22040002'));

        String expectedData = '{bairro=Bairro B, cep=22040002, localidade=Cidade B, logradouro=Rua B, uf=UF B}';

        System.assertEquals(expectedData, parsedData.toString(), 'Deve fazer a busca por CEP válido');
    }

    @isTest
    static void shouldAddCepDataToCepDataWrapperWithValidCep() {
        Test.setMock(HttpCalloutMock.class, new ViaCepApiCalloutMock());
        Map<String, Object> parsedData = (Map<String, Object>) JSON.deserializeUntyped(ViaCepApi.getCepData('22040002'));
        
        Test.startTest();
        CepDataWrapper result = CepData.addCepDataToCepDataWrapper('22040002');
        Test.stopTest();

        System.assertEquals('22040002', result.cep);
        System.assertEquals('Rua B', result.rua);
        System.assertEquals('Bairro B', result.bairro);
        System.assertEquals('Cidade B', result.cidade);
        System.assertEquals('UF B', result.estado);
    }

    @isTest
    static void shouldNotAddCepDataToCepDataWrapperWithBlankCep() {
        CepDataWrapper result = new CepDataWrapper();

        Test.startTest();
        try {
            result = CepData.addCepDataToCepDataWrapper('');
        } catch (Exception e) {
            System.assertEquals(result.toString(), e.getMessage());
        }
        Test.stopTest();

        System.assertEquals(null, result.cep);
        System.assertEquals(null, result.rua);
        System.assertEquals(null, result.bairro);
        System.assertEquals(null, result.cidade);
        System.assertEquals(null, result.estado);
    }

    @isTest
    static void shouldSaveCepData() {
        String validCepData = '{"bairro":"Copacabana","cep":"22040-002","cidade":"Rio de Janeiro","estado":"RJ","rua":"Rua Barata Ribeiro"}';
        String numberSaved = '100';
        Account account = new Account(Name = 'Conta teste', BillingPostalCode = '11111-111');
        insert account;
        String oldPostalCode = account.BillingPostalCode;

        Test.startTest();
        String result = CepData.saveCepData(validCepData, account.Id, numberSaved);
        Test.stopTest();
        
        String newPostalCode = account.BillingPostalCode;

        System.assertNotEquals(oldPostalCode, newPostalCode, 'Deve retornar o cep da conta atual atualizada');
    }

    @isTest
    static void shouldSaveCepDataWithoutNumber() {
        String validCepData = '{"bairro":"Copacabana","cep":"22040-002","cidade":"Rio de Janeiro","estado":"RJ","rua":"Rua Barata Ribeiro"}';
        String numberSaved = '';
        Account account = new Account(Name = 'Conta teste');
        insert account;

        Test.startTest();
        String result = CepData.saveCepData(validCepData, account.Id, numberSaved);
        Test.stopTest();

        System.assertEquals('S/N', numberSaved, 'Deve retornar o número como S/N para número não informado');
    }

    @isTest
    static void shouldNotSaveCepDataWithoutValidCepData() {
        String validCepData = '';
        String numberSaved = '';
        Account account = new Account(Name = 'Conta teste');
        insert account;

        String exceptionOccurred;
        String result;

        Test.startTest();
       try {
            result = CepData.saveCepData(validCepData, account.Id, numberSaved);
       } catch (Exception e) {
            exceptionOccurred = e.getMessage();
       }
        Test.stopTest();

        System.AssertEquals(exceptionOccurred, result, 'Deve lançar exceção');
    }
}