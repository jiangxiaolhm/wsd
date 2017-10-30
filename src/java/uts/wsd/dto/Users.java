package uts.wsd.dto;

import java.io.Serializable;
import java.util.ArrayList;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author ShiWei
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name = "users")
public class Users implements Serializable {

    @XmlElement(name = "user")
    private ArrayList<User> list = new ArrayList<User>();

    /**
     *
     * @return
     */
    public ArrayList<User> getList() {
        return list;
    }

    /**
     *
     */
    public Users() {
    }

    /**
     *
     * @param user
     */
    public void addUser(User user) {
        list.add(user);
    }

    /**
     *
     * @param user
     */
    public void removeUser(User user) {
        list.remove(user);
    }

    /**
     *
     * @param email
     * @return
     */
    public User getUser(String email) {
        for (User user : list) {
            if (user.getEmail().equals(email)) {
                return user;
            } else {
            }
        }
        return null;
    }

    /**
     *
     * @param email
     * @param password
     * @return
     */
    public User login(String email, String password) {
        // For each user in the list...
        for (User user : list) {
            //System.out.println(user.getEmail() + "___" + user.getPassword());
            if (user.getEmail().equals(email) && user.getPassword().equals(password)) {
                return user; // Login correct. Return this user.
            }
        }
        return null; // Login incorrect. Return null.
    }
    
}
