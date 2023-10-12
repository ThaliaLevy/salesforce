import { LightningElement, track, api } from 'lwc';
import { RefreshEvent } from 'lightning/refresh';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import addCepDataToCepDataWrapper from '@salesforce/apex/CepData.addCepDataToCepDataWrapper';
import saveCepData from '@salesforce/apex/CepData.saveCepData';

export default class ConsultaCEP extends LightningElement {
    @track isModalOpen = false;
    @api recordId

    cepData = {};
    cepSavedForSearch;
    numberSaved;

    closeSection() {
        this.isModalOpen = false;
    }

    openSection() {
        this.isModalOpen = true;
        this.cleanSection();
    }

    cleanSection() {
        this.cepData = {};
    }

    saveCepForSearch(event) {
        this.cepSavedForSearch = event.target.value;
    }

    saveNumber(event) {
        this.numberSaved = event.target.value;
    }

    searchCep() {
        addCepDataToCepDataWrapper({ cep: this.cepSavedForSearch })
        .then(result => {
            this.showToast('Sucesso', 'Consulta realizada com sucesso', 'Success');
            this.cepData = result;
        })
        .catch(() => {
            this.showToast('Falha ao realizar consulta', 'Cep inválido', 'error');
        });
    }

    saveCep() {
        if(this.cepData.cep != null) {
            saveCepData({ cepData: JSON.stringify(this.cepData), idCurrentAccount: this.recordId, numberSaved: this.numberSaved })
            .then(() => {
                this.closeSection();
                this.showToast('Sucesso', 'Endereço atualizado com sucesso', 'Success');
                this.dispatchEvent(new RefreshEvent());
            })
            .catch(() => {
                this.showToast('Falha ao atualizar', 'Ocorreu um erro ao salvar o endereço', 'error');
            });
        } else {
            this.showToast('Falha ao atualizar', 'Preencha o CEP e clique na lupa para fazer a busca dos dados antes de clicar em Salvar', 'error');
        }
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
          title: title,
          message: message,
          variant: variant
        });

        this.dispatchEvent(event);
      }
}