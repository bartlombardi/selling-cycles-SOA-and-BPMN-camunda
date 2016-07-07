package it.unibo.soseng.sellingcycles.datamodel;

import java.util.HashMap;
import java.util.Map;

public class DBManager {
		
	public InfoPezzo getPezzoByID(int idPezzo) {
		Map<Integer, InfoPezzo> tabellaPezzi = new HashMap<>();
		tabellaPezzi.put(0, new InfoPezzo("Manubrio", true, 0, 15.99));
		tabellaPezzi.put(1, new InfoPezzo("Campanello", false, 1, 5.99));
		tabellaPezzi.put(2, new InfoPezzo("Fanale", false, 2, 4.50));
		tabellaPezzi.put(3, new InfoPezzo("Sellino", true, 3, 7.99));
		tabellaPezzi.put(4, new InfoPezzo("Set 4 Catarinfrangenti", false, 4, 1.00));
		tabellaPezzi.put(5, new InfoPezzo("Telaio", true, 5, 59.90));
		tabellaPezzi.put(6, new InfoPezzo("Borraccia", false, 6, 5.00));	
		tabellaPezzi.put(7, new InfoPezzo("Contachilometri", false, 7, 11.40));
		
		return tabellaPezzi.get(idPezzo);
	}

	public Map<Integer, InfoMagazzino> getAllMagazzini() {
		Map<Integer, InfoMagazzino> tabellaMagazzini = new HashMap<>();		
		tabellaMagazzini.put(1, new InfoMagazzino(1, "Parma", "Via Papparappa", true, false));
		tabellaMagazzini.put(2, new InfoMagazzino(2, "Napoli", "Via Napoli", false, false));
		tabellaMagazzini.put(3, new InfoMagazzino(3, "Bologna", "Via Cippalippa", false, false));
		tabellaMagazzini.put(101, new InfoMagazzino(101, "Milano", "Via Delle Vie", false, true));
		
		return tabellaMagazzini;
	}
}
