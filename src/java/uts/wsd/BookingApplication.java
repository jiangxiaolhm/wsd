package uts.wsd;

import java.io.Serializable;
import java.util.Random;
import uts.wsd.dao.BookingsDAO;
import uts.wsd.dao.BookingsDAO_Impl;
import uts.wsd.dto.Booking;
import uts.wsd.dto.Bookings;
import uts.wsd.dto.Flight;
import uts.wsd.dto.User;

/**
 *
 * @author Hongming
 */
public class BookingApplication implements Serializable {
        
    private String xmlFilePath;
    private String xsdFilePath;
    private Bookings bookings;
    private BookingsDAO bookingsDAO;
    
    /**
     *
     */
    public BookingApplication() {
    }
    
    /**
     *
     * @return
     */
    public Bookings loadBookings() {
        bookingsDAO = new BookingsDAO_Impl(xmlFilePath, xsdFilePath);
        bookings = bookingsDAO.loadBookings();
        return bookings;
    }
    
    /**
     *
     * @return
     */
    public boolean saveBookings() {
        bookingsDAO = new BookingsDAO_Impl(xmlFilePath, xsdFilePath);
        return bookingsDAO.saveBookings(bookings);
    }
    
    /**
     *
     * @param xmlFilePath
     * @param xsdFilePath
     * @param bookings
     * @return
     */
    public boolean updateBookings(String xmlFilePath, String xsdFilePath, Bookings bookings) {
        this.xmlFilePath = xmlFilePath;
        this.xsdFilePath = xsdFilePath;
        this.bookings = bookings;
        this.bookingsDAO = new BookingsDAO_Impl(xmlFilePath, xsdFilePath);
        return this.bookingsDAO.saveBookings(bookings);
    }
    
    /**
     *
     * @param userID
     * @return
     */
    public Bookings getBookingsByUserID(int userID) {
        return bookings.getBookingsByUserID(userID);
    }
    
    /**
     *
     * @param userID
     * @return
     */
    public Booking getActiveBookingByUserID(int userID) {
        return bookings.getActiveBookingByUserID(userID);
    }
    
    /**
     *
     * @param user
     * @param flight
     * @return
     */
    public boolean createBooking(User user, Flight flight) {
        
        if (user == null || flight == null)
            return false;
        bookings.addBooking(new Booking((new Random()).nextInt(1000000), user, flight, 1, "Active" ));
        return this.saveBookings();
    }
    
    /**
     *
     * @param userID
     * @return
     */
    public boolean cancelBooking(int userID) {
        bookings.cancelBooking(userID);
        return this.saveBookings();
    }
    
    /**
     *
     * @param userID
     * @param seatChange
     * @return
     */
    public boolean changeSeat(int userID, int seatChange) {
        bookings.changeSeeat(userID, seatChange);
        return this.saveBookings();
    }
    
    /**
     *
     * @param bookingID
     * @return
     */
    public Booking getBookingByBookingID(int bookingID) {
        return bookings.getBooking(bookingID);
    }
    
    /**
     *
     * @return
     */
    public String getXmlFilePath() {
        return xmlFilePath;
    }

    /**
     *
     * @param xmlFilePath
     */
    public void setXmlFilePath(String xmlFilePath) {
        this.xmlFilePath = xmlFilePath;
    }

    /**
     *
     * @return
     */
    public String getXsdFilePath() {
        return xsdFilePath;
    }

    /**
     *
     * @param xsdFilePath
     */
    public void setXsdFilePath(String xsdFilePath) {
        this.xsdFilePath = xsdFilePath;
    }

    /**
     *
     * @return
     */
    public Bookings getBookings() {
        return bookings;
    }

    /**
     *
     * @param bookings
     */
    public void setBookings(Bookings bookings) {
        this.bookings = bookings;
    }
    
}
