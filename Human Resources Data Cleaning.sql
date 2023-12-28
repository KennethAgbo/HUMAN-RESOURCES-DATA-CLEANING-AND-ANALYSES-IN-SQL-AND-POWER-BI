CREATE DATABASE Human_resources;

USE Human_resources;

DESCRIBE hr;

-- From my inspection of the hr data, the following columns needs to be cleaned: ï»¿id,'birthdate', 'hire_date','termdate'

-- To CHANGE the ï»¿id to id, apply:
ALTER TABLE hr
CHANGE ï»¿id  Id varchar(40) not null;

-- To MODIFY the birthdate, use
SELECT birthdate FROM hr;

UPDATE hr 
SET birthdate = CASE
WHEN birthdate LIKE  "%/%/%" THEN date_format(str_to_date(birthdate,"%m/%d/%Y"), "%Y-%m-%d")
WHEN birthdate LIKE "%-%-%" THEN date_format(str_to_date(birthdate,"%m-%d-%Y"), "%Y-%m-%d")
ELSE null
END;

ALTER TABLE hr
MODIFY `birthdate` date;


-- To MODIFY hire_date from text datatype to date datatype, apply:
SELECT hire_date FROM hr;

UPDATE hr
SET hire_date = CASE
		WHEN hire_date LIKE  "%/%/%" THEN date_format(str_to_date(hire_date,"%m/%d/%Y"), "%Y-%m-%d")
        ELSE
        date_format(str_to_date(hire_date,"%m-%d-%Y"), "%Y-%m-%d") END;

ALTER TABLE hr
MODIFY `hire_date` date;


-- To modify termdate, apply:
-- NB: termdate was in normal format like %Y-%m-%d so we used "date" instaed of "date_format"
SELECT termdate FROM hr;
UPDATE hr
SET termdate = CASE
WHEN termdate THEN date(str_to_date(termdate,"%Y-%m-%d %H:%i:%s UTC"))
ELSE NULL
END ;

-- NB: Null (in termdate column) refers to the employees still active in services. 

ALTER TABLE hr
MODIFY termdate date; 

DESCRIBE HR;

-- To ADD a new column: use

ALTER TABLE hr
ADD COLUMN age INT AFTER birthdate;

SELECT * FROM hr;

UPDATE hr 
SET age = timestampdiff(Year,birthdate,CURDATE());

SELECT birthdate, age FROM hr;




