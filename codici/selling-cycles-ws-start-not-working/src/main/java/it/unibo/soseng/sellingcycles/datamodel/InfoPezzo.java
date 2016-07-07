package it.unibo.soseng.sellingcycles.datamodel;

public class InfoPezzo {
	protected String nome;
	protected boolean assemblabile;
    protected int idPezzo;
    protected Double prezzo;
	    
	public InfoPezzo(String nome, boolean assemblabile, int idPezzo, Double prezzo) {
		this.nome = nome;
		this.assemblabile = assemblabile;
		this.idPezzo = idPezzo;
		this.prezzo = prezzo;
	}

	public String getNome() {
		return nome;
	}
	
	public void setNome(String nome) {
		this.nome = nome;
	}
	
	public boolean getAssemblabile() {
		return assemblabile;
	}
	
	public void setAssemblabile(boolean assemblabile) {
		this.assemblabile = assemblabile;
	}
		
	public int getIdPezzo() {
		return idPezzo;
	}
	
	public void setIdPezzo(int idPezzo) {
		this.idPezzo = idPezzo;
	}
	
	public Double getPrezzo() {
		return prezzo;
	}
	
	public void setPrezzo(Double prezzo) {
		this.prezzo = prezzo;
	}
}
