## Project tasks ##


#### 1. The ten best-selling video games ####

&ensp;&thinsp;&ensp;&thinsp;This is done by selecting the games from game_sales table depending on the game_sold column.

&ensp;&thinsp;&ensp;&thinsp;```SELECT * FROM game_sales ORDER BY games_sold DESC LIMIT 10;```

&ensp;&thinsp;&ensp;&thinsp;The ten best-selling video games are the games which is on top if we sort the table by game_sold column in descinding order.

&ensp;&thinsp;&ensp;&thinsp;<img src="https://user-images.githubusercontent.com/70551007/216149160-1bf66f27-d2ee-4570-9db5-f41e78a0ecd9.png" width=70%>

- - - -

#### 2. Missing reviews scores ####

&ensp;&thinsp;&ensp;&thinsp;The missing reviews scores are the games which are in game_sales table and don't have user score or critic score, which means that the user_score and critic_score in reviews table are both NULL.

&ensp;&thinsp;&ensp;&thinsp;To extract this information, the 2 tables must get joined together. Since we need the information in game_sales table and not in reviews table, we will LEFT JOIN the 2 tables.

```
  SELECT G.game, R.user_score, R.critic_score FROM game_sales AS G
  LEFT JOIN reviews AS R
      ON G.game = R.game
  WHERE R.user_score IS NULL AND R.critic_score IS NULL
```

&ensp;&thinsp;&ensp;&thinsp;The results will be:

&ensp;&thinsp;&ensp;&thinsp;<img src="https://user-images.githubusercontent.com/70551007/216153907-fcf47cb2-c13c-435b-8c11-e4bf43b2df54.png" width=50%>

&ensp;&thinsp;&ensp;&thinsp;To know their count:

```
  SELECT COUNT(G.game) AS missing_reviews FROM game_sales AS G
  LEFT JOIN reviews AS R
      ON G.game = R.game
  WHERE R.user_score IS NULL AND R.critic_score IS NULL
```

&ensp;&thinsp;&ensp;&thinsp;<img src="https://user-images.githubusercontent.com/70551007/216161154-2ce5186c-93ec-4497-b915-af869a2d463d.png">


- - - -

#### 3. Years that video game critics loved ####

&ensp;&thinsp;&ensp;&thinsp;Those years are the years which have the highest average critics scores.

&ensp;&thinsp;&ensp;&thinsp;To find them, game_scores table and reviews table must get joined together as the previous question, but in this task we need the mutual information between them. So, the INNER JOIN takes place.

```
  SELECT G.year AS ReleaseYear, ROUND(AVG(R.critic_score), 2) AS avg_critic_score
  FROM game_sales AS G
  INNER JOIN reviews AS R
      ON G.game = R.game
  GROUP BY G.year
  ORDER BY avg_critic_score DESC
  LIMIT 10;
```

&ensp;&thinsp;&ensp;&thinsp;The results will be:

&ensp;&thinsp;&ensp;&thinsp;<img src="https://user-images.githubusercontent.com/70551007/216156428-237fc643-8b40-4d38-a5dd-70e77879a4e6.png" width=30%>

- - - -

#### 4. The golden age of video games ####

&ensp;&thinsp;&ensp;This is as same as the previous information, but with the addition of number of video games in each year.

```
  SELECT COUNT(DISTINCT G.game) AS num_games, G.year AS ReleaseYear, ROUND(AVG(R.critic_score), 2) AS avg_critic_score
  FROM game_sales AS G
  INNER JOIN reviews AS R
      ON G.game = R.game
  GROUP BY G.year
      HAVING COUNT(DISTINCT G.game) > 4
  ORDER BY avg_critic_score DESC
  LIMIT 10;
```

&ensp;&thinsp;&ensp;The results will be:

&ensp;&thinsp;&ensp;<img src="https://user-images.githubusercontent.com/70551007/216160566-da0bb0bb-ea36-4416-a48a-0913f69b1e74.png" width=40%>

---

#### 5. First favourite list VS. Second favourite list
&ensp;&thinsp;&ensp;&thinsp;We want to extract the years that are in the critics's first favourite list and are not in their second favourite list due to having four or fewer reviewed games.

&ensp;&thinsp;&ensp;&thinsp;This will be done by comparing the previous two tables and extracting the difference. The steps are as follows:
- Creating a temporary table with the first results

```
WITH first_favourite_list AS (
    SELECT G.year AS ReleaseYear, ROUND(AVG(R.critic_score), 2) AS avg_critic_score
    FROM game_sales AS G
    INNER JOIN reviews AS R
        ON G.game = R.game
    GROUP BY G.year
    ORDER BY avg_critic_score DESC
    LIMIT 10
)
```
- Creating another temporary table with the second results

```
second_favourite_list AS (
    SELECT COUNT(DISTINCT G.game) AS num_games, G.year AS ReleaseYear,
            ROUND(AVG(R.critic_score), 2) AS avg_critic_score
    FROM game_sales AS G
    INNER JOIN reviews AS R
        ON G.game = R.game
    GROUP BY G.year
        HAVING COUNT(DISTINCT G.game) > 4
    ORDER BY avg_critic_score DESC
    LIMIT 10
)
```
- Getting the records which are in the first table and are not in the second table using the EXCEPT clause

```
SELECT ReleaseYear, avg_critic_score FROM first_favourite_list
EXCEPT
SELECT ReleaseYear, avg_critic_score FROM second_favourite_list
ORDER BY avg_critic_score DESC;
```

&ensp;&thinsp;&ensp;&thinsp;&ensp;&thinsp;The results:

&ensp;&thinsp;&ensp;&thinsp;&ensp;&thinsp;<img src="https://user-images.githubusercontent.com/70551007/216186172-914d48a1-be87-4310-9528-24b3e2094090.png" width=30%>

---

#### 6. Years video game players loved ####

&ensp;&thinsp;&ensp;&thinsp;&ensp;&thinsp;This is similar as task number 4 but with users' scores not the critics.

```
SELECT COUNT(DISTINCT G.game) AS num_games, G.year AS ReleaseYear, ROUND(AVG(R.user_score), 2) AS avg_user_score
FROM game_sales AS G
INNER JOIN reviews AS R
    ON G.game = R.game
GROUP BY G.year
    HAVING COUNT(DISTINCT G.game) > 4
ORDER BY avg_user_score DESC
LIMIT 10;
```

&ensp;&thinsp;&ensp;&thinsp;&ensp;&thinsp;The results:

&ensp;&thinsp;&ensp;&thinsp;&ensp;&thinsp;<img src="https://user-images.githubusercontent.com/70551007/216187178-b785aa90-5a99-4b28-963a-413eeecfded5.png" width=40%>

---

#### 7. Years that both players and critics loved ####

&ensp;&thinsp;&ensp;&thinsp;&ensp;&thinsp;This is about the favourite years for both critics and users. This can be done using 2 methods.
- Using INNER JOIN between the 2 tables top_critic_years_more_than_four_games and top_user_years_more_than_four_games

```
SELECT C.year AS favourite_years FROM top_critic_years_more_than_four_games AS C
INNER JOIN top_user_years_more_than_four_games AS U
    ON C.year = U.year;
```

- Using INTERSECT between 2 separate queries

```
SELECT year AS favourite_years FROM top_critic_years_more_than_four_games
INTERSECT
SELECT year AS favourite_years FROM top_user_years_more_than_four_games;
```

&ensp;&thinsp;&ensp;&thinsp;&ensp;&thinsp;Both result the same records.

&ensp;&thinsp;&ensp;&thinsp;&ensp;&thinsp;<img src="https://user-images.githubusercontent.com/70551007/216189193-c938ff48-05ab-405c-8b28-31271ff00aac.png" width=30%>

---

#### 8. Sales in the best video game years ####

&ensp;&thinsp;&ensp;&thinsp;&ensp;&thinsp;The best video game years are the years which are favourite for both critics and users. So we need the list of those years (from the previous task) to get their sales.

&ensp;&thinsp;&ensp;&thinsp;&ensp;&thinsp;To do this, we use the concept of sub-query and its results will be our filter.

```
SELECT year, SUM(games_sold) AS total_games_sold FROM game_sales
WHERE year IN (SELECT year AS favourite_years FROM top_critic_years_more_than_four_games
                INTERSECT
                SELECT year AS favourite_years FROM top_user_years_more_than_four_games)
GROUP BY year
ORDER BY total_games_sold DESC;
```

&ensp;&thinsp;&ensp;&thinsp;&ensp;&thinsp;The results will be:

&ensp;&thinsp;&ensp;&thinsp;&ensp;&thinsp;<img src="https://user-images.githubusercontent.com/70551007/216190451-9ce03deb-53c1-4ee9-94b6-a988ebf5acf7.png" width=30%>
