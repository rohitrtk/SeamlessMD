# README

My technical assignment for SeamlessMD. Objective is to pull data off of an [FHIR server](https://hapi.fhir.org/resource?serverId=home_r4&pretty=false&_summary=&resource=Patient) and display patient information on an HTML page.

HTML page contains a table which displays a patients ID, First Name, Last Name, Gender, Birthdate and Age. Note that sometimes the server doesn't
give out all of this information, most of the time only an ID is given. In the case where information besides the ID is not given, the table displays
the message "No information available" in the cell.
