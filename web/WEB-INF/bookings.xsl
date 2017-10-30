<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Document   : bookings.xsd
    Created on : 09/05/2017, 1:37:05 AM
    Author     : XiranLi
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:a="http://learn.it.uts.edu.au/wsd">
    <xsl:output method="html"/>
    <xsl:param name="bgColor"/>
    <xsl:template match="a:bookings">
        <html>
            <head>
                <style>
                    .artist { font-style: italic; margin-bottom: 20px; }
                </style>
            </head>
            <body>
                <xsl:apply-templates/> 
            </body>
        </html>
    </xsl:template>
    <xsl:template match="a:bookings">
        <h2>
            <xsl:apply-templates />
        </h2>
    </xsl:template>
   
    <xsl:template match="a:bookings">
        <table board="1">
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>UserID</th>
                    <th>Username</th>
                    <th>Useremail</th>
                    <th>Date of birth</th>
                    <th>User Type</th>
                    <th>Flight ID</th>
                    <th>Departure date and time </th>
                    <th>Return date and time</th>
                    <th>Class type</th>
                    <th>Ticket price</th>
                    <th>Number of seat</th>
                    <th>Departure city</th>
                    <th>Arrive city</th>
                    <th>Seat number</th>
                    <th>Description</th>
                </tr>
            </thead>
            <tbody>
                
                <xsl:apply-templates/>
            </tbody>
        </table>    		 		
    </xsl:template>

    <xsl:template match="a:bookingID">
        <tr>

        </tr>
        <td>
            <xsl:apply-templates/>
        </td>
        
    </xsl:template>
    	
    <xsl:template match="a:userID">
        <td>
            <xsl:apply-templates/>
        </td>
    </xsl:template>	
    
    <xsl:template match="a:name">
        <td>
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="a:email">
        <td>
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="a:DOB">
        <td>
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="a:password"/>
    
    <xsl:template match="a:type">
        <td>
            <xsl:apply-templates/>
        </td>
    </xsl:template>	
    
    <xsl:template match="a:flightID">
        <td>
            <xsl:apply-templates/>
        </td>
    </xsl:template>	
    
    <xsl:template match="a:dDateTime">
        <td>
            <xsl:apply-templates/>
        </td>
    </xsl:template>	
    
    <xsl:template match="a:dDateTime">
        <td>
            <xsl:apply-templates/>
        </td>
    </xsl:template>	
    
    <xsl:template match="a:rDateTime">
        <td>
            <xsl:apply-templates/>
        </td>
    </xsl:template>	
    
    <xsl:template match="a:type">
        <td>
            <xsl:apply-templates/>
        </td>
    </xsl:template>	
    
    <xsl:template match="a:price">
        <td>
            <xsl:apply-templates/>
        </td>
    </xsl:template>	
    
    <xsl:template match="a:numOfSeats">
        <td>
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="a:from">
        <td>
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="a:to">
        <td>
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="a:seat">
        <td>
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="a:description">
        <td>
            <xsl:apply-templates/>
        </td>
    </xsl:template>

</xsl:stylesheet>