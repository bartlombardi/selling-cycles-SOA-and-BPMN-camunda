include "dataTypes.iol"

interface InterfacciaMagazzinoSecondario {
	RequestResponse:
		verificaDisponibilitaPezzi(RichiestaDisponibilitaPezzi)(RispostaMagazzinoSecondario),
		prenotaPezzi(RichiestaPrenotazionePezzi)(PezziMancanti)
	
	OneWay:
		eliminaPrenotazionePezzi(int),
		eseguiOrdinePezzi(int) 
}
