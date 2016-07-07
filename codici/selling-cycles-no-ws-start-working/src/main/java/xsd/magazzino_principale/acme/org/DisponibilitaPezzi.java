
package xsd.magazzino_principale.acme.org;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per DisponibilitaPezzi complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType name="DisponibilitaPezzi"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="idPezzo" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
 *         &lt;element name="magazzini" maxOccurs="unbounded" minOccurs="0"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="qta" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
 *                   &lt;element name="idMagazzino" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
 *                   &lt;element name="prezzo" type="{http://www.w3.org/2001/XMLSchema}double" minOccurs="0"/&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "DisponibilitaPezzi", propOrder = {
    "idPezzo",
    "magazzini"
})
public class DisponibilitaPezzi implements Serializable{

    protected int idPezzo;
    protected List<DisponibilitaPezzi.Magazzini> magazzini;

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
     * Gets the value of the magazzini property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the magazzini property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getMagazzini().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link DisponibilitaPezzi.Magazzini }
     * 
     * 
     */
    public List<DisponibilitaPezzi.Magazzini> getMagazzini() {
        if (magazzini == null) {
            magazzini = new ArrayList<DisponibilitaPezzi.Magazzini>();
        }
        return this.magazzini;
    }


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
     *         &lt;element name="qta" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
     *         &lt;element name="idMagazzino" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
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
    @XmlType(name = "", propOrder = {
        "qta",
        "idMagazzino",
        "prezzo"
    })
    public static class Magazzini implements Serializable {

        protected int qta;
        protected int idMagazzino;
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

}
