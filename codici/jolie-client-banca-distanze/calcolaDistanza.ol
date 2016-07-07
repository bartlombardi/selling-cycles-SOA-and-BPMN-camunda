/*
 * Service: calcolare la distanza tra due città con l'uso di GoogleMaps
 * 
*/
include "console.iol"
include "string_utils.iol"

execution { concurrent }

type RestRequest: void {
	.origins: string
	.destinations: string
	.language: string
}

type DistanceRequest: void{
	.primo: string
	.secondo: string
}

interface DistanceMatrixInterface {
	RequestResponse: 
		default( RestRequest )( undefined ),
		distance( DistanceRequest )( int )
}

outputPort DistanceMatrixService {
	Location: "socket://maps.googleapis.com:80/"
	Protocol: http { 
		.method = "get";
		.osc.default.alias = "maps/api/distancematrix/json";
		.format = "json"
	}
	Interfaces: DistanceMatrixInterface
}

inputPort MyInput {
	Location: "socket://localhost:8000/"
	Protocol: http
	Interfaces: DistanceMatrixInterface
}

main
{
	distance( percorso )( distanza ) {
		request.destinations = percorso.primo;
		request.origins = percorso.secondo;
		request.language = "it-IT";

		default@DistanceMatrixService( request )( responseService );
				
		for (i = 0, i < #responseService.rows, ++i) {

			stringa = responseService.rows[i].elements.distance.text;
			stringa.regex = " ";

			split@StringUtils(stringa)(stringhe);
			distanza = int(stringhe[0].result)
		}
	}
}