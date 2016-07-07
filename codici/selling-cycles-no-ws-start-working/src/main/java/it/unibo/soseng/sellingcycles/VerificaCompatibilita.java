package it.unibo.soseng.sellingcycles;

import it.unibo.soseng.sellingcycles.datamodel.PezziWrapper;

import java.util.ArrayList;
import java.util.List;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

import xsd.magazzino_principale.acme.org.Pezzo;

public class VerificaCompatibilita implements JavaDelegate {
	private List<Pezzo> pezziIncompatibili = new ArrayList<>();
	
	public void execute(DelegateExecution execution) throws Exception {
		List<Pezzo> ordine = (List<Pezzo>) execution.getVariable("ordine");
		
		boolean compatibile = Math.random() <= 1.0;		
		execution.setVariable("compatibile", compatibile);
		
		if(!compatibile)
			for (Pezzo pezzo : ordine)
				pezziIncompatibili.add(pezzo);
		
		PezziWrapper pezziWrapper = new PezziWrapper(pezziIncompatibili);
		execution.setVariable("pezziIncompatibili", pezziWrapper);
	}
}
