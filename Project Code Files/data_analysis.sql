-- 1. The ten best-selling video games
SELECT * FROM game_sales ORDER BY games_sold DESC LIMIT 10;


-- 2. Missing reviews scores
SELECT G.game, R.user_score, R.critic_score FROM game_sales AS G
LEFT JOIN reviews AS R
    ON G.game = R.game
WHERE R.user_score IS NULL AND R.critic_score IS NULL

SELECT COUNT(G.game) AS missing_reviews FROM game_sales AS G
LEFT JOIN reviews AS R
    ON G.game = R.game
WHERE R.user_score IS NULL AND R.critic_score IS NULL

-- 3. Years that video game critics loved
SELECT G.year AS ReleaseYear, ROUND(AVG(R.critic_score), 2) AS avg_critic_score
FROM game_sales AS G
INNER JOIN reviews AS R
    ON G.game = R.game
GROUP BY G.year
ORDER BY avg_critic_score DESC
LIMIT 10;

-- 4. The golden age of video games
SELECT COUNT(DISTINCT G.game) AS num_games, G.year AS ReleaseYear,
            ROUND(AVG(R.critic_score), 2) AS avg_critic_score
FROM game_sales AS G
INNER JOIN reviews AS R
    ON G.game = R.game
GROUP BY G.year
    HAVING COUNT(DISTINCT G.game) > 4
ORDER BY avg_critic_score DESC
LIMIT 10;

-- 5. Years that dropped off the critics’ favorites list
WITH first_favourite_list AS (
    SELECT G.year AS ReleaseYear, ROUND(AVG(R.critic_score), 2) AS avg_critic_score
    FROM game_sales AS G
    INNER JOIN reviews AS R
        ON G.game = R.game
    GROUP BY G.year
    ORDER BY avg_critic_score DESC
    LIMIT 10
),

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

SELECT ReleaseYear, avg_critic_score FROM first_favourite_list
EXCEPT
SELECT ReleaseYear, avg_critic_score FROM second_favourite_list
ORDER BY avg_critic_score DESC;

-- 6. Years video game players loved
SELECT COUNT(DISTINCT G.game) AS num_games, G.year AS ReleaseYear,
            ROUND(AVG(R.user_score), 2) AS avg_user_score
FROM game_sales AS G
INNER JOIN reviews AS R
    ON G.game = R.game
GROUP BY G.year
    HAVING COUNT(DISTINCT G.game) > 4
ORDER BY avg_user_score DESC
LIMIT 10;

-- 7. Years that both players and critics loved
SELECT C.year AS favourite_years FROM top_critic_years_more_than_four_games AS C
INNER JOIN top_user_years_more_than_four_games AS U
    ON C.year = U.year;

SELECT year AS favourite_years FROM top_critic_years_more_than_four_games
INTERSECT
SELECT year AS favourite_years FROM top_user_years_more_than_four_games;

-- 8. Sales in the best video game years
SELECT year, SUM(games_sold) AS total_games_sold FROM game_sales
WHERE year IN (SELECT year AS favourite_years FROM top_critic_years_more_than_four_games
                INTERSECT
                SELECT year AS favourite_years FROM top_user_years_more_than_four_games)
GROUP BY year
ORDER BY total_games_sold DESC;