public class ViaCepApi {

    public static String getCepData(String cep) {
        try {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
        
            request.setEndpoint('https://viacep.com.br/ws/' + cep + '/json/');
            request.setMethod('GET');
            
            HttpResponse response = http.send(request);

            return response.getBody();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}