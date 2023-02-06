## This phase is divided into 3 sub-phases ##

### 1. Planning for the insights I want to extract ###

This phase needs strong understanding of each column in each table in the database and what does it represent. After this, the insights start to float.

For this project, I was interested in some points:

  - The total number of games, developers, publishers, platforms, and total profit achieved from these games.
  - The number of games created by each developer, and produced by each platform
  - The number of games created each year
  - Profit curve over the years
  - Users VS. critics scores over the years

After I've specified these information, I want to extract them from the database.

- - - -

### 2. Extracting the needed information from the database ###

In order to ease the visualization sub-phase, I prefered to extract each information I want into a separate csv file to be ready for visualization.

  1. Showing the needed information to ensure its form
            
      For example: number of games released each year
      
        ```
        SELECT year, COUNT(DISTINCT game) AS NumberOfGames FROM game_sales
        GROUP BY year ORDER BY year;
        ```
        
        I've got these results, and been sure that this is the data I need for visualization
        
        <img src="https://user-images.githubusercontent.com/70551007/216799765-ab886df5-c60f-4c7f-938b-17d6b617438a.png">

        <br>
                
  2. Extracting this information to a csv file

        To do this task I've run this query:
        
        ```
        SELECT 'year', 'num_of_games'
        UNION
        (
            SELECT year, COUNT(DISTINCT game)
            INTO OUTFILE 'path\gamesVSyears.csv'
            FIELDS TERMINATED BY ','
            ENCLOSED BY '"'
            LINES TERMINATED BY '\n'
            FROM game_sales
                GROUP BY year ORDER BY year
        );
        ```
        
        Now, the csv file is ready in the selected path, and I've been sure that the data is extracted correctly and here's a sample of it.
                
        <img src="https://user-images.githubusercontent.com/70551007/217109648-c59b3482-17e7-4c39-a248-a6fe74d98578.png">


        
- - - -

### 3. Visualizing the information I've extracted ###
