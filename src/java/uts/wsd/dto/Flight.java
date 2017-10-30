package uts.wsd.dto;

import java.io.Serializable;
import java.util.Date;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
import uts.wsd.dao.XmlDateTimeAdapter;

/**
 *
 * @author Hongming
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement
public class Flight implements Serializable {
    
    @XmlElement(name = "flightID")
    private String flightID;
    @XmlElement(name = "dDateTime")
    @XmlJavaTypeAdapter(XmlDateTimeAdapter.class)
    private Date dDateTime;
    @XmlElement(name = "rDateTime")
    @XmlJavaTypeAdapter(XmlDateTimeAdapter.class)
    private Date rDateTime;
    @XmlElement(name = "type")
    private String type;
    @XmlElement(name = "price")
    private double price;
    @XmlElement(name = "numOfSeats")
    private int numOfSeats;
    @XmlElement(name = "from")
    private String from;
    @XmlElement(name = "to")
    private String to;

    /**
     *
     */
    public Flight() {
    }

    /**
     *
     * @param flightID
     * @param dDateTime
     * @param rDateTime
     * @param type
     * @param price
     * @param numOfSeats
     * @param from
     * @param to
     */
    public Flight(String flightID, Date dDateTime, Date rDateTime, String type, double price, int numOfSeats, String from, String to) {
        this.flightID = flightID;
        this.dDateTime = dDateTime;
        this.rDateTime = rDateTime;
        this.type = type;
        this.price = price;
        this.numOfSeats = numOfSeats;
        this.from = from;
        this.to = to;
    }

    /**
     *
     * @return
     */
    public String getFlightID() {
        return flightID;
    }

    /**
     *
     * @param flightID
     */
    public void setFlightID(String flightID) {
        this.flightID = flightID;
    }

    /**
     *
     * @return
     */
    public Date getdDateTime() {
        return dDateTime;
    }

    /**
     *
     * @param dDateTime
     */
    public void setdDateTime(Date dDateTime) {
        this.dDateTime = dDateTime;
    }

    /**
     *
     * @return
     */
    public Date getrDateTime() {
        return rDateTime;
    }

    /**
     *
     * @param rDateTime
     */
    public void setrDateTime(Date rDateTime) {
        this.rDateTime = rDateTime;
    }

    /**
     *
     * @return
     */
    public String getType() {
        return type;
    }

    /**
     *
     * @param type
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     *
     * @return
     */
    public double getPrice() {
        return price;
    }

    /**
     *
     * @param price
     */
    public void setPrice(double price) {
        this.price = price;
    }

    /**
     *
     * @return
     */
    public int getNumOfSeats() {
        return numOfSeats;
    }

    /**
     *
     * @param numOfSeats
     */
    public void setNumOfSeats(int numOfSeats) {
        this.numOfSeats = numOfSeats;
    }

    /**
     *
     * @return
     */
    public String getFrom() {
        return from;
    }

    /**
     *
     * @param from
     */
    public void setFrom(String from) {
        this.from = from;
    }

    /**
     *
     * @return
     */
    public String getTo() {
        return to;
    }

    /**
     *
     * @param to
     */
    public void setTo(String to) {
        this.to = to;
    }
    
}
