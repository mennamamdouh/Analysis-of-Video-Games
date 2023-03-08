# Analysis-of-Video-Games

### About the project ###

This project is a guided project from DataCamp (i.e. the data is already prepared and ready to use). The project is about analyzing and getting insights about video games sales, and users and critics reviews. The project's main goal is to answer some questions and get insights about the world of video games with the help of these answers.

<img src="https://img.freepik.com/free-vector/set-objects-related-video-games-neon-linear-style_24908-58670.jpg?w=1380&t=st=1675376871~exp=1675377471~hmac=364fe80b35699101a47dcf53d29391555c393215382a26e4bf81e04615c86940">

- - - -

### How to run the project ? ###

All you need is to install MySQL Server on your machine. The following links will guide you to do this:

&ensp;&thinsp;&ensp;&thinsp;[1. Installing MySQL Server](https://www.javatpoint.com/how-to-install-mysql)

&ensp;&thinsp;&ensp;&thinsp;[2. Connect to MySQL Server using VS Code](https://www.geeksforgeeks.org/how-to-connect-to-mysql-server-using-vs-code-and-fix-errors/)

&ensp;&thinsp;&ensp;&thinsp;&ensp;&thinsp;NOTE: This step is optional, you can work with the server on any software you want.

Then follow the steps in the Project Documentation folder to import the data into the server.

- - - -

### The project is divided into 4 phases ###

1. Importing the data into a database ([Documentation](https://github.com/mennamamdouh/Analysis-of-Video-Games/blob/main/Project%20Documentation/Importing%20the%20database%20into%20MySQL%20Server.md))

    - Creating a database
  
    - Creating tables
  
    - Importing an existing data into the database

2. Data exploration phase ([Documentation](https://github.com/mennamamdouh/Analysis-of-Video-Games/blob/main/Project%20Documentation/Data%20Exploration%20Phase.md))

    - Showing the columns of each table
  
    - Understanding what each column represents
  
    - Showing top records of each table
  
3. Data analysis phase ([Documentation](https://github.com/mennamamdouh/Analysis-of-Video-Games/blob/main/Project%20Documentation/Data%20Analysis%20Phase.md)) -> The phase at which the questions are answered. This is done using:
 
    - SQL simple queries such as SELECT ... FROM ... WHERE, JOINs, Grouping, and Ordering

    - Complex queries such as CTEs and Sub-queries

    - Some aggregate functions such as SUM, AVG, and COUNT

4. Reporting and visualization phase ([Documentaion](https://github.com/mennamamdouh/Analysis-of-Video-Games/blob/main/Project%20Documentation/Reporting%20Phase.md))

    The final report is created using Power BI Desktop software ([Click to have a copy to try filters](https://github.com/mennamamdouh/Analysis-of-Video-Games/blob/main/Video%20Games%20Analysis%20Report.pbix?raw=true)):
    
    <p align="center">
    <img src="https://user-images.githubusercontent.com/70551007/218227985-ac8949b2-a035-4fa9-acd0-7f0711624f5f.png">
    <p/>   
    
    These visualizations have shown me some insights:
            
    + Most games are created by __Nintendo__ and __Playstation__ platforms
    + For most of the years, users' average score are less than critics' average score
    + According to the number of games created, the era of evolution is between __2000__ and __2015__
    + In many years, __Nintendo__ has the same (or more) number of games as __Playstation__ in spite of the more number of developers who work for __Playstation__ (approximately the double)
    + For the last 20 years, __Atari__ and __GEN__ platforms are disappeared
    + The top 10 developers (out of 133) have created more than 37% of the total created games
