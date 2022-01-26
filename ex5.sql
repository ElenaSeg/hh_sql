SELECT
	v.vacancy_id AS id,
	v.position_name AS title
FROM vacancy v, response r 
	WHERE v.vacancy_id = r.vacancy_id 
   	AND r.date_of_creation  BETWEEN v.date_of_creation AND v.date_of_creation + interval '7 day'
GROUP BY v.vacancy_id 
HAVING COUNT(*) > 5;
