package it.unibo.soseng.sellingcycles;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

public class EliminaIstanzaOrdine implements JavaDelegate {

	public void execute(DelegateExecution execute) throws Exception {
		// Eliminazione dal database dell'ordine (non presente)
	}

}
