import { LightningElement, wire } from 'lwc';
import getVeiculosElegantes from '@salesforce/apex/Veiculos.getVeiculosElegantes';

export default class ViewCatalogoElegantes extends LightningElement {
    informacoesVeiculos;

    @wire(getVeiculosElegantes)
    wiredgetPrecosDosVeiculos({data, error}) {
        if(data) {
            this.informacoesVeiculos = data;
        } else if(error) {
            console.log('Erro.', error);
        }
    }
}