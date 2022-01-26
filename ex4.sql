SELECT date_of_creation, amount, type
FROM (
    SELECT
        to_char(date_of_creation, 'Month YYYY') AS date_of_creation,
        count(*) AS amount,
        'vacancy' AS type
    FROM vacancy
    GROUP BY to_char(date_of_creation, 'Month YYYY')
    ORDER BY count(*) DESC
    LIMIT 1
) AS max_amount_vacancy
UNION (
    SELECT
		to_char(date_of_creation, 'Month YYYY'),
                count(*) AS amount,
                'resume' AS type
    FROM resume
    GROUP BY to_char(date_of_creation, 'Month YYYY')
    ORDER BY count(*) DESC
    LIMIT 1
);

------------------------------------------------------------------------------------------

 -- количество вакансий по месяцам
with vacancy_cnt_per_month AS (
        SELECT
                date_trunc('month',date_of_creation) AS month,
                count(*) vacancy_cnt
        FROM vacancy v
        GROUP BY date_trunc('month',date_of_creation)
),
 -- месяцы с максимальным количеством вакансий (их может быть несколько)
vacancy_max_cnt_month AS (
        SELECT
                string_agg(to_char(v.month,'Month YYYY'), ', ') AS vacancy_max_month
        FROM vacancy_cnt_per_month v,
                (SELECT
                        max(vacancy_cnt) max_cnt
                FROM vacancy_cnt_per_month) t
        WHERE v.vacancy_cnt = t.max_cnt --проверяем количество вакансий за месяц на равенство максимальному кол-ву
),
-- количество резюме по месяцам
resume_cnt_per_month AS (
        SELECT
                date_trunc('month',date_of_creation) AS month,
                count(*) resume_cnt
        FROM resume r
        GROUP BY date_trunc('month',date_of_creation)
),
 -- месяцы с максимальным количеством резюме
resume_max_cnt_month AS (
        SELECT
                string_agg(to_char(r.month,'Month YYYY'), ', ') AS resume_max_month
        FROM resume_cnt_per_month r,
       (SELECT
                max(resume_cnt) max_cnt -- максимальное количество резюме за месяц
        FROM resume_cnt_per_month) t
        WHERE r.resume_cnt = t.max_cnt --проверяем количество резюме за месяц на равенство максимальному количеству
)
 
SELECT
        v.vacancy_max_month AS "Максимальное кол-во вакансий",
        r.resume_max_month AS "Максимальное кол-во резюме"
FROM vacancy_max_cnt_month v, resume_max_cnt_month r;
