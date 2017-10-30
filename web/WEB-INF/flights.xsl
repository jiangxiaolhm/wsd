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
    <xsl:template match="a:flights">
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
   
      	
    <xsl:template match="a:flights">
        <table>
            <thead>
                <tr>
                    <th>Flight ID</th>
                    <th>Depature Date Time</th>
                    <th>Return Date Time</th>
                    <th>Class type</th>
                    <th>Ticket price</th>
                    <th>Number of seat</th>
                    <th>Departure city </th>
                    <th>Arrive city</th>
                </tr>
            </thead>
            <tbody>
                <xsl:apply-templates/>
            </tbody>
        </table>     		 		
    </xsl:template>
    
    <xsl:template match="a:flightID">
        <tr>

        </tr>
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
   
</xsl:stylesheet>