package it.unibo.soseng.sellingcycles;

import it.unibo.soseng.sellincycles.rest.CalcolaDistanza;
import it.unibo.soseng.sellingcycles.datamodel.DBManager;
import it.unibo.soseng.sellingcycles.datamodel.InfoMagazzino;
import it.unibo.soseng.sellingcycles.datamodel.InfoPezzo;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import wsdl.magazzino_principale.acme.org.MySelf;
import wsdl.magazzino_principale.acme.org.MySelfService;
import xsd.magazzino_principale.acme.org.DisponibilitaPezzi;
import xsd.magazzino_principale.acme.org.DisponibilitaPezzi.Magazzini;
import xsd.magazzino_principale.acme.org.PezziMagazzino;
import xsd.magazzino_principale.acme.org.Pezzo;
import xsd.magazzino_principale.acme.org.Utente;

public class SceltaMagazzino implements JavaDelegate {
	private Map<Integer, Integer> distanze;
	private Map<Integer, InfoMagazzino> infoMagazzini;
	
	public Map<Integer, Integer> calcolaDistanze(Map<Integer, InfoMagazzino> infoMagazzini, String destinazione) {
		Map<Integer, Integer> distanze = new HashMap<>();
		CalcolaDistanza calcola = new CalcolaDistanza();
		
		for (InfoMagazzino m : infoMagazzini.values()) {
			int d = calcola.calcoladistanza(m.getCitta(), destinazione);
			distanze.put(m.getIdMagazzino(), d);
		}
		
		// distanze false per debug
		//distanze.put(1, 30);
		//distanze.put(2, 600);
		//distanze.put(3, 130);
		//distanze.put(101, 110);
		
		return distanze;
	}
	
	public void execute(DelegateExecution execution) throws Exception {
		Utente utente = (Utente) execution.getVariable("utente");
		
		List<Pezzo> ordine = (List<Pezzo>) execution.getVariable("ordine");
		Map<Integer, Pezzo> tabellaOrdine = new HashMap<>();
		for (Pezzo pezzo : ordine) 
			tabellaOrdine.put(pezzo.getIdPezzo(), pezzo);
		
		int idOrdine = (Integer) execution.getVariable("idOrdine");
		List<DisponibilitaPezzi> disponibilitaPezzi = (List<DisponibilitaPezzi>) execution.getVariable("disponibilitaPezzi");
				
		DBManager dbManager = new DBManager();
				
		infoMagazzini = dbManager.getAllMagazzini();
		distanze = calcolaDistanze(infoMagazzini, utente.getIndirizzo().getCitta());
		
		for (DisponibilitaPezzi d : disponibilitaPezzi) {
			final InfoPezzo pezzo = dbManager.getPezzoByID(d.getIdPezzo()); 
			d.getMagazzini().sort(new Comparator<Magazzini>() {
				@Override
				public int compare(Magazzini o1,
						Magazzini o2) {
					InfoMagazzino m1 = SceltaMagazzino.this.infoMagazzini.get(o1.getIdMagazzino());
					InfoMagazzino m2 = SceltaMagazzino.this.infoMagazzini.get(o2.getIdMagazzino());
					
					int distanza1 = SceltaMagazzino.this.distanze.get(o1.getIdMagazzino());
					int distanza2 = SceltaMagazzino.this.distanze.get(o2.getIdMagazzino());
					
					if(m1.getPrincipale() && !m2.getPrincipale())
						return -1;
					if(!m1.getPrincipale() && m2.getPrincipale())
						return 1;
					if(m1.getFornitore() && !m2.getFornitore())
						return 1;
					if(!m1.getFornitore() && m2.getFornitore())
						return -1;
					
					if(!pezzo.getAssemblabile()) {						
						if(distanza1 < distanza2)
							return -1;
						if(distanza1 > distanza2)
							return 1;
						if(distanza1 == distanza2)
						return 0;
					}
					return 0;
				}	
			});
		}
		
		System.out.println("DisponibilitaPezzi");
		for (DisponibilitaPezzi d : disponibilitaPezzi) {
			System.out.print("idPezzo: " + d.getIdPezzo() + " -> [");
			for (Magazzini m : d.getMagazzini())
				System.out.print(m.getIdMagazzino() + " ,");
			System.out.println("]");
		}
		
		MySelfService service = new MySelfService();
		MySelf port = service.getMySelfServicePort();
		
		Map<Integer, PezziMagazzino> tabellaPrenotazione = new HashMap<>();
		for (DisponibilitaPezzi d : disponibilitaPezzi) {
			
			int idPezzo = d.getIdPezzo();
			int qtaTotale = tabellaOrdine.get(d.getIdPezzo()).getQta();
			
			for (Magazzini m : d.getMagazzini()) {
				int qtaMagazzino = m.getQta();
				int idMagazzino = m.getIdMagazzino();
				
				if(!tabellaPrenotazione.containsKey(idMagazzino)) {
					PezziMagazzino x = new PezziMagazzino();
					x.setIdMagazzino(idMagazzino);
					tabellaPrenotazione.put(idMagazzino, x);
				}
				PezziMagazzino pm = tabellaPrenotazione.get(idMagazzino);
								
				Pezzo p = new Pezzo(); 
				p.setIdPezzo(idPezzo);
				
				if(m.getPrezzo() != null)
					p.setPrezzo(m.getPrezzo());
				
				if(qtaTotale - qtaMagazzino > 0) {
					p.setQta(qtaMagazzino);
					pm.getPezzi().add(p);
				} else {
					p.setQta(qtaTotale);
					pm.getPezzi().add(p);
					break;	
				}
				
				qtaTotale = qtaTotale - qtaMagazzino;
			}
		}
		
		
		for (Entry<Integer, Integer> x : distanze.entrySet()) {
			System.out.println("città: " + infoMagazzini.get(x.getKey()).getCitta() + " km: " + x.getValue());			
		}
		
		execution.setVariable("tabellaPrenotazione", tabellaPrenotazione);
		execution.setVariable("distanze", distanze);
		
		List<PezziMagazzino> pezziMagazzino = new ArrayList<>(tabellaPrenotazione.values());
		for (PezziMagazzino pm : pezziMagazzino) {
			System.out.print("idMagazzino: " + pm.getIdMagazzino() + "[");
			for (Pezzo p : pm.getPezzi()) {
				System.out.print("<" + p.getIdPezzo() + "," + p.getQta() + "> ");
			}
			System.out.println("]");
		}
		
		//TabellaPrenotazioneWrapper tabellaWrapper = new TabellaPrenotazioneWrapper();
		//tabellaWrapper.setTabellaPrenotazione(tabellaPrenotazione);
		
//		port.prenotaPezziMagazzini(pezziMagazzino, utente, idOrdine);
//		port.eliminaPrenotazioneMagazzini(idOrdine);
	}
}

