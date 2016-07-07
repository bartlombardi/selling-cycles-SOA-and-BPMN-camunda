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
		// Inserisce nel database l'ordine e la pk autogenerata è l'idOrdine
		// qui inizializzata staticamente sempre a 0
		int idOrdine = 0;		
		
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
		
		execution.setVariable("utente", utente);
		
		execution.setVariable("idOrdine", idOrdine);
	}

}
