package it.unibo.soseng.sellingcycles.datamodel;

public class InfoMagazzino {
	private int idMagazzino;
	private double distanza;
	private String citta;
	private String indirizzo;
	private boolean principale;
	private boolean fornitore;
	
	public InfoMagazzino(int idMagazzino, String citta, 
			String indirizzo, boolean principale, boolean fornitore) {
		
		this.idMagazzino = idMagazzino;
		this.citta = citta;
		this.indirizzo = indirizzo;
		this.fornitore = fornitore;
		this.principale = principale;
	}
		
	public int getIdMagazzino() {
		return idMagazzino;
	}
	
	public double getDistanza() {
		return distanza;
	}
	
	public String getCitta() {
		return citta;
	}
	
	public String getIndirizzo() {
		return indirizzo;
	}
	
	public boolean getPrincipale() {
		return principale;
	}
	
	public boolean getFornitore() {
		return fornitore;
	}
	
	public void setIdMagazzino(int idMagazzino) {
		this.idMagazzino = idMagazzino;
	}
	
	public void setDistanza(double distanza) {
		this.distanza = distanza;
	}

	public void setCitta(String citta) {
		this.citta = citta;
	}
	
	public void setIndirizzo(String indirizzo) {
		this.indirizzo = indirizzo;
	}
}
