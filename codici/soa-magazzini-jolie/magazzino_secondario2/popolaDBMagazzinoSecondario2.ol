include "database.iol"
include "console.iol"
include "string_utils.iol"

/** DB MAGAZZINO SECONDARIO **/

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

//testoDaStampare="richiestaOrdine"; oggettoDaStampare->richiestaOrdine; stampa; // debug
//testoDaStampare="tabellaOrdine"; oggettoDaStampare->tabellaOrdine; stampa; // debug

main {
    // Impostazione parametri
    with ( connectionInfo ) {
        .username = "acme";
        .password = "";
        .host = "";
        .port = 5433;
        .database = "file:db/DB_magazzinoSec"; // "." for memory-only
        .driver = "hsqldb_embedded"
    };

    // Connessione a database
    connect@Database( connectionInfo )( void );

    scope ( insertTable ) {
        install ( SQLException => println@Console("errore in insert pezzi")());
        updateRequest =
            "INSERT INTO pezzi(id, nome, quantita, assemblabile) VALUES" + 
            "(0, 'campanello', 30, FALSE)," +
            "(1, 'faro', 30, FALSE)," +
            "(6, 'casco', 30, FALSE), " +
            "(4, 'ruota', 30, TRUE)," +
            "(5, 'catena', 10, TRUE)";
        update@Database( updateRequest )( ret );
        nullProcess
    };

    scope ( insertTable ) {
        install ( SQLException => println@Console("errore in insert utenti")() );
        updateRequest =
            "INSERT INTO utenti(cod_fiscale, via, citta) VALUES" + 
            "('MNCMRG91A14G942B', 'Via Manhes 2', 'Potenza')," + 
            "('NTDSTF92R14G942F', 'Via Martiri 35', 'Potenza')," +
            "('SGLNDR93F26F921A', 'Via Londra 1', 'Frattamaggiore')";
        update@Database( updateRequest )( ret )
    };

    // scope ( insertTable ) {
    //     install ( SQLException => println@Console("errore in insert ordini")() );
    //     updateRequest =
    //         "INSERT INTO ordini(id, data, id_utente) VALUES" + 
    //         "(0, '2010-01-01', 'MNCMRG91A14G942B')," +
    //         "(1, '2010-01-01', 'MNCMRG91A14G942B')," +
    //         "(2, '2010-02-11', 'MNCMRG91A14G942B')";
    //     update@Database( updateRequest )( ret )
    // };

    // shutdown DB
    update@Database( "SHUTDOWN" )( ret )

} // end main