/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.wsd.dom;

import java.io.*;
import java.util.*;
import javax.xml.parsers.*;
import org.w3c.dom.*;
import org.xml.sax.*;

/**
 *
 * @author ShiWei
 */
public class UsersPrinter {

    public static final Printer plain = new PlainPrinter();
    public static final Printer xml = new XMLPrinter();
    public static final Printer html = new HTMLPrinter();

    public static void main(String[] args) throws ParserConfigurationException, SAXException, IOException {
        PrintWriter out = new PrintWriter(new OutputStreamWriter(System.out), true);
        Scanner keyboard = new Scanner(System.in);

        System.out.println("Select an output mode:");
        System.out.println("1: plain");
        System.out.println("2: xml");
        System.out.println("3: html");
        System.out.print("Enter choice: ");
        int mode = keyboard.nextInt();
        switch (mode) {
            case 1:
                plain.print("web/WEB-INF/users.xml", out);
                break;
            case 2:
                xml.print("web/WEB-INF/users.xml", out);
                break;
            case 3:
                html.print("web/WEB-INF/users.xml", out);
                break;
        }
    }

    public static abstract class Printer {

        public abstract void print(Node node, PrintWriter out);

        public void print(String filePath, Writer out) throws ParserConfigurationException, SAXException, IOException {
            print(filePath, new PrintWriter(out, true));
        }

        public void print(String filePath, PrintWriter out) throws ParserConfigurationException, SAXException, IOException {
            FileInputStream in = new FileInputStream(filePath);
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document document = builder.parse(in);
            Element root = document.getDocumentElement();
            print(root, out);
            out.flush();
        }
    }

    public static class PlainPrinter extends Printer {

        @Override
        public void print(Node node, PrintWriter out) {
            // INSERT YOUR CODE HERE
            int type = node.getNodeType();
            String name = node.getNodeName();
            String value = node.getNodeValue();

            switch (type) {
                case Node.ELEMENT_NODE: {
                    out.print(name);
                    NodeList children = node.getChildNodes();
                    for (int i = 0; i < children.getLength(); i++) {
                        Node child = children.item(i);
                        print(child, out);
                    }
                    break;
                }

                case Node.TEXT_NODE:
                    out.print(value);
                    break;

            }
        }
    }

    public static class XMLPrinter extends Printer {

        @Override
        public void print(Node node, PrintWriter out) {
            // INSERT YOUR CODE HERE
            int type = node.getNodeType();
            String name = node.getNodeName();
            String value = node.getNodeValue();

            switch (type) {
                case Node.ELEMENT_NODE:
                    out.print("<" + name + ">");
                    NodeList children = node.getChildNodes();
                    for (int i = 0; i < children.getLength(); i++) {
                        Node child = children.item(i);
                        print(child, out);
                    }
                    out.print("</" + name + ">");

                    break;
                case Node.TEXT_NODE:
                    out.print(value);
                    break;
            }
        }
    }

    public static class HTMLPrinter extends Printer {

        @Override
        public void print(Node node, PrintWriter out) {
            // INSERT YOUR CODE HERE
            int type = node.getNodeType();
            String name = node.getNodeName();
            String value = node.getNodeValue();
            switch (type) {
                case Node.ELEMENT_NODE:
                    if (name.equals("users")) {
                        name = "table";
                    } else if (name.equals("user")) {
                        name = "tr";
                    } else {
                        name = "td";
                    }

                    out.print("<" + name + ">");
                    if (name.equals("table")) {
                        out.print("\n<tr><td>Email</td><td>Name</td><td>Password</td><td>DOB</td><td>Type</td></tr>");
                    }
                    NodeList children = node.getChildNodes();
                    for (int i = 0; i < children.getLength(); i++) {
                        Node child = children.item(i);
                        print(child, out);
                    }
                    out.print("</" + name + ">");
                    break;
                case Node.TEXT_NODE:
                    out.print(value);
                    break;
            }
        }
    }
}
