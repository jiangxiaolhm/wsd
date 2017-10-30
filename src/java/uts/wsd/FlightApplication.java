package uts.wsd;

import java.io.Serializable;
import uts.wsd.dto.Flights;
import uts.wsd.dao.FlightsDAO;
import uts.wsd.dao.FlightsDAO_Impl;
import uts.wsd.dto.Flight;

/**
 *
 * @author Hongming
 */
public class FlightApplication implements Serializable {
    
    private String xmlFilePath;
    private String xsdFilePath;
    private Flights flights;
    private FlightsDAO flightsDAO;
    
    /**
     *
     */
    public FlightApplication() {
    }
    
    /**
     *
     * @return
     */
    public Flights loadFlights() {
        flightsDAO = new FlightsDAO_Impl(xmlFilePath, xsdFilePath);
        flights = flightsDAO.loadFlights();
        return flights;
    }
    
    /**
     *
     * @return
     */
    public boolean saveFlights() {
        flightsDAO = new FlightsDAO_Impl(xmlFilePath, xsdFilePath);
        return flightsDAO.saveFlights(flights);
    }
    
    /**
     *
     * @param xmlFilePath
     * @param xsdFilePath
     * @param flights
     * @return
     */
    public boolean updateFlights(String xmlFilePath, String xsdFilePath, Flights flights) {
        this.xmlFilePath = xmlFilePath;
        this.xsdFilePath = xsdFilePath;
        this.flights = flights;
        this.flightsDAO = new FlightsDAO_Impl(xmlFilePath, xsdFilePath);
        return this.flightsDAO.saveFlights(flights);
    }
    
    /**
     *
     * @param flightID
     * @return
     */
    public Flight getFlightByFlightID(String flightID) {
        return flights.getFlightByFlightID(flightID);
    }
    
    public boolean decreaseSeat(String flightID, int seat) {
        flights.decreaseSeat(flightID, seat);
        return this.saveFlights();
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
    public Flights getFlights() {
        return flights;
    }

    /**
     *
     * @param flights
     */
    public void setFlights(Flights flights) {
        this.flights = flights;
    }
    
}
