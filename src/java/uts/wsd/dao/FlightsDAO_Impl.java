/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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
import uts.wsd.dto.Flights;

/**
 *
 * @author Hongming
 */
public class FlightsDAO_Impl implements FlightsDAO {

    private String xmlFilePath;
    private String xsdFilePath;

    public FlightsDAO_Impl(String xmlFilePath, String xsdFilePath) {
        this.xmlFilePath = xmlFilePath;
        this.xsdFilePath = xsdFilePath;
    }

    @Override
    public Flights loadFlights() {
        Flights flights = null;
        try {
            JAXBContext jc = JAXBContext.newInstance(Flights.class);
            Unmarshaller u = jc.createUnmarshaller();
            SchemaFactory sf = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
            Schema schema = sf.newSchema(new File(xsdFilePath));
            FileInputStream fin = new FileInputStream(xmlFilePath);
            u.setSchema(schema);
            u.setEventHandler(new XmlValidationEventHandler());
            flights = (Flights) u.unmarshal(fin);
            fin.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flights;
    }

    @Override
    public boolean saveFlights(Flights flights) {
        try {
            JAXBContext jc = JAXBContext.newInstance(Flights.class);
            JAXBSource js = new JAXBSource(jc, flights);
            
            SchemaFactory sf = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
            Schema schema = sf.newSchema(new File(xsdFilePath));
            
            Validator validator = schema.newValidator();
            validator.validate(js);
            
            Marshaller m = jc.createMarshaller();
            FileOutputStream fout = new FileOutputStream(xmlFilePath);
            
            m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
            m.marshal(flights, fout);
            fout.close();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
    
}
