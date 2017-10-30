package uts.wsd.dao;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import javax.xml.XMLConstants;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import javax.xml.bind.util.JAXBSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;
import uts.wsd.dto.Bookings;

/**
 *
 * @author Hongming
 */
public class BookingsDAO_Impl implements BookingsDAO {

    private String xmlFilePath;
    private String xsdFilePath;

    public BookingsDAO_Impl(String xmlFilePath, String xsdFilePath) {
        this.xmlFilePath = xmlFilePath;
        this.xsdFilePath = xsdFilePath;
    }
    
    @Override
    public Bookings loadBookings() {
        Bookings bookings = null;
        try {
            JAXBContext jc = JAXBContext.newInstance(Bookings.class);
            Unmarshaller u = jc.createUnmarshaller();
            SchemaFactory sf = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
            Schema schema = sf.newSchema(new File(xsdFilePath));
            FileInputStream fin = new FileInputStream(xmlFilePath);
            u.setSchema(schema);
            u.setEventHandler(new XmlValidationEventHandler());
            bookings = (Bookings) u.unmarshal(fin);
            fin.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bookings;
    }

    @Override
    public boolean saveBookings(Bookings bookings) {
        try {
            JAXBContext jc = JAXBContext.newInstance(Bookings.class);
            JAXBSource js = new JAXBSource(jc, bookings);
            
            SchemaFactory sf = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
            Schema schema = sf.newSchema(new File(xsdFilePath));
            
            Validator validator = schema.newValidator();
            validator.validate(js);
            
            Marshaller m = jc.createMarshaller();
            FileOutputStream fout = new FileOutputStream(xmlFilePath);
            
            m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
            m.marshal(bookings, fout);
            fout.close();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
    
}
