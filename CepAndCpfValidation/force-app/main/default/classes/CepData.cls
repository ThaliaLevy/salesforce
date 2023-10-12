public class CepData {
    
    @AuraEnabled(cacheable = true)
    public static CepDataWrapper addCepDataToCepDataWrapper(String cep) {
        //TODO: tirar o Map e usar o objeto
        try {
            Map<String, Object> parsedData = (Map<String, Object>) JSON.deserializeUntyped(ViaCepApi.getCepData(cep));
            CepDataWrapper cepDataWrapper = new CepDataWrapper();

            if(!String.isBlank(cep)) {
                cepDataWrapper.cep = parsedData.get('cep').toString();
                cepDataWrapper.rua = parsedData.get('logradouro').toString();
                cepDataWrapper.bairro = parsedData.get('bairro').toString();
                cepDataWrapper.cidade = parsedData.get('localidade').toString();
                cepDataWrapper.estado = parsedData.get('uf').toString();
            }

            return cepDataWrapper;
        } catch (Exception e) {
            throw new AuraHandledException('CEP não pode ser nulo');
        }
    }
    
    @AuraEnabled
    public static String saveCepData(string cepData, Id idCurrentAccount, String numberSaved) {
        try {
            if(String.isBlank(numberSaved))
                numberSaved = 'S/N';

            CepDataWrapper cepDataWrapper = (CepDataWrapper) JSON.deserialize(cepData, CepDataWrapper.class);
            Account currentAccount = [SELECT BillingAddress FROM Account WHERE Id=:idCurrentAccount ];

            currentAccount.BillingStreet = cepDataWrapper.rua + ', ' + cepDataWrapper.bairro + ' - ' + numberSaved;
            currentAccount.BillingCity = cepDataWrapper.cidade;
            currentAccount.BillingState = cepDataWrapper.estado;
            currentAccount.BillingPostalCode = cepDataWrapper.cep;
            currentAccount.BillingCountry = 'Brasil';

            update currentAccount;

            return cepData;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}