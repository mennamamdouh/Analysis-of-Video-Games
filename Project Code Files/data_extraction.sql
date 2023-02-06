-------------------------------------------------------------------------------------------------------------------------
/*
While exploring the database, I've found that some platforms in the already-existing data belongs to a bigger platform
Those bigger platforms are 6: XBOS, playstation, Atari, GEN, PC, and Nintendo
So, I've decided to create a new column to map each sub-platform to its platform
*/
-------------------------------------------------------------------------------------------------------------------------

-- 1. Adding a new column in the database as it represents the Actual Platform of the existing sub-platforms
ALTER TABLE game_sales
ADD COLUMN ActualPlatform VARCHAR(15);

UPDATE game_sales
SET ActualPlatform = 
    CASE
        WHEN platform like "X%" THEN "XBOX"
        WHEN platform like "PS%" THEN "Playstation"
        WHEN platform = "2600" THEN "Atari"
        WHEN platform like "GEN" THEN "GEN"
        WHEN platform like "PC" THEN "PC"
        ELSE "Nintendo"
    END;

------------------------------------------------------------------------
/*
2. Needed information about:
----------------------------
2.1. platform, subplatform, number of games --> platforms table
2.2. developer, number of games --> developers table
2.3. publisher, number of games --> publishers table
*/
------------------------------------------------------------------------

-- To save the required information into csv files

SELECT 'platform', 'sub_platform', 'num_of_games'
UNION
(
    SELECT ActualPlatform, platform, COUNT(DISTINCT game)
    INTO OUTFILE 'path\platforms.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    FROM game_sales
        GROUP BY ActualPlatform, platform ORDER BY COUNT(DISTINCT game) DESC
);


SELECT 'developer', 'num_of_games'
UNION
(
    SELECT developer, COUNT(DISTINCT game)
    INTO OUTFILE 'path\developers.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    FROM game_sales
        GROUP BY developer ORDER BY COUNT(DISTINCT game) DESC
);


SELECT 'publisher', 'num_of_games'
UNION
(
    SELECT publisher, COUNT(DISTINCT game)
    INTO OUTFILE 'path\publishers.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    FROM game_sales
        GROUP BY publisher ORDER BY COUNT(DISTINCT game) DESC
);

------------------------------------------------------------------------------------------------
/*
3. Needed information about (over years):
-----------------------------------------
3.1. year, number of games --> gamesVSyears table
3.2. total profits, year --> profits table
3.3. users & critics scores, year --> usersVScritics table
3.4. platform, sub_platforms, year, number of games, total profit --> platformsVSyears table
*/
------------------------------------------------------------------------------------------------

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


SELECT 'profit', 'year'
UNION
(
    SELECT SUM(games_sold), year
    INTO OUTFILE 'path\profits.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    FROM game_sales
        GROUP BY year ORDER BY year
);


SELECT 'users_score', 'critics_score', 'year'
UNION
(
    SELECT AVG(R.user_score), AVG(R.critic_score), G.year
    INTO OUTFILE 'path\usersVScritics.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    FROM reviews AS R
        INNER JOIN game_sales AS G
            ON G.game = R.game
        GROUP BY year ORDER BY year
);


SELECT 'platform', 'sub_platform', 'num_of_games', 'year', 'total_profits'
UNION
(
    SELECT ActualPlatform, platform, COUNT(game), year, SUM(games_sold)
    INTO OUTFILE 'path\platformsVSyears.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    FROM game_sales
        GROUP BY ActualPlatform, platform, year
        ORDER BY year
);