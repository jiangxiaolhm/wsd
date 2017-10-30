/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.wsd.dao;

import java.util.Date;
import javax.xml.bind.annotation.adapters.XmlAdapter;
import uts.wsd.DateFormat;

/**
 *
 * @author Hongming
 */
public class XmlDateAdapter extends XmlAdapter<String, Date> {
    
    @Override
    public Date unmarshal(String v) throws Exception {
        synchronized (DateFormat.DATE_FORMAT) {
            return DateFormat.DATE_FORMAT.parse(v);
        }
    }

    @Override
    public String marshal(Date v) throws Exception {
        synchronized (DateFormat.DATE_FORMAT) {
            return DateFormat.DATE_FORMAT.format(v);
        }
    }
    
}
