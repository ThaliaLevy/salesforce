public with sharing class CepDataWrapper {
    @AuraEnabled
    public String rua {get;set;}

    @AuraEnabled
    public String bairro {get;set;}

    @AuraEnabled
    public String cidade {get;set;}

    @AuraEnabled
    public String estado {get;set;}

    @AuraEnabled
    public String cep {get;set;}
}