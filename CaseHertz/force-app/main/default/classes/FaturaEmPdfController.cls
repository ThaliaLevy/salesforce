public class FaturaEmPdfController {

    public List<LinhasFatura__c> linhasDaFatura { get; set;}
    
    public FaturaDoCliente__c fatura { get; set;}
    
    public FaturaEmPdfController() {
        Id faturaId = ApexPages.currentPage().getParameters().get('id'); 
    
        if (faturaId != null) {
            linhasDaFatura = [SELECT Id, Produto__c, Quantidade__c, PrecoUnitario__c, Subtotal__c, Total__c FROM LinhasFatura__c WHERE Fatura_do_cliente__c=:faturaId];
            fatura = [SELECT Id, Name, DataVencimento__c, Fatura_est_paga__c, Subtotal__c, Total__c, CPF__c, Contato__r.Name, Endereco__c, QuantidadeProdutos__c FROM FaturaDoCliente__c WHERE Id=:faturaId LIMIT 1];
        }
    }
}