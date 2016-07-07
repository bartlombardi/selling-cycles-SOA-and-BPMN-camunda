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
        .username = "fornitore";
        .password = "";
        .host = "";
        .port = 5433;
        .database = "file:db/DB_fornitore"; // "." for memory-only
        .driver = "hsqldb_embedded"
    };

    // Connessione a database
    connect@Database( connectionInfo )( void );

    // Creazione tabelle
    scope ( createTable ) {
        install ( SQLException => println@Console("Undefined problem during creation")() );
        updateRequest =
            "CREATE TABLE pezzi" + 
            "(id INTEGER PRIMARY KEY," + 
            "nome VARCHAR(50) NOT NULL, " +
            "quantita INTEGER NOT NULL, " +
            "prezzo FLOAT NOT NULL," +
            "assemblabile BOOLEAN NOT NULL)";
        update@Database( updateRequest )( ret );

        updateRequest =
            "CREATE TABLE utenti" + 
            "(cod_fiscale VARCHAR(16) PRIMARY KEY," + 
            "via VARCHAR(256) NOT NULL, " +
            "citta VARCHAR(256) NOT NULL)";
        update@Database( updateRequest )( ret );

        updateRequest =
            "CREATE TABLE ordini" + 
            "(id INTEGER PRIMARY KEY," + // auto-generato
            "data DATE NOT NULL, " +
            "id_utente VARCHAR(16) NOT NULL," +
            "FOREIGN KEY (id_utente) REFERENCES utenti(cod_fiscale))";
        update@Database( updateRequest )( ret );

        updateRequest =
            "CREATE TABLE pezziOrdini" + 
            "(id_pezzo INTEGER NOT NULL," + 
            "id_ordine INTEGER NOT NULL, " +
            "quantita INTEGER NOT NULL," +
            "FOREIGN KEY (id_pezzo) REFERENCES pezzi(id)," +
            "FOREIGN KEY (id_ordine) REFERENCES ordini(id))";
        update@Database( updateRequest )( ret )

    };

    // shutdown DB
    update@Database( "SHUTDOWN" )( ret )

} // end main