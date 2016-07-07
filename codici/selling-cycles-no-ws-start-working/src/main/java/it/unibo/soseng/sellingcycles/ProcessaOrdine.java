package it.unibo.soseng.sellingcycles;

import it.unibo.soseng.sellingcycles.datamodel.PezziWrapper;

import java.util.ArrayList;
import java.util.List;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;
import org.camunda.bpm.engine.variable.Variables;
import org.camunda.bpm.engine.variable.value.ObjectValue;

import xsd.magazzino_principale.acme.org.Indirizzo;
import xsd.magazzino_principale.acme.org.Pezzo;
import xsd.magazzino_principale.acme.org.Utente;


public class ProcessaOrdine implements JavaDelegate {

	/**
	 * Creazione di un ordine fittizio
	 */
	public void execute(DelegateExecution execution) throws Exception {
		// Inizializzazione utente fittizio, arriverebbe in un messaggio SOAP
		Utente utente = new Utente();
		utente.setCodFis("SGLNDR93P28XXX");
		utente.setCognome("Segalini");
		utente.setDataNascita("28/9/1993");
		Indirizzo indirizzo = new Indirizzo();
		indirizzo.setCitta("Potenza");
		indirizzo.setVia("Via G. Di Vittorio 12 B");
		utente.setIndirizzo(indirizzo);
		utente.setNome("Andrea");
		utente.setTelefono("0524597893");
		
		// Inizializzazione lista di pezzi fittizi ricevuta come parametro di una chiamata a
		// web service SOAP
		Pezzo p1 = new Pezzo();
		p1.setIdPezzo(0);
		p1.setQta(5);
		Pezzo p2 = new Pezzo();
		p2.setIdPezzo(1);
		p2.setQta(40);
		Pezzo p3 = new Pezzo();
		p3.setIdPezzo(2);
		p3.setQta(5);
		Pezzo p4 = new Pezzo();
		p4.setIdPezzo(3);
		p4.setQta(5);
		Pezzo p5 = new Pezzo();
		p5.setIdPezzo(4);
		p5.setQta(35);
		Pezzo p6 = new Pezzo();
		p6.setIdPezzo(5);
		p6.setQta(70);
		Pezzo p7 = new Pezzo();
		p7.setIdPezzo(6);
		p7.setQta(5);
		List<Pezzo> listaPezzi = new ArrayList<Pezzo>();
		listaPezzi.add(p1);
		listaPezzi.add(p2);
		listaPezzi.add(p3);
		listaPezzi.add(p4);
		listaPezzi.add(p5);
		listaPezzi.add(p6);
		listaPezzi.add(p7);
		
		// Inizializzazione idOrdine fittizio, in teoria dovrebbe ritornare la chiave
		// autogenerata dopo l'inserimento del record del database
		int idOrdine = 0;
		
		execution.setVariable("ordine", listaPezzi);
		execution.setVariable("idOrdine", idOrdine);
		execution.setVariable("utente", utente);
	
		PezziWrapper jsonOrdine = new PezziWrapper(listaPezzi);
		execution.setVariable("jsonOrdine", jsonOrdine);
	}

}
