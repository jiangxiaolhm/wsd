package uts.wsd.rest;

import java.io.IOException;
import javax.servlet.ServletContext;
import javax.ws.rs.*;
import javax.ws.rs.core.*;
import javax.xml.bind.JAXBException;
import uts.wsd.ListingApplication;
import uts.wsd.dto.Listings;

/**
 *
 * @author Hongming
 */
@Path("/listingREST")
public class ListingREST {

    @Context
    private ServletContext application;

    private ListingApplication getListingApp() throws JAXBException, IOException {
        synchronized (application) {
            ListingApplication listingApp = (ListingApplication) application.getAttribute("listingApp");
            if (listingApp == null) {
                listingApp = new ListingApplication();
                listingApp.setXmlFilePath(application.getRealPath("WEB-INF/listings.xml"));
                listingApp.setXsdFilePath(application.getRealPath("WEB-INF/listings.xsd"));
                application.setAttribute("listingApp", listingApp);
            }
            return listingApp;
        }
    }
    
    /**
     *
     * @param username
     * @param status
     * @param numOfFlights
     * @return
     * @throws JAXBException
     * @throws IOException
     */
    @Path("listing")
    @GET
    @Produces(MediaType.APPLICATION_XML)
    public Listings listings(@QueryParam("username") String username, @QueryParam("status") String status, @QueryParam("numofflights") int numOfFlights) throws JAXBException, IOException {
        // http://localhost:8080/assignment/rest/listingREST/listing?username=lixiranph@126.com&numofflights=2&status=Unavailable
        return this.getListingApp().fetchListings(username, status, numOfFlights);
    }
}
