
CREATE TABLE hh_user(
        user_id SERIAL PRIMARY KEY,
        login VARCHAR(100) unique NOT NULL,
        password_hash VARCHAR(100) NOT NULL
);

CREATE TABLE area(
        area_id SERIAL PRIMARY KEY,
        area_name VARCHAR(50) NOT NULL
);

CREATE TABLE employer(
        employer_id SERIAL PRIMARY KEY,
        user_id INTEGER NOT NULL REFERENCES hh_user(user_id),
        employer_name VARCHAR(100) NOT NULL,
        description TEXT,
        site VARCHAR(200)
);	

CREATE TABLE applicant(
        applicant_id SERIAL PRIMARY KEY,
        user_id INTEGER NOT NULL REFERENCES hh_user(user_id),
        applicant_name VARCHAR(100) NOT NULL,
        area_id INTEGER NOT NULL REFERENCES area(area_id),
        date_of_birth DATE 
);

CREATE TABLE specialization(
        specialization_id SERIAL PRIMARY KEY,
        specialization_name VARCHAR(100) NOT NULL
);

CREATE TABLE skills(
        skill_id SERIAL PRIMARY KEY,
        skill_name VARCHAR(100) NOT NULL
);


CREATE TABLE vacancy(
        vacancy_id SERIAL PRIMARY KEY,
        employer_id INTEGER NOT NULL REFERENCES employer(employer_id),
        area_id INTEGER NOT NULL REFERENCES area(area_id),
	date_of_creation timestamp with time zone,
        position_name VARCHAR(100) NOT NULL,
        specialization_id INTEGER NOT NULL REFERENCES specialization(specialization_id),
        compensation_from INTEGER,
        compensation_to INTEGER,
        compensation_gross BOOLEAN,
        description TEXT,
        required_work_experience TEXT,
        is_active BOOLEAN NOT NULL
);
 
CREATE TABLE skills_for_vacancy(
        vacancy_id INTEGER NOT NULL REFERENCES vacancy(vacancy_id),
        skill_id INTEGER NOT NULL REFERENCES skills(skill_id)
);

CREATE TABLE resume(
        resume_id SERIAL PRIMARY KEY,
        applicant_id INTEGER NOT NULL REFERENCES applicant(applicant_id),
	date_of_creation timestamp with time zone,
        specialization_id INTEGER NOT NULL REFERENCES specialization(specialization_id),
        phone_number VARCHAR(20) NOT NULL,
        email VARCHAR(100),
        education TEXT,
        work_experience TEXT,
        description TEXT,
        compensation_from INTEGER,
        compensation_to INTEGER
);

CREATE TABLE skills_in_resume(
        resume_id INTEGER NOT NULL REFERENCES resume(resume_id),
        skill_id INTEGER NOT NULL REFERENCES skills(skill_id)
);

CREATE TABLE response(
        response_id SERIAL PRIMARY KEY,
        vacancy_id INTEGER NOT NULL REFERENCES vacancy(vacancy_id),
        resume_id INTEGER NOT NULL REFERENCES resume(resume_id),
        date_of_creation TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

