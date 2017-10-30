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
import uts.wsd.dto.Listings;

/**
 *
 * @author Hongming
 */
public class ListingsDAO_Impl implements ListingsDAO {

    private String xmlFilePath;
    private String xsdFilePath;

    public ListingsDAO_Impl(String xmlFilePath, String xsdFilePath) {
        this.xmlFilePath = xmlFilePath;
        this.xsdFilePath = xsdFilePath;
    }
    
    @Override
    public Listings loadListings() {
        Listings listings = null;
        try {
            JAXBContext jc = JAXBContext.newInstance(Listings.class);
            Unmarshaller u = jc.createUnmarshaller();
            SchemaFactory sf = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
            Schema schema = sf.newSchema(new File(xsdFilePath));
            FileInputStream fin = new FileInputStream(xmlFilePath);
            u.setSchema(schema);
            u.setEventHandler(new XmlValidationEventHandler());
            listings = (Listings) u.unmarshal(fin);
            fin.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listings;
    }

    @Override
    public boolean saveListings(Listings listings) {
        try {
            JAXBContext jc = JAXBContext.newInstance(Listings.class);
            JAXBSource js = new JAXBSource(jc, listings);
            
            SchemaFactory sf = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
            Schema schema = sf.newSchema(new File(xsdFilePath));
            
            Validator validator = schema.newValidator();
            validator.validate(js);
            
            Marshaller m = jc.createMarshaller();
            FileOutputStream fout = new FileOutputStream(xmlFilePath);
            m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
            m.marshal(listings, fout);
            fout.close();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public String getXmlFilePath() {
        return xmlFilePath;
    }

    public void setXmlFilePath(String xmlFilePath) {
        this.xmlFilePath = xmlFilePath;
    }

    public String getXsdFilePath() {
        return xsdFilePath;
    }

    public void setXsdFilePath(String xsdFilePath) {
        this.xsdFilePath = xsdFilePath;
    }
    
}
