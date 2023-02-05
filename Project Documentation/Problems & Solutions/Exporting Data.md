### All I wanted to do is to export some tables from my database into csv files ###

The commands that do this task is:
```
SELECT field1, field2, ... FROM table_name
INTO OUTFILE 'path\file_name.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
```
The error is

> Error Code: 1290. The MySQL server is running with the –secure-file-priv option so it cannot execute this statement

- - - -
### About the secure-file-priv ###

The --secure-file-priv option is a system variable used by MySQL to limit the ability of the users to export or import data from the database server. It shows some issues when using the command like:

```
LOAD DATA INTO FILE --> This imports data from an external file into the database
```

or

```
SELECT data INTO OUTFILE --> This selects data to export to an external file out of the database
```

- - - -

### To overcome those issues ###
The secure-file-priv parameter is in a system file called 'my.ini' at the path 'C:\ProgramData\MySQL\MySQL Server 8.0'. To solve these problems we've to set this parameter by NULL or "" (empty string).

So, do the following:
1. Open this file (my.ini)
2. Search for secure
3. Set it as empty string as the following image

<img src="https://user-images.githubusercontent.com/70551007/216798759-b6097c6a-90e3-4085-bb81-036d8c1929cf.png">

Then restart your MySQL service and try again to export the data using the commands above.

- - - -

### About the my.ini file ###
You may face an issue about this file, that is it cannot be changed.

After trying to save this file  once you've changed the secure-file-priv parameter this error may occur:

> you don't have permission to open this file

The following link will help you to change the permissions of this file.

[Changing files permissions](https://answers.microsoft.com/en-us/windows/forum/all/windows-10-error-you-dont-have-permission-to-open/91f0d6a8-1766-45a3-a2bd-afea3398cc13)

After that, the file can be saved successfully.
