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
      scope ( insertTable ) {
        install ( SQLException => println@Console("errore in insert pezzi")());
        updateRequest =
            "INSERT INTO pezzi(id, nome, assemblabile) VALUES" + 
            "(0, 'campanello', FALSE)," +
            "(1, 'faro', FALSE)," +
            "(2, 'sterzo', TRUE)," +
            "(3, 'sellino', TRUE)," +
            "(4, 'ruota', TRUE)," +
            "(5, 'catena', TRUE)," +
            "(6, 'casco', FALSE)";
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

     scope ( insertTable ) {
        install ( SQLException => println@Console("errore in insert magazzini")() );
        updateRequest =
            "INSERT INTO magazzini(id, url, principale, fornitore) VALUES" + 
            "(1, 'socket://localhost:8001', TRUE, FALSE)," + 
            "(2, 'socket://localhost:8002', FALSE, FALSE)," +
						"(3, 'socket://localhost:8003', FALSE, FALSE)," +
            "(101, 'socket://localhost:8101', FALSE, TRUE)";
        update@Database( updateRequest )( ret )
    };


    // shutdown DB
    update@Database( "SHUTDOWN" )( ret );

    nullProcess
} // end main
