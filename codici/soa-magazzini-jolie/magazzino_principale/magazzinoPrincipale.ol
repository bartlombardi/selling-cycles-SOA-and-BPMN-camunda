include "console.iol"
include "string_utils.iol"
include "time.iol"
include "ini_utils.iol"
include "database.iol"

include "../interfacce/interfacciaMagazzinoPrincipale.iol"
include "../interfacce/interfacciaMagazzinoSecondario.iol"
include "../interfacce/interfacciaFornitore.iol"

/*  Comando per la generazione del WSDL

	$ jolie2wsdl -i ~/Scrivania/interfacce/:/usr/lib/jolie/include/ \
		--namespace org.acme.magazzino-principale --portName MySelf \
		--portAddr http://localhost:8000 \
		--o magazzinoPrincipale.wsdl magazzinoPrincipale.ol
*/

inputPort MySelf {
	Location: "socket://localhost:8000"
	Protocol: soap {
		.wsdl = "file:magazzinoPrincipale.wsdl";
  		.wsdl.port = "MySelfServicePort";
		.dropRootValue = true
	}	
	Interfaces: InterfacciaMagazzinoPrincipale
}

outputPort ServizioMagazzinoPrincipale {
	Location: "socket://localhost:8000"
	Protocol: soap 
	Interfaces: InterfacciaMagazzinoPrincipale
}

outputPort ServizioMagazzinoSecondario {
	Protocol: soap
	Interfaces: InterfacciaMagazzinoSecondario
}

outputPort ServizioFornitore {
	Protocol: soap
	Interfaces: InterfacciaFornitore
}

//==============================================================
// Debug Procedure
//==============================================================

define stampa {
	valueToPrettyString@StringUtils(oggettoDaStampare)(aaa);
	println@Console(testoDaStampare)();
	println@Console()();
	println@Console(aaa)();
	println@Console("===============================================================================")()
}

define stampaArray {
	println@Console(testoDaStampare)();
	println@Console()();
	println@Console("Dimensione array = " + #arrayDaStampare)();
	for(ii = 0, ii < #arrayDaStampare, ++ii) {
		valueToPrettyString@StringUtils(arrayDaStampare[ii])(aaa);
		println@Console("[" + ii +"]" + aaa)()
	};
	println@Console("===============================================================================")()
}

define log {
	getCurrentDateTime@Time(null)(timestamp); 
	println@Console(timestamp + " - " + messaggioDaStampare)()
}

//==============================================================
// Procedure
//==============================================================

/**
 * Procedura che leggi dal file "magazzinoPrincipale.conf" le
 * informazioni per il deployment
 */
define leggiImpostazioni {
	parseIniFile@IniUtils("magazzinoPrincipale.conf")(configInfo);
	location = configInfo.deployment.url;
	idMagazzinoPrincipale = int(configInfo.deployment.idMagazzino);

	username = configInfo.database.username;
	password = configInfo.database.password;
	host = configInfo.database.host;
	port = int(configInfo.database.port);
	database = configInfo.database.url;
	driver = configInfo.database.driver
}

define inizializzaPorte {
	ServizioMagazzinoPrincipale.location = location
}

define connettiDB {
	scope( scopeConnettiDB ) {
		install(DriverClassNotFound => messaggioDaStampare = "[ERROR] - Driver class not found"; log );
		install(InvalidDriver => messaggioDaStampare = "[ERROR] - Invalid driver"; log );
		install(ConnectionError => messaggioDaStampare = "[ERROR] - Connection error"; log );

		with ( connectionInfo ) {
	        .username = username;
	        .password = password;
	        .host = host;
	        .port = port;
	        .database = database; // "." for memory-only
	        .driver = driver
	    };

    	connect@Database( connectionInfo )( void )
    	//messaggioDaStampare = "connesso al database"; log
    }
}

define disconnettiDB {
	scope(scopeDisconnettiDB) {
		close@Database()()
		//messaggioDaStampare = "disconnesso dal database"; log
	}
}
	
define inizializzaInfoMagazzini {
	scope(scopeInizializzaInfoMagazzini) {	

		connettiDB;

		scope(selection) {
			queryRequest = 
				"SELECT id, url, principale FROM magazzini " + 
				"WHERE principale = TRUE";
			query@Database( queryRequest )( queryResponse );
			magazzinoPrincipale.idMagazzino = queryResponse.row[0].ID;
			magazzinoPrincipale.url = queryResponse.row[0].URL;
			tabellaMagazzini.(magazzinoPrincipale.idMagazzino).fornitore = false;
			tabellaMagazzini.(queryResponse.row[i].ID).url = queryResponse.row[i].URL
		};

		scope(selection) {	
			queryRequest = 
				"SELECT id, url, fornitore FROM magazzini " + 
				"WHERE fornitore = TRUE";
			query@Database( queryRequest )( queryResponse );
			fornitore.idMagazzino = queryResponse.row[0].ID;
			fornitore.url = queryResponse.row[0].URL;
			tabellaMagazzini.(fornitore.idMagazzino).fornitore = true;
			tabellaMagazzini.(queryResponse.row[i].ID).url = queryResponse.row[i].URL
		};

		scope(selection) {
			queryRequest = 
				"SELECT id, url, fornitore, principale FROM magazzini " + 
				"WHERE principale = FALSE and fornitore = FALSE";
			query@Database( queryRequest )( queryResponse );
			for(i = 0, i < #queryResponse.row, ++i) {
				nMS = #magazziniSecondari;
				magazziniSecondari[nMS].idMagazzino = queryResponse.row[i].ID;
				magazziniSecondari[nMS].url = queryResponse.row[i].URL;
				tabellaMagazzini.(queryResponse.row[i].ID).fornitore = false;
				tabellaMagazzini.(queryResponse.row[i].ID).url = queryResponse.row[i].URL
			}
		};

		disconnettiDB
	}
}


/** Inizializzo le tabelle tabellaOrdine
 * tabellaOrdine <- inizializzaTabelle(richiestaOrdine:RichiestaOrdine)
 */
define inizializzaTabelle {
	for(i = 0, i < #richiestaOrdine.pezzi, ++i) {
		idPezzo = richiestaOrdine.pezzi[i].idPezzo;
		qta = richiestaOrdine.pezzi[i].qta;

		tabellaOrdine.(idPezzo).qta = qta
	}
}

/** Aggiorna tabella tabellaDisponibilita
 * tabellaDisponibilita <- aggiornaDisponibilitaPezzi(
 *     disponibilitaMagazzino:DisponibilitaMagazzino, 
 *     idMagazzino:int)
 */
define aggiornaDisponibilitaPezzi {
	for(i = 0, i < #disponibilitaMagazzino.pezziDisponibili, ++i) {
		idPezzo = disponibilitaMagazzino.pezziDisponibili[i].idPezzo;
		qta = disponibilitaMagazzino.pezziDisponibili[i].qta;

		entry -> tabellaDisponibilita.(idPezzo).magazzini;
		nMagazzini = #entry;

		entry[nMagazzini].idMagazzino = idMagazzino;
		entry[nMagazzini].qta = qta;

		if(is_defined(disponibilitaMagazzino.pezziDisponibili[i].prezzo)) {
			entry[nMagazzini].prezzo = disponibilitaMagazzino.pezziDisponibili[i].prezzo
		}
	}
}

/** Crea la lista dei pezziMancanti
 * pezziMancanti <- riempiPezziMancanti(tabellaDisponibilita:TabellaDisponibilitaMagazzino,
 *     tabellaOrdine:TabellaOrdine)
 */
define riempiPezziMancanti {
	foreach (t : tabellaOrdine) {
		if(!is_defined(tabellaDisponibilita.(t))) {
			idPezzo = int(t);
			nPezzMancanti = #pezziMancanti;
			
			pezziMancanti[nPezzMancanti].idPezzo = idPezzo;
			pezziMancanti[nPezzMancanti].qta = tabellaOrdine.(idPezzo).qta
		}
	};

	foreach (d : tabellaDisponibilita) {
		idPezzo = int(d);
		nPezzMancanti = #pezziMancanti;
		magazzini -> tabellaDisponibilita.(d).magazzini;

		qtaAccumulata = 0;
		for(l = 0, l < #magazzini, ++l) {
			qtaAccumulata = qtaAccumulata + magazzini[l].qta
		};

		qtaOrdine -> tabellaOrdine.(d).qta;
		if(qtaOrdine > qtaAccumulata) {
			pezziMancanti[nPezzMancanti].idPezzo = idPezzo;
			pezziMancanti[nPezzMancanti].qta = qtaOrdine - qtaAccumulata
		}
	}
}

//==============================================================
// Main
//==============================================================

execution { concurrent }

init {
	println@Console("#ServizioMagazzinoSecondario")();
	// Legge le impostazione dal file di configurazione "magazzinoSecondario.conf"
	leggiImpostazioni;
	inizializzaPorte;
	println@Console("#location: " + location)();

	inizializzaInfoMagazzini;

	messaggioDaStampare = "[INFO] Servizio inziato"; log
}

main {




[verificaDisponibilitaMagazzini(richiestaOrdine)(rispostaVerificaDisponibilita) {
	scope( scopeVerificaDisponibilitaMagazzini ) {
		aaa = "richiestaOrdine"; oggettoDaStampare << richiestaOrdine; stampa;

		inizializzaTabelle; // Inizializzo le tabelle tabellaOrdine
		utente << richiestaOrdine.utente; // Estraggo l'utente che ha fatto l'ordine

		// Controllo nel magazzino principale
		richiestaDisponibilita.idMagazzino = magazzinoPrincipale.idMagazzino;
		richiestaDisponibilita.pezzi << richiestaOrdine.pezzi;
		verificaDisponibilitaMagazzino@ServizioMagazzinoPrincipale(richiestaDisponibilita)(disponibilitaMagazzino);

		// Riempio disponibilitaPezzi
		idMagazzino = magazzinoPrincipale.idMagazzino;
		aggiornaDisponibilitaPezzi;
		riempiPezziMancanti; // Riempio pezziMancanti

		// Per ogni magazzino secondario:
		for(k = 0, k < #magazziniSecondari, ++k) {
			idMagazzino = magazziniSecondari[k].idMagazzino;
			// Preparo la richiesta disponibilita pezzi con i pezzi mancanti della prima fase
			undef( richiestaDisponibilita );
			richiestaDisponibilita.idMagazzino = idMagazzino;
			richiestaDisponibilita.pezzi << pezziMancanti;
			verificaDisponibilitaMagazzino@ServizioMagazzinoPrincipale(richiestaDisponibilita)(disponibilitaMagazzino);
			// Riempio disponibilitaPezzi. N.B. idMagazzino è già inizializzato correttamente
			aggiornaDisponibilitaPezzi
		};

		// Riempio pezziMancanti
		undef(pezziMancanti);
		riempiPezziMancanti;

		// Preparo la richiesta disponibilita pezzi per il fornitore esterno
		richiestaOrdineFornitore.utente << utente;
		richiestaOrdineFornitore.idFornitore = fornitore.idMagazzino;
		richiestaOrdineFornitore.pezzi << pezziMancanti;
		verificaDisponibilitaFornitore@ServizioMagazzinoPrincipale(richiestaOrdineFornitore)(rispostaFornitore);

		// Aggiorno disponibilitaPezzi
		undef(disponibilitaMagazzino);
		disponibilitaMagazzino << rispostaFornitore;
		idMagazzino = fornitore.idMagazzino;
		aggiornaDisponibilitaPezzi;

		// Riempio pezziMancanti
		undef(pezziMancanti);
		riempiPezziMancanti;

		// Riempio la risposta dell'operation rispostaVerificaDisponibilita
		rispostaVerificaDisponibilita.pezziMancanti << pezziMancanti;
		foreach (p : tabellaDisponibilita) {
			n = #rispostaVerificaDisponibilita.disponibilitaPezzi;
			r -> rispostaVerificaDisponibilita.disponibilitaPezzi[n];
			r.idPezzo = int(p);
			r.magazzini << tabellaDisponibilita.(p).magazzini
		};

	  aaa = "rispostaVerificaDisponibilita"; oggettoDaStampare << rispostaVerificaDisponibilita; stampa
	}
}]{messaggioDaStampare = "[INFO] Invocato verificaDisponibilitaMagazzini()()"; log}




[verificaDisponibilitaMagazzino(richiestaDisponibilitaMagazzino)(rispostaDisponibilitaMagazzino) {
	scope( scopeVerificaDisponibilitaMagazzino ) {
		idMagazzino = richiestaDisponibilitaMagazzino.idMagazzino;
		richiestaDisponibilitaPezzi.pezzi << richiestaDisponibilitaMagazzino.pezzi;

		ServizioMagazzinoSecondario.location = tabellaMagazzini.(idMagazzino).url;
		verificaDisponibilitaPezzi@ServizioMagazzinoSecondario(richiestaDisponibilitaPezzi)(pezziDisponibili);

		rispostaDisponibilitaMagazzino.pezziDisponibili << pezziDisponibili.pezzi
	}	
}]{messaggioDaStampare = "[INFO] Invocato verificaDisponibilitaMagazzino()()"; log}




[verificaDisponibilitaFornitore(richiestaOrdineFornitore)(rispostaFornitore) {
	scope( scopeVerificaDisponibilitaFornitore ) {
		idMagazzino = richiestaOrdineFornitore.idFornitore;
		pezzi << richiestaOrdineFornitore.pezzi;

		richiestaDisponibilitaFornitore.pezzi << pezzi;
		ServizioFornitore.location = tabellaMagazzini.(idMagazzino).url;
		verificaDisponibilitaPezzi@ServizioFornitore(richiestaDisponibilitaFornitore)(rispostaDisponibilitaFornitore);

		rispostaFornitore.pezziDisponibili << rispostaDisponibilitaFornitore.pezzi
	}
}]{ messaggioDaStampare = "[INFO] Invocato verificaDisponibilitaFornitore()()"; log }




[prenotaPezziMagazzini(ordine)(rispostaPrenotazioneMagazzini) {
	scope(prenotaPezziMagazzini) {
		idOrdine = ordine.idOrdine;
		utente << ordine.utente;

		// creo nel database l'istanza dell'ordine
		creaIstanzaOrdine@ServizioMagazzinoPrincipale(ordine)();
		pezziMagazzino -> ordine.pezziMagazzino;

		// Inizializzo una tabella "tabellaOrdiniMagazzini" con <idMagazzino, <idPezzo, qta>>
		for(i = 0, i < #pezziMagazzino, ++i) {
			idMagazzino = pezziMagazzino[i].idMagazzino;

			ordineMagazzino.idOrdine = idOrdine;
			ordineMagazzino.utente << utente;
			ordineMagazzino.idMagazzino = idMagazzino;
			ordineMagazzino.pezzi << pezziMagazzino[i].pezzi;

			if(tabellaMagazzini.(idMagazzino).fornitore == false) {
				prenotaPezziMagazzino@ServizioMagazzinoPrincipale(ordineMagazzino)(pezziNonRiservati);
				nullProcess
			} else {
				prenotaPezziFornitore@ServizioMagazzinoPrincipale(ordineMagazzino)(pezziNonRiservati);
				nullProcess
			};

			// Aggiorno la lista di pezzi non riservati
			for(j = 0, j < #pezziNonRiservati.pezzi, ++j) {
				pezziMancanti[#pezziMancanti] << pezziNonRiservati.pezzi[j]
			}
		};

		// Setto la risposta dell'operation con la lista dei pezzi non riservati
		rispostaPrenotazioneMagazzini.pezzi << pezziMancanti
	}
}]{ messaggioDaStampare = "[INFO] Invocato prenotaPezziMagazzini()()"; log }




[creaIstanzaOrdine(istanzaOrdine)() {
	scope(scopeCreaIstanzaOrdine) {
		idOrdine = istanzaOrdine.idOrdine;
		utente << istanzaOrdine.utente;
		magazzino -> istanzaOrdine.pezziMagazzino;

		connettiDB;

		// Inserisco l'utente solo se non è già presente
		scope(select) {
			queryRequest = 
				"SELECT * FROM utenti " + 
				"WHERE cod_fiscale = :codFis";
			queryRequest.codFis = utente.codFis;
			query@Database( queryRequest )( queryResponse )
		};
		if(#queryResponse.row == 0) {
			scope(insert) {
				updateRequest =
			        "INSERT INTO utenti(cod_fiscale, via, citta) VALUES" +
			        "(:codFis, :via, :citta)";
			    updateRequest.codFis = utente.codFis;
			    updateRequest.via = utente.indirizzo.via;
			    updateRequest.citta = utente.indirizzo.via;
			    update@Database( updateRequest )( ret )
			}
		};

		scope(insert) {
			undef( updateRequest );
			updateRequest =
		        "INSERT INTO ordini(id, data, id_utente) VALUES" +
		        "(:idOrdine, '2010-1-1', :idUtente)";
		    updateRequest.idOrdine = idOrdine;
		    //updateRequest.data = "2010-02-11";
		    updateRequest.idUtente = utente.codFis;
		    update@Database( updateRequest )( ret )
		};

		scope(insert) {
			undef( updateRequest );

			for (i = 0, i < #magazzino, ++i) {
				for(j = 0, j < #magazzino[i].pezzi, ++j) {
					updateRequest =
						"INSERT INTO pezziOrdini(id_pezzo, id_ordine, id_magazzino, quantita) VALUES " +
			        	"(:idPezzo, :idOrdine, :idMagazzino, :qta)";
			        updateRequest.idPezzo = magazzino[i].pezzi[j].idPezzo;
			        updateRequest.idOrdine = idOrdine;
			        updateRequest.idMagazzino = magazzino[i].idMagazzino;
			        updateRequest.qta = magazzino[i].pezzi[j].qta;
			        update@Database( updateRequest )( ret )
				}  
			}
		};

		disconnettiDB
	}
} ] { messaggioDaStampare = "[INFO] Invocato creaIstanzaOrdine()()"; log }




[prenotaPezziMagazzino(richiestaPrenotazioneMagazzino)(rispostaPezziMancanti){
	scope(scopePrenotaPezziMagazzino) {
		idMagazzino = richiestaPrenotazioneMagazzino.idMagazzino;
		richiestaPrenotazione.idOrdine = richiestaPrenotazioneMagazzino.idOrdine;
		richiestaPrenotazione.utente << richiestaPrenotazioneMagazzino.utente;
		richiestaPrenotazione.pezzi << richiestaPrenotazioneMagazzino.pezzi;

		ServizioMagazzinoSecondario.location = tabellaMagazzini.(idMagazzino).url;
		prenotaPezzi@ServizioMagazzinoSecondario(richiestaPrenotazione)(pezziNonRiservati);

		rispostaPezziMancanti << pezziNonRiservati
	}
}]{messaggioDaStampare = "[INFO] Invocato prenotaPezziMagazzino()()"; log}




[prenotaPezziFornitore(richiestaPrenotazioneMagazzino)(rispostaPezziMancanti){
	scope(scopePrenotaPezziFornitore) {
		idMagazzino = richiestaPrenotazioneMagazzino.idMagazzino;
		richiestaPrenotazione.idOrdine = richiestaPrenotazioneMagazzino.idOrdine;
		richiestaPrenotazione.utente << richiestaPrenotazioneMagazzino.utente;
		richiestaPrenotazione.pezzi << richiestaPrenotazioneMagazzino.pezzi;

		ServizioFornitore.location = tabellaMagazzini.(idMagazzino).url;
		prenotaPezzi@ServizioFornitore(richiestaPrenotazione)(pezziNonRiservati);

		rispostaPezziMancanti << pezziNonRiservati
	}
}]{messaggioDaStampare = "[INFO] Invocato prenotaPezziFornitore()()"; log}




[eliminaPrenotazioneMagazzini(richiestaEliminazione)() {
	scope(scopeEliminaPrenotazioneMagazzini) {
		idOrdine = richiestaEliminazione.idOrdine;

		connettiDB;
	
		// Elimino ordine dal db del magazzino principale
		scope(update) {
			undef( updateRequest );
			updateRequest =
	        "DELETE FROM pezziOrdini WHERE id_ordine = :idOrdine";
	        updateRequest.idOrdine = idOrdine;
	        update@Database( updateRequest )( ret );
	        undef( updateRequest );
	        updateRequest =
	        "DELETE FROM ordini WHERE id = :idOrdine";
	        updateRequest.idOrdine = idOrdine;
	        update@Database( updateRequest )( ret )
	    };
	
	    disconnettiDB;
	
		// Eseguo la richiesta di eliminazione ordine presso gli altri enti coinvolti
		richiestaEliminazione.idMagazzino = magazzinoPrincipale.idMagazzino;
		richiestaEliminazione.idOrdine = idOrdine;
		eliminaPrenotazioneMagazzino@ServizioMagazzinoPrincipale(richiestaEliminazione)();
		for(i = 0, i < #magazziniSecondari, ++i) {
			undef( richiestaEliminazione );
			richiestaEliminazione.idMagazzino = magazziniSecondari[i].idMagazzino;
			richiestaEliminazione.idOrdine = idOrdine;
			eliminaPrenotazioneMagazzino@ServizioMagazzinoPrincipale(richiestaEliminazione)()
		};
		undef( richiestaEliminazione );
		richiestaEliminazione.idMagazzino = fornitore.idMagazzino;
		richiestaEliminazione.idOrdine = idOrdine;

		eliminaPrenotazioneFornitore@ServizioMagazzinoPrincipale(richiestaEliminazione)()
	}
} ] { messaggioDaStampare = "[INFO] Invocato eliminaPrenotazioneMagazzini()"; log }




[eliminaPrenotazioneMagazzino(richiestaEliminazione)() {
	scope(scopeEliminaPrenotazioneMagazzino) {
		idMagazzino = richiestaEliminazione.idMagazzino;
		idOrdine = richiestaEliminazione.idOrdine;

		ServizioMagazzinoSecondario.location = tabellaMagazzini.(idMagazzino).url;		
		eliminaPrenotazionePezzi@ServizioMagazzinoSecondario(idOrdine)
	}
} ] { messaggioDaStampare = "[INFO] Invocato eliminaPrenotazioneMagazzino()"; log }




[eliminaPrenotazioneFornitore(richiestaEliminazione)() {
	scope(scopeEliminaPrenotazioneMagazzino) {
		idMagazzino = richiestaEliminazione.idMagazzino;
		idOrdine = richiestaEliminazione.idOrdine;

		ServizioFornitore.location = tabellaMagazzini.(idMagazzino).url;
		eliminaPrenotazionePezzi@ServizioFornitore(idOrdine)
	}
} ] { messaggioDaStampare = "[INFO] Invocato eliminaPrenotazioneFornitore()"; log }




[eseguiOrdineMagazzini(richiestaEsecuzione)() {
	scope(scopeEseguiOrdineMagazzini) {
		idOrdine = richiestaEsecuzione.idOrdine;
		
		foreach (m : tabellaMagazzini) {
			idMagazzino = tabellaMagazzini.(m).idMagazzino;
			url = tabellaMagazzini.(m).url;

			richiestaEsecuzioneOrdine.idMagazzino = idMagazzino;
			richiestaEsecuzioneOrdine.idOrdine = idOrdine;

			if(tabellaMagazzini.(m).fornitore == true) {
				eseguiOrdineMagazzino@ServizioMagazzinoPrincipale(richiestaEsecuzioneOrdine)()
			} else {
				eseguiOrdineFornitore@ServizioMagazzinoPrincipale(richiestaEsecuzioneOrdine)()
			}
		}
	}
} ] { messaggioDaStampare = "[INFO] Invocato eseguiOrdineMagazzini()"; log }




[eseguiOrdineMagazzino(richiestaEsecuzioneOrdine)() {
	scope(scopeEseguiOrdineFornitore) {
		idOrdine = richiestaEsecuzioneOrdine.idOrdine;
		idMagazzino = richiestaEsecuzioneOrdine.idMagazzino;

		url = tabellaMagazzini.(idMagazzino).url;
		ServizioMagazzinoSecondario.location = url;
		eseguiOrdinePezzi@ServizioMagazzinoSecondario(idOrdine);

		testoDaStampare="Esegui ordine fornitore"; oggettoDaStampare->richiestaEsecuzioneOrdine; stampa; // debug
		nullProcess
	}
} ] { messaggioDaStampare = "[INFO] invocato eseguiOrdineFornitore()"; log }




[eseguiOrdineFornitore(richiestaEsecuzioneOrdine)() {
	scope(scopeEseguiOrdineFornitore) {
		testoDaStampare="Esegui ordine fornitore"; oggettoDaStampare->richiestaEsecuzioneOrdine; stampa; // debug
		nullProcess
	}
} ] { messaggioDaStampare = "[INFO] invocato eseguiOrdineFornitore()"; log }




[assemblaCiclo(richiestaAssembla)] {
	scope(scopeAssemblaCiclo) {
		idOrdine = richiestaAssembla.idOrdine;
		testoDaStampare="Assembla ciclo"; oggettoDaStampare->idOrdine; stampa; // debug
		nullProcess
	};
	messaggioDaStampare = "[INFO] invocato assemblaCiclo()"; log
}




}
