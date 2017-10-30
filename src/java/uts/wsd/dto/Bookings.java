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
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name = "bookings")
public class Bookings implements Serializable {

    @XmlElement(name = "booking")
    private ArrayList<Booking> list = new ArrayList<Booking>();

    /**
     *
     */
    public Bookings() {
    }

    /**
     *
     * @return
     */
    public ArrayList<Booking> getList() {
        return list;
    }

    /**
     *
     * @param booking
     */
    public void addBooking(Booking booking) {
        list.add(booking);
    }

    /**
     *
     * @param booking
     */
    public void removeListing(Booking booking) {
        list.remove(booking);
    }
    
    /**
     *
     * @param userID
     * @return
     */
    public Bookings getBookingsByUserID(int userID) {
        Bookings bookings = new Bookings();
        for (Booking booking : list) {
            if (booking.getUser().getUserID() == userID) {
                bookings.addBooking(booking);
            }
        }
        return bookings;
    }
    
    /**
     *
     * @param userID
     * @return
     */
    public Booking getActiveBookingByUserID(int userID) {
        
        for (Booking booking : list) {
            if (booking.getUser().getUserID() == userID && booking.getDescription().equals("Active")) {
                return booking;
            }
        }
        return null;
    }
    
    /**
     *
     * @param bookingID
     * @return
     */
    public Booking getBooking(int bookingID) {
        
        for (Booking booking : list) {
            if (booking.getBookingID() == bookingID) {
                return booking;
            }
        }
        return null;
    }
    
    /**
     *
     * @param userID
     */
    public void cancelBooking(int userID) {
        
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).getUser().getUserID() == userID)
                list.get(i).setDescription("Canceled");
        }
    }
    
    /**
     *
     * @param userID
     * @param seat
     */
    public void changeSeeat(int userID, int seatChange) {
        
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).getUser().getUserID() == userID) {
                list.get(i).setSeat(list.get(i).getSeat()+seatChange);
                list.get(i).getFlight().setNumOfSeats(list.get(i).getFlight().getNumOfSeats()-seatChange);
            }
        }
    }
}
