USE elidek;

DROP TABLE IF EXISTS `institute`;
CREATE TABLE institute (
	inst_id INT UNSIGNED AUTO_INCREMENT,
    inst_name VARCHAR(60) NOT NULL,
	acronym VARCHAR(20),
    inst_type VARCHAR(15) NOT NULL
		CHECK (inst_type="university" OR
			inst_type="corporation" OR 
			inst_type="research center"), # Dokimase to me create domain, to idio kai gia to gender
    street_name VARCHAR(45),
    street_number SMALLINT UNSIGNED,
    town VARCHAR(45),
    postal_code INT UNSIGNED,
    PRIMARY KEY (inst_id)
);
DROP TABLE IF EXISTS `university`;
CREATE TABLE university (
	uni_id INT UNSIGNED NOT NULL,
    ministry_budget INT UNSIGNED,
    FOREIGN KEY (uni_id) REFERENCES institute (inst_id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (uni_id)
);
DROP TABLE IF EXISTS `corporation`;
CREATE TABLE corporation (
	corp_id INT UNSIGNED NOT NULL,
    capital INT UNSIGNED,
    FOREIGN KEY (corp_id) REFERENCES institute (inst_id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (corp_id)
);
DROP TABLE IF EXISTS `research_center`;
CREATE TABLE research_center (
	center_id INT UNSIGNED NOT NULL,
    private_budget INT UNSIGNED,
    ministry_budget INT UNSIGNED,
    total_budget INT UNSIGNED GENERATED ALWAYS AS (private_budget+ministry_budget),
    FOREIGN KEY (center_id) REFERENCES institute (inst_id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (center_id)
);

DROP TABLE IF EXISTS `researcher`;
CREATE TABLE researcher (
	researcher_id INT UNSIGNED AUTO_INCREMENT,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    gender VARCHAR(6) NOT NULL, 
    birthday DATE DEFAULT (DATE_SUB(CURRENT_DATE(), INTERVAL 18 YEAR)) ,
    age INT GENERATED ALWAYS AS (TIMESTAMPDIFF(YEAR, birthday , CURRENT_DATE())),
    PRIMARY KEY (researcher_id)
);

DROP TABLE IF EXISTS `elidek_manager`;
CREATE TABLE elidek_manager (
	manager_id INT UNSIGNED AUTO_INCREMENT,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    gender VARCHAR(6) NOT NULL, #dokimase create domain gender varchar(6) constraint binary check (value in ('female','male'))
    birthday DATE NOT NULL,
    elidek_address VARCHAR(45) NOT NULL,
    PRIMARY KEY (manager_id)
);

DROP TABLE IF EXISTS `funding_program`;
CREATE TABLE funding_program (
	program_id INT UNSIGNED AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    budget BIGINT UNSIGNED,
    elidek_address VARCHAR(100),
    PRIMARY KEY (program_id)
);
DROP TABLE IF EXISTS `research`;
CREATE TABLE research (
	research_id INT UNSIGNED AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    summary VARCHAR(1500) DEFAULT ' ',
    start_date DATE NOT NULL DEFAULT (CURRENT_DATE()),
    end_date DATE NOT NULL DEFAULT (DATE_ADD(CURRENT_DATE(), INTERVAL 1 YEAR)),
	CHECK(start_date < end_date),
    duration INT DEFAULT (TIMESTAMPDIFF(MONTH, start_date, end_date)) CHECK (12<=duration AND duration<=48),
    inst_id INT UNSIGNED,
	senior_scientist_id INT UNSIGNED NOT NULL,
	budget INT UNSIGNED CHECK (100000<=budget and budget<=1000000),
    manager_id INT UNSIGNED,
	program_id INT UNSIGNED,
    FOREIGN KEY (inst_id) REFERENCES institute (inst_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (senior_scientist_id) REFERENCES researcher (researcher_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (manager_id) REFERENCES elidek_manager (manager_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (program_id) REFERENCES funding_program (program_id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (research_id)
)DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `institute_worker`;
CREATE TABLE institute_worker (
	worker_id INT UNSIGNED NOT NULL,
    inst_id INT UNSIGNED NOT NULL,
    start_date DATE DEFAULT (CURRENT_DATE()),
    FOREIGN KEY (worker_id) REFERENCES researcher (researcher_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (inst_id) REFERENCES institute (inst_id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (worker_id, inst_id)
);

DROP TABLE IF EXISTS `is_about`;
CREATE TABLE is_about (
    research_id INT UNSIGNED,
    science_field_id INT UNSIGNED,
    FOREIGN KEY (research_id) REFERENCES research (research_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (science_field_id) REFERENCES science_field (field_id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (research_id, science_field_id)
);
DROP TABLE IF EXISTS `telephone`;
CREATE TABLE telephone (
	tel_id INT UNSIGNED AUTO_INCREMENT,
	tel_number VARCHAR(15) NOT NULL,
    inst_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (inst_id) REFERENCES institute (inst_id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (tel_id)
);

DROP TABLE IF EXISTS `research_worker`;
CREATE TABLE research_worker(
	worker_id INT UNSIGNED NOT NULL,
    research_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (worker_id) REFERENCES researcher (researcher_id) ,
    FOREIGN KEY (research_id) REFERENCES research (research_id) ,
    PRIMARY KEY (worker_id, research_id)
);
DROP TABLE IF EXISTS `review`;
CREATE TABLE review (
	researcher_id INT UNSIGNED NOT NULL,
    research_id INT UNSIGNED NOT NULL,
    grade SMALLINT UNSIGNED NOT NULL,
    review_date DATE NOT NULL,
    FOREIGN KEY (researcher_id) REFERENCES researcher (researcher_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (research_id) REFERENCES research (research_id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (researcher_id, research_id)
);
DROP TABLE IF EXISTS `report`;
CREATE TABLE report (
	report_id INT UNSIGNED AUTO_INCREMENT,
    title VARCHAR(45) NOT NULL,
    summary VARCHAR(1000) DEFAULT ' ',
    deadline DATE NOT NULL,
    research_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (research_id) REFERENCES research (research_id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (report_id)
);
