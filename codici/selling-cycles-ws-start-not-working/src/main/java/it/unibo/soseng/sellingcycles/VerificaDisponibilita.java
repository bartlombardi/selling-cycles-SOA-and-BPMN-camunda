package it.unibo.soseng.sellingcycles;

import it.unibo.soseng.sellingcycles.datamodel.PezziWrapper;

import java.util.ArrayList;
import java.util.List;

import javax.xml.ws.Holder;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import wsdl.magazzino_principale.acme.org.MySelf;
import wsdl.magazzino_principale.acme.org.MySelfService;
import xsd.magazzino_principale.acme.org.DisponibilitaPezzi;
import xsd.magazzino_principale.acme.org.DisponibilitaPezzi.Magazzini;
import xsd.magazzino_principale.acme.org.Pezzo;
import xsd.magazzino_principale.acme.org.Utente;

public class VerificaDisponibilita implements JavaDelegate {
	
	public void execute(DelegateExecution execution) throws Exception {
		List<Pezzo> ordine = (List<Pezzo>) execution.getVariable("ordine");
		Utente utente = (Utente) execution.getVariable("utente");
		int idOrdine = (Integer) execution.getVariable("idOrdine");
		
		Holder<List<DisponibilitaPezzi>> holderDisponibilitaPezzi = 
				new Holder<List<DisponibilitaPezzi>>();
		Holder<List<Pezzo>> holderPezziMancanti = 
				new Holder<List<Pezzo>>();

		MySelfService service = new MySelfService();
		MySelf port = service.getMySelfServicePort();

		port.verificaDisponibilitaMagazzini(ordine, 
				utente, 
				holderDisponibilitaPezzi, 
				holderPezziMancanti);
		
		List<DisponibilitaPezzi> disponibilitaPezzi = holderDisponibilitaPezzi.value;
		List<Pezzo> pezziMancanti = holderPezziMancanti.value;

		System.out.println("DisponibilitaPezzi");
		for (DisponibilitaPezzi d : disponibilitaPezzi) {
			System.out.print("idPezzo: " + d.getIdPezzo() + " -> [");
			for (Magazzini m : d.getMagazzini())
				System.out.print(m.getIdMagazzino() + " ,");
			System.out.println("]");
		}
		
		if(pezziMancanti.isEmpty()) {
			execution.setVariable("pezziTuttiDisponibili", true);
			execution.setVariable("disponibilitaPezzi", disponibilitaPezzi);
		} else {
			execution.setVariable("pezziTuttiDisponibili", false);
			PezziWrapper pezziWrapper = new PezziWrapper(pezziMancanti);
			execution.setVariable("pezziMancanti", pezziWrapper);
		}
	}
}
