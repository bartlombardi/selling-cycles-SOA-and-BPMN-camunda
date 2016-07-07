include "console.iol"
include "string_utils.iol"
include "database.iol"
include "time.iol"
include "ini_utils.iol"

include "../interfacce/interfacciaMagazzinoSecondario.iol"

inputPort MySelf {
	Location: "socket://localhost:8002"
	Protocol: soap
	Interfaces: InterfacciaMagazzinoSecondario
}

outputPort ServizioMagazzinoSecondario {
	Protocol: soap
	Interfaces: InterfacciaMagazzinoSecondario
}

//==============================================================
// Procedure di debug
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

define leggiImpostazioni {
	parseIniFile@IniUtils("magazzinoSecondario.conf")(configInfo);
	location = configInfo.deployment.url;
	idMagazzino = int(configInfo.deployment.idMagazzino);

	username = configInfo.database.username;
	password = configInfo.database.password;
	host = configInfo.database.host;
	port = int(configInfo.database.port);
	database = configInfo.database.url;
	driver = configInfo.database.driver
}

define inizializzaPorte {
	ServizioMagazzinoSecondario.location = location
}

define connettiDB {
	scope( scopeConnettiDB ) {
		install(DriverClassNotFound => println@Console("Driver class not found")());
		install(InvalidDriver => println@Console("Invalid driver")());
		install(ConnectionError => println@Console("Connection error")());

		with ( connectionInfo ) {
	        .username = username;
	        .password = password;
	        .host = host;
	        .port = port;
	        .database = database; // "." for memory-only
	        .driver = driver
	    };

    	connect@Database( connectionInfo )( void );
    	messaggioDaStampare = "connesso al database"; log
    }
}

define disconnettiDB {
	close@Database()();
	messaggioDaStampare = "disconnesso dal database"; log
}
 
execution { concurrent }

init {
	println@Console("#ServizioMagazzinoSecondario")();
	// Legge le impostazione dal file di configurazione "magazzinoSecondario.conf"
	leggiImpostazioni;
	println@Console("#location: " + location)();
	// Inizializza l'inputPort
	inizializzaPorte;
	messaggioDaStampare = "servizio inziato"; log
}

main {
[verificaDisponibilitaPezzi(richiestaDisponibilitaPezzi)(rispostaDisponibilitaMagazzino) {
scope(scopeVerificaDiponibilitaPezzi) {
	connettiDB;
	pezzi -> richiestaDisponibilitaPezzi.pezzi;
	scope(selection) {
		for(i = 0, i < #pezzi, ++i) {
			queryRequest = 
				"SELECT id, quantita FROM pezzi " + 
				"WHERE id = :id";
			queryRequest.id = pezzi[i].idPezzo;
			query@Database( queryRequest )( queryResponse );
			if(#queryResponse.row > 0) {
				nPezziDisponibili = #pezziDisponibili;
				pezziDisponibili[nPezziDisponibili].idPezzo = queryResponse.row[0].ID;
				pezziDisponibili[nPezziDisponibili].qta = queryResponse.row[0].QUANTITA
			}
		}
	};
	disconnettiDB;
	rispostaDisponibilitaMagazzino.pezzi << pezziDisponibili
}
}]{messaggioDaStampare = "invocata verificaDisponibilitaPezzi()()"; log}




[prenotaPezzi(richiestaPrenotazionePezzi)(pezziMancanti) {
scope(scopePrenotaPezzi) {
	idOrdine = richiestaPrenotazionePezzi.idOrdine;
	utente << richiestaPrenotazionePezzi.utente;
	pezzi << richiestaPrenotazionePezzi.pezzi;
	getCurrentDateTime@Time(null)(data);

	connettiDB;
	scope(select) {
		//install(SQLException => println@Console("select utenti")());
		queryRequest = 
			"SELECT * FROM utenti " + 
			"WHERE cod_fiscale = :codFis";
		queryRequest.codFis = utente.codFis;
		query@Database( queryRequest )( queryResponse );
		nullProcess
	};
	if(#queryResponse.row == 0) {
		scope(insert) {
			//install(SQLException => println@Console("errore insert utente")());
			updateRequest =
		        "INSERT INTO utenti(cod_fiscale, via, citta) VALUES" +
		        "(:codFis, :via, :citta)";
		    updateRequest.codFis = utente.codFis;
		    updateRequest.via = utente.indirizzo.via;
		    updateRequest.citta = utente.indirizzo.via;
		    update@Database( updateRequest )( ret );
		    nullProcess
		}
	};

	scope(insert) {
		//install(SQLException => println@Console("errore insert ordine")());
		undef( updateRequest );
		updateRequest =
	        "INSERT INTO ordini(id, data, id_utente) VALUES" +
	        "(:idOrdine, '2010-1-1', :idUtente)";
	    updateRequest.idOrdine = idOrdine;
	    updateRequest.data = "2010-02-11";
	    updateRequest.idUtente = utente.codFis;
	    update@Database( updateRequest )( ret )
	};

	for(i = 0, i < #pezzi, ++i) {
		scope(select) {
			//install(SQLException => println@Console("select pezzi: " + i)());
			undef(queryRequest);
			queryRequest = 
				"SELECT quantita FROM pezzi " + 
				"WHERE id = :idPezzo";
			queryRequest.idPezzo = pezzi[i].idPezzo;
			query@Database( queryRequest )( queryResponse );
			nullProcess
		};

		if(queryResponse.row[0].QUANTITA >= pezzi[i].qta) {
			scope(insert) {
				//install(SQLException => println@Console("insert pezziOrdini: " + i)());
				undef( updateRequest );
				updateRequest =
		        "INSERT INTO pezziOrdini(id_pezzo, id_ordine, quantita) VALUES" +
		        "(:idPezzo, :idOrdine, :qta)";
		        updateRequest.idOrdine = idOrdine;
		        updateRequest.idPezzo = pezzi[i].idPezzo;
		        updateRequest.qta = pezzi[i].qta;
		        update@Database( updateRequest )( ret );
		    	nullProcess
		    }
		} else {
			nPezziMancanti = #pezziMancanti.pezzi;
			pezziMancanti.pezzi[nPezziMancanti].idPezzo = pezzi[i].idPezzo;
			pezziMancanti.pezzi[nPezziMancanti].qta = pezzi[i].qta - queryResponse.row[0].QUANTITA
		}
	};

	disconnettiDB;
	if(#pezziMancanti.pezzi > 0) {
		eliminaPrenotazionePezzi@ServizioMagazzinoSecondario(idOrdine);
		nullProcess
	}
}
}]{messaggioDaStampare = "invocata prenotaPezzi()()"; log}





[eliminaPrenotazionePezzi(idOrdine)] {
	scope(scopeEliminaPrenotazionePezzi) {
		//install(SQLException => println@Console("insert pezziOrdini: " + i)());
		connettiDB;
		scope(insert) {
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
	    disconnettiDB
	};
	messaggioDaStampare = "invocata eliminaPrenotazionePezzi()()"; log
}




[eseguiOrdinePezzi(idOrdine)] {
	scope(scopeEseguiOrdinePezzi) {
		nullProcess
	};
	messaggioDaStampare = "invocata eseguiOrdinePezzi()()"; log
}

}
