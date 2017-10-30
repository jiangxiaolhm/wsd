package uts.wsd.soap;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Random;
import javax.annotation.Resource;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.bind.JAXBException;
import javax.xml.ws.WebServiceContext;
import javax.xml.ws.handler.MessageContext;
import uts.wsd.BookingApplication;
import uts.wsd.FlightApplication;
import uts.wsd.ListingApplication;
import uts.wsd.UserApplication;
import uts.wsd.dto.Flight;
import uts.wsd.dto.Listings;
import uts.wsd.dto.User;

/**
 *
 * @author Hongming
 */
@WebService(serviceName = "AirlineSOAP")
public class AirlineSOAP {

    @Resource
    private WebServiceContext context;
    
    private UserApplication getUserApp() throws JAXBException, IOException {
        
        ServletContext application = (ServletContext) context.getMessageContext().get(MessageContext.SERVLET_CONTEXT);
        
        synchronized (application) {
            UserApplication userApp = (UserApplication) application.getAttribute("userApp");
            if (userApp == null) {
                userApp = new UserApplication();
                userApp.setXmlFilePath(application.getRealPath("WEB-INF/users.xml"));
                userApp.setXsdFilePath(application.getRealPath("WEB-INF/users.xsd"));
                application.setAttribute("userApp", userApp);
            }
            return userApp;
        }
    }
    
    private ListingApplication getListingApp() throws JAXBException, IOException {
        
        ServletContext application = (ServletContext) context.getMessageContext().get(MessageContext.SERVLET_CONTEXT);
        
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
    
    private BookingApplication getBookingApp() throws JAXBException, IOException {
        
        ServletContext application = (ServletContext) context.getMessageContext().get(MessageContext.SERVLET_CONTEXT);
        
        synchronized (application) {
            BookingApplication bookingApp = (BookingApplication) application.getAttribute("bookingApp");
            if (bookingApp == null) {
                bookingApp = new BookingApplication();
                bookingApp.setXmlFilePath(application.getRealPath("WEB-INF/bookings.xml"));
                bookingApp.setXsdFilePath(application.getRealPath("WEB-INF/bookings.xsd"));
                application.setAttribute("bookingApp", bookingApp);
            }
            return bookingApp;
        }
    }
    
    private FlightApplication getFlightApp() throws JAXBException, IOException {
        
        ServletContext application = (ServletContext) context.getMessageContext().get(MessageContext.SERVLET_CONTEXT);
        
        synchronized (application) {
            FlightApplication flightApp = (FlightApplication) application.getAttribute("flightApp");
            if (flightApp == null) {
                flightApp = new FlightApplication();
                flightApp.setXmlFilePath(application.getRealPath("WEB-INF/flights.xml"));
                flightApp.setXsdFilePath(application.getRealPath("WEB-INF/flights.xsd"));
                application.setAttribute("flightApp", flightApp);
            }
            return flightApp;
        }
    }
    
    private HttpSession getSession() {
        
        HttpServletRequest request = (HttpServletRequest) context.getMessageContext().get(MessageContext.SERVLET_REQUEST);
        return request.getSession();
    }
    
    /**
     *
     * @param email
     * @param password
     * @return
     * @throws JAXBException
     * @throws IOException
     */
    @WebMethod(operationName = "login")
    public User login(@WebParam(name = "email") String email, @WebParam(name = "password") String password) throws JAXBException, IOException {
        if (email == null || password == null)
            return null;
        UserApplication userApp = this.getUserApp();
        userApp.loadUsers();
        User user = userApp.login(email, password);
        if (user != null)
            this.getSession().setAttribute("user", user);
        return (User)this.getSession().getAttribute("user");
    }
    
    /**
     *
     */
    @WebMethod(operationName = "logout")
    public void logout() {
        this.getSession().invalidate();
    }
    
    /**
     *
     * @param user
     * @param flightList
     * @return
     * @throws JAXBException
     * @throws IOException
     */
    @WebMethod(operationName = "createListing")
    public boolean createListing(@WebParam(name = "user") User user, 
            @WebParam(name = "flights") ArrayList<Flight> flightList) throws JAXBException, IOException {
        
        ListingApplication listingApp = this.getListingApp();
        listingApp.loadListings();
        
        return listingApp.createListing(user, flightList);
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
    @WebMethod(operationName = "fetchListings")
    public Listings fetchListings(@WebParam(name = "username") String username, 
            @WebParam(name = "status") String status, 
            @WebParam(name = "numofflight") int numOfFlights) throws JAXBException, IOException {
        
        ListingApplication listingApp = this.getListingApp();
        listingApp.loadListings();
        
        return this.getListingApp().fetchListings(username, status, numOfFlights);
    }
    
    /**
     *
     * @param listingID
     * @return
     * @throws JAXBException
     * @throws IOException
     */
    @WebMethod(operationName = "closeListing")
    public boolean closeListing(@WebParam(name = "listingID") int listingID) throws JAXBException, IOException {
        
        ListingApplication listingApp = this.getListingApp();
        listingApp.loadListings();
        
        return listingApp.closeListing(listingID);
    }
    
    /**
     *
     * @param user
     * @param flight
     * @return
     * @throws javax.xml.bind.JAXBException
     * @throws java.io.IOException
     */
    @WebMethod(operationName = "makeBooking")
    public boolean makeBooking(User user, Flight flight) throws JAXBException, IOException {
        if (user == null || flight == null)
            return false;
        if (flight.getNumOfSeats() > 0) {
            FlightApplication flightApp = this.getFlightApp();
            ListingApplication listingApp = this.getListingApp();
            BookingApplication bookingApp = this.getBookingApp();
            flightApp.loadFlights();
            listingApp.loadListings();
            bookingApp.loadBookings();
            
            return (flightApp.decreaseSeat(flight.getFlightID(), 1) &&
                    listingApp.decreaseSeat(flight.getFlightID(), 1) &&
                    bookingApp.createBooking(user, flight));
        }
        return false;
    }
    
}
