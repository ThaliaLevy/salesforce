public with sharing class InformacoesWrapper {    
    @AuraEnabled
    public List<InformacoesProdutoWrapper> veiculosEconomicosComDesconto5Porcento {get;set;}
    
    @AuraEnabled
    public List<InformacoesProdutoWrapper> veiculosEconomicosComDesconto10Porcento {get;set;}

    @AuraEnabled
    public List<InformacoesProdutoWrapper> veiculosEconomicosComDesconto15Porcento {get;set;}

    @AuraEnabled
    public List<InformacoesProdutoWrapper> veiculosParaFamiliaComDesconto5Porcento {get;set;}
    
    @AuraEnabled
    public List<InformacoesProdutoWrapper> veiculosParaFamiliaComDesconto10Porcento {get;set;}

    @AuraEnabled
    public List<InformacoesProdutoWrapper> veiculosParaFamiliaComDesconto15Porcento {get;set;}

    @AuraEnabled
    public List<InformacoesProdutoWrapper> veiculosLuxuososComDesconto5Porcento {get;set;}
    
    @AuraEnabled
    public List<InformacoesProdutoWrapper> veiculosLuxuososComDesconto10Porcento {get;set;}

    @AuraEnabled
    public List<InformacoesProdutoWrapper> veiculosLuxuososComDesconto15Porcento {get;set;}
    
    @AuraEnabled
    public List<InformacoesProdutoWrapper> itemAdicionalComDesconto20Porcento {get;set;}
    
    @AuraEnabled
    public List<InformacoesProdutoWrapper> itemAdicionalComDesconto50Porcento {get;set;}

    @AuraEnabled
    public List<InformacoesProdutoWrapper> itemAdicionalComDesconto100Porcento {get;set;}

    @AuraEnabled
    public List<InformacoesProdutoWrapper> precosQuilometragensComDesconto {get;set;}

    @AuraEnabled
    public List<Plano__c> planosParaLocacao {get;set;}

    @AuraEnabled
    public List<String> beneficiosPlanoMensal {get;set;}

    @AuraEnabled
    public List<String> beneficiosPlanoSemestral {get;set;}

    @AuraEnabled
    public List<String> beneficiosPlanoAnual {get;set;}

    @AuraEnabled
    public List<InformacoesProdutoWrapper> seguros {get;set;}
    
    @AuraEnabled
    public List<InformacoesProdutoWrapper> quilometragens {get;set;}

    @AuraEnabled
    public String planoEscolhido {get;set;}
    
    @AuraEnabled
    public String seguroEscolhido {get;set;}
    
    @AuraEnabled
    public String itemAdicionalEscolhido {get;set;}

    @AuraEnabled
    public String veiculoEscolhido {get;set;}

    @AuraEnabled
    public String quilometragemEscolhida {get;set;}
    
    @AuraEnabled
    public String dataVencimentoEscolhida {get;set;}
    
    @AuraEnabled
    public Date dataRetiradaEscolhida {get;set;}

    @AuraEnabled
    public String cpfDoCliente {get;set;}
}