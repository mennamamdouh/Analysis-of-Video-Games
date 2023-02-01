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

- - - -

#### 3. Years that video game critics loved ####

&ensp;&thinsp;&ensp;&thinsp;Those years are the years which have the highest average critics scores.

&ensp;&thinsp;&ensp;&thinsp;To find them, game_scores table and reviews table must get joined together as the previous question, but in this point we need the mutual information between them. So, the INNER JOIN takes place.

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

