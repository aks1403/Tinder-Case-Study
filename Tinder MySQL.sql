CREATE DATABASE tinder;
USE tinder;

# Importing the users and matches tables
SHOW tables;
SELECT * FROM users;
SELECT * FROM matches;

# Task1: Write a query to print the name and details of all the users to whom a particular user has sent request.

SELECT u.name, u.age, u.city FROM users u INNER JOIN matches m ON u.user_id = m.target_id WHERE sender_id = 1;

# Task2: Write a query to find the name of the user who has sent 2nd most number of requests, also print the count.

CREATE VIEW very_single AS
SELECT sender_id, COUNT(*) AS no_of_req FROM matches
GROUP BY sender_id ORDER BY no_of_req DESC LIMIT 1,1;

SELECT * FROM very_single;

SELECT u.user_id, u.name, u.city, u.age, v.no_of_req FROM very_single v INNER JOIN users u ON  v.sender_id = u.user_id ;



# Task3: Find the name of the user(s) who has received minimum and maximum number of requests

CREATE VIEW req_received AS
SELECT target_id, COUNT(*) AS no_of_req FROM matches GROUP BY target_id;

# Minimum requests received
SELECT u.user_id, u.name, u.city, u.age, b.no_of_req FROM users u INNER JOIN 
(SELECT * FROM req_received WHERE no_of_req = (SELECT MIN(no_of_req) FROM req_received)) b 
ON u.user_id = b.target_id;

# Maximum requests received
SELECT u.user_id, u.name, u.city, u.age, b.no_of_req FROM users u INNER JOIN 
(SELECT * FROM req_received WHERE no_of_req = (SELECT MAX(no_of_req) FROM req_received)) b 
ON u.user_id = b.target_id;



# Task 4: Find all the matches for each user

SELECT
    u1.name AS sender_name, u2.name AS target_name, m1.sender_id, m1.target_id
FROM
    matches m1
JOIN
    matches m2 ON m1.sender_id = m2.target_id AND m1.target_id = m2.sender_id
JOIN
    users u1 ON m1.sender_id = u1.user_id
JOIN
    users u2 ON m1.target_id = u2.user_id
WHERE
    m1.sender_id < m1.target_id;
    
    
    
# Task 5: People from which cities are most active on Tinder ?

SELECT u.city, COUNT(*) as a FROM users u JOIN matches m ON u.user_id = m.sender_id GROUP BY u.city ORDER BY COUNT(*) DESC;
    

# Task 6: Which age people are most active on Tinder?

SELECT u.age, COUNT(*) FROM users u JOIN matches m ON u.user_id = m.sender_id GROUP BY age ORDER BY COUNT(*) DESC;
    
    
# Task 7: Which body type is mostly chosen by users on tinder?

SELECT u.body_type, COUNT(*) FROM users u JOIN matches m ON u.user_id = m.target_id GROUP BY u.body_type ;


