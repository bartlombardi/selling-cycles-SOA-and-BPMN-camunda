/**
 * Tipi comuni a tutti i servizi
 */

type Indirizzo:void {
	.citta:string
	.via:string
}

type Utente:void {
	.nome:string
	.cognome:string
	.dataNascita:string
	.codFis:string
	.indirizzo:Indirizzo
	.telefono:string
}

type Pezzo:void {
	.idPezzo:int
	.qta:int
	.prezzo?:double
}

type PezzoConPrezzo:void {
	.idPezzo:int
	.qta:int
	.prezzo:double
}

type PezziMancanti:void {
	.pezzi*:Pezzo
}

/**
 * Magazzino Principale
 */

/* Richieste */

// verificaDisponibilitaMagazzini
type RichiestaOrdine:void {
	.utente:Utente
	.pezzi*:Pezzo
}

// verificaDisponibilitaMagazzino
type RichiestaMagazzino:void {
	.idMagazzino:int
	.pezzi*:Pezzo
}

// verificaDisponibilitaFornitore
type RichiestaFornitore:void {
	.utente:Utente
	.idFornitore:int
	.pezzi*:Pezzo
}

// prenotaPezziMagazzini
type RichiestaPrenotazioneMagazzini:void {
	.idOrdine:int
	.utente:Utente
	.pezziMagazzino*:PezziMagazzino
}

// prenotaPezziMagazzino
type RichiestaPrenotazioneMagazzino:void {
	.idMagazzino:int
	.idOrdine:int
	.utente:Utente
	.pezzi*:Pezzo
}

// creaIstanzaOrdine
type RichiestaCreaOrdine:void {
	.idOrdine:int
	.utente:Utente
	.pezziMagazzino*:PezziMagazzino
}

// prenotaPezziFornitore
type RichiestaPrenotazioneFornitore:void {
	.idMagazzino:int
	.idOrdine:int
	.utente:Utente
	.pezzi*:Pezzo
}

// eliminaPrenotazioneMagazzini
type RichiestaEliminazioneMagazzini:void {
	.idOrdine:int
}

// eliminaPrenotazioneMagazzino
type RichiestaEliminazioneMagazzino:void {
	.idMagazzino:int
	.idOrdine:int
}

// eliminaPrenotazioneFornitore
type RichiestaEliminazioneFornitore:void {
	.idMagazzino:int
	.idOrdine:int
}

// eseguiOrdineMagazzini
type RichiestaEsecuzioneMagazzini:void {
	.idOrdine:int
}

// eseguiOrdineMagazzino
type RichiestaEsecuzioneMagazzino:void {
	.idMagazzino:int
	.idOrdine:int
}

// eseguiOrdineFornitore
type RichiestaEsecuzioneFornitore:void {
	.idMagazzino:int
	.idOrdine:int
}

// assemblaCiclo
type RichiestaAssembla:void {
	.idOrdine:int
}

/* Risposte */

// verificaDisponibilitaMagazzini
type RispostaVerificaDisponibilita:void {
	.pezziMancanti*:Pezzo
	.disponibilitaPezzi*:DisponibilitaPezzi
}

// verificaDisponibilitaMagazzino
type RispostaMagazzino:void {
	.pezziDisponibili*:Pezzo
}

// verificaDisponibilitaFornitore (pending)
type RispostaFornitore:void {
	.pezziDisponibili*:PezzoConPrezzo
}

/**
 * Tipi per il servizio magazzino secondario
 */

type RichiestaDisponibilitaPezzi:void {
	.pezzi*:Pezzo
}

type RichiestaDisponibilitaPezziFornitore:void {
	.pezzi*:Pezzo
}

type RichiestaPrenotazionePezzi:void {
	.idOrdine:int
	.utente:Utente
	.pezzi*:Pezzo
}

type DisponibilitaPezzi:void {
	.idPezzo:int
	.magazzini*:void {
		.idMagazzino:int
		.qta:int
		.prezzo?:double
	}	
}

type PezziMagazzino:void {
	.idMagazzino:int
	.pezzi*:Pezzo
}

type RispostaMagazzinoFornitore:void {
	.pezzi*:PezzoConPrezzo
}

type RispostaMagazzinoSecondario:void {
	.pezzi*:Pezzo
}