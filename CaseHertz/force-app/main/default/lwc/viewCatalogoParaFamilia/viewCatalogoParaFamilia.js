import { LightningElement, wire } from 'lwc';
import getVeiculosParaFamilia from '@salesforce/apex/Veiculos.getVeiculosParaFamilia';

export default class ViewCatalogoParaFamilia extends LightningElement {
    informacoesVeiculos;

    @wire(getVeiculosParaFamilia)
    wiredgetPrecosDosVeiculos({data, error}) {
        if(data) {
            this.informacoesVeiculos = data;
        } else if(error) {
            console.log('Erro.', error);
        }
    }
}