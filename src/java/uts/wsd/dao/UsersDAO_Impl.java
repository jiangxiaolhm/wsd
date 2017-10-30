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
import uts.wsd.dto.Users;

/**
 *
 * @author Hongming
 */
public class UsersDAO_Impl implements UsersDAO {
    
    private String xmlFilePath;
    private String xsdFilePath;

    public UsersDAO_Impl(String xmlFilePath, String xsdFilePath) {
        this.xmlFilePath = xmlFilePath;
        this.xsdFilePath = xsdFilePath;
    }
    
    @Override
    public Users loadUsers() {
        Users users = null;
        try {
            JAXBContext jc = JAXBContext.newInstance(Users.class);
            Unmarshaller u = jc.createUnmarshaller();
            SchemaFactory sf = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
            Schema schema = sf.newSchema(new File(xsdFilePath));
            FileInputStream fin = new FileInputStream(xmlFilePath);
            u.setSchema(schema);
            u.setEventHandler(new XmlValidationEventHandler());
            users = (Users) u.unmarshal(fin);
            fin.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    @Override
    public boolean saveUsers(Users users) {
        try {
            JAXBContext jc = JAXBContext.newInstance(Users.class);
            JAXBSource js = new JAXBSource(jc, users);
            
            SchemaFactory sf = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
            Schema schema = sf.newSchema(new File(xsdFilePath));
            
            Validator validator = schema.newValidator();
            validator.validate(js);
            
            Marshaller m = jc.createMarshaller();
            FileOutputStream fout = new FileOutputStream(xmlFilePath);
            m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
            m.marshal(users, fout);
            fout.close();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
    
}
