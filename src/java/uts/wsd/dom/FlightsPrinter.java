package uts.wsd.dom;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

/**
 *
 * @author Hongming
 */
public class FlightsPrinter {
    
    public static final Printer plain = new PlainPrinter();
    public static final Printer xml = new XMLPrinter();
    public static final Printer html = new HTMLPrinter();
    
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
    public static class PlainPrinter extends FlightsPrinter.Printer {

        public void print(Node node, PrintWriter out) {
            // INSERT YOUR CODE HERE
            int type = node.getNodeType();
            String name = node.getNodeName();
            String value = node.getNodeValue();

            switch (type) {
                case Node.ELEMENT_NODE:
                    out.print(name);
                    NodeList children = node.getChildNodes();
                    for (int i = 0; i < children.getLength(); i++) {
                        print(children.item(i), out);
                    }
                    break;
                case Node.TEXT_NODE:
                    out.print(value);
                    break;
            }
        }
    }

    public static class XMLPrinter extends FlightsPrinter.Printer {

        public void print(Node node, PrintWriter out) {
            // INSERT YOUR CODE HERE
            int type = node.getNodeType();
            String name = node.getNodeName();
            String value = node.getNodeValue();

            switch (type) {
                case Node.ELEMENT_NODE:
                    out.print("<"+name+">");
                    NodeList children = node.getChildNodes();
                    for (int i = 0; i < children.getLength(); i++) {
                        print(children.item(i), out);
                    }
                    out.print("</"+name+">");
                    break;
                case Node.TEXT_NODE:
                    out.print(value);
                    break;
            }
        }
    }

    public static class HTMLPrinter extends FlightsPrinter.Printer {

        public void print(Node node, PrintWriter out) {
            // INSERT YOUR CODE HERE
            int type = node.getNodeType();
            String name = node.getNodeName();
            String value = node.getNodeValue();

            switch (type) {
                case Node.ELEMENT_NODE:
                    if(name.equals("users"))
                        name = "table";
                    else if(name.equals("user"))
                        name = "tr";
                    else
                        name = "td";
                    
                    out.print("<"+name+">");
                    
                    if(name.equals("table"))
                        out.print("\n    <tr><td>FlightID</td><td>dDateTime</td><td>rDateTime</td><td>Type</td><td>Price</td><td>SeatNo</td><td>from</td><td>to</td></tr>");
                    
                    NodeList children = node.getChildNodes();
                    for (int i = 0; i < children.getLength(); i++) {
                        print(children.item(i), out);
                    }
                    
                    out.print("</"+name+">");
                    break;
                case Node.TEXT_NODE:
                    out.print(value);
                    break;
            }
        }
    }
}
