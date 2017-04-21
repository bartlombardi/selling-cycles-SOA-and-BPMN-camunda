# Selling Cycles SOA

University of Bologna - MSc Computer Science. <br>
Service Oriented Software Engineering course. <br>

Jolie SOA which supports the activities of a bicycle selling company + BPMN with Camunda.

## Contributors
Bartolomeo Lombardi  <br>
Amerigo Mancino <br>
Andrea Segalini <br>


## Descrizione del dominio e del problema

L’azienda ACME si occupa di fornire biciclette assemblate su richiesta ed accessori a rivendite che operano direttamente con il pubblico.
Gli accessori e i componenti che non hanno necessità di assemblaggio o che richiedono operazioni elementari che possono essere effettuate direttamente nelle rivendite (come, ad esempio, il montaggio di un fanale) possono essere oggetto di spedizioni distinte da quello dei cicli.
Le rivendite inviano ad ACME ordini composti da cicli e accessori. Per ogni ciclo viene specificato il modello base, la colorazione e le eventuali customizzazioni per gruppo frenante, gruppo sterzo, trasmissione e ammortizzatori.
Una volta ricevuto l’ordine ACME si accerta che le eventuali customizzazioni richieste siano possibili e procede quindi all’assemblaggio dei cicli richiesti e alla fornitura degli accessori.
L’assemblaggio (che inizia dopo il pagamento dell’anticipo come dettagliato sotto) prevede una prima fase nella quale si verifica la presenza di tutti componenti necessari nel magazzino principale; nel caso di componenti non presenti si verifica se sono in uno dei magazzini secondari. Se ci sono vengono trasferiti, se non ci sono vengono ordinati (ad un unico fornitore esterno).
L’assemblaggio dei cicli avviene nella sede principale dell’azienda (dove si trova anche il magazzino principale), ma si sta valutando se spostarlo in una nuova sede.
Per maggiore efficienza se un ordine include accessori che non devono essere assemblati, questo può essere scomposto in modo che sia possibile che i diversi prodotti vengano inviati al cliente direttamente dai diversi magazzini (principale e secondari). A tal fine, per ogni prodotto, il magazzino che viene selezionato è quello che ha il prodotto disponibile e che è geograficamente più vicino alla sede del cliente.
Il costo dell’ordine viene determinato in funzione del costo dei prodotti e di tutte le spedizioni necessarie. Per ordini superiori ad una certa cifra (che può variare nel tempo) viene valutata l’eventuale applicazione di uno sconto. Tale valutazione viene effettuata da un membro dello staff di ACME che ha l’autorità per farla.
Una volta determinato il costo finale viene inviato un preventivo al cliente che può accettarlo o rifiutarlo.
In caso di rifiuto l’interazione termina.
In caso di accettazione ACME si pone in attesa che il cliente invii un riferimento ad un bonifico effettuato per una somma pari almeno ad un decimo del costo dell’ordine a titolo di anticipo.
Una volta verificato con il sistema bancario il pagamento dell’anticipo ACME procede alle spedizioni e si pone in attesa che il cliente notifichi il pagamento del saldo. Una volta controllato con il sistema bancario anche questo trasferimento il processo termina.
Si progetti e realizzi una SOA che supporti le attività di ACME.

## Vincoli

I processi rilevanti di ACME devono essere modellati in BPMN.
Il sistema deve utilizzare un BPMS (almeno) per la parte di human workflow. Si consiglia di utilizzare Camunda o Activiti.
La parte di gestione dei magazzini (principale e secondari) deve essere effettuata tramite una SOA di servizi Jolie.
Si assume che il sistema integri sotto forma di servizi (almeno) le seguenti capability esterne:
* Calcolo distanze geografiche (preferibilmente con API Rest)
* Sistema bancario (preferibilmente API Rest)
* Fornitore componenti

Tali servizi vanno implementati (con logica elementare) come parte del progetto.
