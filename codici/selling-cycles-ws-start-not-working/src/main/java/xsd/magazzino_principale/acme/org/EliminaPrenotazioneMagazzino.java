
package xsd.magazzino_principale.acme.org;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per anonymous complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="idMagazzino" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
 *         &lt;element name="idOrdine" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "idMagazzino",
    "idOrdine"
})
@XmlRootElement(name = "eliminaPrenotazioneMagazzino")
public class EliminaPrenotazioneMagazzino {

    protected int idMagazzino;
    protected int idOrdine;

    /**
     * Recupera il valore della proprietà idMagazzino.
     * 
     */
    public int getIdMagazzino() {
        return idMagazzino;
    }

    /**
     * Imposta il valore della proprietà idMagazzino.
     * 
     */
    public void setIdMagazzino(int value) {
        this.idMagazzino = value;
    }

    /**
     * Recupera il valore della proprietà idOrdine.
     * 
     */
    public int getIdOrdine() {
        return idOrdine;
    }

    /**
     * Imposta il valore della proprietà idOrdine.
     * 
     */
    public void setIdOrdine(int value) {
        this.idOrdine = value;
    }

}
