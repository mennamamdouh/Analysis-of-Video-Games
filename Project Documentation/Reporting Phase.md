## This phase is divided into 3 sub-phases ##

### 1. Planning for the insights I want to extract ###

This phase needs strong understanding of each column in each table in the database and what does it represent. After this, the insights start to float.

For this project, I was interested in some points:

  - The total number of games, developers, publishers, platforms, and total profit achieved from these games.
  - The number of games created by each developer, published by each publisher, and produced by each platform
  - The number of games created each year
  - Profit curve over the years
  - Users VS. critics scores over the years

After I've specified these information, I want to extract them from the database.

- - - -

### 2. Extracting the needed information from the database ###

In order to ease the visualization sub-phase, I prefered to extract each information I want into a separate table in the database. At the end, these tables will be exported into csv files to be ready for visualization.

  1. Extracting the needed information from the database into a separate table
      
      To test the information I need, I've selected it from the database first.
      
      For example: number of games over the years
      
        ```
        SELECT year, COUNT(DISTINCT game) AS NumberOfGames FROM game_sales
        GROUP BY year ORDER BY year;
        ```
        
        and get these results
        
        <img src="https://user-images.githubusercontent.com/70551007/216799765-ab886df5-c60f-4c7f-938b-17d6b617438a.png">
        
        Then created a  table where I want to save this information in:
        
        ```
        CREATE TABLE gamesVSyears(
          releasedYear INT,
          NumberOfGames INT
        );
        ```
        
        Then, inserted the information into the table:
        
        ```
        INSERT INTO gamesVSyears(releasedYear, NumberOfGames)
          SELECT year, COUNT(DISTINCT game) AS NumberOfGames FROM game_sales
          GROUP BY year ORDER BY year;
        ```
        Finally, the table is ready.
        
        <br>
                
  2. Exporting the table which I've created in the database to csv file

        To do this task I've run this query:
        
        ```
        SELECT * FROM gamesVSyears
        INTO OUTFILE 'path\gamesVSyears.csv'
        FIELDS TERMINATED BY ','
        ENCLOSED BY '"'
        LINES TERMINATED BY '\n';
        ```
        
        And the csv file is ready in the selected path.
        
- - - -

### 3. Visualizing the information I've extracted ###
