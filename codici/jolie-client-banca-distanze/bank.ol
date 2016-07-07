/*
 * Service: contatto con la banca per richiedere accept/refuse del bonifico (API Rest)
 * 
*/
include "console.iol"
include "string_utils.iol"

execution { concurrent }

type CheckBankRequest: void{
	.error?: string //codice di errore di pagamento
	.risultato: bool // se il pagamento è andato a buon fine
}

type PaymentCheckRequest: void{
	.id: int // riferimento bancario
	.price: int // prezzo atteso
}

interface BankPaymentInterface {
	RequestResponse: 
		default( int )( undefined ),
		bonifico( PaymentCheckRequest )( CheckBankRequest )
}

outputPort BankPaymentService {
	Location: "socket://localhost:8080/"
	Protocol: http {
		.method = "get";
		.osc.default.alias = "bonificobancario/bonifici/bonifico";
		.format = "json"
	}
	Interfaces: BankPaymentInterface
}

inputPort MyInput {
	Location: "socket://localhost:8000/"
	Protocol: http
	Interfaces: BankPaymentInterface
}

main
{
	bonifico( requestCheck )( responseCheck ) {
		requestId = requestCheck.id;
		default@BankPaymentService( requestId )( responseService );
		// *****************DEBUG****************************
		valueToPrettyString@StringUtils( responseService )( s );
		println@Console(s)();
		// **************************************************
		if(responseService.paycheck == false){
			responseCheck.error = "PAGAMENTO_NON_EFFETTUATO";
			responseCheck.risultato = false
		} else {
			if(responseService.price != requestCheck.price) {
				responseCheck.error = "PAGAMENTO_NON_EFFETTUATO";
				responseCheck.risultato = false
			} else {
				responseCheck.error = "PAGAMENTO_EFFETTUATO";
				responseCheck.risultato = true
			}
		}
	}
}