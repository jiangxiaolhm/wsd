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
@XmlRootElement(name = "listings")
public class Listings implements Serializable  {
    
    @XmlElement(name = "listing")
    private ArrayList<Listing> list = new ArrayList<Listing>();

    /**
     *
     */
    public Listings() {
    }

    
    /**
     *
     * @return
     */
    public ArrayList<Listing> getList() {
        return list;
    }

    /**
     *
     * @param list
     */
    public void setList(ArrayList<Listing> list) {
        this.list = list;
    }
    
    /**
     *
     * @param listing
     */
    public void addListing(Listing listing) {
        list.add(listing);
    }

    /**
     *
     * @param listing
     */
    public void removeListing(Listing listing) {
        list.remove(listing);
    }
    
    /**
     *
     * @param listingID
     */
    public void closeListing(int listingID) {
        
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).getListingID() == listingID)
                list.get(i).setDescription("Canceled");
        }
    }
    
    /**
     *
     * @param userID
     * @return
     */
    public Listings getActiveListingsByUserID(int userID) {
        Listings listings = new Listings();
        
        for (Listing listing : list) {
            if (listing.getUser().getUserID() == userID && listing.getDescription().equals("Active")) {
                listings.addListing(listing);
            }
        }
        return listings;
    }
    
    public void decreaseSeat(String flightID, int seat) {
        
        for (int i = 0; i < list.size(); i++) {
            for (int j = 0; j < list.get(i).getFlights().size(); j++) {
                if (list.get(i).getFlights().get(j).getFlightID().equals(flightID))
                    list.get(i).getFlights().get(j).setNumOfSeats(list.get(i).getFlights().get(j).getNumOfSeats()-seat);
            }
        }
    }
}
