include "console.iol"
include "string_utils.iol"
include "time.iol"

include "../interfacce/interfacciaMagazzinoPrincipale.iol"

//==============================================================
// Debug Procedure
//==============================================================

define stampa {
	valueToPrettyString@StringUtils(oggettoDaStampare)(aaa);
	println@Console(testoDaStampare)();
	println@Console()();
	println@Console(aaa)();
	println@Console("=================================================================================")()
}

define stampaArray {
	println@Console(testoDaStampare)();
	println@Console()();
	println@Console("Dimensione array = " + #arrayDaStampare)();
	for(ii = 0, ii < #arrayDaStampare, ++ii) {
		valueToPrettyString@StringUtils(arrayDaStampare[ii])(aaa);
		println@Console("[" + ii +"]" + aaa)()
	};
	println@Console("=================================================================================")()
}

define log {
	getCurrentDateTime@Time(null)(timestamp); 
	println@Console(timestamp + messaggioDaStampare)()
}

define inizializzaRichiestaOrdine {
	iii.citta = "Soragna";
	iii.via = "Via Giuseppe Di Vittorio 12B";

	with(richiestaOrdine.utente) {
		.nome = "Andrea";
		.cognome = "Segalini";
		.dataNascita = "28/09/1993";
		.codFis = "SGLNDR044032XX";
		.indirizzo << iii;
		.telefono = "0524597893"
	};
	testoDaStampare="richiestaOrdine.utente"; oggettoDaStampare->richiestaOrdine.utente; stampa; // debug
	
	with(richiestaOrdine.pezzi[0]) {
		.idPezzo = 0;
		.qta = 15
	};
	with(richiestaOrdine.pezzi[1]) {
		.idPezzo = 1;
		.qta = 40
	};
	with(richiestaOrdine.pezzi[2]) {
		.idPezzo = 2;
		.qta = 5
	};
	with(richiestaOrdine.pezzi[3]) {
		.idPezzo = 3;
		.qta = 500
	};
	with(richiestaOrdine.pezzi[4]) {
		.idPezzo = 4;
		.qta = 35
	};
	with(richiestaOrdine.pezzi[5]) {
		.idPezzo = 5;
		.qta = 70
	};
	with(richiestaOrdine.pezzi[6]) {
		.idPezzo = 6;
		.qta = 5
	};
	nullProcess
}

//==============================================================
// Procedure
//==============================================================


outputPort ServizioMagazzinoPrincipale {
	Location: "socket://localhost:8000"
	Protocol: soap {
		.wsdl = "file:/home/andrea/Scrivania/magazzino_principale/magazzinoPrincipale.wsdl";
  		.wsdl.port = "MySelfServicePort"
	}
	Interfaces: InterfacciaMagazzinoPrincipale
}

main {
	install( default => println@Console("Server error")() );
	inizializzaRichiestaOrdine;
	getCurrentDateTime@Time(null)(ttt);
	println@Console("data:" + ttt)();
	testoDaStampare="richiestaOrdine"; oggettoDaStampare->richiestaOrdine; stampa; // debug
	verificaDisponibilitaMagazzini@ServizioMagazzinoPrincipale(richiestaOrdine)(rispostaDisponibilita);
	testoDaStampare="rispostaDisponibilita"; oggettoDaStampare->rispostaDisponibilita; stampa // debug
}
