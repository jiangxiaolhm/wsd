package uts.wsd.dao;

import uts.wsd.dto.Listings;

/**
 *
 * @author Hongming
 */
public interface ListingsDAO {
    
    public Listings loadListings();
    public boolean saveListings(Listings listings);
    
}
