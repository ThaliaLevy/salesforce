@isTest
public class CepDataTest {
    
    static String setupCepData() {
        return '{"bairro":"Copacabana","cep":"22040-002","cidade":"Rio de Janeiro","estado":"RJ","rua":"Rua Barata Ribeiro"}';
    }

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
        
        CepDataWrapper result = CepData.addCepDataToCepDataWrapper('22040002');

        System.assertEquals('22040002', result.cep);
        System.assertEquals('Rua B', result.rua);
        System.assertEquals('Bairro B', result.bairro);
        System.assertEquals('Cidade B', result.cidade);
        System.assertEquals('UF B', result.estado);
    }

    @isTest
    static void shouldNotAddCepDataToCepDataWrapperWithBlankCep() {
        CepDataWrapper result = new CepDataWrapper();
        CepDataWrapper cepDataWrapper = new CepDataWrapper();

        try{
            result = CepData.addCepDataToCepDataWrapper('');
        } catch(Exception e) {
            System.assertEquals(result.toString(), cepDataWrapper.toString());
        }
    }

    @isTest
    static void shouldSaveCepDataThatCepIsChanged() {
        String validCepData = setupCepData();
        String numberSaved = '100';
        
        Account oldCepData = new Account(Name = 'Conta teste', BillingPostalCode = '11111-111');
        insert oldCepData;
        
        Account newCepData = CepData.saveCepData(validCepData, oldCepData.Id, numberSaved); 
        
        System.assertNotEquals(newCepData.BillingPostalCode, oldCepData.BillingPostalCode, 'Deve retornar o cep da conta atual atualizada');
    }

    @isTest
    static void shouldSaveCepDataWithoutNumber() {
        String validCepData = setupCepData();
        String numberSaved = '';
        
        Account account = new Account(Name = 'Conta teste');
        insert account;

        Account newCepData = CepData.saveCepData(validCepData, account.Id, numberSaved);
        String[] cepDataSplited = newCepData.BillingStreet.split('-');
        String newNumberSaved = cepDataSplited[1].trim();
        
        System.assertEquals('S/N', newNumberSaved, 'Deve retornar o número como S/N para número não informado');
    }

   /* @isTest
    static void shouldNotSaveCepDataWithoutValidCepData() {
        String validCepData = '';
        String numberSaved = '100';
        
        Account account = new Account(Name = 'Conta teste');
        insert account;

        Account newCepData = CepData.saveCepData(validCepData, account.Id, numberSaved);
        Account result = new Account();

       try {
            result = CepData.saveCepData(validCepData, account.Id, numberSaved);
       } catch (Exception e) {
           System.debug(e);
           	//System.assertEquals(result.toString(), Account.toString());
       }
    } */
}