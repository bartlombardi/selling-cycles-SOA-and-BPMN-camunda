
package xsd.magazzino_principale.acme.org;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per PezzoConPrezzo complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="PezzoConPrezzo"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="qta" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
 *         &lt;element name="idPezzo" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
 *         &lt;element name="prezzo" type="{http://www.w3.org/2001/XMLSchema}double"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "PezzoConPrezzo", propOrder = {
    "qta",
    "idPezzo",
    "prezzo"
})
public class PezzoConPrezzo {

    protected int qta;
    protected int idPezzo;
    protected double prezzo;

    /**
     * Recupera il valore della proprietà qta.
     * 
     */
    public int getQta() {
        return qta;
    }

    /**
     * Imposta il valore della proprietà qta.
     * 
     */
    public void setQta(int value) {
        this.qta = value;
    }

    /**
     * Recupera il valore della proprietà idPezzo.
     * 
     */
    public int getIdPezzo() {
        return idPezzo;
    }

    /**
     * Imposta il valore della proprietà idPezzo.
     * 
     */
    public void setIdPezzo(int value) {
        this.idPezzo = value;
    }

    /**
     * Recupera il valore della proprietà prezzo.
     * 
     */
    public double getPrezzo() {
        return prezzo;
    }

    /**
     * Imposta il valore della proprietà prezzo.
     * 
     */
    public void setPrezzo(double value) {
        this.prezzo = value;
    }

}
