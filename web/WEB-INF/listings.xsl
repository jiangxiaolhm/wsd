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
    <xsl:template match="a:listings">
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
   
      	
    <xsl:template match="a:listings">
                <xsl:apply-templates/>		 		
    </xsl:template>
    
    <xsl:template match="a:listingID">
        <li>
            Listing ID:<xsl:apply-templates/>
        </li>
    </xsl:template>
    	
    <xsl:template match="a:userID">
        <ol>
            User ID: <xsl:apply-templates/>
        </ol>
    </xsl:template>	
    
    <xsl:template match="a:name">
        <ol>
            <ul>
                Full name: <xsl:apply-templates/>
            </ul>
        </ol>
    </xsl:template>	
    
    <xsl:template match="a:email">
        <ol>
            <ul>
                Email: <xsl:apply-templates/>
            </ul>
        </ol>
    </xsl:template>	
    
    <xsl:template match="a:DOB">
        <ol>
            <ul>
                Date of Birth: <xsl:apply-templates/>
            </ul>
        </ol>
    </xsl:template>	
    
    <xsl:template match="a:password"/>
    
    <xsl:template match="a:user/a:type">
        <ol>
            <ul>
                User type: <xsl:apply-templates/>
            </ul>
        </ol>
    </xsl:template>	
    
    <xsl:template match="a:flightID">
        <ol>
            Flight ID: <xsl:apply-templates/>
        </ol>
    </xsl:template>	
    
    <xsl:template match="a:dDateTime">
        <ol>
            <ul>
                Departure date and time: <xsl:apply-templates/>
            </ul>
        </ol>
    </xsl:template>	
    
    <xsl:template match="a:rDateTime">
        <ol>
            <ul>
                Return date and time: <xsl:apply-templates/>
            </ul>
        </ol>
    </xsl:template>	
    
    <xsl:template match="a:type">
        <ol>
            <ul>
                Class type: <xsl:apply-templates/>
            </ul>
        </ol>
    </xsl:template>	
    
    <xsl:template match="a:price">
        <ol>
            <ul>
                Ticket price: <xsl:apply-templates/>
            </ul>
        </ol>
    </xsl:template>	
    
    <xsl:template match="a:numOfSeats">
        <ol>
            <ul>
                Number of seat: <xsl:apply-templates/>
            </ul>
        </ol>
    </xsl:template>	
    
    <xsl:template match="a:from">
        <ol>
            <ul>
                Departure city: <xsl:apply-templates/>
            </ul>
        </ol>
    </xsl:template>	
    
    <xsl:template match="a:to">
        <ol>
            <ul>
                Arrive city: <xsl:apply-templates/>
            </ul>
        </ol>
    </xsl:template>	
    
    <xsl:template match="a:description">
        <ol>
            <ul>
                Description: <xsl:apply-templates/>
            </ul>
        </ol>
    </xsl:template>	

</xsl:stylesheet>
                    
