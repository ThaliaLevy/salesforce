import { LightningElement, wire } from 'lwc';
import getVeiculosEconomicos from '@salesforce/apex/Veiculos.getVeiculosEconomicos';

export default class ViewCatalogoEconomicos extends LightningElement {
    informacoesVeiculos;

    @wire(getVeiculosEconomicos)
    wiredgetPrecosDosVeiculos({data, error}) {
        if(data) {
            this.informacoesVeiculos = data;
        } else if(error) {
            console.log('Erro.', error);
        }
    }
}