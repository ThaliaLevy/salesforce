public without sharing class Veiculos {
    
    public static InformacoesReservaWrapper informacoesReservaWrapper = new InformacoesReservaWrapper();

    @auraEnabled(cacheable = true)
    public static List<Product2> getProdutos() {
        List<Product2> lProdutos = new List<Product2>(); 
        lProdutos = [SELECT Id, Name, Family, DisplayUrl, Description FROM Product2];

        return lProdutos;
    }

    @auraEnabled(cacheable = true)
    public static List<PricebookEntry> getPrecosDosProdutos() {
        List<PricebookEntry> lPrecos = new List<PricebookEntry>(); 
        lPrecos = [SELECT Id, Product2Id, UnitPrice FROM PricebookEntry WHERE IsActive = true];

        return lPrecos;
    }

    @auraEnabled(cacheable = true)
    public static List<Plano__c> getPlanosParaLocacao() {
        List<Plano__c> lPlanos = new List<Plano__c>(); 
        lPlanos = [SELECT Id, Name, DescontoSobreDiaria__c, PacoteBeneficios__c, ImagemPlano__c FROM Plano__c];

        return lPlanos;
    }

    @auraEnabled(cacheable = true)
    public static List<SeguroDoVeiculo__c> getSeguros() {
        List<SeguroDoVeiculo__c> lSeguros = new List<SeguroDoVeiculo__c>(); 
        lSeguros = [SELECT Id, Name, Sinistros_cobertos__c FROM SeguroDoVeiculo__c];

        return lSeguros;
    }

    @auraEnabled(cacheable = true)
    public static List<InformacoesProdutoWrapper> getSegurosFormatados() {
        List<InformacoesProdutoWrapper> segurosComPrecos = getSegurosComPrecos(); 
        List<InformacoesProdutoWrapper> lSegurosFormatados = new List<InformacoesProdutoWrapper>(3); 

        for(InformacoesProdutoWrapper seguro : segurosComPrecos) {
            if(seguro.Name == 'Básico') {
                lSegurosFormatados.add(0, seguro);
                lSegurosFormatados[0].sinistrosCobertos = 'Sinistros de pequena monta que incluem situações como arranhões leves ou amassados em veículos estacionados';
            } else if(seguro.Name == 'Balanceado') {
                lSegurosFormatados.add(1, seguro);
                lSegurosFormatados[1].sinistrosCobertos = 'Além de sinistros de pequena monta, inclui também os de média monta, que envolvem danos mais substanciais, como colisões entre veículos em que ambos requerem reparos';
            } else if(seguro.Name == 'Completo') {
                lSegurosFormatados.add(2, seguro);
                lSegurosFormatados[2].sinistrosCobertos = 'Além de sinistros de pequena e média monta, inclui também sinistros de grande monta, que são eventos graves, como acidentes de alta velocidade com danos extensos, ferimentos ou perda total do veículo';
            } 
        }

        return lSegurosFormatados;
    }

    @auraEnabled(cacheable = true)
    public static List<InformacoesProdutoWrapper> getQuilometragensComPrecos() {
        List<InformacoesProdutoWrapper> lProdutosComPrecoDiaria = getTodasInformacoesDosProdutos(); 
        List<InformacoesProdutoWrapper> quilometragensComPreco = new List<InformacoesProdutoWrapper>();
        
        for(InformacoesProdutoWrapper produto : lProdutosComPrecoDiaria) {
            if(produto.family == 'Quilometragens') {
                quilometragensComPreco.add(produto);
            }
        }

        return quilometragensComPreco;
    }

    @auraEnabled(cacheable = true)
    public static List<String> getBeneficiosPlanoMensal() {
        List<Plano__c> lPlanos = getPlanosParaLocacao();
        List<String> lBeneficios = new List<String>();
       
        for(Plano__c plano : lPlanos) {
            if(plano.Name == 'Mensal') {
                lBeneficios.addAll(plano.PacoteBeneficios__c.split(';'));
            }
        }

        return lBeneficios;
    }

    @auraEnabled(cacheable = true)
    public static List<String> getBeneficiosPlanoSemestral() {
        List<Plano__c> lPlanos = getPlanosParaLocacao();
        List<String> lBeneficios = new List<String>();
       
        for(Plano__c plano : lPlanos) {
            if(plano.Name == 'Semestral') {
                lBeneficios.addAll(plano.PacoteBeneficios__c.split(';'));
            }
        }

        return lBeneficios;
    }

    @auraEnabled(cacheable = true)
    public static List<String> getBeneficiosPlanoAnual() {
        List<Plano__c> lPlanos = getPlanosParaLocacao();
        List<String> lBeneficios = new List<String>();
       
        for(Plano__c plano : lPlanos) {
            if(plano.Name == 'Anual') {
                lBeneficios.addAll(plano.PacoteBeneficios__c.split(';'));
            }
        }

        return lBeneficios;
    }

    @auraEnabled(cacheable = true)
    public static List<InformacoesProdutoWrapper> getTodasInformacoesDosProdutos() {
        List<Product2> lProdutos = getProdutos();
        List<PricebookEntry> lPrecos = getPrecosDosProdutos();
        List<InformacoesProdutoWrapper> lInformacoesVeiculosWrapper = new List<InformacoesProdutoWrapper>();

        for(Product2 produto : lProdutos) {
            for(PricebookEntry preco : lPrecos) {
                if(produto.Id == preco.Product2Id) {
                    InformacoesProdutoWrapper getInformacoes = new InformacoesProdutoWrapper();
                    
                    getInformacoes.id = produto.Id;
                    getInformacoes.name = produto.Name;
                    getInformacoes.family = produto.Family;
                    getInformacoes.displayUrl = produto.DisplayUrl;
                    getInformacoes.description = produto.Description;
                    getInformacoes.unitPrice = preco.UnitPrice;

                    lInformacoesVeiculosWrapper.add(getInformacoes);
                }
            }
        }
        
        return lInformacoesVeiculosWrapper;
    }

    @auraEnabled(cacheable = true)
    public static List<InformacoesProdutoWrapper> getVeiculosParaFamilia() {
        List<InformacoesProdutoWrapper> lProdutosComPrecoDiaria = getTodasInformacoesDosProdutos(); 
        List<InformacoesProdutoWrapper> lVeiculosParaFamilia = new List<InformacoesProdutoWrapper>();
        
        for(InformacoesProdutoWrapper produto : lProdutosComPrecoDiaria) {
            if(produto.family == 'Minivans' || produto.family == 'SUVs' || produto.family == 'Sedãs') {
                lVeiculosParaFamilia.add(produto);
            }
        }

        return lVeiculosParaFamilia;
    }

    @auraEnabled(cacheable = true)
    public static List<InformacoesProdutoWrapper> getVeiculosEconomicos() {
        List<InformacoesProdutoWrapper> lProdutosComPrecoDiaria = getTodasInformacoesDosProdutos(); 
        List<InformacoesProdutoWrapper> lVeiculosEconomicos = new List<InformacoesProdutoWrapper>();
        
        for(InformacoesProdutoWrapper produto : lProdutosComPrecoDiaria) {
            if(produto.family == 'Compactos') {
                lVeiculosEconomicos.add(produto);
            }
        }

        return lVeiculosEconomicos;
    }

    @auraEnabled(cacheable = true)
    public static List<InformacoesProdutoWrapper> getVeiculosElegantes() {
        List<InformacoesProdutoWrapper> lProdutosComPrecoDiaria = getTodasInformacoesDosProdutos(); 
        List<InformacoesProdutoWrapper> lVeiculosElegantes = new List<InformacoesProdutoWrapper>();
        
        for(InformacoesProdutoWrapper produto : lProdutosComPrecoDiaria) {
            if(produto.family == 'Luxuosos') {
                lVeiculosElegantes.add(produto);
            }
        }

        return lVeiculosElegantes;
    }

    @auraEnabled(cacheable = true)
    public static List<InformacoesProdutoWrapper> getItensAdicionais() {
        List<InformacoesProdutoWrapper> lProdutosComPrecoDiaria = getTodasInformacoesDosProdutos(); 
        List<InformacoesProdutoWrapper> lItensAdicionais = new List<InformacoesProdutoWrapper>();
        
        for(InformacoesProdutoWrapper produto : lProdutosComPrecoDiaria) {
            if(produto.family == 'Itens adicionais') {
                lItensAdicionais.add(produto);
            }
        }

        return lItensAdicionais;
    }

    @auraEnabled(cacheable = true)
    public static List<InformacoesProdutoWrapper> getSegurosComPrecos() {
        List<InformacoesProdutoWrapper> lProdutosComPrecoDiaria = getTodasInformacoesDosProdutos(); 
        List<InformacoesProdutoWrapper> segurosComPreco = new List<InformacoesProdutoWrapper>();
        
        for(InformacoesProdutoWrapper produto : lProdutosComPrecoDiaria) {
            if(produto.family == 'Seguros') {
                segurosComPreco.add(produto);
            }
        }

        return segurosComPreco;
    }
    
    @auraEnabled(cacheable = true)
    public static List<String> getOpcoesDiasVencimento() {
        List<String> opcoesDiasVencimento = new List<String>{'5° dia do mês', '15° dia do mês', '30° dia do mês'}; 

        return opcoesDiasVencimento;
    }

    public static Plano__c getPlanoEscolhido(string nomePlanoEscolhido) {
        List<Plano__c> lPlanos = getPlanosParaLocacao();
        Plano__c planoEscolhido = new Plano__c();

        for(Plano__c plano : lPlanos) {
            if(plano.Name == nomePlanoEscolhido) 
                planoEscolhido = plano;
        }

        return planoEscolhido;
    }

    public static SeguroDoVeiculo__c getSeguroEscolhido(string nomeSeguroEscolhido) {
        List<SeguroDoVeiculo__c> lSeguros = getSeguros();
        SeguroDoVeiculo__c seguroEscolhido = new SeguroDoVeiculo__c();

        for(SeguroDoVeiculo__c seguro : lSeguros) {
            if(seguro.Name == nomeSeguroEscolhido) 
                seguroEscolhido = seguro;
        }

        return seguroEscolhido;
    }

    @auraEnabled(cacheable = true)
    public static List<InformacoesProdutoWrapper> getProdutosComDesconto(List<InformacoesProdutoWrapper> veiculos, decimal porcentagemDesconto) {        
        for(InformacoesProdutoWrapper produto : veiculos) {
            produto.precoComDesconto = produto.unitPrice - (produto.unitPrice * porcentagemDesconto/100);
        }

        return veiculos;
    }

    @auraEnabled(cacheable = true)
    public static InformacoesWrapper loadProducts() {
        InformacoesWrapper informacoesWrapper = new InformacoesWrapper();
        
        informacoesWrapper.veiculosEconomicosComDesconto5Porcento = getProdutosComDesconto(getVeiculosEconomicos(), 5.0);
        informacoesWrapper.veiculosEconomicosComDesconto10Porcento = getProdutosComDesconto(getVeiculosEconomicos(), 10.0);
        informacoesWrapper.veiculosEconomicosComDesconto15Porcento = getProdutosComDesconto(getVeiculosEconomicos(), 15.0);
        informacoesWrapper.veiculosParaFamiliaComDesconto5Porcento = getProdutosComDesconto(getVeiculosParaFamilia(), 5.0);
        informacoesWrapper.veiculosParaFamiliaComDesconto10Porcento = getProdutosComDesconto(getVeiculosParaFamilia(), 10.0);
        informacoesWrapper.veiculosParaFamiliaComDesconto15Porcento = getProdutosComDesconto(getVeiculosParaFamilia(), 15.0);
        informacoesWrapper.veiculosLuxuososComDesconto5Porcento = getProdutosComDesconto(getVeiculosElegantes(), 5.0);
        informacoesWrapper.veiculosLuxuososComDesconto10Porcento = getProdutosComDesconto(getVeiculosElegantes(), 10.0);
        informacoesWrapper.veiculosLuxuososComDesconto15Porcento = getProdutosComDesconto(getVeiculosElegantes(), 15.0);
        informacoesWrapper.itemAdicionalComDesconto100Porcento = getProdutosComDesconto(getItensAdicionais(), 100.0);
        informacoesWrapper.itemAdicionalComDesconto20Porcento = getProdutosComDesconto(getItensAdicionais(), 20.0);
        informacoesWrapper.itemAdicionalComDesconto50Porcento = getProdutosComDesconto(getItensAdicionais(), 50.0);
        informacoesWrapper.planosParaLocacao = getPlanosParaLocacao();
        informacoesWrapper.beneficiosPlanoMensal = getBeneficiosPlanoMensal();
        informacoesWrapper.beneficiosPlanoSemestral = getBeneficiosPlanoSemestral();
        informacoesWrapper.beneficiosPlanoAnual = getBeneficiosPlanoAnual();
        informacoesWrapper.seguros = getSegurosFormatados();
        informacoesWrapper.quilometragens = getQuilometragensComPrecos();

        return informacoesWrapper;
    }

    @auraEnabled
    public static void salvarCaso(string  informacoesReserva) {
        try {
            InformacoesWrapper informacoesReservaWrapper = (InformacoesWrapper) JSON.deserialize(informacoesReserva, InformacoesWrapper.class);

            List<User> usuario = [SELECT Id FROM User WHERE Name='Thalia Levy' AND Email='thalialevy@gmail.com' LIMIT 1];
            List<Contact> contato = [SELECT Id FROM Contact WHERE CPF__c=:informacoesReservaWrapper.cpfDoCliente LIMIT 1]; 

            Id recordTypeLocacaoRecorrente = '012Hu000000LbpVIAS';

            Case novoCaso = new Case(RecordTypeId = recordTypeLocacaoRecorrente);

            novoCaso.OwnerId = usuario[0].Id;
            novoCaso.ContactId = contato[0].Id;
            novoCaso.MotivoDoContato__c = 'Locação de produtos';
            novoCaso.EstagioLocacaoRecorrente__c = 'Negociação';
            novoCaso.Status = 'New';
            novoCaso.Origin = 'Web';
            novoCaso.Itens_adicionais__c = informacoesReservaWrapper.itemAdicionalEscolhido;
            novoCaso.VeiculoAlugado__c = informacoesReservaWrapper.veiculoEscolhido;
            novoCaso.DataVencimentoFatura__c = informacoesReservaWrapper.dataVencimentoEscolhida;
            novoCaso.DataRetirada__c = informacoesReservaWrapper.dataRetiradaEscolhida;
            novoCaso.KmMes__c = informacoesReservaWrapper.quilometragemEscolhida;
            novoCaso.Plano__c = getPlanoEscolhido(informacoesReservaWrapper.planoEscolhido).Id;
            novoCaso.SeguroVeiculo__c = getSeguroEscolhido(informacoesReservaWrapper.seguroEscolhido).Id; 

            insert novoCaso;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}