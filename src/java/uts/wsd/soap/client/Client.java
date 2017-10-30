package uts.wsd.soap.client;

import java.util.ArrayList;
import uts.wsd.DateFormat;
import uts.wsd.dto.Flights;

/**
 *
 * @author Hongming
 */
public class Client {
    
    public static void main(String[] args) throws IOException_Exception, JAXBException_Exception {
        AirlineSOAP_Service locator = new AirlineSOAP_Service();
        AirlineSOAP airlineService = locator.getAirlineSOAPPort();
        
//        User user = airlineService.login("lixiranph@126.com", "A123123");
//        if (user != null) {
//            System.out.println("Login successfully.");
//            System.out.println("UserID: " + user.getUserID());
//            System.out.println("Name: " + user.getName());
//            System.out.println("Email: " + user.getEmail());
//            System.out.println("Password: " + user.getPassword());
//            System.out.println("DOB: " + user.getDOB());
//            System.out.println("Type: " + user.getType());
//        }
//        
//        airlineService.logout();
//        
//        ArrayList<Flight> flightList = new ArrayList<Flight>();
//        Flight flight = new Flight();
//        flight.setFlightID("AU234");
//        flight.setDDateTime("1/11/2017 18:00:00");
//        flight.setRDateTime("11/11/2017 18:00:00");
//        flight.setType("Economy");
//        flight.setPrice(100);
//        flight.setNumOfSeats(100);
//        flight.setFrom("Sydney");
//        flight.setTo("Adelaide");
//        flightList.add(flight);
//        
//        if (airlineService.createListing(user, flightList)) {
//            System.out.println("Create listing successfully.");
//        }
//
//        Listings listings = airlineService.fetchListings(null, null, 0);
//        System.out.println(listings.getListing().size());
//        for (Listing listing : listings.getListing()) {
//            System.out.println("ListingID: "+listing.getListingID());
//            System.out.println("\tDescription: "+listing.getDescription());
//            System.out.println("\tUserID: "+listing.getUser().getUserID());
//            System.out.println("\t\tEmail: "+listing.getUser().getEmail());
//            System.out.println("\t\tName: "+listing.getUser().getName());
//            System.out.println("\t\tPassword: "+listing.getUser().getPassword());
//            System.out.println("\t\tDOB: "+listing.getUser().getDOB());
//            System.out.println("\t\tType: "+listing.getUser().getType());
//            
//            for (Flight f : listing.getFlight()) {
//                System.out.println("\tFlightID: "+f.getFlightID());
//                System.out.println("\t\tDepartureDateTime: "+f.getDDateTime());
//                System.out.println("\t\tReturenDateTime: "+f.getRDateTime());
//                System.out.println("\t\tFrom: "+f.getFrom());
//                System.out.println("\t\tTo: "+f.getTo());
//                System.out.println("\t\tType: "+f.getType());
//            }
//        }
        
        if (airlineService.closeListing(44949)) {
            System.out.println("Close listing successfully.");
        }
        
//        if (airlineService.makeBooking(user, flight)) {
//            System.out.println("Make booking successfully.");
//        }
        
    }
}
