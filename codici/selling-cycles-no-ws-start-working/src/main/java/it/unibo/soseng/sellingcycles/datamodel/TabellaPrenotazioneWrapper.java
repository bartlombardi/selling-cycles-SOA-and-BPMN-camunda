package it.unibo.soseng.sellingcycles.datamodel;

import java.util.Map;

import xsd.magazzino_principale.acme.org.PezziMagazzino;

public class TabellaPrenotazioneWrapper {
	Map<Integer, PezziMagazzino> tabellaPrenotazione;
	
	public Map<Integer, PezziMagazzino> getTabellaPrenotazione() {
		return tabellaPrenotazione;
	}

	public void setTabellaPrenotazione(
			Map<Integer, PezziMagazzino> tabellaPrenotazione) {
		this.tabellaPrenotazione = tabellaPrenotazione;
	}
}
