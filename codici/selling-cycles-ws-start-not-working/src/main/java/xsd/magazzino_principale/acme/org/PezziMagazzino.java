
package xsd.magazzino_principale.acme.org;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per PezziMagazzino complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="PezziMagazzino"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="idMagazzino" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
 *         &lt;element name="pezzi" type="{org.acme.magazzino-principale.xsd}Pezzo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "PezziMagazzino", propOrder = {
    "idMagazzino",
    "pezzi"
})
public class PezziMagazzino {

    protected int idMagazzino;
    protected List<Pezzo> pezzi;

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

}
