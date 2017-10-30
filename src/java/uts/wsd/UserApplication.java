package uts.wsd;

import uts.wsd.dto.Users;
import java.io.Serializable;
import uts.wsd.dao.UsersDAO;
import uts.wsd.dao.UsersDAO_Impl;
import uts.wsd.dto.User;

/**
 *
 * @author ShiWei
 */
public class UserApplication implements Serializable {

    private String xmlFilePath;
    private String xsdFilePath;
    private Users users;
    private UsersDAO usersDAO;
    
    /**
     *
     */
    public UserApplication() {
    }

    /**
     *
     * @return
     */
    public Users loadUsers() {
        usersDAO = new UsersDAO_Impl(xmlFilePath, xsdFilePath);
        users = usersDAO.loadUsers();
        return users;
    }
    
    /**
     *
     * @return
     */
    public boolean saveUsers() {
        usersDAO = new UsersDAO_Impl(xmlFilePath, xsdFilePath);
        return usersDAO.saveUsers(users);
    }
    
    /**
     *
     * @param xmlFilePath
     * @param xsdFilePath
     * @param users
     * @return
     */
    public boolean updateUsers(String xmlFilePath, String xsdFilePath, Users users) {
        this.xmlFilePath = xmlFilePath;
        this.xsdFilePath = xsdFilePath;
        this.users = users;
        this.usersDAO = new UsersDAO_Impl(xmlFilePath, xsdFilePath);
        return this.usersDAO.saveUsers(users);
    }
    
    /**
     *
     * @param email
     * @param password
     * @return
     */
    public User login(String email, String password) {
        return users.login(email, password);
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
    public Users getUsers() {
        return users;
    }

    /**
     *
     * @param users
     */
    public void setUsers(Users users) {
        this.users = users;
    }
    
}
