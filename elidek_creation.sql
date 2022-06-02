SET FOREIGN_KEY_CHECKS=0;

DROP SCHEMA IF EXISTS elidek;
CREATE SCHEMA elidek;
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
delimiter # 
create trigger update_inst_type after insert on institute for each row 
if new.inst_type = "university" 
then insert into university (uni_id) values (new.inst_id); 
elseif new.inst_type = "corporation" 
then insert into corporation (corp_id) values (new.inst_id); 
else 
insert into research_center (center_id) values (new.inst_id); 
end if#
delimiter ;

INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('1', 'Institute for Language and Speech Processing', 'ILSP', 'research center', 'Artemidos', '6', 'Athens', '15125');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('2', 'Biomedical Sciences Research Center \'Alexander Fleming\'', 'BSRC AI', 'research center', 'Flemming', '34', 'Vari', '16672');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('3', 'Center for the Greek Language', 'CCL', 'research center', 'Karamaouna', '1', 'Thessaloniki', '55132');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('4', 'Chemical Process & Energy Resources Institute', 'CPERI', 'research center', 'Aigialeias', '52', 'Athens', '15125');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('5', 'Hellenic Institute of Transport', 'HIT', 'research center', 'Harilaou Thermi', '6', 'Thessaloniki', '57001');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('6', 'Institute of Applied Biosciences', 'INAB', 'research center', 'Harilaou Thermi', '6', 'Thessaloniki', '57001');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('7', 'Information Technologies Institute', 'ITT', 'research center', 'Harilaou Thermi', '6', 'Thessaloniki', '57001');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('8', 'Institute for Research and Technology, Thessaly', 'IRETETH', 'research center', 'Harilaou Thermi', '6', 'Thessaloniki', '57001');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('9', 'Technological Institute of Crete', 'TEIC', 'university', 'Estauromenos', '0', 'Iraklion', '71410');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('10', 'Mediterranean Agronomic Institute of Chania', 'MAICh', 'research center', 'Makedonias', '1', 'Chania', '73100');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('11', 'National Observatory of Athens', 'NOA', 'research center', 'Lofos Nymphon', '0', 'Athens', '11810');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('12', 'National Centre of Scientific Research \'Demokritos\'', 'NCSR', 'research center', 'Neapoleos', '27', 'Agia Paraskevi', '15341');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('13', 'Space Internetworking Center', 'SPICE', 'research center', 'Panepistimioupoli', '0', 'Xanthi', '67100');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('14', 'Alfa Institute of Biomedical Sciences', 'AIBS', 'corporation', 'Neapoleos', '9', 'Marousi', '15123');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('15', 'American School of Classical Studies at Athens', 'ASCSA', 'corporation', 'ASCSA', '54', 'Souidias', '10676');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('16', 'Athens University of Economics and Business', 'AUEB', 'university', 'Patission', '76', 'Athens', '10434');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('17', 'Aristotle University of Thessaloniki', 'AUT', 'university', 'University Campus', '0', 'Thessaloniki', '54124');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('18', 'University of West Attica', 'UNIWA', 'university', 'Ag. Spyridonos', '0', 'Athens', '12243');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('19', 'Agricultural University of Athens', 'AUA', 'university', 'Iera Odos', '75', 'Athens', '11855');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('20', 'Athens School of Fine Arts', 'ASFA', 'university', 'Pireos', '0', 'Athens', '69100');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('21', 'Democritus University of Thrace', 'DUT', 'university', 'Panepistimioupoli', '0', 'Thrace', '69100');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('22', 'Harokopio University of Athens', 'HUA', 'university', 'Thiseos', '70', 'Kallithea', '17671');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('23', 'National Technical University of Athens', 'NTUA', 'university', 'Stournari', '42', 'Athens', '10682');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('24', 'National and Kapodistrian University of Athens', 'UOA', 'university', 'Panepistimiou', '30', 'Athens', '10679');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('25', 'Hellenic Open University', 'HOU', 'university', 'Par. Aristotelous', '18', 'Patras', '26335');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('26', 'International Hellenic University', 'IHU', 'university', 'N.Moudanion', '14', 'Thessaloniki', '57001');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('27', 'Ionian University', 'IU', 'university', 'Ioannou Theotoki', '72', 'Corfu', '49100');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('28', 'Panteion University', 'PU', 'university', 'Syngrou Av', '136', 'Athens', '17671');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('29', 'University of the Aegean', 'UOTA', 'university', 'Lofos Panepistimiou', '0', 'Mytilene', '81100');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('30', 'University of Crete', 'UOC', 'university', 'Panepistimioupoli Rethymnoy', '0', 'Rethymno', '74100');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('31', 'University of Ioannina', 'UOI', 'university', 'Panepistimioupoli Ioanninon', '0', 'Ioannina', '45110');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('32', 'University of Macedonia', 'UOM', 'university', 'Egnatia Odos', '156', 'Thessaloniki', '54636');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('33', 'University of Patras', 'UOP', 'university', 'Panepistimioupoli Patron', '0', 'Patras', '26504');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('34', 'University of Peloponnese', 'UOP', 'university', 'Karaiskaki', '70', 'Tripoli', '22100');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('35', 'Centre for Research and Technology Hellas', 'CERTH', 'research center', 'Egialias', '52', 'Marousi', '15125');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('36', 'Foundation for Research and Technology', 'FORTH', 'research center', 'N. Plastira', '100', 'Iraklion', '70013');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('37', 'National Hellenic Research Foundation', 'NHRF', 'research center', 'Leof. Vasileos Konstantinou', '48', 'Athens', '11635');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('38', 'Hellenic Centre for Marine Research', 'HCMR', 'research center', 'Athinon', '46', 'Anavyssos', '19013');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('39', 'University of Thessaly', 'UOT', 'university', 'Argonauton kai Filellinon', '0', 'Volos', '38221');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('40', 'Hellenic Pasteur Institute', 'HPI', 'research center', 'Vasillissis Sofias', '127', 'Athens', '11521');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('41', 'Technical University of Crete', 'TUC', 'university', 'Akrotiri Campus', '0', 'Chania', '73100');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('42', 'TEI of Thessaly', 'TEIT', 'university', 'Panagouli and Kiprou', '0', 'Larisa', '41110');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('43', 'Academy of Athens', 'AOA', 'research center', 'Panepistimiou', '28', 'Athens', '10679');
INSERT INTO `elidek`.`institute` (`inst_id`, `inst_name`, `acronym`, `inst_type`, `street_name`, `street_number`, `town`, `postal_code`) VALUES ('44', 'National Centre for Social Research', 'NCSR', 'research center', 'Kratinou', '9', 'Athens', '10552');
update university set ministry_budget =650558 where uni_id =9;
update university set ministry_budget =656915 where uni_id =16;
update university set ministry_budget =482080 where uni_id =17;
update university set ministry_budget =484324 where uni_id =18;
update university set ministry_budget =672030 where uni_id =19;
update university set ministry_budget =740581 where uni_id =20;
update university set ministry_budget =117439 where uni_id =21;
update university set ministry_budget =887026 where uni_id =22;
update university set ministry_budget =273646 where uni_id =23;
update university set ministry_budget =511028 where uni_id =24;
update university set ministry_budget =115252 where uni_id =25;
update university set ministry_budget =148596 where uni_id =26;
update university set ministry_budget =697890 where uni_id =27;
update university set ministry_budget =365654 where uni_id =28;
update university set ministry_budget =131588 where uni_id =29;
update university set ministry_budget =997964 where uni_id =30;
update university set ministry_budget =147765 where uni_id =31;
update university set ministry_budget =203734 where uni_id =32;
update university set ministry_budget =169640 where uni_id =33;
update university set ministry_budget =557926 where uni_id =34;
update university set ministry_budget =542029 where uni_id =39;
update university set ministry_budget =583082 where uni_id =41;
update university set ministry_budget =785170 where uni_id =42;
update research_center set private_budget =803359 , ministry_budget = 975533 where center_id =1;
update research_center set private_budget =416117 , ministry_budget = 368567 where center_id =2;
update research_center set private_budget =309000 , ministry_budget = 342449 where center_id =3;
update research_center set private_budget =172226 , ministry_budget = 869902 where center_id =4;
update research_center set private_budget =425330 , ministry_budget = 996073 where center_id =5;
update research_center set private_budget =939656 , ministry_budget = 980965 where center_id =6;
update research_center set private_budget =513873 , ministry_budget = 322729 where center_id =7;
update research_center set private_budget =304358 , ministry_budget = 948795 where center_id =8;
update research_center set private_budget =869561 , ministry_budget = 783790 where center_id =10;
update research_center set private_budget =859510 , ministry_budget = 160654 where center_id =11;
update research_center set private_budget =345370 , ministry_budget = 148344 where center_id =12;
update research_center set private_budget =432162 , ministry_budget = 788619 where center_id =13;
update research_center set private_budget =222432 , ministry_budget = 159899 where center_id =35;
update research_center set private_budget =272195 , ministry_budget = 389896 where center_id =36;
update research_center set private_budget =255364 , ministry_budget = 823883 where center_id =37;
update research_center set private_budget =404468 , ministry_budget = 134794 where center_id =38;
update research_center set private_budget =427674 , ministry_budget = 208683 where center_id =40;
update research_center set private_budget =805645 , ministry_budget = 953146 where center_id =43;
update research_center set private_budget =162452 , ministry_budget = 459310 where center_id =44;
update corporation set capital =861967 where corp_id =14;
update corporation set capital =171353 where corp_id =15;

DROP TABLE IF EXISTS `researcher`;
CREATE TABLE researcher (
	researcher_id INT UNSIGNED AUTO_INCREMENT,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    gender VARCHAR(6) NOT NULL, #dokimase create domain gender varchar(6) constraint binary check (value in ('female','male'))
    birthday DATE ,
    PRIMARY KEY (researcher_id)
);

INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('1', 'Andreas', 'Agathangelidis', 'Male', '1957-04-15');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('2', 'Christos', 'Aggelopoulos', 'Male', '1961-05-02');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('3', 'Antonia', 'Akoumnianaki', 'Female', '1990-07-23');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('4', 'Alexakis', 'Dimitrios', 'Male', '1963-06-11');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('5', 'Maria', 'Andria', 'Female', '1962-01-21');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('6', 'Georgia', 'Antonopoulou', 'Female', '1956-12-27');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('7', 'Anna', 'Apostolidou', 'Female', '1982-09-24');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('8', 'Ioanna', 'Apostolidou', 'Female', '1977-11-25');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('9', 'Marina', 'Arbi', 'Female', '1979-12-28');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('10', 'Giorgos', 'Bourogiannis', 'Male', '1972-05-10');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('11', 'Georgios', 'Charalambidis', 'Male', '1970-03-02');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('12', 'Giorgos', 'Chatzigeorgiou', 'Male', '1986-07-24');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('13', 'Evangelia', 'Chatzinikolaou', 'Female', '1999-04-29');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('14', 'Georgia', 'Chatzinikolaou', 'Female', '1978-11-27');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('15', 'Eirini', 'Chioti', 'Female', '1955-03-06');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('16', 'Nadia', 'Coutsinas', 'Female', '1956-04-16');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('17', 'Kalliopi', 'Dasyra', 'Female', '1963-01-05');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('18', 'Sotiris', 'Demis', 'Male', '1995-08-07');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('19', 'Myrto', 'Denaxa', 'Female', '1980-08-13');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('20', 'Konstantinos', 'Dimos', 'Male', '1991-06-10');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('21', 'Charalampia', 'Dimou', 'Female', '1966-03-22');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('22', 'Paraskevi', 'Elefanti', 'Female', '1972-01-06');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('23', 'Zoi', 'Erpapazoglou', 'Female', '1974-04-11');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('24', 'Kyriaki-Maria', 'Fameli', 'Female', '1974-02-22');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('25', 'Dimitrios', 'Fidaros', 'Male', '1959-07-27');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('26', 'Michaela', 'Filiou', 'Female', '1969-11-20');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('27', 'Magdalini', 'Fytili', 'Female', '1986-01-08');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('28', 'George', 'Georgiou', 'Male', '1960-09-26');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('29', 'Panos', 'Georgiou', 'Male', '1989-09-04');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('30', 'Artemis', 'Giannakopoulou', 'Female', '1998-07-02');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('31', 'Petros', 'Giastas', 'Male', '1981-06-20');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('32', 'Dimitrios', 'Giataganas', 'Male', '1974-09-24');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('33', 'Gkana', 'Eleni', 'Female', '1989-03-27');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('34', 'Evangelia', 'Gontikaki', 'Female', '1971-08-23');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('35', 'Andreas', 'Gondikas', 'Male', '1996-07-11');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('36', 'Johanne', 'Hizanidis', 'Female', '1984-02-02');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('37', 'Stavros', 'Ioannidis', 'Male', '1997-02-06');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('38', 'Konstantina', 'Kalfa', 'Female', '1966-04-10');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('39', 'Konstantinos', 'Kalogiannis', 'Male', '1978-05-27');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('40', 'Elpida', 'Karaba', 'Female', '1970-12-23');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('41', 'Merkouris', 'Karaliopoulos', 'Male', '1959-09-20');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('42', 'George', 'Karapetsas', 'Male', '1967-10-26');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('43', 'Georgios', 'Katsoprinakis', 'Male', '1961-05-29');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('44', 'Vassiliki', 'Kleftoyanni', 'Female', '1982-08-29');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('45', 'Ioannis', 'Kokkinopoulos', 'Male', '1990-08-31');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('46', 'Maria', 'Koletsi', 'Female', '1992-06-05');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('47', 'Athanasia', 'Kostopoulou', 'Female', '1977-07-11');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('48', 'Panagiotis', 'Kougias', 'Male', '1995-09-03');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('49', 'Konstantinos', 'Kougioumoutzis', 'Male', '1996-06-08');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('50', 'Emmanuel', 'Koukaras', 'Male', '1957-10-15');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('51', 'Vasiliki', 'Kyrargyri', 'Male', '1996-02-21');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('52', 'Ilias', 'Lagkouvardos', 'Male', '1981-10-02');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('53', 'Dimitris', 'Lallas', 'Male', '1979-01-12');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('54', 'Eirini', 'Leriou', 'Female', '1963-12-25');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('55', 'Athina', 'Markou', 'Female', '1973-01-11');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('56', 'Thomas', 'Mazarakos', 'Male', '1975-02-13');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('57', 'Ifigeneia', 'Mellidou', 'Female', '1986-10-15');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('58', 'Dimitra', 'Melissaropoulou', 'Female', '1969-12-31');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('59', 'Charis', 'Mesaritakis', 'Male', '1987-12-23');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('60', 'Chrysoula', 'Michailof', 'Female', '1969-05-18');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('61', 'Vasileios', 'Moulianitis', 'Male', '1960-02-13');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('62', 'Despoina', 'Nazou', 'Female', '1975-12-15');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('63', 'Christos', 'Nikolopoulos', 'Male', '1959-02-03');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('64', 'Christos', 'Orfanos', 'Male', '1973-05-07');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('65', 'Evangelos', 'Pafilis', 'Male', '1970-08-18');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('66', 'Konstantinos', 'Palikaras', 'Male', '1961-07-06');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('67', 'Eleni', 'Panagouli', 'Female', '1990-09-08');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('68', 'Theodora', 'Panou', 'Female', '1999-08-01');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('69', 'Evangelia', 'Pantatosaki', 'Female', '1965-04-15');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('70', 'Katerina', 'Pantavou', 'Female', '1972-06-19');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('71', 'Yiannis', 'Papadopoulos', 'Male', '1998-03-04');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('72', 'Athanasios', 'Papakyriakou', 'Male', '1995-10-30');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('73', 'Anastasia', 'Mpakali', 'Female', '1959-06-03');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('74', 'Katerina', 'Papanikolopoulou', 'Female', '1979-02-26');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('75', 'George', 'Papastefanatos', 'Male', '1982-02-12');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('76', 'Evangelos', 'Pastelakos', 'Male', '1967-10-24');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('77', 'Georgios', 'Pastras', 'Male', '1978-11-03');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('78', 'Theodore', 'Patkos', 'Male', '1980-08-28');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('79', 'Eleftheria', 'Pefani', 'Female', '1994-08-04');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('80', 'Spyros', 'Petrakis', 'Male', '1968-11-24');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('81', 'Victoria', 'Polissidis', 'Female', '1998-03-31');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('82', 'Ioanna', 'Salvarina', 'Female', '1972-05-07');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('83', 'Michalis', 'Sarris', 'Male', '1981-06-25');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('84', 'Maria', 'Savvaki', 'Female', '1979-05-15');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('85', 'Olga', 'Siskou', 'Female', '1993-03-22');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('86', 'Emmanouil', 'Skantzakis', 'Male', '1977-03-26');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('87', 'Christos', 'Sourdis', 'Male', '1988-07-19');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('88', 'Emmanouil', 'Spanakis', 'Male', '1961-05-05');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('89', 'Fotios', 'Spyropoulos', 'Male', '1956-06-25');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('90', 'Eirini', 'Stamouli', 'Female', '1996-06-02');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('91', 'Varvara', 'Sygouni', 'Female', '1995-03-17');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('92', 'Vasileios', 'Takavakoglou', 'Male', '1968-03-29');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('93', 'Riccardo', 'Tomasello', 'Male', '1981-01-09');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('94', 'Konstantinos', 'Tsagarakis', 'Male', '1995-10-18');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('95', 'Kosmas', 'Tsakmakidis', 'Male', '1974-10-07');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('96', 'Michail', 'Tsakos', 'Male', '1998-02-16');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('97', 'Maria', 'Tsoumakidou', 'Female', '1996-07-22');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('98', 'Dimitra', 'Tsoutsou', 'Female', '1969-10-12');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('99', 'Dimitrios', 'Tzeranis', 'Male', '1972-04-22');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('100', 'Vasileios', 'Tzounakas', 'Male', '1975-12-15');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('101', 'Dimitrios', 'Velesiotis', 'Male', '1976-09-07');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('102', 'Zoe', 'Veneti', 'Female', '1983-12-16');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('103', 'Eleni', 'Vergadi', 'Female', '1970-02-22');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('104', 'Frederic', 'Verret', 'Male', '1983-10-20');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('105', 'Mihalis', 'Verykokakis', 'Male', '1979-01-01');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('106', 'Christos', 'Vlachos', 'Male', '1955-06-21');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('107', 'Ioannis', 'Voskos', 'Male', '1995-10-16');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('108', 'Maria', 'Xenitidou', 'Female', '1983-02-10');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('109', 'Andreas', 'Yiotis', 'Male', '1990-04-30');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('110', 'Aikaterini', 'Zombra', 'Female', '1977-09-14');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('111', 'Florrie', 'Dufton', 'Female', '1980-12-30');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('112', 'Juliana', 'Argont', 'Female', '1996-02-24');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('113', 'Umberto', 'De\'Vere - Hunt', 'Male', '1974-02-11');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('114', 'Alexine', 'Galpin', 'Female', '1994-10-10');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('115', 'Nelie', 'Gavrieli', 'Female', '1994-11-30');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('116', 'Phillida', 'Mayling', 'Female', '1972-03-09');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('117', 'Lockwood', 'Buscher', 'Male', '1993-01-20');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('118', 'Benedetta', 'Gollop', 'Female', '1980-06-01');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('119', 'Francine', 'Stobbes', 'Female', '1992-06-05');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('120', 'Eli', 'Seary', 'Male', '1964-10-21');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('121', 'Christopher', 'Tipper', 'Male', '1961-10-31');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('122', 'Perry', 'Harsant', 'Female', '1986-04-05');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('123', 'Malynda', 'Clemonts', 'Female', '1976-06-08');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('124', 'Danica', 'Szubert', 'Female', '1978-03-07');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('125', 'Danica', 'Brundale', 'Female', '1997-06-16');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('126', 'Chandal', 'Shawell', 'Female', '1965-11-18');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('127', 'Rebekkah', 'McGauhy', 'Female', '1964-03-13');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('128', 'Allen', 'Soldan', 'Male', '1997-07-03');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('129', 'Lazaro', 'Sonnenschein', 'Male', '1956-10-30');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('130', 'Bartolemo', 'McWhan', 'Male', '1970-07-11');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('131', 'Hadleigh', 'Mc Kellen', 'Male', '1978-12-14');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('132', 'Amalita', 'Pighills', 'Female', '1991-12-14');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('133', 'Sheelah', 'Fabbro', 'Female', '1956-08-10');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('134', 'Celie', 'Patridge', 'Female', '1968-12-13');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('135', 'Leoline', 'Fincher', 'Female', '1962-04-19');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('136', 'Pippy', 'Lucey', 'Female', '1964-04-05');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('137', 'Tandie', 'Waterstone', 'Female', '1976-06-21');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('138', 'Sanderson', 'Barlthrop', 'Male', '1985-02-02');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('139', 'Jeromy', 'Storah', 'Male', '1960-05-14');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('140', 'Christos', 'Waple', 'Male', '1963-05-17');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('141', 'Hardy', 'Cohen', 'Male', '1985-02-10');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('142', 'Reinald', 'Jessup', 'Male', '1981-10-12');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('143', 'Gawen', 'Circuit', 'Male', '1969-01-05');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('144', 'Keane', 'Flight', 'Male', '1991-04-29');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('145', 'Starr', 'Millthorpe', 'Female', '1960-11-10');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('146', 'Rodrick', 'Gherardini', 'Male', '1996-03-27');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('147', 'Kahaleel', 'Waterhouse', 'Male', '1966-12-12');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('148', 'Forest', 'Jorez', 'Male', '1992-10-19');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('149', 'Dallas', 'Rostron', 'Male', '1969-11-16');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('150', 'Silvana', 'Thowes', 'Female', '1961-03-29');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('151', 'Bastian', 'Pimm', 'Male', '1988-10-02');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('152', 'Sara', 'Reford', 'Female', '1959-11-12');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('153', 'Sharona', 'Gwynn', 'Female', '1976-04-12');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('154', 'Lorain', 'Yurlov', 'Female', '1964-09-25');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('155', 'Stanly', 'Thomesson', 'Male', '1994-10-03');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('156', 'Claudius', 'Metcalfe', 'Male', '1969-09-23');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('157', 'Nessa', 'Quinn', 'Female', '1974-07-08');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('158', 'Tallulah', 'Makeswell', 'Female', '1977-05-08');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('159', 'Cybil', 'Pidgen', 'Female', '1975-07-06');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('160', 'Marty', 'Hargrave', 'Female', '1985-01-29');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('161', 'Gizela', 'Battabee', 'Female', '1955-06-26');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('162', 'Ardisj', 'Bruffell', 'Female', '1980-08-28');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('163', 'Laurel', 'Ritch', 'Female', '1998-10-14');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('164', 'Merle', 'Shiel', 'Male', '1973-06-01');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('165', 'Fredek', 'Breissan', 'Male', '1994-10-31');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('166', 'Kile', 'Sunderland', 'Male', '1968-03-01');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('167', 'Jose', 'Lufkin', 'Male', '1987-02-19');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('168', 'Allie', 'Dellenbach', 'Male', '1995-01-29');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('169', 'Jacob', 'Durn', 'Male', '1994-11-21');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('170', 'Cammy', 'Southward', 'Female', '1966-01-05');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('171', 'Hedvig', 'Ponten', 'Female', '1968-06-10');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('172', 'Emlen', 'McGrail', 'Male', '1973-11-27');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('173', 'Ofelia', 'Laver', 'Female', '1994-11-15');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('174', 'Timi', 'Tattersfield', 'Female', '1963-07-17');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('175', 'Carmine', 'Prophet', 'Male', '1962-07-27');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('176', 'Rosabel', 'Vanichev', 'Female', '1959-07-10');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('177', 'Kennie', 'Sweetenham', 'Male', '1955-03-06');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('178', 'Auroora', 'Leckey', 'Female', '1970-01-17');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('179', 'Appolonia', 'Blei', 'Female', '1969-12-13');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('180', 'Broderick', 'Filyaev', 'Male', '1975-01-20');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('181', 'Mikel', 'Najera', 'Male', '1972-08-19');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('182', 'Carilyn', 'Dowyer', 'Female', '1980-12-25');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('183', 'Ev', 'Gerren', 'Male', '1990-08-26');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('184', 'Annnora', 'Spellacy', 'Female', '1980-09-15');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('185', 'Anatole', 'Rennard', 'Male', '1986-11-01');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('186', 'Nelle', 'Lissandre', 'Female', '1963-06-03');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('187', 'Radcliffe', 'Parmiter', 'Male', '1955-03-21');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('188', 'Beau', 'Leinweber', 'Male', '1985-11-24');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('189', 'Curcio', 'Garlant', 'Male', '1985-10-14');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('190', 'Dredi', 'Kiddy', 'Female', '1999-05-14');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('191', 'Thom', 'Dykins', 'Male', '1970-10-14');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('192', 'Kristian', 'Lorand', 'Male', '1971-06-11');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('193', 'Farrel', 'Bucham', 'Male', '1964-02-01');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('194', 'Odette', 'Cassedy', 'Female', '1996-05-28');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('195', 'Baryram', 'Bowcock', 'Male', '1969-09-15');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('196', 'Ross', 'Lafaye', 'Male', '1983-08-18');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('197', 'Illa', 'Monkeman', 'Female', '1977-01-07');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('198', 'Kimmi', 'Sleney', 'Female', '1995-05-27');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('199', 'Alta', 'Keerl', 'Female', '1961-04-21');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('200', 'Ware', 'Roly', 'Male', '1995-08-01');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('201', 'Joyan', 'Cuerda', 'Female', '1994-04-19');
INSERT INTO `elidek`.`researcher` (`researcher_id`, `first_name`, `last_name`, `gender`, `birthday`) VALUES ('202', 'Susanna', 'Rolston', 'Female', '1964-12-05');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (203, 'Lewie', 'Wikey', 'Male', '1961-11-19');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (204, 'Adan', 'Scholl', 'Male', '1986-11-09');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (205, 'Chelsea', 'Ruddiforth', 'Female', '1984-01-24');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (206, 'Fania', 'Hafner', 'Female', '1968-06-11');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (207, 'Freddie', 'Eddow', 'Male', '1976-03-03');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (208, 'Nickolaus', 'Jeens', 'Male', '1966-12-13');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (209, 'Marleah', 'Houldin', 'Female', '1962-08-10');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (210, 'Ailyn', 'Annandale', 'Female', '1979-10-20');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (211, 'Petra', 'O''Curran', 'Female', '1985-01-18');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (212, 'Roch', 'Laurenceau', 'Female', '1960-10-25');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (213, 'Kassi', 'Bercher', 'Female', '1972-03-22');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (214, 'Shir', 'Josilowski', 'Female', '1961-02-19');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (215, 'Osbourn', 'Tinham', 'Male', '1983-04-03');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (216, 'Patrica', 'Humburton', 'Female', '1971-02-02');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (217, 'Gillie', 'Dimitrescu', 'Female', '1969-01-07');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (218, 'Florry', 'Louthe', 'Female', '1976-06-03');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (219, 'Kevin', 'Breming', 'Male', '1966-10-30');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (220, 'Allx', 'Luty', 'Female', '1984-05-18');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (221, 'Drona', 'Gritskov', 'Female', '1984-04-12');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (222, 'Isadore', 'Peake', 'Male', '1988-01-09');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (223, 'Aubert', 'Tibb', 'Male', '1979-01-13');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (224, 'Elisabetta', 'Fice', 'Female', '1979-06-25');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (225, 'Sherilyn', 'Taggett', 'Female', '1975-01-12');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (226, 'Dyanna', 'Chittim', 'Female', '1974-07-30');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (227, 'Isidoro', 'Halsey', 'Male', '1980-10-28');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (228, 'Ludovico', 'Mitten', 'Male', '1962-07-12');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (229, 'Inglis', 'Nisco', 'Male', '1976-04-15');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (230, 'Randell', 'Beardsall', 'Male', '1964-02-07');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (231, 'Reyna', 'Thurlow', 'Female', '1968-05-14');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (232, 'Demeter', 'Downes', 'Female', '1968-01-30');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (233, 'Hanan', 'MacLaig', 'Male', '1962-02-06');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (234, 'Deck', 'Weymont', 'Male', '1989-08-27');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (235, 'Mallorie', 'Kepe', 'Female', '1973-04-10');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (236, 'Odelinda', 'Buckland', 'Female', '1975-09-23');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (237, 'Eyde', 'Buesden', 'Female', '1970-05-01');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (238, 'Rickey', 'Jeeks', 'Male', '1963-06-12');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (239, 'Lidia', 'Chillcot', 'Female', '1980-04-21');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (240, 'Dniren', 'Bubbins', 'Female', '1980-04-17');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (241, 'Madelene', 'MacLise', 'Female', '1984-09-01');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (242, 'Madge', 'Detheridge', 'Female', '1985-07-31');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (243, 'Laurena', 'Albrooke', 'Female', '1978-03-30');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (244, 'Robb', 'Haddrell', 'Male', '1966-12-18');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (245, 'Sunny', 'Kahler', 'Female', '1982-08-17');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (246, 'Ninnetta', 'Kellar', 'Female', '1984-02-12');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (247, 'Maximilian', 'Scurrah', 'Male', '1979-02-22');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (248, 'Cathryn', 'Mathieson', 'Female', '1966-04-24');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (249, 'Issi', 'Croley', 'Female', '1979-12-28');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (250, 'Miltie', 'Eidelman', 'Male', '1965-03-28');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (251, 'Holmes', 'Dawidsohn', 'Male', '1975-08-05');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (252, 'Cly', 'Cowburn', 'Male', '1971-01-30');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (253, 'Timothee', 'Huntington', 'Male', '1983-03-05');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (254, 'Hieronymus', 'Annable', 'Male', '1985-02-12');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (255, 'Theo', 'Baylie', 'Female', '1969-01-12');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (256, 'Minnie', 'Houlden', 'Female', '1973-09-19');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (257, 'Mitchel', 'Craydon', 'Male', '1978-09-14');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (258, 'Saudra', 'Camilleri', 'Female', '1968-07-20');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (259, 'Waite', 'MacTague', 'Male', '1978-01-25');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (260, 'Dominique', 'Stidson', 'Male', '1961-02-14');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (261, 'Meris', 'Mathieu', 'Female', '1982-03-12');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (262, 'Ron', 'Karel', 'Male', '1977-09-25');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (263, 'Prudence', 'Elcombe', 'Female', '1973-04-06');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (264, 'Edouard', 'Cheves', 'Male', '1963-06-06');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (265, 'Susana', 'Newns', 'Female', '1988-07-01');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (266, 'Gisela', 'Ferrar', 'Female', '1973-07-22');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (267, 'Corena', 'Bannerman', 'Female', '1965-06-06');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (268, 'Sean', 'Copson', 'Male', '1980-12-17');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (269, 'Ardene', 'Hendricks', 'Female', '1986-07-13');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (270, 'Kare', 'Bigley', 'Female', '1963-02-05');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (271, 'Cymbre', 'Strevens', 'Female', '1983-12-27');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (272, 'Avril', 'Greenall', 'Female', '1982-06-13');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (273, 'Swen', 'Gallichiccio', 'Male', '1986-03-08');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (274, 'Nappie', 'Ruilton', 'Male', '1985-05-29');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (275, 'Taffy', 'Please', 'Female', '1966-11-02');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (276, 'Brana', 'MacDowal', 'Female', '1975-09-20');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (277, 'Osbourn', 'Brunetti', 'Male', '1978-02-19');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (278, 'Nev', 'Missington', 'Male', '1982-07-02');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (279, 'Mollee', 'Minillo', 'Female', '1969-10-03');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (280, 'Lemmie', 'de Quesne', 'Male', '1962-01-09');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (281, 'Jemima', 'Lisamore', 'Female', '1975-12-10');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (282, 'Arlana', 'Wilacot', 'Female', '1966-01-19');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (283, 'Merle', 'Nind', 'Female', '1984-07-09');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (284, 'Boote', 'Frankel', 'Male', '1968-02-16');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (285, 'Peyter', 'Pierse', 'Male', '1988-04-11');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (286, 'Adair', 'Ondrus', 'Male', '1962-05-27');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (287, 'Katie', 'Comoletti', 'Female', '1982-09-20');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (288, 'Dulsea', 'Bangley', 'Female', '1968-05-26');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (289, 'Reid', 'Scogings', 'Male', '1972-11-19');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (290, 'Marje', 'Cuniffe', 'Female', '1980-06-09');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (291, 'Paten', 'Rushton', 'Male', '1978-10-10');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (292, 'Madlin', 'Daymond', 'Female', '1987-03-18');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (293, 'Loralyn', 'Wrate', 'Female', '1966-09-10');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (294, 'Liam', 'Skillitt', 'Male', '1983-10-27');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (295, 'Ingamar', 'Redsell', 'Male', '1969-04-02');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (296, 'Eb', 'Bover', 'Male', '1983-05-12');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (297, 'Broddie', 'Cavaney', 'Male', '1963-08-04');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (298, 'Gerick', 'Anscott', 'Male', '1973-03-02');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (299, 'Enid', 'Dinsmore', 'Female', '1963-08-11');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (300, 'Shawn', 'Fomichyov', 'Female', '1967-03-16');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (301, 'Sybyl', 'Grimbleby', 'Female', '1989-03-10');
insert into `elidek`.`researcher` (researcher_id, first_name, last_name, gender, birthday) values (302, 'Hartwell', 'Shawel', 'Male', '1978-06-10');

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

INSERT INTO `elidek`.`elidek_manager` (`manager_id`, `first_name`, `last_name`, `gender`, `birthday`, `elidek_address`) VALUES ('1', 'Xenia', 'Chryssochoou', 'Female', '1980-12-30', 'ELIDEK ADDRESS1');
INSERT INTO `elidek`.`elidek_manager` (`manager_id`, `first_name`, `last_name`, `gender`, `birthday`, `elidek_address`) VALUES ('2', 'Constantinos', 'Charitidis', 'Male', '1996-02-24', 'ELIDEK ADDRESS');
INSERT INTO `elidek`.`elidek_manager` (`manager_id`, `first_name`, `last_name`, `gender`, `birthday`, `elidek_address`) VALUES ('3', 'Constantine', 'Galiotis', 'Male', '1974-02-11', 'ELIDEK ADDRESS');
INSERT INTO `elidek`.`elidek_manager` (`manager_id`, `first_name`, `last_name`, `gender`, `birthday`, `elidek_address`) VALUES ('4', 'Emmanouil', 'Kakaras', 'Male', '1994-10-10', 'ELIDEK ADDRESS');
INSERT INTO `elidek`.`elidek_manager` (`manager_id`, `first_name`, `last_name`, `gender`, `birthday`, `elidek_address`) VALUES ('5', 'Evangelos', 'Markatos', 'Male', '1994-11-30', 'ELIDEK ADDRESS');
INSERT INTO `elidek`.`elidek_manager` (`manager_id`, `first_name`, `last_name`, `gender`, `birthday`, `elidek_address`) VALUES ('6', 'Stylianos', 'Neophytides', 'Male', '1972-03-09', 'ELIDEK ADDRESS');
INSERT INTO `elidek`.`elidek_manager` (`manager_id`, `first_name`, `last_name`, `gender`, `birthday`, `elidek_address`) VALUES ('7', 'George-John', 'Nychas', 'Male', '1993-01-20', 'ELIDEK ADDRESS');
INSERT INTO `elidek`.`elidek_manager` (`manager_id`, `first_name`, `last_name`, `gender`, `birthday`, `elidek_address`) VALUES ('8', 'Antonios', 'Rengakos', 'Male', '1980-06-01', 'ELIDEK ADDRESS');
INSERT INTO `elidek`.`elidek_manager` (`manager_id`, `first_name`, `last_name`, `gender`, `birthday`, `elidek_address`) VALUES ('9', 'Costantinos', 'Biliaderis', 'Male', '1992-06-05', 'ELIDEK ADDRESS');
INSERT INTO `elidek`.`elidek_manager` (`manager_id`, `first_name`, `last_name`, `gender`, `birthday`, `elidek_address`) VALUES ('10', 'Ioannis', 'Emiris', 'Male', '1964-10-21', 'ELIDEK ADDRESS');
INSERT INTO `elidek`.`elidek_manager` (`manager_id`, `first_name`, `last_name`, `gender`, `birthday`, `elidek_address`) VALUES ('11', 'Nicolas', 'Moussiopoulos', 'Male', '1961-10-31', 'ELIDEK ADDRESS');
INSERT INTO `elidek`.`elidek_manager` (`manager_id`, `first_name`, `last_name`, `gender`, `birthday`, `elidek_address`) VALUES ('12', 'Mattheos', 'Santamouris', 'Male', '1986-04-05', 'ELIDEK ADDRESS');
INSERT INTO `elidek`.`elidek_manager` (`manager_id`, `first_name`, `last_name`, `gender`, `birthday`, `elidek_address`) VALUES ('13', 'Xenophon', 'Verykios', 'Male', '1976-06-08', 'ELIDEK ADDRESS');

DROP TABLE IF EXISTS `funding_program`;
CREATE TABLE funding_program (
	program_id INT UNSIGNED AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    budget BIGINT UNSIGNED,
    elidek_address VARCHAR(100),
    PRIMARY KEY (program_id)
);

INSERT INTO `elidek`.`funding_program` (`program_id`, `title`, `budget`, `elidek_address`) VALUES ('1', '1st Call for H.F.R.I. research projects to support Postdoctoral Researchers', '9000000', 'Post Doctorate Research Projects');
INSERT INTO `elidek`.`funding_program` (`program_id`, `title`, `budget`, `elidek_address`) VALUES ('2', '2nd Call for H.F.R.I. Research Projects to Support Post-Doctoral Researchers', '16580000', 'Post Doctorate Research Projects');
INSERT INTO `elidek`.`funding_program` (`program_id`, `title`, `budget`, `elidek_address`) VALUES ('3', '3rd Call for H.F.R.I. Research Projects to support Postdoctoral Researchers', '8000000', 'Post Doctorate Research Projects');
INSERT INTO `elidek`.`funding_program` (`program_id`, `title`, `budget`, `elidek_address`) VALUES ('4', '2nd Call for H.F.R.I. Scholarships to PhD Candidates', '10000000', 'PhD Candidate Scholarships');
INSERT INTO `elidek`.`funding_program` (`program_id`, `title`, `budget`, `elidek_address`) VALUES ('5', '3rd Call for H.F.R.I. Scholarships for PhD Candidates', '8000000', 'PhD Candidate Scholarships');
INSERT INTO `elidek`.`funding_program` (`program_id`, `title`, `budget`, `elidek_address`) VALUES ('6', '4th Call for H.F.R.I. Scholarships to PhD Candidates', '5000000', 'PhD Candidate Scholarships');
INSERT INTO `elidek`.`funding_program` (`program_id`, `title`, `budget`, `elidek_address`) VALUES ('7', '1st Call for H.F.R.I. Research Projects to Support Faculty Members & Researchers and Procure High-Value Research Equipment', '65000000', 'Faculty Member DEP/Researcher Research Projects');
INSERT INTO `elidek`.`funding_program` (`program_id`, `title`, `budget`, `elidek_address`) VALUES ('8', '2nd Call for H.F.R.I.\'’\'s Research Projects to Support Faculty Members & Researchers', '24500000', 'Faculty Member DEP/Researcher Research Projects');
INSERT INTO `elidek`.`funding_program` (`program_id`, `title`, `budget`, `elidek_address`) VALUES ('9', 'Basic Research Financing (Horizontal support for all Sciences), National Recovery and Resilience Plan (Greece 2.0)', '14000000', 'Researchers/Academic Staff');
INSERT INTO `elidek`.`funding_program` (`program_id`, `title`, `budget`, `elidek_address`) VALUES ('10', '1st Call for the Science & Society Action \'“200 Years from the Greek Revolution”\'', '1030000', 'Science and Society');
INSERT INTO `elidek`.`funding_program` (`program_id`, `title`, `budget`, `elidek_address`) VALUES ('11', '3rd Call for Action \'“Science and Society”\' \'“Research, Innovation and Dissemination Hubs”\'', '3000000', 'Science and Society');
INSERT INTO `elidek`.`funding_program` (`program_id`, `title`, `budget`, `elidek_address`) VALUES ('12', '2nd Call for Action \'“Science and Society”\' \'“Always Strive for Excellence – Theodore Papazoglou”\'', '10000000', 'Science and Society');
INSERT INTO `elidek`.`funding_program` (`program_id`, `title`, `budget`, `elidek_address`) VALUES ('13', '4th Call for Action \'“Science and Society”\'-Emblematic Action- Interventions to address the economic and social effects of the COVID-19 pandemic', '1500000', 'Science and Society');
INSERT INTO `elidek`.`funding_program` (`program_id`, `title`, `budget`, `elidek_address`) VALUES ('14', '5th Call for Action \'“Science and Society”\' – “Always Strive for Excellence-Theodore Papazoglou” (co-funded by the Stavros Niarchos Foundation and H.F.R.I.)', '10000000', 'Science and Society');
INSERT INTO `elidek`.`funding_program` (`program_id`, `title`, `budget`, `elidek_address`) VALUES ('15', 'Fieldwork for the collection of data in Greece in the context of the \'“Wave 10” of the European Social Survey', '220000', 'Important Actions');
INSERT INTO `elidek`.`funding_program` (`program_id`, `title`, `budget`, `elidek_address`) VALUES ('16', 'Emblematic Action: “The emerging landscape of digital work in Humanities in the context of the European infrastructures DARIAH and CLARIN”', '365000', 'Important Actions');
INSERT INTO `elidek`.`funding_program` (`program_id`, `title`, `budget`, `elidek_address`) VALUES ('17', 'Funding Basic Research (Horizontal Support for all Sciences) National Recovery and Resilience Plan (Greece 2.0)', '58000000', 'Future Actions');
INSERT INTO `elidek`.`funding_program` (`program_id`, `title`, `budget`, `elidek_address`) VALUES ('18', '5th Call for Action \'“Science and Society”\' – “Always Strive for Excellence-Theodore Papazoglou” (co-funded by the Stavros Niarchos Foundation and H.F.R.I.)', '10000000', 'Future Actions');
INSERT INTO `elidek`.`funding_program` (`program_id`, `title`, `budget`, `elidek_address`) VALUES ('19', '2nd Call for the Procurement of High-Value Research Equipment', '7560000', 'Future Actions');

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
    #reviewer_id INT UNSIGNED CHECK(NOT reviewer_id = senior_scientist_id),
    manager_id INT UNSIGNED,
	program_id INT UNSIGNED,
    FOREIGN KEY (inst_id) REFERENCES institute (inst_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (senior_scientist_id) REFERENCES researcher (researcher_id) ON DELETE CASCADE ON UPDATE CASCADE,
    #FOREIGN KEY (reviewer_id) REFERENCES researcher (researcher_id),
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
delimiter #
create trigger check_senior_scientist before insert on research for each row
if exists(select * from institute_worker as iw, research as res
		where iw.worker_id = new.senior_scientist_id
        and not iw.inst_id = new.inst_id)
then signal sqlstate '45000' set message_text = "senior scientist must work for the same institute that carries out the research";
end if #
delimiter ;
delimiter #
create trigger check_senior_scientist_u before update on research for each row
if exists(select * from institute_worker as iw, research as res
		where iw.worker_id = new.senior_scientist_id
        and not iw.inst_id = new.inst_id)
then signal sqlstate '45000' set message_text = "senior scientist must work for the same institute that carries out the research";
end if #
delimiter ;
delimiter #
create trigger update_iw after insert on research for each row
if not exists(select * from research, institute_worker as iw
				where iw.worker_id = new.senior_scientist_id)
then insert into institute_worker (worker_id,inst_id)
	values (new.senior_scientist_id, new.inst_id);
end if #
delimiter ;
delimiter #
create trigger update_iw_u after update on research for each row
if not exists(select * from research, institute_worker as iw
				where iw.worker_id = new.senior_scientist_id)
then insert into institute_worker (worker_id,inst_id)
	values (new.senior_scientist_id, new.inst_id);
end if #
delimiter ;


INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('1', 'CLLon - Immunogenetic and functional analysis of the B-cell receptor in Monoclonal B-cell Lymphocytosis (MBL) and Chronic Lymphocytic Leukemia (CLL) : implications for disease ontogeny', 'CLLon aims at dissecting the processes related to the B-cell receptor immunoglobulin (BcR IG) that occur throughout the natural history of CLL and contribute to disease ontogeny and evolution, through in-depth immunogenetic and functional studies of the clonotypic BcR IG. To reach solid conclusions, the study group will include individuals with MBL of both subtypes: (i) low-count MBL (LC-MBL) and (ii) high-count MBL (HC-MBL), as well as patients with CLL with distinct clinical courses, ranging from ultra-stable (asymptomatic for at least 10 years) to rapidly progressive. A multiparametric characterization of the BcR properties in MBL and CLL will be performed at different levels: (i) IG heavy and light chain sequence composition, (ii) BcR reactivity profile and (iii) (classical and autonomous) BcR signaling capacity.', '2020-01-02', '2023-01-02', '36', '6', '1', '300339', '2', '6');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('2', 'In Situ Soil Remediation by NonThermal Plasma', 'The goal of the project is to examine the applicability of non-thermal plasma (NTP) discharge techniques as advanced oxidation methods for the resource-efficient, sustainable and cost-effective in-situ remediation of soil contaminated by recalcitrant organic pollutants. Studies of plasma discharge techniques will be performed on lab-scale reactors by testing the possibility to remove several classes of recalcitrant / persistent organic pollutants (e.g. pesticides, chlorinated solvents, PAH) from two specific soil types. Plasma discharge reactors will be designed, constructed and tested for the in situ treatment of polluted soils by NTP. Parametric studies with respect to soil properties, pollutant type/concentration, moisture content, oxidant type, and flow conditions will be performed.', '2020-01-01', '2023-01-01', '36', '36', '2', '157138', '3', '15');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('3', 'Delineating molecular mechanisms of PHAGOsome dysFUNction underlying Sepsis Immunosuppression: A Roadmap to Personalized Medicine in Sepsis', 'Despite significant advances in life support of critically ill patients, sepsis remains a major cause of mortality worldwide. Recently, it has been realized that many patients who survive the initial sepsis episode, enter a prolonged state of immune deactivation, termed sepsis-induced immunosuppression, which accounts for treatment failure and death due to secondary infection(s) by opportunistic bacterial and fungal pathogens. While the clinical impact of sepsis immunosuppression is well recognized, the underlying mechanisms remain unknown. Furthermore, the failure of over 100 clinical trials on sepsis immunotherapy has been largely attributed to the complexity of the underlying molecular mechanisms of the disease in humans and the lack of reliable biological measures that discriminate patients with immune deactivation.', '2020-01-03', '2023-01-03', '36', '31', '3', '164,328', '4', '8');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('4', 'Development of an integrated 5- Dimensional space-based methodology for Assessing and modeling the Response of Erosion dynamics to land use and climatic changes in Mediterranean watersheds', 'Soil erosion is as a major environmental problem since it seriously threatens natural resources, agriculture and the environment. 5DARE project will assess the impacts of a changing climate, land use, soil moisture, hydrology and vegetation cover, on the quantity of erosion processes in two catchments in the island of Crete / Greece. Modelling techniques will be used to project the influence of changes of abovementioned factors on the major determinants of erosion processes, at various time and space scales, in the near and far future. Regional climate scenarios will provide the essential information on shifting precipitation and temperature patterns, and will feed into erosion models in order to assess the changes in seasonality, amount, and incidence of extreme events in the catchment areas', '2020-01-04', '2023-01-04', '36', '31', '4', '164284', '5', '15');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('5', 'Learning and teaching Greek as a second/foreign language', 'Given the fact that there is nowadays a growing need for learning Greek as Second Language (SL) /Foreign Language (FL), examining firstly how Greek can be taught in a more efficient way for different target groups of learners, and adequately training and certifying teachers of Greek in second, are issues of great importance for our community. To address these issues, the current project sets three interrelated and complementary studies, meant to approach the area of Modern Greek as a SL/FL from different perspectives, by taking into account all parties involved in the learning process. More specifically, Study 1 aims at analyzing classroom interaction during the acquisition of Greek in both SL and FL context. Study 2 aims to explore the gains that different learner groups obtain in terms of linguistic outcomes, pragmatic competence development and sociocultural awareness, over the period of instruction and whether individual factors have a relationship with these gains. Study 3, which is framed within the idea of Lifelong Learning, focuses on the perceptions of student-teachers’ and current teaching training of teachers teaching Greek, classroom practices, self-evaluation and professional development.', '2020-01-05', '2023-01-05', '36', '24', '5', '370587', '6', '15');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('6', 'Application of microbial electrochemical technologies towards advanced biofuels production', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', '2020-01-06', '2023-01-06', '36', '36', '6', '325048', '7', '8');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('7', 'Ethnography and/as hypertext fiction: representing surrogate motherhood', 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', '2020-01-07', '2023-01-07', '36', '29', '7', '199320', '8', '18');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('8', 'Development of an Innovative Traceability System for Controlling Food Safety in Sustainable AgriFood Supply Chains', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', '2020-01-08', '2023-01-08', '36', '17', '8', '491810', '9', '18');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('9', 'From Two to Many: Geminin Family Members Control Centriole Amplification, Cilia Formation and Pathology', 'Maintenance of correct centriole/centrosome numbers is essential for genome stability. The centrosome duplication cycle must occur in concert with the chromosome cycle. Aberrations both in the genome content and in centrosome numbers can lead to genomic inconsistency. However, such aberrations can also be part of the normal life-cycle of specific cell types. Multiciliated cells best exemplify the deviation from a normal centriole cycle, as they exit the cell cycle and generate hundreds of centrioles per cell, breaking the spatiotemporal rules of generation of only one new centriole next to the parental centriole, in each cell cycle.', '2020-01-09', '2023-01-09', '36', '33', '9', '240236', '10', '7');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('10', 'Cypriot Connectivity in the Mediterranean from the Late Bronze to the end of the Classical period: An Interdisciplinary Approach', 'The ‘Cypriot Connectivity in the Mediterranean from the Late Bronze to the end of the Classical period: An Interdisciplinary Approach’ research project, aims at the study of Cypriot presence and activity in the Mediterranean between the Late Bronze Age, a time of great prosperity for ancient Cyprus, and the end of the Classical period, when the Cypriot city-kingdoms, the island’s political institution par excellence, get abolished. This long period of c. 13 centuries (1650–310 BC) is characterised by numerous historic facts that influenced not just Cyprus but also the Mediterranean as a whole.', '2020-01-10', '2023-01-10', '36', '38', '10', '157902', '11', '5');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('11', 'Development of Bio-Inspired Photocatalytic Systems for H2 Production and CO2 Reduction', 'The decrease of total available reserves of fossil fuels along with the environmental problems caused by increased CO2 emissions, have turned research community interest towards developing catalytic systems which convert solar energy into exploitable fuels. Hydrogen is considered as the \"ideal\" fuel because its combustion with oxygen produces water and heat as the only byproducts. Therefore, the preparation of efficient catalytic systems that exploit solar energy for H2 production and CO2 reduction, can contribute to an ultimate green sustainable development of our planet, solving energy and environmental issues', '2020-01-11', '2023-01-11', '36', '30', '11', '247286', '12', '7');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('12', 'Establishment of a Monitoring Network and a web-based platform of Non-Indigenous Species in Major Ports of Greece - AlienPorts', 'Alien species significantly change the structure of Mediterranean habitats by restricting the distribution of native species, degrading the local biodiversity and altering the habitat functioning. AlienPort project has as a target to create a monitoring network among the Major Ports of Greece and a web-based platform including information for NIS located in the ports and their distribution through Greek waters. In addition, this project will propose a sampling protocol specially focused on NIS species in port. Project results will be available to the port and management authorities and will potentially be used as a base for developing management tools.', '2020-01-12', '2023-01-12', '36', '39', '12', '296849', '13', '11');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('13', 'Effects of Climate Change and Ocean acidification on marine gastropods', 'Anthropogenic activities, such as fossil fuel combustion and deforestation, are responsible for the increase of atmospheric carbon dioxide, which in turn is absorbed by the oceans causing changes in the seawater carbonate chemistry. Ocean acidification (low pH) decreases the calcium carbonate saturation states in seawater, thus inhibiting calcification rates in shell-forming marine organisms. Elevated carbon dioxide may have additional sublethal impacts on organismal, developmental and physiological levels and as a result can significantly suppress the abundance and diversity of species. This study will use an integrated multidisciplinary approach in order to investigate morphological, physiological, behavioral, chemical and molecular responses of selected gastropod species on a complementary basis. A long-term experiment is scheduled in order to investigate the direct and indirect effects of low pH and increased temperature and also to reveal possible adaptations of the organisms. Four different treatments with a combination of low or ambient pH and increased or ambient temperature will be used in order to investigate the long-term synergistic effects of those two factors on marine gastropods.', '2020-01-13', '2023-01-13', '36', '39', '13', '264527', '1', '10');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('14', 'DNA damage & histone variants in development & disease', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', '2020-01-14', '2023-01-14', '36', '37', '14', '287612', '2', '16');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('15', 'Athenian Presence in Thrace through the Diffusion of Attic Painted Pottery (6th-4th c. BCE)', 'The object of this project is the examination of Athenian presence in Thrace from the 6th to the 4th century BCE through the study of commercial and social networks developed in the area. Using the published attic painted pottery found in different places in ancient Thrace (settlements, burials, sanctuaries) as a basic tool, we are going to study the shapes, the iconographic themes and the use of attic vases in the local society. Thus, we are going to obtain a sample picture of the luxurious attic pottery in Thrace, of the commercial roads through which it was disseminated but also of the local preferences. The study of the material will enable us to examine under quantitative and quality parameters, the role of attic painted vases both in coastal and inland Thrace and we will take under consideration space and time in the individual stages of analysis.', '2020-01-30', '2023-01-14', '35', '36', '15', '302470', '3', '1');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('16', 'Spatial Dynamics and Settlement Patterns in Eastern Crete from the Classical to the Venetian Period', 'Through an interdisciplinary approach (combining a careful reading of historical and archaeological evidence and the spatial analysis offered by new technologies in archaeological research), this project will attempt to highlight the developments of the settlement patterns in Eastern Crete from the Classical to the Venetian period. During more than a millennium, from the 5th c. B.C. to the 17th c. A.D., Crete has known several political and administrative systems. The main goal is to track the transition from ancient autonomous city-states to the medieval dependent cities and villages.', '2020-01-15', '2023-01-15', '36', '37', '16', '129026', '4', '14');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('17', 'Do massive winds induced by black-hole jets alter galaxy evolution? Evidence from galaxies in the Atacama Large Millimeter Array (ALMA) Radiosource Catalog', 'A major recent discovery, is that supermassive black holes expel and heat large amounts of molecular gas in galaxies, which is responsible for star formation. Plasma jets and radiation pressure, which are related to the infall of matter onto black holes, can accelerate gas beyond escape velocity; resulting winds often have mass flow rates exceeding star formation rates in their galaxies. But are these phenomena significant enough to affect galaxy sizes? To answer this question, we will systematically exploit molecular (CO) line observations from the largest mm interferometer today, the Atacama Large Millimeter Array (ALMA).', '2020-01-16', '2023-01-16', '36', '11', '17', '267620', '5', '11');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('18', 'A Systematic investigation of the Durability of Textile Reinforced Mortars (TRM) and of TRM/RC elements under harsh environments', 'The increasing need for retrofit and repair of existing reinforced concrete (RC) structures, has urged the international research community to develop innovative structural components and techniques, aiming to increase their strength and/or deformation capacity. In this direction, innovative composite materials, comprised of high strength textiles in inorganic matrices, named textile reinforced mortars (TRM), have been introduced as an alternative to the traditionally used FRP systems, in the field of strengthening and seismic retrofitting. Since on any strengthening application, the TRM will be applied on the external surface of an existing RC element, exposed to a particular harsh environment (e.g. chlorides, carbon dioxide, etc.), the long-term performance of both the TRM and the TRM strengthened RC structure (noted as “TRM/RC”) should be considered, in terms of structural durability. Even though research on TRM in terms of strengthening applications and techniques is currently at quite an advanced stage, limited data are available in literature concerning TRM durability and long-term performance in various exposures.', '2020-01-17', '2023-01-17', '36', '33', '18', '441193', '6', '4');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('19', 'Mechanisms controlling the maturation of distinct interneuron population', 'The balance between excitation and inhibition (E-I balance) is essential for the generation of optimal neural circuit activity patterns and brain function. Cortical interneurons (cINs) represent the main source of inhibition for excitatory projection neurons (PNs) in the pallium (cortex), and changes in the number or activity of cINs have been associated with neurodevelopmental and neuropsychiatric disorders, such as epilepsy, schizophrenia and autism spectrum (ASD) disorders.', '2020-01-18', '2023-01-18', '36', '2', '19', '429018', '7', '19');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('20', 'Fluorescent inks, pastes and filaments based on luminescent carbon dots for cutting edge and bio-applications', 'FluoPrints aims to the development of fluorescent inks, pastes and filaments based on carbon dots for cutting edge and bio- applications via 2D and 3D printing technologies. Carbon dots are on the research spotlight of recently, due to their biocompatibility and photoluminescence in advance, while 3D printing is considered a major technological breakthrough that will dominate multiple markets in near future.', '2020-01-19', '2023-01-19', '36', '31', '20', '309018', '8', '18');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('21', 'Valorization of agro-industrial by-product streams from Aegean for the production of carotenoids, proteins and novel functional foods', 'The development of bio or environmentally friendly strategies for the production of value-added food products with high nutritional value is a field of high interest for both the industrial sector, consumers and academic research. Driven by increasing social demand for the production of healthier products not colored by chemical synthesized ingredients, malnutrition of a great deal of worldwide population, the necessity of protecting the environment, waste management penalties imposed from inappropriate discharging of waste streams, valorization of high pollutant by-product streams for the production of bio or carotenoids and functional food from costless raw materials, has become inevitable. Therefore, the exploitation of agro-industrial originated by-product streams, aiming at producing functional foods through the application of proper processes, is a promising alternative toward sustainable management, promoting public health.', '2020-01-20', '2023-01-20', '36', '29', '21', '326575', '9', '9');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('22', 'From hunter-gatherers to early farmers in Greece', 'The Mesolithic represents a brief slice of time sandwiched between the Upper Palaeolithic and Neolithic. It begins at the end of the Younger Dryas and is characterised by improving conditions after the extremes of the Last Glacial Maximum. Our understanding of the Mesolithic in Greece was based until recently on a small number of key sites, but there is now a growing body of evidence from the mainland and islands of the Aegean which is beginning to fill these gaps in our knowledge. The picture that these present, is of a preference for coastal environments, although there are also small numbers of sites located in inland and upland areas. A number of models have been put forward to explain the nature of the Mesolithic in Greece, both in terms of its evolution from the Late Upper Palaeolithic as well as the transition to the Neolithic. These all tend to agree that the Greek Mesolithic was atypical compared to the rest of Europe or the Levant.', '2020-01-21', '2023-01-21', '36', '24', '22', '309202', '10', '7');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('23', 'Role of alternative splicing in the regulation of mitochondrial physiology and retrograde signaling to the nucleus', 'Mitochondria are semiautonomous organelles, critically involved in ATP production, Ca2+ buffering, oxidative stress and apoptosis. They are in constant communication with the nucleus, and induce, under stress conditions, massive changes in nuclear gene expression (mitochondrial retrograde signaling). Mitochondrial quality and signaling have attracted great attention in the study of pathogenesis of neurodegenerative and metabolic diseases, as well as cancer. The transcriptional regulation of these pathways has been thoroughly investigated. However, there is growing evidence that post-transcriptional regulation, specifically alternative splicing, constitutes an additional, yet poorly explored level of control.', '2020-01-22', '2023-01-22', '36', '2', '23', '311208', '11', '9');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('24', 'Observatory of Air and Particulate Pollution over Greece (AirPaP)', 'A great part of worldwide population is daily exposed to air pollution levels that exceed health-based ambient standards. According to the FEI-GREGAA Emission Inventory (E.I.) recently completed by Dr. Fameli for Greece and the Greater Athens Area (GAA), the field of pollutant sources has changed because of major infrastructure projects undertaken and the parallel economic development of new regions. Moreover, the economic crisis has affected human activities and consequently the share of pollution sources in total emissions.', '2020-01-23', '2023-01-23', '36', '11', '24', '395940', '12', '17');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('25', 'Numerical and experimental assessment of solar air heater systems performance towards zero energy buildings', 'The main objective of the project is the development of a user-friendly software tool for the design and energy performance assessment of three types of Solar Air Heater (SAH) systems for heating buildings in Mediterranean climatic conditions. SAH systems represent a cost-effective technology used either to heat a space attached to it or to heat air for industrial applications and processes.', '2020-01-24', '2023-01-24', '36', '40', '25', '393484', '13', '13');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('26', 'The bioenergetic dimension of stress: focus on mitochondria (ENERGEIA)', 'Chronic stress and stress-related pathologies pose a great challenge for modern societies, affecting our life quality, the health system, the pharmaceutical industry and how mental illness is perceived by the public. The molecular mechanisms underlying stress responses remain to date poorly understood. Consequently, currently used treatments for stress-related pathologies target mainly the symptoms rather than the molecular causes, have severe side-effects and show low remission rates. The ENERGEIA project investigates how mitochondrial functions regulate stress responses and whether mitochondria can be used as pharmacological targets to treat stress-related pathologies. Besides ATP production and oxidative stress regulation, mitochondria mediate a plethora of energy-dependent functions in the brain, including synaptic neurotransmission, neuronal plasticity and apoptosis. Dysfunctions of these processes under stress conditions may causally disrupt brain circuits and lead to pathological states.', '2020-01-25', '2023-01-25', '36', '31', '26', '446301', '1', '15');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('27', 'Politics of Recognition: The Afterlife of the Greek Resistance in Law, History, and Memory', 'The official recognition of the European Resistance after the Second World War is of utmost importance, since it is associated with a set of broader public policies that allow us to understand the ways in which states pass from a state of war to a period of peace, restore their social balance and seek the legitimacy of postwar governments. In Greece, National Resistance constituted an open issue for decades. However, compared with the abundant literature for the history of the Resistance, very limited research has been conducted on the issue of the official recognition of the Resistance. Official recognition however, is a key concept for the study of the ‘second life’ of the Resistance and that is why we approach it as an autonomous research field; since it constitutes a long process which functioned as a laboratory for concepts and politics, that decisively affected the formation of Greek society and the political system for at least half a century.', '2020-01-26', '2023-01-26', '36', '24', '27', '329338', '2', '14');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('28', 'Non-perturbative Gauge Dynamics from Integrability and Gauge/Gravity Dualities', 'The purpose of the proposed work is to shed some light to the non-perturbative dynamics of gauge field theories. The present project will deploy in two parallel directions. In the first one, we shall focus on the construction and study of integrable multi-parameter deformations of conformal field theories (CFTs) of the WZW type. Emphasis will be given to the key feature of integrability of the resulting theories and not to other aspects, such as supersymmetry. Subsequently, we will embed these models to type IIA or type IIB supergravity, identify the dual gauge theories and study the role of the deformation parameters in their strongly coupled dynamics through the AdS/CFT correspondence. These novel realisations of the AdS/CFT correspondence will be closer to quantum chromodynamics (QCD) since the deformations will break supersymmetry down to N=1, or even N=0.', '2020-01-27', '2023-01-27', '36', '12', '28', '256339', '3', '11');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('29', 'Performance Evaluation of Low Energy Asphalt mixes and their impact on Pavement Sustainability (LEAPS)', 'According to the Eurostat and the European Environment Agency transportation accounts for over 23 percent, with increasing trend since 1990, of all humancaused GHG emissions in the European Union. EU has committed for 2020 to cutting its emissions to 20% below 1990 levels. So, a challenge emerges to reduce GHG emissions and improve the sustainability of pavement structures, which provide mobility and access to a range of users as integral part of the roadway and transportation networks.', '2020-01-28', '2023-01-28', '36', '23', '29', '246569', '4', '5');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('30', 'Integration of experimental investigation and computational modeling to decipher dormancy related stochastic phenomena in Listeria monocytogenes', 'The application of multiple barriers in the food industry aims at the inhibition of growth of spoilage and pathogenic microorganisms, in order to ensure the highest levels of quality and safety of the final products. Listeria monocytogenes is a foodborne bacterial pathogen often found in nature and in food processing environment, and causal agent of the well-known infection, Listeriosis, with a mortality rate of 20-30%. An environmental stimulus, such as a preservative agent in food, may induce changes in a microorganism’s metabolism in aim to increase its survival potential. Several studies have highlighted the importance of the dormancy state as a bacterial response to unfavourable environment. While at this state, cells are called “Viable but non-culturable” (VBNC), they cannot multiply and are nonculturable in the laboratory media, but may regain their culturability when found back in favourable conditions.', '2020-01-29', '2023-01-29', '36', '19', '30', '442699', '5', '1');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('31', 'Structural and Functional Studies of Nicotinic Acetylcholine Receptors', 'Nicotinic acetylcholine receptors (nAChRs) belong to the family of pentameric ligand gated ion channels (LGIC) and are key molecules in mediating fast neurotransmission and in regulating neurotransmitter release. nAChRs are protein molecules embedded to the cell membrane, which upon acetylcholine binding at their extracellular domain, transmit allosterically the signal across the plasma membrane. It is then when nAChRs undergo complex conformational changes that lead to transient opening of the ion channel, depolarizing the cell membrane and initiating a cascade of events. Apart from nAChRs, the pentameric LGIC family comprises receptors activated by glycine, GABA and serotonine. Due to their involvement in a series of neurodegenerative diseases and disorders, LGICs are the main targets of a series of psychotropic drugs with therapeutic or alleviating properties (including nicotine, varenicline, benzodiazepines, alcohol, antiemetics, general aneasthetics etc).', '2020-01-30', '2023-01-30', '36', '40', '31', '202081', '6', '4');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('32', 'Quark-Gluon Plasma Thermalization and Plasma Instabilities in AdS/CFT', 'String theory is the most promising candidate for quantum theory of gravity in theoretical physics. However, in the recent years it has grown as a rich mathematical structure and tool that has allowed outstanding applications to very different areas of physics and mathematics. One of its important achievements is the gauge/gravity correspondence, a duality between a quantum field theory and gravity. More precisely, the correspondence relates the quantum physics of strongly correlated many body systems where the computations are not easily tractable, to the classical dynamics of gravity in one higher dimension where we have developed the necessary tools to complete the corresponding computations. The duality is also sometimes referred to as holographic due to the extra dimension that is needed to formulate it. The idea is now 20 years old, but remains one of the most active research topics in high energy theoretical physics.', '2014-01-31', '2018-01-31', '48', '24', '32', '169452', '7', '11');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('33', 'Rapid field diagnostic technology for detection of major swine viral diseases', 'Diseases affecting livestock can have a devastating impact on animal productivity and production, on live animal trade, meat and other animal products, on human health and, consequently, on the overall process of economic development. Among them, Porcine Reproductive and Respiratory Syndrome virus (PRRSV), Porcine Circovirus (PCV2) and Swine Influenza A (SIV) have a significant impact on the economy of the swine industry. During the last 10 years, much emphasis has been focused on emerging infectious zoonotic diseases, such as Hepatitis E virus (HEV), that have recently drawn more attention. Thus, there is a need for evaluation of reliable, rapid and simple diagnostic testing directly on the field, that would enable rapid local decision making which is crucial to prevent further spreading of the disease. One promising solution that can help address this issue is loop-mediated isothermal amplification (LAMP).', '2014-02-01', '2018-02-01', '48', '19', '33', '424866', '8', '17');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('34', 'Determination of the self-healing capabilities of the Eastern Mediterranean Sea from accidental deep-sea oil releases', 'As exploration for new oil and gas fields moves to progressively deeper waters, the risk of oil spills originating in the deep sea is bound to increase in the future. The recent Deepwater Horizon (DWH) oil spill at 1500m in the Gulf of Mexico was a stark reminder of the risks attached to human activity in largely unknown extreme environments and has evidently demonstrated the shortcomings of current response strategies in tackling accidental oil releases in the deep sea.', '2014-02-02', '2018-02-02', '48', '41', '34', '134450', '9', '8');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('35', 'Detection of engineered, incidental, and natural nanoparticles in marine waters, in the proximity of islands', 'The development of nanotechnology has introduced significant advancements in materials sciences and several companies, taking advantage of the unique properties of nanomaterials, are developing nano‐ enabled products that have already entered the market. Cosmetics, sunscreens, paints, automotive parts, tools, fabrics/clothes, toys, and many others are just a few examples. Due to the increasing development and use of nano‐enabled products, release of nanoparticles in the environment is considered unavoidable.', '2014-01-01', '2018-01-01', '48', '24', '35', '369784', '10', '12');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('36', 'SQUID metamaterials: chimera states and spatio-temporal dynamics (acronym: SQUIRREL)', 'The interplay between nonlinearity and structure is at the center of research on complex systems. In ensembles of coupled oscillators, the synergy between topological features and the underlying dynamics may lead to interesting self-organized phenomena. Within the SQUIRREL project, we will study a system that is capable of exhibiting such complex dynamics: a SQUID (superconducting quantum-interference device) metamaterial, i. e. an artificially structured medium of periodically arranged, weakly coupled SQUIDs, that exhibits extraordinary properties, e. g. negative diamagnetic permeability. The SQUIRREL project will involve theoretical modeling in close interaction with experimental activity. The main focus will be on chimera states, a fascinating counter-intuitive symmetry breaking phenomenon of partially coherent and partially incoherent behavior. The increasing number of studies on chimeras is impressive, ranging from physical and chemical, to biological and technological systems. Works on superconducting systems, however, are still largely missing.', '2014-01-02', '2018-01-02', '48', '30', '36', '197872', '11', '3');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('37', 'Biological Metaphysics: Understanding Developmental Mechanisms', 'The study of development poses fundamental epistemological and metaphysical problems and has been a traditional focus of philosophical analysis. But although contemporary philosophy of biology has evolved into a central sub-discipline within philosophy of science, developmental biology has received very little philosophical attention. In particular, the ontological and epistemological commitments of contemporary developmental biology constitute issues that are virtually unexplored in the philosophical literature. By combining concepts and methods from philosophy of biology and metaphysics of science with detailed case studies of developmental explanations, this project investigates the explanatory practices of contemporary developmental biology and their consequences for our philosophical views, about the nature of explanation in the life sciences and the ontology of biological systems.', '2014-01-03', '2018-01-03', '48', '24', '37', '249676', '12', '4');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('38', 'Antiparochi and (its) architects: Histories of social forces, spatial politics and the architectural profession in Greece, 1929-74', '‘Antiparochi and (its) architects’ is planned as a three-year collaborative research project at the School of Architecture, National Technical University of Athens. The project involves original archival research and interviews with protagonists from different professional backgrounds and generations. It exploits new technologies for the documentation and digitization of archival material and for the development of an open, interactive, multimodal and searchable database. It establishes collaborations with noted scholars from various disciplines and countries to promote a multi-disciplinary and internationally comparative theoretical and methodological analysis, leading to the sharpening of existing and development of new analytical tools. It schedules lectures, public conversations, a specialized workshop in collaboration with UCy, and an international one-day conference as part of the dissemination process.', '2014-01-04', '2018-01-04', '48', '23', '38', '203398', '13', '7');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('39', 'Novel Conversion Technologies of Waste Biomass to Food additives and Fine Chemicals', 'The NoWasteBioTech aims at developing a zero-waste biorefinery concept by using novel pretreatment/fractionation technologies and combining them with thermochemical and enzymatic/fermentation technologies. Agricultural residues such as corn stover and cotton stalks will be fractionated to their three basic constituents, producing three distinct streams: (1) A solid cellulose pulp, (2) An aqueous stream of hemicellulose oligo- and mono- sugars, (3) A depolymerized lignin. Enzymatic and biotransformation processes will be employed to produce high added value chemicals and food additives such as Prebiotics, Lactic acid and Polyunsaturated fatty acids (PUFAs).', '2014-01-05', '2018-01-05', '48', '35', '39', '418085', '1', '9');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('40', 'Media Lab for Feminist Public Practices', 'The Center of New Media and Feminist Public Practices is dedicated to the production, postproduction, distribution and support of women’s practice and feminist theory development. The center will be an innovative initiative which by definition involves application of information and technology, imagination and diverse methods in deriving new and different values and ethos in new media, feminist practice and public space. Ideas and processes will be conveyed to cultural products which will enhance women’s’ advancement, productivity and assimilation to the professional field.', '2014-01-06', '2018-01-06', '48', '39', '40', '117754', '2', '16');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('41', 'Crowdsourced networks, services, transport: analytical foundations of sustainable sharing', 'The project focuses on applications and services that lie in the broader area of sharing economy. The future of sharing economy and its ultimate role in the world economic activities will depend on many factors, including the legal and regulation policies applied to them. In any case, however, the related service platforms need to cope with fundamental issues regarding the allocation and sharing of common resources, the provision of incentives, and their business models. CRESCENDO responds to this need by drawing analysis tools from the areas of network economics, queuing theory and (stochastic) optimization, but also from machine learning and numerical analysis. It is structured along three discrete thematic areas: shared network connectivity, participatory sensing, and crowdsourced transport. Common to all three thematic areas is the dimension of crowdsourcing and resource sharing, as well as the sustainability challenges that relate to them.', '2014-01-07', '2018-01-07', '48', '16', '41', '329981', '3', '13');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('42', 'Dynamics of SPREADing on liquid substrates with complex rheology', 'The aim of our work is to provide fundamental understanding on the dynamics of liquids spreading on soft materials with complex rheological behavior, a problem that lies at the heart of many engineering, biological and biomedical settings. Emphasis is placed on the drug delivery on compliant substrates, which involves spreading of bioadhesive or muco-adhesive liquids over tissue or over mucus laden films in the lung or elsewhere in the body. In lung diseases such as cystic fibrosis and chronic obstructive pulmonary disease the efficacy of the administered drugs is often limited by heterogeneous distribution and non-uniform deposition. To improve dose uniformity, it is crucial to find ways in order to maximize post-deposition spreading of the liquid drug on the airway lining (e.g. with efficient use of surfactants). The latter, however, consists of a mucus layer with rather complex rheology, typically exhibiting both considerable yield stress and viscoelastic properties.', '2014-01-08', '2018-01-08', '48', '17', '42', '109619', '4', '7');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('43', 'Chirality Amplification and Detection using Cavity Optical Rotation Enhancement (HANDCORE)', 'A molecule or ion is “chiral” when it is -geometrically- non-superimposable on its mirror image. This asymmetry manifests as optical activity, i.e. as optical rotation (OR) of the polarization plane of light traversing the sample, with the two “enantiomers” (mirror images) producing opposite polarization rotations. Systems causing OR with the same symmetry as chiral rotation, although not due to their geometry, are also referred to as chiral systems, the prime example being the parity-non-conserving (PNC) optical transitions in certain atomic and molecular systems.', '2014-01-09', '2018-01-09', '48', '36', '43', '309259', '5', '13');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('44', 'Perspective of Agroforestry in Thessaly region: a research on social, environmental and economic aspects to enhance farmer participation (acronym: AgroThes)', 'Agroforestry, a novel and well-promising practice in reshaping the countryside of Greece, comes along with parallel benefits in environmental, social and economic terms. Agroforestry is defined as the composite agronomic practice of triple temporal or/and spatial combination of two or three distinct land uses and farming activities, i.e. crop cultivation, or/and forest tree growing, or/and domestic animal breeding. It is an effective form of land use that achieves increased output and ecological stability contributing to environmental sustainability and biodiversity conservation, but also creating social capital and economic opportunities.', '2014-01-10', '2018-01-10', '48', '42', '44', '334981', '6', '12');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('45', 'Investigation of the plasticity of cardiac progenitors', 'During development, the cardiomyocyte lineage is highly specialised, comprising of cardiac progenitor cells allocated in a discrete and temporal order. At embryonic day 7.5 in mice, the heart tube is the prime structure that will eventually give rise to the heart proper. It is populated by two distinct sets of cardiac progenitors cell subsets, derived from two anatomical regions; the first heart field (also known as the cardiac crescent) which will give rise to the left ventricle and parts of the atria, and the second heart field that contributes towards the right ventricle, outflow tract and the remaining parts of the atria, including the septum. These fields are genetically distinguishable, at embryonic day 7.5, by expression of specific transcription factors.', '2014-01-11', '2018-01-11', '48', '43', '45', '260146', '7', '10');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('46', 'Growing & Enabling Information Technologies for Online Neighborhoods: Implications & Applications', 'G.E.I.T.O.N.I.A. project (the word “geitonia” stands for neighborhood in Greek) aspires to advance the current research field on the concepts of neighborhood and community, both on theoretical and empirical level. It will do so by providing, at a pilot level, a free, non-commercial local online application for neighborhoods in Greece, designed according to the findings of a multidisciplinary research study and the members of the local community as co-creators, on the one hand. And on the other, by studying and analyzing the effect of such an application on the strengthening of social bonds across a local physical community that can lead to the formation of a “hybrid” neighborhood (convergence of physical and virtual) from a socio-psychological point of view.', '2014-01-12', '2018-01-12', '48', '28', '46', '101284', '8', '11');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('47', 'Low-Temperature Growth of Perovskite Nanosystems for High-Performance Perovskite Solar Cells', 'Photovoltaic is the most promising technology of converting solar energy to useful electrical power. The need for materials of lower production cost than those commercially available has led to new photovoltaic technologies. In less than five years, the perovskite solar cells have been considered a promising photovoltaic technology due to the unprecedented rise of their power conversion (from 3.8 to 20 %) similar to that observed for the rest of photovoltaic devices after decades of research effort. The light-harvesting active material for these solar cells is a perovskite, namely a semiconductor of the AMX3 type, where A is a cation (organic or inorganic), M a heavy atom (cation) such as Pb or Sn and X a halide atom (Cl, Br, I).', '2014-01-13', '2018-01-13', '48', '36', '47', '209945', '9', '8');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('48', 'Unravelling Ariadnes thread into the microbiome of Anaerobic Digestion labyrinth', 'The objective of “MicroAD: Unravelling Ariadne’s thread into the microbiome of Anaerobic Digestion labyrinth” is to elucidate the functional organisation of engineered anaerobic microcosms, such as the one populating biogas reactors, by a novel platform based on utilisation of modern molecular and analytical tools and models. Anaerobic digestion is a biological process, mediated by different groups of microorganisms, which follow diverse metabolic pathways to produce biogas. Biogas is a mixture of gases (mainly composed by methane and carbon dioxide) and is used for the production of electricity, heat, or after processing, transport fuel. Organic matter used as a substrate for biogas production is usually agro-industrial or urban waste, manure and food residues. The composition, the relative abundance and the interactions within this microbial community, in combination with substrate characteristics, are pivotal to the performance of the bioreactor. Furthermore, the microbial communities change in response to different environmental conditions, so that the biogas reactor can be considered as a dynamic system requiring a constant and reliable monitoring and control.', '2014-01-14', '2018-01-14', '48', '17', '48', '220174', '10', '15');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('49', 'Species on the brink of extinction', 'The planet is facing an unprecedented biodiversity crisis, with current extinction rates 1000 times higher than the background extinction rate. In order to halt this phenomenon, the Convention on Biological Diversity targets to prevent the extinction of known threatened species and to improve their conservation status by 2020. Nevertheless, extinction rates under current management schemes will continue to increase under any potential future climate scenario. Greece constitutes one of the most important biodiversity hotspots worldwide and hosts 74 Critically Endangered (CR) taxa at national and global level. Fifty of the CR taxa were assessed prior to 2012 and were classified as such, based solely on geographical criteria and without any data regarding their population trend; the latter being one of the most fundamental criteria regarding the threat categorization according to IUCN.', '2014-01-15', '2018-01-15', '48', '19', '49', '203802', '11', '13');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('50', 'Designing pillared graphene nanomaterials with tuneable electronic properties and enhanced flexibility for electronic devices (GRAFEL)', 'he vision for implementing this project has been primarily driven by the requirement of cheaper, large-area electronic devices that can be integrated on flexible substrates through low-temperature deposition or solution-based printing methods. The great challenge in the area is to surpass the respective disadvantages of inorganic and organic semiconducting materials for use in flexible electronics and design new materials that combine their advantages, namely controllable electronic properties accompanied by mechanical conformability. From a device design perspective, such materials will also lead to minimization of contact issues (heat dissipation, contact resistance) associated with the interface which exists when multiple materials are combined.', '2014-01-16', '2018-01-16', '48', '36', '50', '289873', '12', '4');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('51', 'Microglia-driven pathology and altered brain surveillance in demyelination', 'Neuroflammation is a common feature of all neurodegenerative disorders, ranging from immune-mediated diseases such as multiple sclerosis (MS), to classical neurodegenerative diseases such as Alzheimer’s disease, and is a promising target for therapeutic intervention. Microglia is the local immune system of the central nervous system (CNS) that mediates intrinsic neuroinflammation. Chronic activation promotes neuroinflammation and induces secondary damage to brain tissue. Recent research, however, has shown that microglia performs equally important regulatory functions in the healthy brain, and has a beneficial role in restoring local tissue alterations. This multiplicity of microglial function suggests that these cells react differently to similar stimuli, acquiring either a beneficial or a harmful role. The new data implies the need for a better understanding of microglial function before designing any therapeutic approach that will target them. In this study, we will investigate the hypothesis that activation of specific microglial molecules contributes to the progression of chronic neuroinflammation, while reducing its positive contribution to brain repair.', '2014-01-17', '2018-01-17', '48', '40', '51', '385387', '13', '2');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('52', 'Large-scale bioinformatic integration of sequence data for novel insights into microbial diversity and ecology', 'Studying microbial diversity and ecology allows the discovery of novel microbial functions and the design of innovative strategies, towards targeted manipulation of microbial communities for the sake of biotechnological, environmental, or health-related issues. However, this process is slowed down by the currently limited description of microbial diversity and poor understanding of community dynamics, amplified by the lack of data integration and utilization tools. I propose to tackle this issue by means of innovative bioinformatic approaches. Thanks to our past efforts in integration of microbial data into the web-based platform IMNGS (www.imngs.org), we are now able to utilize the universal pool of sequence-based knowledge to address several important microbial ecological questions. I plan to utilize this resource to provide answers to ‘what’ is the sequence supported global prokaryotic diversity and ‘where’ future microbial isolation efforts should focus for environments rich in undescribed taxa. Furthermore, by clustering thousands of microbial composition profiles available in IMNGS, we will provide evidence for the existence of persistent composition states (attractors) in different environments, identify their core species based on co-occurrence networks, and explore their functional basis.', '2014-01-18', '2018-01-18', '48', '38', '52', '274582', '1', '18');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('53', 'Consumerism in a period of economic crisis: Consumption practices and forms of governance', 'This research proposal regards the study of the cultural significance of consumption in a period of economic recession and debt crisis. This research aims to investigate whether, and at which point is consumerism as a cultural tendency, undergoing a crisis or if it is reproduced in economic crisis conditions.', '2014-01-19', '2018-01-19', '48', '44', '53', '291594', '2', '1');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('54', 'Understanding, measuring and monitoring children’s welfare: An action plan with The Smile (C.W. SMILE)', 'In this research project, an initial indicator of child welfare (well-being) or its opposite child poverty will be used, which has already been declared by the project scientific coordinator. This indicator will be developed, finalized and compared with other relevant indicators that record child welfare (well-being) and will be implemented in schools of Attica region. The participant/user is the “The Smile of the Child”, which has confirmed in writing its intention to cooperate, and will help focus on necessary information for the study of child welfare. An analysis of the results will be held, which will formulate specific proposals for economic and social policy, mitigation of child poverty and welfare enhancement of children in Greece.', '2014-01-20', '2018-01-20', '48', '28', '54', '191522', '3', '3');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('55', 'Liquid biopsy for the early detection of clinical relapse in patients with operable early stage non-small cell lung cancer and evaluation of genetic heterogeneity', 'Lung cancer is the most common cause of cancer-related mortality worldwide. However, even after complete primary tumor resection, about 45% of early stage NSCLC patients develop local or distant recurrence within 8-18 months. These distant metastases arise from single migratory tumor cells that, detached from the primary tumor, survive in the circulation and, finally, colonize distant target tissue.  The possibility of probing the molecular landscape of solid tumors via a blood draw -termed as ‘liquid biopsy’- with major implications for research and patient care, has attracted remarkable interest among the oncology community. In this proposal, by testing a combined analysis of CTCs, exosomes, cfDNA and cfmiRNAs we aim to: i) monitor MRD during the follow-up of patients with resected NSCLC, and ii) detect disease relapse in advance of established metastatic disease. More specifically, by analysing peripheral blood samples from NSCLC patients that undergo tumor biopsy, we aim to stratify patients in high risk and low risk to develop metastasis.', '2014-01-21', '2018-01-21', '48', '24', '55', '391275', '4', '12');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('56', 'Floating Hybrid Mooring Wind Turbine Energy System (Acronym: FHMES)', 'FHMES (Floating Hybrid Mooring Wind Turbine Energy System) is a contemporary project, aiming at the development and design of a moored steel platform, suitable for offshore wind energy resource exploitation. It involves an interdisciplinary collaboration, which covers all aspects of FHMES platform analysis and design, validated through scaled-down hydrodynamic testing.', '2014-01-22', '2018-01-22', '48', '23', '56', '116973', '5', '12');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('57', 'Plant Growth Promoting Rhizobacteria (PGPR) that alleviate abiotic stress in plants grown in the Mediterranean environment: understanding the biochemical and molecular mechanisms of tolerance', 'Environmental stresses such as drought, or salinity can severely injure plants, triggering a wide range of responses detectable at the physiological, biochemical, and molecular level. The synergistic effect  of the striking losses of crop production and the constantly growing world population is expected to worsen in the future, thus representing a major challenge for current agricultural practices to find solution to the steadily escalating demand for food production. The use of Plant-Growth-Promoting Rhizobacteria (PGPR) can serve as a promising sustainable strategy to improve crop production under sub-optimal conditions. These bacteria are a group of microbes which colonize plant roots and improve plant growth, while some of them may also improve plant tolerance to (a)biotic stress factors.', '2014-01-23', '2018-01-23', '48', '17', '57', '231555', '6', '6');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('58', 'Digitizing the Cappadocian Dialectal Landscape', 'The project aims at the thorough documentation and study of an Asia Minor Greek linguistic variety, in specific the Cappadocian dialect, attempting, for the first time in Greece, to implement a fully digital approach to dialectological research, by applying cutting-edge informatics tools to the study and documentation of dialectal variation. In detail, apart from primary linguistic research leading to the production of scholarly papers advancing our knowledge in the field of Linguistics and Cultural History, the project aims to produce two state-of-the-art major reference works, namely an interactive electronic dialectal atlas (which will constitute the first such effort in the domain of Greek Linguistics) and a comprehensive historical dictionary of the Cappadocian dialects (again lacking until now).', '2014-01-24', '2018-01-24', '48', '33', '58', '157428', '7', '9');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('59', 'NEBULA Neuromorphic Processors based on Quantum-Dot Lasers', 'NEBULA project targets the investigation of cutting edge technologies in the emerging field of photonic neuromorphic engineering. This field, engulfs widespread computational paradigms like neural networks and photonic technology; aiming to merge the low power ultra-fast operation of photonics with the flexibility and computational efficiency of neural-like paradigms. In particular, our efforts will be focused on combining recent advantages in quantum-dot based ultra-fast photonic neurons and a subset of recursive neural networks with unparalleled merits called reservoir computing. Quantum dot photonic structures, due to the 3D spatial confinement of carriers allow an atom-in-a-box like behaviour, thus enabling thermal insensitivity, ultra-fast response time and more importantly multi-band emission capabilities. Especially, this last feature, can provide a fully isomorphic to neural circuits behaviour, by encoding inhibitory and excitatory neural signals as ultra-short pulses from different optical wavelengths. In a complementary direction, reservoir computing is an extremely powerful machine learning paradigm that bypasses the slow-convergence of training by employing nonlinear randomly interconnected recursive neural nodes driven to the edge-of-chaos. The dimensionality increase allows for high efficient prediction or classification of complex time-dependent signals.', '2014-01-25', '2018-01-25', '48', '24', '59', '197513', '8', '2');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('60', 'Sustainable conversion of agro-industrial REsidues and WAste-streams to high-added value CHEMicals (ReWardChem)', 'In the framework of circular economy and green chemistry, increasing scientific effort is placed on the exploitation of waste towards the production of bio-fuels and bio-chemicals. Particular emphasis is assigned to the valorization of waste/residual biomass, as one of the most abundant, renewable and sustainable sources of alternative feedstock, simultaneously fulfilling the need to preserve cultivable land for food production. Thus, ReWardCHEM project’s objective is the development of a sustainable, green, chemo-catalytic route for the valorization of agricultural by-products (e.g. tree branches, cotton mill waste) and food processing waste (e.g. vegetable and fruit kernels, pulp and peel) available in the Southern Mediterranean area and in Greece in particular, so as to produce the high added value versatile platform chemicals gluconic and glucaric acid.  Gluconic and glucaric acids are the products of glucose oxidation. As chemicals they have multiple applications ranging from the alimentary and pharmaceuticals to chemical and materials (polymers) industry. Indicatively, gluconic acid and its derivatives are used as food additives and food acidity regulators, glucaric acid may be used for the synthesis of bio-based adipic acid, while specific glucaric acid salts and lactones possess anti-carcinogenic properties.', '2014-01-26', '2018-01-26', '48', '17', '60', '104106', '9', '8');
INSERT INTO `elidek`.`research` (`research_id`, `title`, `summary`, `start_date`, `end_date`, `duration`, `inst_id`, `senior_scientist_id`, `budget`, `manager_id`, `program_id`) VALUES ('61', 'Design and Development of a Reconfigurable Metamorphic Manipulator System', 'The OVIDIUS proposal aims at the development of an integrated reconfigurable metamorphic open kinematic chain manipulator system, for application in the field of therapeutic and post-op massaging. However, the main aim of the proposal is to provide the means that will enable robotics to achieve a higher configurability level, which is one of the main key technological aspects that will enable the evolution of robotics in the future. OVIDIUS project specific goals are: i) hardware design and development for the structuring of reconfigurable metamorphic open kinematic chain manipulators; ii) software tool development for the kinematic and dynamic modeling of metamorphic manipulators; iii) control scheme development for the proposed reconfigurable metamorphic robot system; iv) the development of optimization methods, for proposed system functionality as well as reconfiguration and metamorphosis; and v) the development of a laboratory TRL level 5 demonstrator.', '2014-01-27', '2018-01-27', '48', '29', '61', '363734', '10', '10');

DROP TABLE IF EXISTS `science_field`;
CREATE TABLE science_field (
	field_id INT UNSIGNED AUTO_INCREMENT,
    title VARCHAR(45) NOT NULL,
    PRIMARY KEY (field_id)
);
delimiter #
create trigger check_unique_field before insert on science_field for each row
	if exists(select * from science_field where science_field.title = new.title)
    then signal sqlstate '45000' set message_text = "science field already exists";
    end if #
delimiter ;

INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('1', 'Life Sciences');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('2', 'Environment Sciences');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('3', 'Social Sciences');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('4', 'Social Anthropology');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('5', 'Natural Sciences');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('6', 'Environment');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('7', 'Climate Change');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('8', 'Human Sciences');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('9', 'Astrophysics');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('10', 'Engineering Sciences');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('11', 'Energy');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('12', 'Neuroscience');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('13', 'Technology Sciences');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('14', 'Agricultural Science');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('15', 'Humanities Studies');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('16', 'Memory Studies');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('17', 'Art');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('18', 'Communication Sciences');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('19', 'Computer Sciences');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('20', 'Informatics');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('21', 'Archaeology');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('22', 'Numismatics');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('23', 'Epigraphy');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('24', 'History');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('25', 'Political Science');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('26', 'Law');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('27', 'Physics');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('28', 'Fundamental Sciences');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('29', 'Contituents of Matter');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('30', 'Structural Biology');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('31', 'Biochemistry');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('32', 'High Energy Physics');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('33', 'Mathematics');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('34', 'Physical Sciences');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('35', 'Developmental Biology');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('36', 'Nanotechnology');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('37', 'Neuroimmunology');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('38', 'Photonics');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('39', 'Neuromorphic');
INSERT INTO `elidek`.`science_field` (`field_id`, `title`) VALUES ('40', 'Lasers');

DROP TABLE IF EXISTS `is_about`;
CREATE TABLE is_about (
    research_id INT UNSIGNED,
    science_field_id INT UNSIGNED,
    FOREIGN KEY (research_id) REFERENCES research (research_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (science_field_id) REFERENCES science_field (field_id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (research_id, science_field_id)
);

INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('1', '1');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('2', '2');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('3', '1');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('4', '5');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('5', '3');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('6', '11');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('6', '6');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('7', '4');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('8', '3');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('9', '1');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('10', '21');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('10', '22');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('10', '23');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('11', '5');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('12', '6');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('12', '7');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('13', '6');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('13', '11');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('14', '1');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('15', '21');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('16', '8');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('17', '9');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('18', '10');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('18', '13');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('19', '12');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('20', '10');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('20', '13');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('21', '14');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('22', '15');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('23', '15');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('24', '2');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('25', '10');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('25', '13');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('26', '1');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('27', '16');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('27', '24');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('27', '25');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('27', '26');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('28', '5');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('28', '27');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('28', '28');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('28', '29');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('29', '10');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('29', '13');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('30', '14');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('31', '1');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('31', '30');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('31', '31');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('32', '5');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('32', '32');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('32', '28');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('32', '29');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('33', '14');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('34', '6');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('34', '11');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('35', '5');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('36', '27');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('37', '3');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('38', '15');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('38', '17');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('39', '10');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('39', '13');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('39', '6');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('39', '11');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('40', '3');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('41', '33');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('41', '18');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('41', '19');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('41', '20');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('42', '10');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('42', '13');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('43', '34');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('44', '3');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('44', '14');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('45', '35');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('46', '3');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('47', '10');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('47', '13');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('47', '36');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('48', '10');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('48', '13');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('49', '14');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('50', '5');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('51', '1');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('51', '12');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('51', '37');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('52', '6');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('52', '11');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('53', '3');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('54', '3');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('55', '1');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('56', '10');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('56', '13');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('57', '14');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('57', '5');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('58', '3');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('59', '5');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('59', '38');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('59', '39');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('59', '40');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('59', '20');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('60', '10');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('60', '13');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('61', '10');
INSERT INTO `elidek`.`is_about` (`research_id`, `science_field_id`) VALUES ('61', '13');

DROP TABLE IF EXISTS `telephone`;
CREATE TABLE telephone (
	tel_id INT UNSIGNED AUTO_INCREMENT,
	tel_number VARCHAR(15) NOT NULL,
    inst_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (inst_id) REFERENCES institute (inst_id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (tel_id)
);

INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('1', '2106875300', '1');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('2', '21 0965 6310', '2');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('3', '231 333 1500', '3');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('4', '231 049 8112', '4');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('5', '21 1106 9599', '5');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('6', '231 049 8272', '6');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('7', '2311 257701', '7');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('8', '241 068 4448', '8');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('9', '2821 037001', '9');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('10', '2821 035000', '10');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('11', '21 0349 0000', '11');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('12', '21 0650 3000', '12');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('13', '25 4107 9575', '13');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('14', '25 4107 9554', '13');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('15', '25 4107 9553', '13');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('16', '210 683 9604', '14');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('17', '210 683 9605', '14');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('18', '21 3000 2400', '15');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('19', '21 0820 3911', '16');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('20', '231 099 6000', '17');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('21', '21 0538 1100', '18');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('22', '21 0529 4900', '19');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('23', '21 0480 1259', '20');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('24', '2531 039000', '21');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('25', '21 0954 9101', '22');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('26', '210 772 1000', '23');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('27', '21 0727 7000', '24');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('28', '261 036 7600', '25');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('29', '2310 807531', '26');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('30', '2310 807577', '26');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('31', '2661 087609', '27');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('32', '21 0920 1001', '28');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('33', '21 0649 2000', '29');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('34', '281 039 3229', '30');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('35', '2651 007777', '31');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('36', '231 089 1101', '32');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('37', '261 099 6683', '33');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('38', '271 023 0000', '34');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('39', '21 1106 9599', '35');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('40', '2810 391500', '36');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('41', '2810 391502', '36');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('42', '210 72 73 516', '37');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('43', '2291076462', '38');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('44', '2421 074000', '39');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('45', '21 0647 8800', '40');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('46', '2821 037001', '41');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('47', '241 068 4448', '42');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('48', '21 0366 4700', '43');
INSERT INTO `elidek`.`telephone` (`tel_id`, `tel_number`, `inst_id`) VALUES ('49', '21 0749 1636', '44');


DROP TABLE IF EXISTS `research_worker`;
CREATE TABLE research_worker(
	worker_id INT UNSIGNED NOT NULL,
    research_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (worker_id) REFERENCES researcher (researcher_id) ,
    FOREIGN KEY (research_id) REFERENCES research (research_id) ,
    PRIMARY KEY (worker_id, research_id)
);
delimiter #
create trigger update_institute_worker before insert on research_worker for each row
	if not exists (select * from institute_worker, research_worker, research
    where institute_worker.worker_id = new.worker_id)
    then insert into institute_worker (worker_id, inst_id) values (new.worker_id, (select research.inst_id from research, institute
																					where research.research_id = new.research_id
																					and research.inst_id = institute.inst_id));
	end if #
delimiter ;

INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('110', '28');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('109', '19');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('108', '3');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('107', '45');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('106', '54');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('105', '2');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('104', '41');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('103', '56');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('102', '46');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('101', '21');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('100', '22');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('99', '26');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('98', '5');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('97', '4');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('96', '49');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('95', '17');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('94', '50');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('93', '11');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('92', '42');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('91', '11');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('90', '52');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('89', '8');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('88', '44');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('87', '13');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('86', '11');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('85', '49');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('84', '18');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('83', '45');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('82', '32');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('81', '60');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('80', '50');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('79', '35');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('78', '36');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('77', '44');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('76', '39');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('75', '38');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('74', '3');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('73', '50');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('72', '43');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('71', '52');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('70', '39');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('69', '35');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('68', '21');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('67', '44');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('66', '59');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('65', '45');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('64', '11');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('63', '52');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('62', '7');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('111', '4');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('112', '1');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('113', '10');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('114', '23');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('115', '46');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('116', '29');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('117', '32');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('118', '45');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('119', '41');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('120', '25');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('121', '28');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('122', '41');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('123', '21');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('124', '49');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('125', '51');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('126', '58');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('127', '2');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('128', '15');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('129', '18');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('130', '22');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('131', '52');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('132', '42');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('133', '10');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('134', '37');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('135', '10');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('136', '28');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('137', '5');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('138', '15');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('139', '55');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('140', '2');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('141', '55');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('142', '48');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('143', '26');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('144', '42');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('145', '16');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('146', '53');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('147', '31');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('148', '43');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('149', '8');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('150', '55');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('151', '32');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('152', '29');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('153', '44');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('154', '18');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('155', '55');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('156', '42');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('157', '49');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('158', '30');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('159', '7');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('160', '28');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('161', '45');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('162', '61');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('163', '23');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('164', '27');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('165', '18');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('166', '39');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('167', '38');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('168', '57');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('169', '20');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('170', '28');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('171', '27');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('172', '25');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('173', '6');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('174', '34');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('175', '48');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('176', '36');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('177', '32');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('178', '15');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('179', '15');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('180', '2');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('181', '8');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('182', '24');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('183', '55');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('184', '60');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('185', '9');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('186', '26');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('187', '61');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('188', '3');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('189', '6');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('190', '53');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('191', '47');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('192', '24');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('193', '35');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('194', '29');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('195', '10');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('196', '35');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('197', '53');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('198', '49');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('199', '18');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('200', '26');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('201', '24');
INSERT INTO `elidek`.`research_worker` (`worker_id`, `research_id`) VALUES ('202', '26');
insert into `elidek`.`research_worker` (worker_id, research_id) values (203, 8);
insert into `elidek`.`research_worker` (worker_id, research_id) values (204, 11);
insert into `elidek`.`research_worker` (worker_id, research_id) values (205, 61);
insert into `elidek`.`research_worker` (worker_id, research_id) values (206, 58);
insert into `elidek`.`research_worker` (worker_id, research_id) values (207, 3);
insert into `elidek`.`research_worker` (worker_id, research_id) values (208, 34);
insert into `elidek`.`research_worker` (worker_id, research_id) values (209, 11);
insert into `elidek`.`research_worker` (worker_id, research_id) values (210, 6);
insert into `elidek`.`research_worker` (worker_id, research_id) values (211, 33);
insert into `elidek`.`research_worker` (worker_id, research_id) values (212, 3);
insert into `elidek`.`research_worker` (worker_id, research_id) values (213, 28);
insert into `elidek`.`research_worker` (worker_id, research_id) values (214, 4);
insert into `elidek`.`research_worker` (worker_id, research_id) values (215, 5);
insert into `elidek`.`research_worker` (worker_id, research_id) values (216, 19);
insert into `elidek`.`research_worker` (worker_id, research_id) values (217, 59);
insert into `elidek`.`research_worker` (worker_id, research_id) values (218, 22);
insert into `elidek`.`research_worker` (worker_id, research_id) values (219, 24);
insert into `elidek`.`research_worker` (worker_id, research_id) values (220, 54);
insert into `elidek`.`research_worker` (worker_id, research_id) values (221, 22);
insert into `elidek`.`research_worker` (worker_id, research_id) values (222, 26);
insert into `elidek`.`research_worker` (worker_id, research_id) values (223, 4);
insert into `elidek`.`research_worker` (worker_id, research_id) values (224, 54);
insert into `elidek`.`research_worker` (worker_id, research_id) values (225, 7);
insert into `elidek`.`research_worker` (worker_id, research_id) values (226, 5);
insert into `elidek`.`research_worker` (worker_id, research_id) values (227, 34);
insert into `elidek`.`research_worker` (worker_id, research_id) values (228, 7);
insert into `elidek`.`research_worker` (worker_id, research_id) values (229, 61);
insert into `elidek`.`research_worker` (worker_id, research_id) values (230, 61);
insert into `elidek`.`research_worker` (worker_id, research_id) values (231, 35);
insert into `elidek`.`research_worker` (worker_id, research_id) values (232, 46);
insert into `elidek`.`research_worker` (worker_id, research_id) values (233, 42);
insert into `elidek`.`research_worker` (worker_id, research_id) values (234, 42);
insert into `elidek`.`research_worker` (worker_id, research_id) values (235, 13);
insert into `elidek`.`research_worker` (worker_id, research_id) values (236, 36);
insert into `elidek`.`research_worker` (worker_id, research_id) values (237, 27);
insert into `elidek`.`research_worker` (worker_id, research_id) values (238, 45);
insert into `elidek`.`research_worker` (worker_id, research_id) values (239, 49);
insert into `elidek`.`research_worker` (worker_id, research_id) values (240, 30);
insert into `elidek`.`research_worker` (worker_id, research_id) values (241, 43);
insert into `elidek`.`research_worker` (worker_id, research_id) values (242, 58);
insert into `elidek`.`research_worker` (worker_id, research_id) values (243, 3);
insert into `elidek`.`research_worker` (worker_id, research_id) values (244, 32);
insert into `elidek`.`research_worker` (worker_id, research_id) values (245, 34);
insert into `elidek`.`research_worker` (worker_id, research_id) values (246, 57);
insert into `elidek`.`research_worker` (worker_id, research_id) values (247, 48);
insert into `elidek`.`research_worker` (worker_id, research_id) values (248, 6);
insert into `elidek`.`research_worker` (worker_id, research_id) values (249, 15);
insert into `elidek`.`research_worker` (worker_id, research_id) values (250, 9);
insert into `elidek`.`research_worker` (worker_id, research_id) values (251, 46);
insert into `elidek`.`research_worker` (worker_id, research_id) values (252, 44);
insert into `elidek`.`research_worker` (worker_id, research_id) values (253, 34);
insert into `elidek`.`research_worker` (worker_id, research_id) values (254, 40);
insert into `elidek`.`research_worker` (worker_id, research_id) values (255, 34);
insert into `elidek`.`research_worker` (worker_id, research_id) values (256, 37);
insert into `elidek`.`research_worker` (worker_id, research_id) values (257, 3);
insert into `elidek`.`research_worker` (worker_id, research_id) values (258, 23);
insert into `elidek`.`research_worker` (worker_id, research_id) values (259, 44);
insert into `elidek`.`research_worker` (worker_id, research_id) values (260, 55);
insert into `elidek`.`research_worker` (worker_id, research_id) values (261, 13);
insert into `elidek`.`research_worker` (worker_id, research_id) values (262, 20);
insert into `elidek`.`research_worker` (worker_id, research_id) values (263, 5);
insert into `elidek`.`research_worker` (worker_id, research_id) values (264, 7);
insert into `elidek`.`research_worker` (worker_id, research_id) values (265, 50);
insert into `elidek`.`research_worker` (worker_id, research_id) values (266, 27);
insert into `elidek`.`research_worker` (worker_id, research_id) values (267, 14);
insert into `elidek`.`research_worker` (worker_id, research_id) values (268, 47);
insert into `elidek`.`research_worker` (worker_id, research_id) values (269, 15);
insert into `elidek`.`research_worker` (worker_id, research_id) values (270, 54);
insert into `elidek`.`research_worker` (worker_id, research_id) values (271, 41);
insert into `elidek`.`research_worker` (worker_id, research_id) values (272, 47);
insert into `elidek`.`research_worker` (worker_id, research_id) values (273, 18);
insert into `elidek`.`research_worker` (worker_id, research_id) values (274, 58);
insert into `elidek`.`research_worker` (worker_id, research_id) values (275, 29);
insert into `elidek`.`research_worker` (worker_id, research_id) values (276, 13);
insert into `elidek`.`research_worker` (worker_id, research_id) values (277, 7);
insert into `elidek`.`research_worker` (worker_id, research_id) values (278, 53);
insert into `elidek`.`research_worker` (worker_id, research_id) values (279, 1);
insert into `elidek`.`research_worker` (worker_id, research_id) values (280, 31);
insert into `elidek`.`research_worker` (worker_id, research_id) values (281, 37);
insert into `elidek`.`research_worker` (worker_id, research_id) values (282, 15);
insert into `elidek`.`research_worker` (worker_id, research_id) values (283, 16);
insert into `elidek`.`research_worker` (worker_id, research_id) values (284, 25);
insert into `elidek`.`research_worker` (worker_id, research_id) values (285, 23);
insert into `elidek`.`research_worker` (worker_id, research_id) values (286, 24);
insert into `elidek`.`research_worker` (worker_id, research_id) values (287, 2);
insert into `elidek`.`research_worker` (worker_id, research_id) values (288, 31);
insert into `elidek`.`research_worker` (worker_id, research_id) values (289, 40);
insert into `elidek`.`research_worker` (worker_id, research_id) values (290, 18);
insert into `elidek`.`research_worker` (worker_id, research_id) values (291, 37);
insert into `elidek`.`research_worker` (worker_id, research_id) values (292, 16);
insert into `elidek`.`research_worker` (worker_id, research_id) values (293, 9);
insert into `elidek`.`research_worker` (worker_id, research_id) values (294, 35);
insert into `elidek`.`research_worker` (worker_id, research_id) values (295, 6);
insert into `elidek`.`research_worker` (worker_id, research_id) values (296, 42);
insert into `elidek`.`research_worker` (worker_id, research_id) values (297, 59);
insert into `elidek`.`research_worker` (worker_id, research_id) values (298, 55);
insert into `elidek`.`research_worker` (worker_id, research_id) values (299, 13);
insert into `elidek`.`research_worker` (worker_id, research_id) values (300, 15);
insert into `elidek`.`research_worker` (worker_id, research_id) values (301, 36);
insert into `elidek`.`research_worker` (worker_id, research_id) values (302, 6);

/*
CREATE TABLE funding (
	program_id INT UNSIGNED NOT NULL,
    research_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (program_id) REFERENCES funding_program (program_id),
    FOREIGN KEY (research_id) REFERENCES research (research_id),
    PRIMARY KEY (program_id, research_id)
);*/
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

INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('62', '1', '9', '2020-01-02');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('63', '2', '10', '2020-01-01');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('64', '3', '9', '2020-01-03');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('65', '4', '8', '2020-01-04');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('66', '5', '9', '2020-01-05');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('67', '6', '10', '2020-01-06');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('68', '7', '10', '2020-01-07');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('69', '8', '10', '2020-01-08');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('70', '9', '7', '2020-01-09');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('71', '10', '9', '2020-01-10');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('72', '11', '8', '2020-01-11');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('73', '12', '10', '2020-01-12');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('74', '13', '7', '2020-01-13');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('75', '14', '9', '2020-01-14');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('76', '15', '9', '2020-01-30');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('77', '16', '8', '2020-01-15');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('78', '17', '7', '2020-01-16');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('79', '18', '10', '2020-01-17');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('80', '19', '9', '2020-01-18');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('81', '20', '9', '2020-01-19');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('82', '21', '7', '2020-01-20');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('83', '22', '7', '2020-01-21');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('84', '23', '7', '2020-01-22');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('85', '24', '10', '2020-01-23');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('86', '25', '7', '2020-01-24');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('87', '26', '9', '2020-01-25');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('88', '27', '8', '2020-01-26');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('89', '28', '10', '2020-01-27');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('90', '29', '8', '2020-01-28');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('91', '30', '10', '2020-01-29');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('92', '31', '10', '2020-01-30');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('93', '32', '7', '2014-01-31');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('94', '33', '7', '2014-02-01');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('95', '34', '9', '2014-02-02');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('96', '35', '8', '2014-01-01');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('97', '36', '10', '2014-01-02');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('98', '37', '8', '2014-01-03');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('99', '38', '7', '2014-01-04');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('100', '39', '8', '2014-01-05');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('101', '40', '8', '2014-01-06');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('102', '41', '10', '2014-01-07');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('103', '42', '8', '2014-01-08');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('104', '43', '7', '2014-01-09');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('105', '44', '9', '2014-01-10');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('106', '45', '10', '2014-01-11');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('107', '46', '9', '2014-01-12');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('108', '47', '7', '2014-01-13');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('109', '48', '8', '2014-01-14');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('110', '49', '8', '2014-01-15');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('62', '50', '10', '2014-01-16');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('63', '51', '7', '2014-01-17');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('64', '52', '8', '2014-01-18');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('65', '53', '10', '2014-01-19');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('66', '54', '8', '2014-01-20');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('67', '55', '7', '2014-01-21');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('68', '56', '10', '2014-01-22');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('69', '57', '10', '2014-01-23');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('70', '58', '9', '2014-01-24');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('71', '59', '9', '2014-01-25');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('72', '60', '8', '2014-01-26');
INSERT INTO `elidek`.`review` (`researcher_id`, `research_id`, `grade`, `review_date`) VALUES ('73', '61', '9', '2014-01-27');


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

/*
elegkse oti oloi oi ereynhtes enos ergoy doyleyoyn gia to idryma
to opoio analambanei to ergo.

elegkse oti oi aksiologhtes enos ergoy den doyleyoyn gia to idryma
to opoio analambanei to ergo.
(edw kalyptetai kai to endexomeno na einai o aksiologhths ereynhths
sto ergo)
*/

delimiter #
create trigger check_reviewer_not_worker before insert on review for each row
	if exists(select * from institute_worker, research, review
    where institute_worker.worker_id = review.reviewer_id
    and research.research_id = review.research_id
    and institute_worker.inst_id = research.inst_id)
    then signal sqlstate '45000' set message_text = "reviewer must not work for the institute carrying out the research";
    end if#
delimiter ;

delimiter #
create trigger check_worker_same_institute before insert on research_worker for each row
	if exists(select * from research, researcher, institute_worker, research_worker
    where research.research_id = research_worker.research_id
	and researcher.researcher_id = research_worker.worker_id
    and researcher.researcher_id = institute_worker.worker_id
    and	not institute_worker.inst_id = research.inst_id)
    then signal sqlstate '45000' set message_text = "researcher institute and research institute must be same";
    end if #
delimiter ;

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `elidek`.`researches_per_worker` AS
    SELECT 
        `res`.`researcher_id` AS `researcher_id`,
        `res`.`first_name` AS `first_name`,
        `res`.`last_name` AS `last_name`,
        `r`.`research_id` AS `research_id`,
        `r`.`title` AS `title`
    FROM
        ((`elidek`.`researcher` `res`
        JOIN `elidek`.`research` `r`)
        JOIN `elidek`.`research_worker`)
    WHERE
        `res`.`researcher_id` = `elidek`.`research_worker`.`worker_id`
            AND `elidek`.`research_worker`.`research_id` = `r`.`research_id`
    ORDER BY `res`.`researcher_id`;

SET FOREIGN_KEY_CHECKS=1;