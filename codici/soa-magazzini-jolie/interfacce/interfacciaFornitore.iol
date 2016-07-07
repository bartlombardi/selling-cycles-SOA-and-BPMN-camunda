include "dataTypes.iol"

interface InterfacciaFornitore {
	RequestResponse:
		verificaDisponibilitaPezzi(RichiestaDisponibilitaPezziFornitore)(RispostaMagazzinoFornitore),
		prenotaPezzi(RichiestaPrenotazionePezzi)(PezziMancanti)
	
	OneWay:
		eliminaPrenotazionePezzi(int),
		eseguiOrdinePezzi(int) 
}
