package it.unibo.soseng.sellingcycles.datamodel;

import java.util.List;

import xsd.magazzino_principale.acme.org.Pezzo;

public class PezziWrapper {
	private List<Pezzo> pezzi;
	
	public PezziWrapper(List<Pezzo> pezzi) {
		this.pezzi = pezzi;
	}

	public List<Pezzo> getPezzi() {
		return pezzi;
	}

	public void setPezzi(List<Pezzo> pezzi) {
		this.pezzi = pezzi;
	}
}
