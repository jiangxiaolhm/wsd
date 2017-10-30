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
    <xsl:template match="a:users">
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
   
      	
    <xsl:template match="a:users">
        <table>
            <thead>
                <tr>
                    <th>User ID</th>
                    <th>Full name</th>
                    <th>Email</th>
                    <th>Date of birth</th>
                    <th>Type</th>
                </tr>
            </thead>
            <tbody>
                <xsl:apply-templates/>
            </tbody>
        </table>     		 		
    </xsl:template>
    
    <xsl:template match="a:userID">
        <td>
            <xsl:apply-templates/>
        </td>
    </xsl:template>

    <xsl:template match="a:user">
        <tr>
            <xsl:apply-templates/>
        </tr>
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
    
</xsl:stylesheet>