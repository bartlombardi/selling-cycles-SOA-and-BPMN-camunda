package it.unibo.informatica.bonificobancario;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Response;

import org.json.JSONException;
import org.json.JSONObject;

@Path("/bonifico")
public class Bonifico {
	
	public static boolean getRandomBoolean() { return Math.random() < 0.5; }
	
	
	@GET
	@Produces("application/json")

	
	public Response paytobank(@QueryParam("i") int i) throws JSONException {
		JSONObject jsonObject = new JSONObject();
		
		int price = 50;
		if(getRandomBoolean() == true){
			jsonObject.put("paycheck", true);
			jsonObject.put("price", price);
		} else{
			jsonObject.put("paycheck", false);
			jsonObject.put("price", price);
		}
		return Response.status(200).entity(jsonObject.toString()).build();
	}
}
