
package xsd.magazzino_principale.acme.org;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
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
 *         &lt;element name="pezziMagazzino" type="{org.acme.magazzino-principale.xsd}PezziMagazzino" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="utente" type="{org.acme.magazzino-principale.xsd}Utente"/&gt;
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
    "pezziMagazzino",
    "utente",
    "idOrdine"
})
@XmlRootElement(name = "creaIstanzaOrdine")
public class CreaIstanzaOrdine {

    protected List<PezziMagazzino> pezziMagazzino;
    @XmlElement(required = true)
    protected Utente utente;
    protected int idOrdine;

    /**
     * Gets the value of the pezziMagazzino property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the pezziMagazzino property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getPezziMagazzino().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link PezziMagazzino }
     * 
     * 
     */
    public List<PezziMagazzino> getPezziMagazzino() {
        if (pezziMagazzino == null) {
            pezziMagazzino = new ArrayList<PezziMagazzino>();
        }
        return this.pezziMagazzino;
    }

    /**
     * Recupera il valore della proprietà utente.
     * 
     * @return
     *     possible object is
     *     {@link Utente }
     *     
     */
    public Utente getUtente() {
        return utente;
    }

    /**
     * Imposta il valore della proprietà utente.
     * 
     * @param value
     *     allowed object is
     *     {@link Utente }
     *     
     */
    public void setUtente(Utente value) {
        this.utente = value;
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
