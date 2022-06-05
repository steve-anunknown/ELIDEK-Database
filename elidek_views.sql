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

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `elidek`.`researches_per_institute` AS
    SELECT 
        `i`.`inst_id` AS `inst_id`,
        `i`.`inst_name` AS `inst_name`,
        `r`.`title` AS `title`,
        `r`.`research_id` AS `research_id`
    FROM
        (`elidek`.`institute` `i`
        JOIN `elidek`.`research` `r`)
    WHERE
        `r`.`inst_id` = `i`.`inst_id`;


CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `elidek`.`field_data` AS
    SELECT 
        `field_help`.`field_id` AS `field_id`,
        `field_help`.`title` AS `title`,
        `field_help`.`research_id` AS `research_id`
    FROM
        (SELECT 
            `elidek`.`science_field`.`field_id` AS `field_id`,
                `elidek`.`science_field`.`title` AS `title`,
                `elidek`.`is_about`.`research_id` AS `research_id`
        FROM
            (`elidek`.`is_about`
        LEFT JOIN `elidek`.`science_field` ON (`elidek`.`is_about`.`science_field_id` = `elidek`.`science_field`.`field_id`)) UNION SELECT 
            `elidek`.`science_field`.`field_id` AS `field_id`,
                `elidek`.`science_field`.`title` AS `title`,
                `elidek`.`is_about`.`research_id` AS `research_id`
        FROM
            (`elidek`.`science_field`
        LEFT JOIN `elidek`.`is_about` ON (`elidek`.`is_about`.`science_field_id` = `elidek`.`science_field`.`field_id`))) `field_help`
    ORDER BY `field_help`.`field_id`;
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `elidek`.`active_research` AS
    SELECT 
        `elidek`.`research`.`research_id` AS `research_id`,
        `elidek`.`research`.`title` AS `title`,
        `elidek`.`research`.`summary` AS `summary`,
        `elidek`.`research`.`start_date` AS `start_date`,
        `elidek`.`research`.`end_date` AS `end_date`,
        `elidek`.`research`.`duration` AS `duration`,
        `elidek`.`research`.`inst_id` AS `inst_id`,
        `elidek`.`research`.`senior_scientist_id` AS `senior_scientist_id`,
        `elidek`.`research`.`budget` AS `budget`,
        `elidek`.`research`.`manager_id` AS `manager_id`,
        `elidek`.`research`.`program_id` AS `program_id`
    FROM
        `elidek`.`research`
    WHERE
        `elidek`.`research`.`end_date` > CURDATE();

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `elidek`.`institute_per_manager` AS
    SELECT 
        `helpme`.`manager_id` AS `manager_id`,
        `helpme`.`inst_id` AS `inst_id`,
        SUM(`helpme`.`budget`) AS `Total_budget`
    FROM
        (SELECT 
            `elidek`.`research`.`manager_id` AS `manager_id`,
                `elidek`.`research`.`research_id` AS `research_id`,
                `elidek`.`research`.`budget` AS `budget`,
                `elidek`.`research`.`inst_id` AS `inst_id`
        FROM
            (`elidek`.`research`
        JOIN `elidek`.`university` ON (`elidek`.`research`.`inst_id` = `elidek`.`university`.`uni_id`))) `helpme`
    GROUP BY `helpme`.`manager_id` , `helpme`.`inst_id`;

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `elidek`.`corporation_per_manager` AS
    SELECT 
        `researches_held_by_corporations`.`manager_id` AS `manager_id`,
        `researches_held_by_corporations`.`inst_id` AS `inst_id`,
        SUM(`researches_held_by_corporations`.`budget`) AS `Total_budget`
    FROM
        (SELECT 
            `elidek`.`research`.`manager_id` AS `manager_id`,
                `elidek`.`research`.`research_id` AS `research_id`,
                `elidek`.`research`.`budget` AS `budget`,
                `elidek`.`research`.`inst_id` AS `inst_id`
        FROM
            (`elidek`.`research`
        JOIN `elidek`.`corporation` ON (`elidek`.`research`.`inst_id` = `elidek`.`corporation`.`corp_id`))) `researches_held_by_corporations`
    GROUP BY `researches_held_by_corporations`.`manager_id` , `researches_held_by_corporations`.`inst_id`;

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `elidek`.`institute_help` AS
    SELECT 
        `elidek`.`institute`.`inst_id` AS `inst_id`,
        `elidek`.`institute`.`inst_name` AS `inst_name`,
        `elidek`.`institute`.`acronym` AS `acronym`,
        COUNT(`elidek`.`research`.`research_id`) AS `researches_per_year`,
        YEAR(`elidek`.`research`.`start_date`) AS `year`
    FROM
        (`elidek`.`institute`
        JOIN `elidek`.`research` ON (`elidek`.`institute`.`inst_id` = `elidek`.`research`.`inst_id`))
    GROUP BY `elidek`.`institute`.`inst_id` , `elidek`.`institute`.`inst_name` , `elidek`.`institute`.`acronym` , YEAR(`elidek`.`research`.`start_date`);
