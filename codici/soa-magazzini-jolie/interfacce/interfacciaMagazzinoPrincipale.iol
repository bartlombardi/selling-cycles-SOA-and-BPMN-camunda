include "dataTypes.iol"

interface InterfacciaMagazzinoPrincipale {
	RequestResponse:
		verificaDisponibilitaMagazzini(RichiestaOrdine)(RispostaVerificaDisponibilita),
		verificaDisponibilitaMagazzino(RichiestaMagazzino)(RispostaMagazzino),
		verificaDisponibilitaFornitore(RichiestaFornitore)(RispostaFornitore),

		prenotaPezziMagazzini(RichiestaPrenotazioneMagazzini)(PezziMancanti),
		prenotaPezziMagazzino(RichiestaPrenotazioneMagazzino)(PezziMancanti),
		prenotaPezziFornitore(RichiestaPrenotazioneFornitore)(PezziMancanti),

		creaIstanzaOrdine(RichiestaCreaOrdine)(void),
	
		eliminaPrenotazioneMagazzini(RichiestaEliminazioneMagazzini)(void),
	  eliminaPrenotazioneMagazzino(RichiestaEliminazioneMagazzino)(void),
	  eliminaPrenotazioneFornitore(RichiestaEliminazioneFornitore)(void),

	  eseguiOrdineMagazzini(RichiestaEsecuzioneMagazzini)(void),
	  eseguiOrdineMagazzino(RichiestaEsecuzioneMagazzino)(void),
	  eseguiOrdineFornitore(RichiestaEsecuzioneFornitore)(void),
	  
	OneWay: 
	    assemblaCiclo(RichiestaAssembla)
}
