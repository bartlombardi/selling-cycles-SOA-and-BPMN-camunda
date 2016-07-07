package it.unibo.soseng.sellincycles.rest;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


public class CalcolaDistanza {

	public int calcoladistanza(String origine, String destinazione) {
		try {
			URL url = new URL("https://maps.googleapis.com/maps/api/distancematrix/json?origins="+origine+"&destinations="+destinazione+"");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");

			conn.setRequestProperty("Accept", "application/json");

			if (conn.getResponseCode() != 200) {
				throw new RuntimeException("Failed : HTTP error code : "
						+ conn.getResponseCode());
			}		
			BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));

			StringBuilder sb = new StringBuilder();

			String line;
			while ((line = br.readLine()) != null) {
			    sb.append(line);
			}

			JSONObject json = null;
			try {
				 json = new JSONObject(sb.toString());
			} catch (JSONException e) {
				e.printStackTrace();
			}
			try {
					JSONArray jsonArray = json.getJSONArray("rows"); 
					JSONObject jsonArray1 = jsonArray.getJSONObject(0); 
					JSONArray distanza = jsonArray1.getJSONArray("elements");	 
					JSONObject jsonObject = distanza.getJSONObject(0);
					JSONObject jsonObject1 = (JSONObject) jsonObject.get("distance");
					String string = (String) jsonObject1.get("text"); 
					String[] s = string.split(" ");
				 
					return Integer.parseInt(s[0]);
				 
			} catch (JSONException e) {
				e.printStackTrace();
			}
			conn.disconnect();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return 0;
	}
}
