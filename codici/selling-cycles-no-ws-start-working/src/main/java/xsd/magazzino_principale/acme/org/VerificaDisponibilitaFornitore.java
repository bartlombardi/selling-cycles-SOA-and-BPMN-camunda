
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
 *         &lt;element name="pezzi" type="{org.acme.magazzino-principale.xsd}Pezzo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="idFornitore" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
 *         &lt;element name="utente" type="{org.acme.magazzino-principale.xsd}Utente"/&gt;
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
    "pezzi",
    "idFornitore",
    "utente"
})
@XmlRootElement(name = "verificaDisponibilitaFornitore")
public class VerificaDisponibilitaFornitore {

    protected List<Pezzo> pezzi;
    protected int idFornitore;
    @XmlElement(required = true)
    protected Utente utente;

    /**
     * Gets the value of the pezzi property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the pezzi property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getPezzi().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Pezzo }
     * 
     * 
     */
    public List<Pezzo> getPezzi() {
        if (pezzi == null) {
            pezzi = new ArrayList<Pezzo>();
        }
        return this.pezzi;
    }

    /**
     * Recupera il valore della proprietà idFornitore.
     * 
     */
    public int getIdFornitore() {
        return idFornitore;
    }

    /**
     * Imposta il valore della proprietà idFornitore.
     * 
     */
    public void setIdFornitore(int value) {
        this.idFornitore = value;
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

}
