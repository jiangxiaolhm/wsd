/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.wsd.dto;

import java.io.Serializable;
import java.util.Date;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
import uts.wsd.dao.XmlDateAdapter;

/**
 *
 * @author ShiWei
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement
public class User implements Serializable {
    
    @XmlElement(name = "userID")
    private int userID;
    @XmlElement(name = "name")
    private String name;
    @XmlElement(name = "email")
    private String email;
    @XmlElement(name = "DOB")
    @XmlJavaTypeAdapter(XmlDateAdapter.class)
    private Date DOB;
    @XmlElement(name = "password")
    private String password;
    @XmlElement(name = "type")
    private String type;

    /**
     *
     */
    public User() {
    }
    
    /**
     *
     * @param userID
     * @param name
     * @param email
     * @param DOB
     * @param password
     * @param type
     */
    public User(int userID, String name, String email, Date DOB, String password, String type) {
        this.userID = userID;
        this.name = name;
        this.email = email;
        this.DOB = DOB;
        this.password = password;
        this.type = type;

    }

    /**
     *
     * @return
     */
    public int getUserID() {
        return userID;
    }

    /**
     *
     * @param userID
     */
    public void setUserID(int userID) {
        this.userID = userID;
    }

    /**
     *
     * @return
     */
    public String getType() {
        return type;
    }

    /**
     *
     * @param type
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     *
     * @return
     */
    public String getEmail() {
        return email;
    }

    /**
     *
     * @param email
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     *
     * @return
     */
    public String getName() {
        return name;
    }

    /**
     *
     * @param name
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     *
     * @return
     */
    public String getPassword() {
        return password;
    }

    /**
     *
     * @param password
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     *
     * @return
     */
    public Date getDOB() {
        return DOB;
    }

    /**
     *
     * @param DOB
     */
    public void setDOB(Date DOB) {
        this.DOB = DOB;
    }
    
}
