SELECT type, COUNT(*) AS total
FROM netflix
GROUP BY type;

-- Total shows per director--
SELECT director,
       COUNT(*) AS total_shows
FROM netflix_raw
WHERE director IS NOT NULL
GROUP BY director
ORDER BY total_shows DESC;

--Movies vs Tv Shows per Director----
SELECT director,
       COUNT(CASE WHEN type = 'Movie' THEN 1 END) AS movies,
       COUNT(CASE WHEN type = 'TV Show' THEN 1 END) AS tv_shows
FROM netflix_raw
WHERE director IS NOT NULL
GROUP BY director
ORDER BY movies DESC, tv_shows DESC;

-----Top 5 genres with most Movies---

SELECT ng.genre, COUNT(*) AS total_movies
FROM netflix n
INNER JOIN netflix_genre ng ON n.show_id = ng.show_id
WHERE n.type = 'Movie'
GROUP BY ng.genre
ORDER BY total_movies DESC;


-----------Number of Shows Added Per Month-------

SELECT FORMAT(date_added, 'yyyy-MM') AS year_month, COUNT(*) AS total_shows
FROM netflix
WHERE date_added IS NOT NULL
GROUP BY FORMAT(date_added, 'yyyy-MM')
ORDER BY year_month;





