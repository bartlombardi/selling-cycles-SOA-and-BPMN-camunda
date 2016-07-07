package it.unibo.soseng.jaxws;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.jws.WebMethod;
import javax.jws.WebService;

import org.camunda.bpm.engine.ProcessEngine;

import xsd.magazzino_principale.acme.org.Pezzo;
import xsd.magazzino_principale.acme.org.Utente;

/*
 * This is a very simple JAX-WS SOAP web service that create a new
 * process instance in the Camunda engine. The WS accepts a string
 * parameter that is used to initialize a "fooBar" process variable.
 */
@WebService
public class StartProcessService {
	@Resource(mappedName = "java:global/camunda-bpm-platform/process-engine/default")
	private ProcessEngine processEngine;

	@WebMethod
	public void start(Utente utente, List<Pezzo> pezzi) {
		Map<String, Object> vars = new HashMap<String, Object>();
		vars.put("utente", utente);
		vars.put("ordine", pezzi);

		processEngine.getRuntimeService().startProcessInstanceByMessage("inizia", vars);
	}
}
