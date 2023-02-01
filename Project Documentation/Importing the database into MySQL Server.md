## Steps to import an existing data of a database into MySQL server using VS Code ##

#### 1. Open the database file (.sql) in VS Code and create the database ####
  &ensp;&thinsp;&ensp;&thinsp;In my case, the .sql file contains the queries for creating only the tables of the database. So, I've created the database first.
  
&ensp;&thinsp;&ensp;&thinsp;<img src="https://user-images.githubusercontent.com/70551007/216082547-6cd964e8-bed2-40ad-9c61-2514902f2011.png">
- - - -
#### 2. Then, all I've done is to run the queries of creating the tables as MySQL queries ####

&ensp;&thinsp;&ensp;&thinsp;<img src="https://user-images.githubusercontent.com/70551007/216082880-e88d0172-d631-4278-8074-8297cd3b3521.png" width=70% height=70%>
- - - -
#### 3. After running all queries, I've to ensure that the tables are added successfully ####


&ensp;&thinsp;&ensp;&thinsp;<img src="https://user-images.githubusercontent.com/70551007/216083273-b8a9ae56-12bb-4828-95e7-de37cd2f0f44.png">
- - - -
#### 4. Now is the time for importing the external **csv** files that contain the data I want to store in my database ####

&ensp;&thinsp;&ensp;&thinsp;To do this I've run a query that loads the data stored in each csv file to its corresponding table in the database.

&ensp;&thinsp;&ensp;&thinsp;The query is: ```LOAD DATA LOCAL INFILE 'file_name.csv' INTO TABLE table_name FIELDS TERMINATED BY ',' IGNORE 1 ROWS;```

&ensp;&thinsp;&ensp;&thinsp;&ensp;&thinsp;&ensp;&thinsp;NOTE: The **IGNORE 1 ROWS** is because that the csv file has a header row.

&ensp;&thinsp;&ensp;&thinsp;Then, all queries for loading the data in all tables are written as following:

&ensp;&thinsp;&ensp;&thinsp;<img src="https://user-images.githubusercontent.com/70551007/216084721-ef9d71e5-7857-4ffc-9486-70117ea7897a.png" width=90% height=90%>
- - - -
