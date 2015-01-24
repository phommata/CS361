DROP TABLE `job_skills`;
DROP TABLE `user_skills`;
DROP TABLE `profile`;
DROP TABLE `job`;
DROP TABLE `skills`;
DROP TABLE `education`;
DROP TABLE `degree`;
DROP TABLE `usr_db`;

/*To store user information */
CREATE TABLE usr_db(
user_id INT(5) NOT NULL AUTO_INCREMENT,
username VARCHAR(50) NOT NULL,
pass VARCHAR(50) NOT NULL,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email_address VARCHAR(50) NOT NULL,
PRIMARY KEY(user_id),
UNIQUE KEY(username)
)ENGINE=InnoDB CHARSET=utf8;

/*To hold the extra profile information */
CREATE TABLE profile(
profile_id INT(5) NOT NULL AUTO_INCREMENT,
user_id INT(5) NOT NULL,
bio TEXT,
experience TEXT,
PRIMARY KEY(profile_id),
FOREIGN KEY(user_id) REFERENCES usr_db(user_id),
UNIQUE KEY(user_id)
)ENGINE=InnoDB CHARSET=utf8;

/*To hold the different degree types */
CREATE TABLE degree(
deg_id INT(5) NOT NULL AUTO_INCREMENT,
deg_name VARCHAR(50) NOT NULL,
PRIMARY KEY(deg_id),
UNIQUE KEY(deg_name)
)ENGINE=InnoDB CHARSET=utf8;

/*To hold the user's education */
CREATE TABLE education(
ed_id INT(5) NOT NULL AUTO_INCREMENT,
user_id INT(5) NOT NULL,
deg_id INT(5) NOT NULL,
concentration VARCHAR(255) NOT NULL,
year INT(4) NOT NULL,
PRIMARY KEY(ed_id),
FOREIGN KEY(user_id) REFERENCES usr_db(user_id),
FOREIGN KEY(deg_id) REFERENCES degree(deg_id),
UNIQUE KEY(user_id, deg_id, concentration)
)ENGINE=InnoDB CHARSET=utf8;

/*To hold all the potential skills - based on only having pre-defined skills for a user to choose from */
CREATE TABLE skills(
skill_id INT(5) NOT NULL AUTO_INCREMENT,
skill_name VARCHAR(75) NOT NULL,
skill_desc VARCHAR(255) NOT NULL,
PRIMARY KEY(skill_id),
UNIQUE KEY(skill_name)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*To tie users and their skills together and hold their rating for the skill*/
CREATE TABLE user_skills(
user_skill_id INT(5) NOT NULL AUTO_INCREMENT,
user_id INT(5) NOT NULL,
skill_id INT(5) NOT NULL,
skill_rating INT(5) NOT NULL,
PRIMARY KEY(user_skill_id),
FOREIGN KEY(user_id) REFERENCES usr_db(user_id),
FOREIGN KEY(skill_id) REFERENCES skills(skill_id),
UNIQUE KEY(user_id, skill_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*To store information about each job */
CREATE TABLE job(
job_id INT(5) NOT NULL AUTO_INCREMENT,
job_name VARCHAR(75) NOT NULL, #job name
job_emp VARCHAR (255) NOT NULL, #employer 
job_desc TEXT NOT NULL, #description
job_pay INT(11) NOT NULL, 
PRIMARY KEY (job_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*To relate jobs to the required skills */
CREATE TABLE job_skills(
job_skill_id INT NOT NULL AUTO_INCREMENT,
job_id INT NOT NULL,
skill_id INT NOT NULL,
FOREIGN KEY(job_id) REFERENCES job(job_id),
FOREIGN KEY(skill_id) REFERENCES skills(skill_id),
UNIQUE KEY(job_id, skill_id), 
PRIMARY KEY(job_skill_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* Inserting dummy data for job table */
INSERT INTO job (job_name, job_emp, job_desc, job_pay) VALUES 
('Database Administrator', 'Oracle', 'Administer databases', '60000'), 
('Junior Application Developer', 'Bristol-Myers Squibb', 'In this position, you will have the opportunity to work and learn from seasoned IT professionals based in Florida, NJ, and Connecticut using the latest technology and application development frameworks to create solutions that enable cutting-edge Pharmaceutical research.', '45000');

/*Inserting dummy data for skills table */
INSERT INTO skills (skill_name, skill_desc) VALUES 
('Java', 'Ability to write java code'), 
('Communication', 'Ability to communicate clearly'), 
('SQL', 'Everything query language');

/* Inserting dummy data for job_skills table */
INSERT INTO job_skills (job_id, skill_id) VALUES 
((SELECT job.job_id FROM job WHERE job_name = "Database Administrator"), (SELECT skill_id FROM skills WHERE skill_name = "SQL")), 
((SELECT job_id FROM job WHERE job_name = "Database Administrator"), (SELECT skill_id FROM skills WHERE skill_name = "Communication")),
((SELECT job_id FROM job WHERE job_name = "Junior Application Developer"), (SELECT skill_id FROM skills WHERE skill_name = "Java")),
((SELECT job_id FROM job WHERE job_name = "Junior Application Developer"), (SELECT skill_id FROM skills WHERE skill_name = "Communication"));

/* TESTING for job_skills*/
INSERT INTO job_skills (job_id, skill_id) VALUES 
(1, 3),
(1, 2),
(2, 2);

/* Inserting dummy data for user table */
INSERT INTO usr_db (username, pass, first_name, last_name, email_address, bio, experience) VALUES 
('sampleuser1', 'pass1', 'Amy', 'Adams', 'fake_amy@test.com', test bio 1, test experience 1), 
('sampleuser2', 'pass2', 'Bob', 'Barker', 'fake_bob@test.com', test bio 2, test experience 2),
('sampleuser3', 'pass3', 'Candy', 'Cane', 'fake_candy@test.com', test bio 3, test experience 3);

INSERT INTO usr_db (username, pass, first_name, last_name, email_address) VALUES 
('sampleuser1', 'pass1', 'Amy', 'Adams', 'fake_amy@test.com'), 
('sampleuser2', 'pass2', 'Bob', 'Barker', 'fake_bob@test.com'),
('sampleuser3', 'pass3', 'Candy', 'Cane', 'fake_candy@test.com');


/* Inserting dummy data for user_skills table */
INSERT INTO user_skills (user_id, skill_id, skill_rating) VALUES 
((SELECT user_id FROM usr_db WHERE username = "sampleuser1"), 
(SELECT skill_id FROM skills WHERE skill_name = "Java"), '4'),
((SELECT user_id FROM usr_db WHERE username = "sampleuser1"), 
(SELECT skill_id FROM skills WHERE skill_name = "Communication"), '2'),
((SELECT user_id FROM usr_db WHERE username = "sampleuser1"), 
(SELECT skill_id FROM skills WHERE skill_name = "SQL"), '5'),
((SELECT user_id FROM usr_db WHERE username = "sampleuser2"), 
(SELECT skill_id FROM skills WHERE skill_name = "Communication"), '5'),
((SELECT user_id FROM usr_db WHERE username = "sampleuser3"), 
(SELECT skill_id FROM skills WHERE skill_name = "Java"), '3'),
((SELECT user_id FROM usr_db WHERE username = "sampleuser3"), 
(SELECT skill_id FROM skills WHERE skill_name = "SQL"), '2'),
((SELECT user_id FROM usr_db WHERE username = "sampleuser3"), 
(SELECT skill_id FROM skills WHERE skill_name = "Communication"), '1');

 /* TESTING for user_skills*/
INSERT INTO user_skills (user_id, skill_id, skill_rating) VALUES 
(1, 1, 4),
(1, 2, 2),
(2, 2, 2),
(2, 3, 5),
(3, 1, 3),
(3, 2, 1);

INSERT INTO degree (deg_name)
VALUES ('BA'), ('BS'), ('MA'), ('MS'), ('MBA'), ('PhD'), ('MD');

/* Inserting dummy data for education table */
INSERT INTO education (user_id, deg_id, concentration, year) VALUES 
((SELECT user_id FROM usr_db WHERE username = "sampleuser1"), 
(SELECT deg_id FROM degree WHERE deg_name = "BA"), 'theater', 2013),
((SELECT user_id FROM usr_db WHERE username = "sampleuser2"), 
(SELECT deg_id FROM degree WHERE deg_name = "BS"), 'communication', 2012),
((SELECT user_id FROM usr_db WHERE username = "sampleuser3"), 
(SELECT deg_id FROM degree WHERE deg_name = "MBA"), 'food science', 2010);

INSERT

/* Query for selecting data for populating user job page ?? (not final) */
SELECT j.job_name, j.job_emp, j.job_desc, j.job_pay, s.skill_name 
FROM job j 
INNER JOIN job_skills js ON j.job_id = js.job_id
INNER JOIN skills s ON js.skill_id = s.skill_id
INNER JOIN user_skills us ON s.skill_id = us.skill_id
INNER JOIN usr_db u ON us.user_id = u.user_id
WHERE u.username = $username


SELECT j.job_name, j.job_emp, j.job_desc, j.job_pay, s.skill_name 
FROM job j 
INNER JOIN job_skills js ON j.job_id = js.job_id
INNER JOIN skills s ON js.skill_id = s.skill_id
INNER JOIN user_skills us ON s.skill_id = us.skill_id
INNER JOIN usr_db u ON us.user_id = u.user_id
WHERE u.username = "sampleuser1";