## This phase is divided into 4 sub-phases ##

### 1. Planning for the insights I want to extract ###

This phase needs strong understanding of each column in each table in the database and what does it represent. After this, the insights start to float.

For this project, I was interested in some points:

  - The total number of games, developers, publishers, platforms, and total profit achieved from these games.
  - Top ten developers according to number of games they created
  - Which platform creates more games and their progress over the years
  - The number of games created each year
  - Profit curve over the years
  - Users VS. critics scores over the years

After I've specified these information, I want to extract them from the database.

- - - -

### 2. Exploring the data I need for visualization ###

It was obvious to me that all the data I need for visualization exists in the files and is already stored in the database, expect one information which is the plaform.

The information about platforms which is stored in the database can be categorized under 6 platforms:

  1. Nintendo
  2. Playstation
  3. XBOX
  4. GEN
  5. Atari
  6. PC

So, I've mapped each sub-platform to its platform and stored it in a column in the database by the following code:

```
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
```

Now, I've all the data I need for visualization
        
- - - -

### 3. Visualizing the information I've extracted ###

For me, this step can be divided into other 3 steps:

  1. Creating visuals and customize them
  2. Planning for the report's final look according to the visuals created (sketch)
  3. Finishing the report

After those 3 steps, I've got many insights about every information I've drawn.

- - - -

### 4. Insights ###

This is the final result of the report

<img src="https://user-images.githubusercontent.com/70551007/218214914-047d45c8-3142-42f8-b7df-96e742faf3de.png">

I've found that:
  
  1. Most games are created by Nintendo and Playstation platforms
  2. For most of the years, users' average score are less than critics' average score
  3. According to the number of games created and total profits, the era of evolution is in 2000 and 2015
  4. For the last 20 years, Atari and GEN platforms are disappeared
  5. Top 10 developers (out of 133) have created more than 37% of the total created games
