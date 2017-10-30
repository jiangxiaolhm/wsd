package uts.wsd.dao;

import uts.wsd.dto.Bookings;

/**
 *
 * @author Hongming
 */
public interface BookingsDAO {
    
    /**
     *
     * @return
     */
    public Bookings loadBookings();

    /**
     *
     * @param bookings
     * @return
     */
    public boolean saveBookings(Bookings bookings);
}
