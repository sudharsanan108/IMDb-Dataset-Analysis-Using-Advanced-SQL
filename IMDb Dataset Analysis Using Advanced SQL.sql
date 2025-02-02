SELECT COUNT(*) AS movie_records FROM movie;

SELECT COUNT(*) AS genre_records FROM genre;

SELECT COUNT(*) AS director_mapping_records FROM director_mapping;

SELECT COUNT(*) AS role_mapping_records FROM role_mapping; 

SELECT COUNT(*) AS names_records FROM names;

SELECT COUNT(*) AS records FROM ratings;
SELECT 
   COUNT(*) - COUNT(title) AS null_count_title,
   COUNT(*) - COUNT(year) AS null_count_year,
   COUNT(*) - COUNT(date_published) AS null_count_published,
   COUNT(*) - COUNT(duration) AS null_count_duration,
   COUNT(*) - COUNT(country) AS null_count_country,
   COUNT(*) - COUNT(languages) AS null_count_lang,
   COUNT(*) - COUNT(production_company) AS null_count_company
FROM movie;
SELECT YEAR(date_published) AS year, 
       MONTH(date_published) AS month, 
       COUNT(id) AS totalmovies 
FROM movie
GROUP BY YEAR(date_published), MONTH(date_published)
ORDER BY YEAR(date_published), MONTH(date_published);
SELECT COUNT(*) 
FROM movie
WHERE (country = 'usa' OR country = 'india') 
AND YEAR(date_published) = 2019;
SELECT g.genre AS unique_genre, COUNT(m.id) AS movie_count
FROM genre g
JOIN movie m ON g.movie_id = m.id
GROUP BY g.genre
ORDER BY movie_count DESC;
select genre,count(genre) as highest_total
from genre 
group by genre
order by highest_total desc limit 1 ;
SELECT g.genre AS genre_name, AVG(m.duration) AS average_duration
FROM genre g
JOIN movie m ON g.movie_id = m.id
GROUP BY g.genre;
SELECT n.name, 
       COUNT(rm.movie_id) AS movie_count, 
       AVG(rt.avg_rating) AS average_rating
FROM role_mapping rm
JOIN ratings rt ON rm.movie_id = rt.movie_id  
JOIN names n ON rm.name_id = n.id
WHERE rt.avg_rating < 5  
GROUP BY rm.name_id, n.name
HAVING COUNT(rm.movie_id) > 3;  
SELECT 
  MIN(avg_rating) AS min_avg_rating,
  MAX(avg_rating) AS max_avg_rating,
  MIN(total_votes) AS min_total_votes,
  MAX(total_votes) AS max_total_votes,
  MIN(median_rating) AS min_median_rating,
  MAX(median_rating) AS max_median_rating
FROM ratings;
SELECT m.title, rt.avg_rating
FROM movie m 
JOIN ratings rt ON m.id = rt.movie_id
ORDER BY rt.avg_rating DESC
LIMIT 10;
SELECT rt.median_rating,count(rt.movie_id) as movie_count
FROM ratings rt
GROUP BY rt.median_rating
ORDER BY rt.median_rating;
SELECT COUNT(m.id) AS movie_count
FROM movie m
JOIN ratings rt ON m.id = rt.movie_id
JOIN genre g ON m.id = g.movie_id  
WHERE m.country = 'usa'
  AND m.date_published BETWEEN '2017-03-01' AND '2017-03-31'
  AND g.genre = 'drama'
  AND rt.total_votes > 1000;
SELECT m.title, g.genre, r.avg_rating
FROM movie m
JOIN genre g ON m.id = g.movie_id
JOIN ratings r ON m.id = r.movie_id
WHERE m.title LIKE 'The%' 
  AND r.avg_rating > 8
ORDER BY g.genre, r.avg_rating DESC;
SELECT count(*) AS total_movies
FROM movie m 
join ratings r on m.id = r.movie_id
BETWEEN '2018-04-01' AND '2019-04-01'
AND r.median_rating = 8;
SELECT country,avg(r.total_votes) AS average_votes
FROM movie m 
join ratings r on m.id = r.movie_id
WHERE m.country IN ('Germany','Italy')
GROUP BY m.country;
SELECT 
  COUNT(CASE WHEN id IS NULL THEN 1 END) AS id_nulls,
  COUNT(CASE WHEN name IS NULL THEN 1 END) AS name_nulls,
  COUNT(CASE WHEN date_of_birth IS NULL THEN 1 END) AS date_of_birth_nulls,
  COUNT(CASE WHEN known_for_movies IS NULL THEN 1 END) AS known_for_movies_nulls
FROM NAMES;
SELECT n.name AS actor_name, r.median_rating
FROM director_mapping d 
JOIN NAMES n ON n.id = d.name_id
JOIN ratings r ON r.movie_id = d.movie_id
WHERE r.median_rating >= 8
ORDER BY r.median_rating DESC
LIMIT 2;

SELECT m.production_company,
       SUM(r.total_votes) AS total_votes
FROM movie m 
JOIN ratings r ON m.id = r.movie_id
GROUP BY m.production_company
ORDER BY total_votes DESC
LIMIT 3;
SELECT COUNT(*) AS directors_with_more_than_three_movies
FROM (
    SELECT name_id
    FROM director_mapping
    GROUP BY name_id
    HAVING COUNT(DISTINCT movie_id) > 3
) AS director_count;
SELECT rm.category,
       AVG(n.height) AS average_height
FROM role_mapping rm
JOIN names n ON rm.name_id = n.id
GROUP BY rm.category;
SELECT m.title, 
       m.country, 
       n.name AS director, 
       m.date_published
FROM movie m
JOIN director_mapping d ON m.id = d.movie_id
JOIN names n ON d.name_id = n.id
ORDER BY m.date_published ASC
LIMIT 10;
SELECT m.title, r.total_votes, g.genre
FROM movie m
JOIN ratings r ON m.id = r.movie_id
JOIN genre g ON m.id = g.movie_id
ORDER BY r.total_votes DESC
LIMIT 5;




select m.title,g.genre,m.production_company,m.duration
from movie m 
join genre g 
on m.id = g.movie_id
order by m.duration desc limit 1;

SELECT m.title, SUM(r.total_votes) AS total_votes
FROM movie m
JOIN ratings r
 ON m.id = r.movie_id
WHERE m.year = '2018'
GROUP BY m.title;
SELECT languages, COUNT(languages) AS court_lang
FROM movie
GROUP BY languages
ORDER BY court_lang DESC
LIMIT 2;






