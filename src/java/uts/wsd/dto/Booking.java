package uts.wsd.dto;

import java.io.Serializable;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Shiwei
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement
public class Booking  implements Serializable {
    
    @XmlElement(name = "bookingID")
    private int bookingID;
    @XmlElement(name = "user")
    private User user;
    @XmlElement(name = "flight")
    private Flight flight;
    @XmlElement(name = "seat")
    private int seat;
    @XmlElement(name = "description")
    private String description;

    /**
     *
     */
    public Booking() {
    }

    /**
     *
     * @param bookingID
     * @param user
     * @param flight
     * @param seat
     * @param description
     */
    public Booking(int bookingID, User user, Flight flight, int seat, String description) {
        this.bookingID = bookingID;
        this.user = user;
        this.flight = flight;
        this.seat = seat;
        this.description = description;
    }

    /**
     *
     * @return
     */
    public int getBookingID() {
        return bookingID;
    }

    /**
     *
     * @param bookingID
     */
    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
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
    public Flight getFlight() {
        return flight;
    }

    /**
     *
     * @param flight
     */
    public void setFlight(Flight flight) {
        this.flight = flight;
    }

    /**
     *
     * @return
     */
    public int getSeat() {
        return seat;
    }

    /**
     *
     * @param seat
     */
    public void setSeat(int seat) {
        this.seat = seat;
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
    
}
