public with sharing class InformacoesProdutoWrapper {
    
    @AuraEnabled
    public id id{get;set;}

    @AuraEnabled
    public string name{get;set;}

    @AuraEnabled
    public string family{get;set;}

    @AuraEnabled
    public string displayUrl{get;set;}

    @AuraEnabled
    public string description{get;set;}

    @AuraEnabled
    public decimal unitPrice{get;set;}

    @AuraEnabled
    public decimal precoComDesconto{get;set;}  

    @AuraEnabled
    public string sinistrosCobertos{get;set;} 
}