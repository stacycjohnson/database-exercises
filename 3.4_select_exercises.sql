USE albums_db;
SHOW TABLES;
SELECT * FROM albums;
SELECT artist, name FROM albums;
-- The name of all ablbums by Pink Floyd
SELECT * FROM albums WHERE artist = 'Pink Floyd';
SELECT name, release_date FROM albums;
-- The year Sgt. Pepper's Lonely Hears Club Band was released.
SELECT release_date FROM albums 
WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';
-- The genre for the album Nevermind.
SELECT genre FROM albums 
WHERE name = 'Nevermind';
-- Which albums were released in the 1990s.
SELECT name,release_date FROM albums WHERE release_date BETWEEN 1990 AND 1999;
-- Which albums had less than 20 million cerified sales.
SELECT name FROM albums WHERE sales < 20000000;
-- All the albums with a genre of "Rock".
SELECT name,genre 
FROM albums;
SELECT name From albums WHERE genre = 'Rock';
-- Because rock is separate category to itself. It also doesn't include multiple categories ie "Rock, Pop, R&B.
SELECT name, genre From albums 
WHERE genre LIKE '%rock%';



