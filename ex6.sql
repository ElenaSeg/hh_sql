-- Создадим индексы почти на все внешние ключи в таблицах, т.к. эти поля часто используются при соединении таблиц
CREATE INDEX aplcnt_user_id ON applicant(user_id);
CREATE INDEX aplcnt_area_id ON applicant(area_id);

CREATE INDEX employer_user_id ON employer(user_id);

CREATE INDEX response_resume_id ON response(resume_id);
CREATE INDEX response_vacancy_id ON response(vacancy_id);

CREATE INDEX resume_applicant_id ON resume(applicant_id);
CREATE INDEX resume_specialization_id ON resume(specialization_id);

CREATE INDEX skills_vcncy_skill_id ON skills_for_vacancy(skill_id);
CREATE INDEX skills_vcncy_vcncy_id ON skills_for_vacancy(vacancy_id);

CREATE INDEX skills_resume_skill_id ON skills_in_resume(skill_id);
CREATE INDEX skills_resume_vcncy_id ON skills_in_resume(resume_id);

CREATE INDEX vacancy_area_id ON vacancy(area_id);
CREATE INDEX vacancy_specialization_id ON vacancy(specialization_id);

--Кандидат может искать вакансии по названию позиции; вакансии и резюме часто сортируются 
-- по дате создания + запрашиваются за последнюю неделю/месяц, поэтому добавим следующие индексы:
CREATE INDEX vacancy_date_of_creation ON vacancy(date_of_creation);
CREATE INDEX vacancy_is_active ON vacancy(is_active);
CREATE INDEX resume_date_of_creation ON resume(date_of_creation); 

--Когда пользователь на сайте вводит логин и пароль, мы должны проверить на совпадение в бд
CREATE UNIQUE INDEX hh_user_login ON hh_user(login);



