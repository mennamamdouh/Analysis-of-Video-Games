DROP TABLE IF EXISTS game_sales;

CREATE TABLE game_sales (
  game VARCHAR(100) PRIMARY KEY,
  platform VARCHAR(64),
  publisher VARCHAR(64),
  developer VARCHAR(64),
  games_sold NUMERIC(5, 2),
  year INT
);

DROP TABLE IF EXISTS reviews;

CREATE TABLE reviews (
    game VARCHAR(100) PRIMARY KEY,
    critic_score NUMERIC(4, 2),   
    user_score NUMERIC(4, 2)
);

DROP TABLE IF EXISTS top_critic_years;

CREATE TABLE top_critic_years (
    year INT PRIMARY KEY,
    avg_critic_score NUMERIC(4, 2)  
);

DROP TABLE IF EXISTS top_critic_years_more_than_four_games;

CREATE TABLE top_critic_years_more_than_four_games (
    year INT PRIMARY KEY,
    num_games INT,
    avg_critic_score NUMERIC(4, 2)  
);

DROP TABLE IF EXISTS top_user_years_more_than_four_games;

CREATE TABLE top_user_years_more_than_four_games (
    year INT PRIMARY KEY,
    num_games INT,
    avg_user_score NUMERIC(4, 2)  
);

LOAD DATA LOCAL INFILE 'game_sales.csv' INTO TABLE game_sales FIELDS TERMINATED BY ',' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE 'game_reviews.csv' INTO TABLE reviews FIELDS TERMINATED BY ',' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE 'top_critic_scores.csv' INTO TABLE top_critic_years FIELDS TERMINATED BY ',' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE 'top_critic_scores_more_than_four_games.csv' INTO TABLE top_critic_years_more_than_four_games FIELDS TERMINATED BY ',' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE 'top_user_scores_more_than_four_games.csv' INTO TABLE top_user_years_more_than_four_games FIELDS TERMINATED BY ',' IGNORE 1 ROWS;
