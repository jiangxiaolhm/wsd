package uts.wsd.dao;

import uts.wsd.dto.Flights;

/**
 *
 * @author Hongming
 */
public interface FlightsDAO {
    
    /**
     *
     * @return
     */
    public Flights loadFlights();

    /**
     *
     * @param flights
     * @return
     */
    public boolean saveFlights(Flights flights);
}
