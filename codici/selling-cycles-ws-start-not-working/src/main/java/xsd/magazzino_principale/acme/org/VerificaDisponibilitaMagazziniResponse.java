
package xsd.magazzino_principale.acme.org;

import java.util.ArrayList;
import java.util.List;
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
 *         &lt;element name="disponibilitaPezzi" type="{org.acme.magazzino-principale.xsd}DisponibilitaPezzi" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="pezziMancanti" type="{org.acme.magazzino-principale.xsd}Pezzo" maxOccurs="unbounded" minOccurs="0"/&gt;
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
    "disponibilitaPezzi",
    "pezziMancanti"
})
@XmlRootElement(name = "verificaDisponibilitaMagazziniResponse")
public class VerificaDisponibilitaMagazziniResponse {

    protected List<DisponibilitaPezzi> disponibilitaPezzi;
    protected List<Pezzo> pezziMancanti;

    /**
     * Gets the value of the disponibilitaPezzi property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the disponibilitaPezzi property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getDisponibilitaPezzi().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link DisponibilitaPezzi }
     * 
     * 
     */
    public List<DisponibilitaPezzi> getDisponibilitaPezzi() {
        if (disponibilitaPezzi == null) {
            disponibilitaPezzi = new ArrayList<DisponibilitaPezzi>();
        }
        return this.disponibilitaPezzi;
    }

    /**
     * Gets the value of the pezziMancanti property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the pezziMancanti property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getPezziMancanti().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Pezzo }
     * 
     * 
     */
    public List<Pezzo> getPezziMancanti() {
        if (pezziMancanti == null) {
            pezziMancanti = new ArrayList<Pezzo>();
        }
        return this.pezziMancanti;
    }

}
