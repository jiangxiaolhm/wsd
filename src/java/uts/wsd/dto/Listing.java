package uts.wsd.dto;

import java.io.Serializable;
import java.util.ArrayList;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Hongming
 */
@XmlAccessorType(XmlAccessType.FIELD) // Use the defaults for fields
@XmlRootElement
public class Listing implements Serializable {

    @XmlElement(name = "listingID")
    private int listingID;
    @XmlElement(name = "user")
    private User user;
    @XmlElement(name = "flight")
    private ArrayList<Flight> flights;
    @XmlElement(name = "description")
    private String description;

    /**
     *
     */
    public Listing() {
    }

    /**
     *
     * @param listingID
     * @param user
     * @param flights
     * @param description
     */
    public Listing(int listingID, User user, ArrayList<Flight> flights, String description) {
        this.listingID = listingID;
        this.user = user;
        this.flights = flights;
        this.description = description;
    }

    /**
     *
     * @return
     */
    public String getDescription() {
        return description;
    }

    /**
     *
     * @param description
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     *
     * @return
     */
    public int getListingID() {
        return listingID;
    }

    /**
     *
     * @param listingID
     */
    public void setListingID(int listingID) {
        this.listingID = listingID;
    }

    /**
     *
     * @return
     */
    public User getUser() {
        return user;
    }

    /**
     *
     * @param user
     */
    public void setUser(User user) {
        this.user = user;
    }

    /**
     *
     * @return
     */
    public ArrayList<Flight> getFlights() {
        return flights;
    }

    /**
     *
     * @param flights
     */
    public void setFlights(ArrayList<Flight> flights) {
        this.flights = flights;
    }

}
