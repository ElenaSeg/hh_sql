with vacancy_random(id, employer_id, specialization_id, compensation_to, date_time,  area_id) AS (
    SELECT
        generate_series(1, 10000) AS id,
                round(random() * 2 + 1) AS employer_id,
                (random() * 5 + 1) AS specialization_id,
        round(random() * 200000 + 25000) AS compensation,
        now() - random() * (timestamp '2018-01-01 00:00:00' - timestamp '2016-01-01 00:00:00') AS date_of_creation ,
        round(random() * 10 + 1) AS area_id
)
INSERT INTO
    vacancy(employer_id,specialization_id ,compensation_to, date_of_creation, position_name, area_id, is_active)
SELECT employer_id, specialization_id, compensation_to, date_time, 'worker', area_id, true FROM vacancy_random;

----------------------------------------------------------------------------------------

with resume_random(id, applicant_id, compensation_from, date_time,  area_id) AS (
    SELECT
        generate_series(1, 100000) AS id,
                round(random() * 10 + 1) AS applicant_id,
        round(random() * 200000 + 25000) AS compensation,
        now() - random() * (timestamp '2018-01-01 00:00:00' - timestamp '2016-01-01 00:00:00') AS date_of_creation ,
        round(random() * 10 + 1) AS area_id
)
INSERT INTO
    resume(applicant_id,specialization_id ,compensation_from, date_of_creation, phone_number )
SELECT applicant_id, 1, compensation_from, date_time, 222244 FROM resume_random;
