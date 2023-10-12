@isTest
global class ViaCepApiCalloutMock implements HttpCalloutMock {

    global HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setBody('{"cep":"22040002", "logradouro":"Rua B", "bairro":"Bairro B", "localidade":"Cidade B", "uf":"UF B"}');
        return response;
    }
}