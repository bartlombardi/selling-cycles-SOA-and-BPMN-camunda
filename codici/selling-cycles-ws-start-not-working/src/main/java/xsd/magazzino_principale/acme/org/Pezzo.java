
package xsd.magazzino_principale.acme.org;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per Pezzo complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="Pezzo"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="qta" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
 *         &lt;element name="idPezzo" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
 *         &lt;element name="prezzo" type="{http://www.w3.org/2001/XMLSchema}double" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "Pezzo", propOrder = {
    "qta",
    "idPezzo",
    "prezzo"
})
public class Pezzo {

    protected int qta;
    protected int idPezzo;
    protected Double prezzo;

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
     * @return
     *     possible object is
     *     {@link Double }
     *     
     */
    public Double getPrezzo() {
        return prezzo;
    }

    /**
     * Imposta il valore della proprietà prezzo.
     * 
     * @param value
     *     allowed object is
     *     {@link Double }
     *     
     */
    public void setPrezzo(Double value) {
        this.prezzo = value;
    }

}
