include "database.iol"
include "console.iol"

/** DB MAGAZZINO PRINCIPALE **/

main {
    // Impostazione parametri
    with ( connectionInfo ) {
        .username = "acme";
        .password = "";
        .host = "";
        .port = 5434;
        .database = "file:db/DB_magazzinoPrinc"; // "." for memory-only
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
            "assemblabile BOOLEAN NOT NULL," +
            "nome VARCHAR(50) NOT NULL)";
        update@Database( updateRequest )( ret );

        updateRequest =
            "CREATE TABLE utenti" + 
            "(cod_fiscale VARCHAR(16) PRIMARY KEY," + 
            "via VARCHAR(50) NOT NULL, " +
            "citta VARCHAR(50) NOT NULL)";
        update@Database( updateRequest )( ret );

        updateRequest =
            "CREATE TABLE ordini" + 
            "(id INTEGER PRIMARY KEY," + // auto-generato
            "data DATE NOT NULL, " +
            "id_utente VARCHAR(16) NOT NULL," +
            "FOREIGN KEY (id_utente) REFERENCES utenti(cod_fiscale))";
        update@Database( updateRequest )( ret );

        updateRequest =
            "CREATE TABLE magazzini" +
            "(id INTEGER PRIMARY KEY," +
            "url VARCHAR(256) NOT NULL," +
            "principale BOOLEAN NOT NULL," +
            "fornitore BOOLEAN NOT NULL)";
        update@Database( updateRequest )( ret );

        updateRequest =
            "CREATE TABLE pezziOrdini" + 
            "(id_pezzo INTEGER NOT NULL," + 
            "id_ordine INTEGER NOT NULL, " +
            "quantita INTEGER NOT NULL," +
            "id_magazzino INTEGER NULL," +
            "FOREIGN KEY (id_pezzo) REFERENCES pezzi(id)," +
            "FOREIGN KEY (id_ordine) REFERENCES ordini(id)," +
            "FOREIGN KEY (id_magazzino) REFERENCES magazzini(id))";
        update@Database( updateRequest )( ret )

    };

    // shutdown DB
    update@Database( "SHUTDOWN" )( ret );

    nullProcess
} // end main