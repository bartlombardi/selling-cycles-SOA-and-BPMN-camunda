package it.unibo.soseng.sellingcycles;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

public class ApplicaSconto implements JavaDelegate{

	@Override
	public void execute(DelegateExecution execution) throws Exception {
		double sconto = (Double) execution.getVariable("sconto");
		double totale = (Double) execution.getVariable("prezzoTotale");
		
		double prezzoScontato = totale - (totale/100 * sconto);
		
		execution.setVariable("prezzoScontato", Math.floor(prezzoScontato * 100) / 100);
	}

}
