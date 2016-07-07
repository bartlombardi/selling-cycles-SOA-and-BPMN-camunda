package it.unibo.soseng.sellingcycles;

import it.unibo.soseng.sellingcycles.datamodel.DBManager;
import it.unibo.soseng.sellingcycles.datamodel.InfoPezzo;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;
import org.camunda.bpm.engine.variable.Variables;
import org.camunda.bpm.engine.variable.value.ObjectValue;

import xsd.magazzino_principale.acme.org.PezziMagazzino;
import xsd.magazzino_principale.acme.org.Pezzo;

public class PreparazionePreventivo implements JavaDelegate {

	public double calcolaSpeseSpedizione(int d) {
		if(d <= 10) 
			return 3.00;
		if(10 < d && d <= 50) 
			return 5.00;
		if(50 < d && d <= 100) 
			return 7.00;
		if(100 < d && d <= 200) 
			return 10.00;
		if(200 < d && d <= 300) 
			return 13.00;
		if(300 < d && d <= 400) 
			return 16.00;
		if(400 < d) 
			return 20.00;
		return 0;
	}
	
	public void execute(DelegateExecution execution) throws Exception {
		Map<Integer, Integer> distanze = 
				(Map<Integer, Integer>) execution.getVariable("distanze");		
		Map<Integer, PezziMagazzino> tabellaPrenotazione = 
				(Map<Integer, PezziMagazzino>) execution.getVariable("tabellaPrenotazione");

					
		DBManager dbManager = new DBManager();
		
		double totale = 0;
		for (Entry<Integer, PezziMagazzino> e : tabellaPrenotazione.entrySet())
			for (Pezzo p : e.getValue().getPezzi())
				if(p.getPrezzo() == null) {				
					InfoPezzo pezzo = dbManager.getPezzoByID(p.getIdPezzo());
					int distanza = distanze.get(e.getKey());
					double prezzo = pezzo.getPrezzo();
					p.setPrezzo(prezzo + calcolaSpeseSpedizione(distanza));
					totale = totale + p.getPrezzo()*p.getQta();			
				} else
					totale = totale + p.getPrezzo()*p.getQta();		
	
		List<PezziMagazzino> pezziMagazzino = new ArrayList<>(tabellaPrenotazione.values());
		for (PezziMagazzino pm : pezziMagazzino) {
			System.out.print("idMagazzino: " + pm.getIdMagazzino() + "[");
			for (Pezzo p : pm.getPezzi()) {
				System.out.print("<" + p.getIdPezzo() + "," + p.getQta() + "," +  p.getPrezzo() + "> ");
			}
			System.out.println("]");
		}
		
		execution.setVariable("tabellaPrenotazione", tabellaPrenotazione);	
		execution.setVariable("prezzoTotale", Math.floor(totale * 100) / 100);		
	}
}
