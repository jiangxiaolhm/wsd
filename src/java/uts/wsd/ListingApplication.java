package uts.wsd;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Random;
import uts.wsd.dao.ListingsDAO;
import uts.wsd.dao.ListingsDAO_Impl;
import uts.wsd.dto.Flight;
import uts.wsd.dto.Listing;
import uts.wsd.dto.Listings;
import uts.wsd.dto.User;

/**
 *
 * @author Hongming
 */
public class ListingApplication implements Serializable {
    
    private String xmlFilePath;
    private String xsdFilePath;
    private Listings listings;
    private ListingsDAO listingsDAO;

    /**
     *
     */
    public ListingApplication() {
    }
    
    /**
     *
     * @return
     */
    public Listings loadListings() {
        listingsDAO = new ListingsDAO_Impl(xmlFilePath, xsdFilePath);
        listings = listingsDAO.loadListings();
        return listings;
    }
    
    /**
     *
     * @return
     */
    public boolean saveListings() {
        listingsDAO = new ListingsDAO_Impl(xmlFilePath, xsdFilePath);
        return listingsDAO.saveListings(listings);
    }
    
    /**
     *
     * @param xmlFilePath
     * @param xsdFilePath
     * @param listings
     * @return
     */
    public boolean updateListings(String xmlFilePath, String xsdFilePath, Listings listings) {
        this.xmlFilePath = xmlFilePath;
        this.xsdFilePath = xsdFilePath;
        this.listings = listings;
        this.listingsDAO = new ListingsDAO_Impl(xmlFilePath, xsdFilePath);
        return this.listingsDAO.saveListings(listings);
    }
    
    /**
     *
     * @param user
     * @param flightList
     * @return
     */
    public boolean createListing(User user, ArrayList<Flight> flightList) {
        
        if (user == null || flightList == null)
            return false;
        listings.addListing(new Listing((new Random()).nextInt(1000000), user, flightList, "Active"));
        
        return this.saveListings();
    }
    
    /**
     *
     * @param username
     * @param status
     * @param numOfFlights
     * @return
     */
    public Listings fetchListings(String username, String status, int numOfFlights) {
        
        Listings results = new Listings();
        Listings listings =  this.loadListings();
        
        for (Listing listing : this.loadListings().getList()) {
            // Skip canceled listing
            if (listing.getDescription().equals("Canceled"))
                continue;
            // Match username (email)
            if (username != null && !username.equals(listing.getUser().getEmail()))
                continue;
            System.out.println(listing.getFlights().size() + " " + numOfFlights);
            // Match minimum number of flights
            if (listing.getFlights().size() < numOfFlights)
                continue;
            
            if (status == null) {
                results.addListing(listing);
            } else {
                ArrayList<Flight> flights = new ArrayList<Flight>();
                for (Flight flight : listing.getFlights()) {
                    System.out.println(flight.getNumOfSeats() + " " + status);
                    if ((flight.getNumOfSeats() > 0 && status.equals("Available"))||
                        (flight.getNumOfSeats() == 0 && status.equals("Unavailable")))
                        flights.add(flight);
                }
                listing.setFlights(flights);
                results.addListing(listing);
            }
        }
        return results;
    }

    /**
     *
     * @param listingID
     * @return
     */
    public boolean closeListing(int listingID) {
        
        listings.closeListing(listingID);
        return this.saveListings();
    }
    
    /**
     *
     * @param userID
     * @return
     */
    public Listings getActiveListingsByUserID(int userID) {
        return listings.getActiveListingsByUserID(userID);
    }
    
    /**
     *
     * @param flightID
     * @param seat
     * @return
     */
    public boolean decreaseSeat(String flightID, int seat) {
        listings.decreaseSeat(flightID, seat);
        return this.saveListings();
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
    public Listings getListings() {
        return listings;
    }

    /**
     *
     * @param listings
     */
    public void setListings(Listings listings) {
        this.listings = listings;
    }
    
}
