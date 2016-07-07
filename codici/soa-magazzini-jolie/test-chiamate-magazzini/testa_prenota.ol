include "console.iol"
include "string_utils.iol"

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

define inizializza {
	iii.citta = "Soragna";
	iii.via = "Via Giuseppe Di Vittorio 12B";

	with(utente) {
		.nome = "Andrea";
		.cognome = "Segalini";
		.dataNascita = "28/09/1993";
		.codFis = "SGLNDR044032XX";
		.indirizzo << iii;
		.telefono = "0524597893"
	};
	testoDaStampare="richiestaOrdine.utente"; oggettoDaStampare->richiestaOrdine.utente; stampa; // debug
	
	with(pezzi[0]) {
		.idPezzo = 2;
		.qta = 500
	};
	with(pezzi[1]) {
		.idPezzo = 3;
		.qta = 30
	};
	with(pezzi[2]) {
		.idPezzo = 4;
		.qta = 30
	};
	with(pezzi[3]) {
		.idPezzo = 5;
		.qta = 30
	};
	with(pezziMagazzino[0]) {
		.idMagazzino = 1;
		.pezzi << pezzi
	};

	undef( pezzi );
	with(pezzi[0]) {
		.idPezzo = 0;
		.qta = 30
	};
	with(pezzi[1]) {
		.idPezzo = 1;
		.qta = 30
	};
	with(pezzi[2]) {
		.idPezzo = 4;
		.qta = 30
	};
	with(pezzi[3]) {
		.idPezzo = 5;
		.qta = 10
	};
	with(pezzi[4]) {
		.idPezzo = 6;
		.qta = 30
	};
	with(pezziMagazzino[1]) {
		.idMagazzino = 2;
		.pezzi << pezzi
	};


	// with(pezziMagazzino[3]) {
	// 	.idMagazzino = 101;
	// 	.pezzi << pezzi
	// };

	ordine.idOrdine = 512;
	ordine.utente << utente;
	ordine.pezziMagazzino << pezziMagazzino;

	nullProcess
}

define iniziliazzaVerificaDisponibilitaMP {
  	with(disponibilitaMagazzino[0]) {
  		.idPezzo = 0;
  		.qta = 1000
  	};
  	nullProcess
}

define iniziliazzaVerificaDisponibilitaMS1 {
  	with(disponibilitaMagazzino[0]) {
  		.idPezzo = 0;
  		.qta = 1000
  	};
  	with(disponibilitaMagazzino[1]) {
  		.idPezzo = 1;
  		.qta = 50
  	};
  	with(disponibilitaMagazzino[2]) {
  		.idPezzo = 2;
  		.qta = 2000
  	};
  	nullProcess
}

outputPort ServizioMagazzinoPrincipale {
	Location: "socket://localhost:8000"
	Protocol: soap {
		.wsdl = "file:/home/andrea/Scrivania/magazzino_principale/magazzinoPrincipale.wsdl";
  		.wsdl.port = "MySelfServicePort"
	}
	Interfaces: InterfacciaMagazzinoPrincipale
}

main {
	inizializza;
	testoDaStampare="ordine"; oggettoDaStampare->ordine; stampa; // debug
	prenotaPezziMagazzini@ServizioMagazzinoPrincipale(ordine)(pezziNonRiservati);
	testoDaStampare="pezziNonRiservati"; oggettoDaStampare->pezziNonRiservati; stampa; // debug
	nullProcess
}