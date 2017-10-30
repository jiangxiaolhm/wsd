package uts.wsd.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Hongming
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name = "flights")
public class Flights implements Serializable {

    @XmlElement(name = "flight")
    private ArrayList<Flight> list = new ArrayList<Flight>();

    /**
     *
     */
    public Flights() {
    }

    /**
     *
     * @return
     */
    public ArrayList<Flight> getList() {
        return list;
    }

    /**
     *
     * @param flight
     */
    public void addFlight(Flight flight) {
        list.add(flight);
    }

    /**
     *
     * @param flight
     */
    public void removeFlight(Flight flight) {
        list.remove(flight);
    }

    /**
     *
     * @param flightID
     * @return
     */
    public Flight getFlight(String flightID) {
        for (Flight flight : list) {
            if (flight.getFlightID().equals(flightID)) {
                return flight;
            }
        }
        return null;
    }

    /**
     *
     * @param from
     * @param to
     * @param dDateTime
     * @param rDateTime
     * @param type
     * @param minPrice
     * @param maxPrice
     * @return
     */
    public ArrayList<Flight> searchFlights(String from, String to, Date dDateTime, Date rDateTime, String type, int minPrice, int maxPrice) {
        
        ArrayList<Flight> results = new ArrayList<Flight>();
        Calendar thisDeparture = Calendar.getInstance();
        Calendar thisReturn = Calendar.getInstance();
        Calendar searchDeparture = Calendar.getInstance();
        Calendar searchReturn = Calendar.getInstance();
        
        searchDeparture.setTime(dDateTime);
        if (rDateTime != null)
            searchReturn.setTime(rDateTime);
        
        for (Flight f : list) {

            if (!f.getFrom().equals(from)) {
                continue;
            }

            if (!f.getTo().equals(to)) {
                continue;
            }

            if (!f.getType().equals(type)) {
                continue;
            }

            thisDeparture.setTime(f.getdDateTime());
            if (thisDeparture.get(Calendar.YEAR) != searchDeparture.get(Calendar.YEAR)
                    || thisDeparture.get(Calendar.MONTH) != searchDeparture.get(Calendar.MONTH)
                    || thisDeparture.get(Calendar.DATE) != searchDeparture.get(Calendar.DATE)) {
                continue;
            }

            if (rDateTime != null) {
                thisReturn.setTime(f.getrDateTime());
                if (thisReturn.get(Calendar.YEAR) != searchReturn.get(Calendar.YEAR)
                        || thisReturn.get(Calendar.MONTH) != searchReturn.get(Calendar.MONTH)
                        || thisReturn.get(Calendar.DATE) != searchReturn.get(Calendar.DATE)) {
                    continue;
                }
            }
            
            if (f.getPrice() < minPrice || f.getPrice() > maxPrice)
                continue;
            results.add(f);
        }
        return results;
    }
    
    /**
     *
     * @param flightID
     * @return
     */
    public Flight getFlightByFlightID(String flightID) {
        
        for (Flight flight : list) {
            if (flight.getFlightID().equals(flightID))
                return flight;
        }
        return null;
    }
    
    /**
     *
     * @param flightID
     * @param seat
     */
    public void decreaseSeat(String flightID, int seat) {
        
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).getFlightID().equals(flightID))
                list.get(i).setNumOfSeats(list.get(i).getNumOfSeats()-seat);
        }
    }
}
