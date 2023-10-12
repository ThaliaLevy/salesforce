import { LightningElement, wire } from 'lwc';
import loadProducts from '@salesforce/apex/Veiculos.loadProducts'; 
import salvarCaso from '@salesforce/apex/Veiculos.salvarCaso';
import getOpcoesDiasVencimento from '@salesforce/apex/Veiculos.getOpcoesDiasVencimento'; 

export default class ViewVeiculos extends LightningElement {
    quilometragens;
    opcoesDiasVencimento;
    planoEscolhido;
    veiculoEscolhido;
    itemAdicionalEscolhido;
    seguroEscolhido;
    quilometragemEscolhida;
    opcaoSelecionada;
    cpfDoCliente;
    precoComDescontoCompactos;
    precoComDescontoLuxuosos;
    precoComDescontoParaFamilia;
    precoComDescontoItemAdicional;
    precoComDescontoQuilometragem;

    informacoesWrapper = {};

    connectedCallback() {
        loadProducts()
        .then((result) => {
            this.informacoesWrapper = JSON.parse(JSON.stringify(result));
            this.informacoesReserva = result;
            this.preencherQuilometragens();
        })
    }

    scrollToTop() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth' 
        });
    }

    preencherQuilometragens() {
        this.quilometragens = [
            { id: 1, opcaoSelecionada: '', options: [
                { label: this.informacoesWrapper.quilometragens[0].name + ' - R$' + this.informacoesWrapper.quilometragens[0].unitPrice + ' ao mês', value: this.informacoesWrapper.quilometragens[0].name },
                { label: this.informacoesWrapper.quilometragens[1].name + ' - R$' + this.informacoesWrapper.quilometragens[1].unitPrice + ' ao mês', value: this.informacoesWrapper.quilometragens[1].name },
                { label: this.informacoesWrapper.quilometragens[2].name + ' - R$' + this.informacoesWrapper.quilometragens[2].unitPrice + ' ao mês', value: this.informacoesWrapper.quilometragens[2].name }
            ]},
        ];
    }

    @wire(getOpcoesDiasVencimento)
    wiredOpcoesDiasVencimento({data, error}) {
        if(data) {
            this.opcoesDiasVencimento = [
                { id: 1, opcaoSelecionada: '', options: [
                    { label: data[0], value: data[0] },
                    { label: data[1], value: data[1] },
                    { label: data[2], value: data[2] }
                ]},
            ];
        } else if(error) {
            console.log(error);
        }
    }

    guardarPlanoEscolhido(event){
        var planoEscolhido = event.currentTarget.dataset.id;
        this.planoEscolhido = planoEscolhido; 
        this.informacoesWrapper.planoEscolhido = planoEscolhido;

        this.mostrarSessaoVeiculos();
    }

    preencherDadosComDescontos() {
        if(this.planoEscolhido == 'Mensal') {
            this.precoComDescontoCompactos = this.informacoesWrapper.veiculosEconomicosComDesconto5Porcento[0].precoComDesconto;
            this.precoComDescontoParaFamilia = this.informacoesWrapper.veiculosParaFamiliaComDesconto5Porcento[0].precoComDesconto;
            this.precoComDescontoLuxuosos = this.informacoesWrapper.veiculosLuxuososComDesconto5Porcento[0].precoComDesconto;
            this.precoComDescontoItemAdicional = this.informacoesWrapper.itemAdicionalComDesconto20Porcento[0].precoComDesconto;
        } else if (this.planoEscolhido == 'Semestral') {
            this.precoComDescontoCompactos = this.informacoesWrapper.veiculosEconomicosComDesconto10Porcento[0].precoComDesconto;
            this.precoComDescontoParaFamilia = this.informacoesWrapper.veiculosParaFamiliaComDesconto10Porcento[0].precoComDesconto;
            this.precoComDescontoLuxuosos = this.informacoesWrapper.veiculosLuxuososComDesconto10Porcento[0].precoComDesconto;
            this.precoComDescontoItemAdicional = this.informacoesWrapper.itemAdicionalComDesconto50Porcento[0].precoComDesconto;
        } else if (this.planoEscolhido == 'Anual') {
            this.precoComDescontoCompactos = this.informacoesWrapper.veiculosEconomicosComDesconto15Porcento[0].precoComDesconto;
            this.precoComDescontoParaFamilia = this.informacoesWrapper.veiculosParaFamiliaComDesconto15Porcento[0].precoComDesconto;
            this.precoComDescontoLuxuosos = this.informacoesWrapper.veiculosLuxuososComDesconto15Porcento[0].precoComDesconto;
            this.precoComDescontoItemAdicional = this.informacoesWrapper.itemAdicionalComDesconto100Porcento[0].precoComDesconto;
        }
    }

    mostrarSessaoVeiculos() {
        this.preencherDadosComDescontos();

        this.template.querySelector('[id^="idPlanos"]').className = 'none';
        this.template.querySelector('[id^="idVeiculos"]').className = 'block';
        this.template.querySelector('[id^="idDadosReserva"]').className = 'block';
        
        this.scrollToTop();
    }

    guardarVeiculoEscolhido(event){
        var veiculoEscolhido = event.currentTarget.dataset.id;
        this.veiculoEscolhido = veiculoEscolhido;
        this.informacoesWrapper.veiculoEscolhido = veiculoEscolhido; 

        this.mostrarSessaoItensAdicionais();
    }

    mostrarSessaoItensAdicionais() {
        this.template.querySelector('[id^="idVeiculos"]').className = 'none';
        this.template.querySelector('[id^="idDadosReservaVeiculo"]').className = 'block';
        this.template.querySelector('[id^="idItensAdicionais"]').className = 'block';
        
        this.scrollToTop();
    }

    guardarItemAdicionalEscolhido(event){
        var itemAdicionalEscolhido = event.currentTarget.dataset.id;
        this.itemAdicionalEscolhido = itemAdicionalEscolhido;
        this.informacoesWrapper.itemAdicionalEscolhido = itemAdicionalEscolhido;

        this.mostrarSessaoSeguros(); 
    }

    mostrarSessaoSeguros() {
        this.template.querySelector('[id^="idItensAdicionais"]').className = 'none';
        this.template.querySelector('[id^="idDadosReservaItemAdicional"]').className = 'block';
        this.template.querySelector('[id^="idSeguros"]').className = 'block';
        
        this.scrollToTop();
    }

    guardarSeguroEscolhido(event){
        var seguroEscolhido = event.currentTarget.dataset.id;
        this.seguroEscolhido = seguroEscolhido;
        this.informacoesWrapper.seguroEscolhido = seguroEscolhido;

        this.mostrarSessaoQuilometragem();
    }

    mostrarSessaoQuilometragem() {
        this.template.querySelector('[id^="idSeguros"]').className = 'none';
        this.template.querySelector('[id^="idDadosReservaSeguro"]').className = 'block';
        this.template.querySelector('[id^="idUltimasInformacoes"]').className = 'block';
        
        this.scrollToTop();
    }
    
    guardarQuilometragemEscolhida(event) {
        this.opcaoSelecionada = event.target.value;
        this.informacoesWrapper.quilometragemEscolhida = this.opcaoSelecionada;
    }

    guardarDataRetiradaEscolhida(event){
        this.opcaoSelecionada = event.target.value;
        this.informacoesWrapper.dataRetiradaEscolhida = this.opcaoSelecionada;
    }
    
    guardarDataVencimentoEscolhida(event){
        this.opcaoSelecionada = event.target.value; 
        this.informacoesWrapper.dataVencimentoEscolhida = this.opcaoSelecionada;
    }
    
    guardarCPFDoCliente(event){
        this.cpfDoCliente = event.target.value; 
        this.informacoesWrapper.cpfDoCliente = this.cpfDoCliente;
        console.log(this.cpfDoCliente);
    }

    finalizarReserva() {
        this.template.querySelector('[id^="idDadosReservaSeguro"]').className = 'none';
        this.template.querySelector('[id^="idUltimasInformacoes"]').className = 'none';
        this.template.querySelector('[id^="idTelaAgradecimento"]').className = 'block';

        salvarCaso({ informacoesReserva: JSON.stringify(this.informacoesWrapper)})
        .then(result => {
            console.log('Caso salvo com sucesso:', result);
        })
        .catch(error => {
            console.error('Erro ao salvar o caso:', error);
        });
    }
}