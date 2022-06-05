# =======================
#       QUERY 3.4
# =======================

SELECT 
    institute_1.inst_id, 
    institute_1.inst_name, 
    institute_1.acronym, 
    institute_1.researches_per_year, 
    institute_1.year AS year_1, 
    institute_2.year AS year_2 
FROM 
    institute_help AS institute_1, 
    institute_help AS institute_2 
WHERE 
    institute_1.inst_id = institute_2.inst_id 
        AND institute_1.researches_per_year = institute_2.researches_per_year 
        AND institute_1.year = institute_2.year - 1 
        AND institute_1.researches_per_year >= 2 
ORDER BY institute_1.researches_per_year , institute_1.inst_id , institute_1.year; 


# =======================
#       QUERY 3.5
# =======================

CREATE VIEW field_data AS
    SELECT 
        *
    FROM
        (SELECT 
            science_field.field_id,
                science_field.title,
                is_about.research_id
        FROM
            is_about
        LEFT JOIN science_field ON is_about.science_field_id = science_field.field_id UNION SELECT 
            science_field.field_id,
                science_field.title,
                is_about.research_id
        FROM
            is_about
        RIGHT JOIN science_field ON is_about.science_field_id = science_field.field_id) AS field_help
    ORDER BY field_help.field_id;

SELECT 
    COUNT(research_id) AS Total_Researches,
    field_1_title AS Field_1,
    field_2_title AS Field_2
FROM
    (SELECT 
        field_1.research_id,
            field_1.field_id AS field_1_id,
            field_2.field_id AS field_2_id,
            field_1.title AS field_1_title,
            field_2.title AS field_2_title
    FROM
        field_data AS field_1, field_data AS field_2
    WHERE
        field_1.research_id = field_2.research_id
            AND field_1.field_id < field_2.field_id) AS pair_of_fields
GROUP BY field_1_title , field_2_title
ORDER BY COUNT(research_id) DESC , field_1_title , field_2_title
LIMIT 3;


# =======================
#       QUERY 3.6
# =======================

CREATE VIEW active_research AS
    SELECT 
        *
    FROM
        research
    WHERE
        research.end_date > CURDATE();


SELECT 
    Active_researches, researcher.*
FROM
    researcher
        INNER JOIN
    (SELECT 
        research_worker.worker_id,
            COUNT(research_worker.research_id) AS Active_researches
    FROM
        research_worker
    INNER JOIN active_research ON research_worker.research_id = active_research.research_id
    GROUP BY research_worker.worker_id) AS researcher_projects ON researcher_projects.worker_id = researcher.researcher_id
WHERE
    researcher.age < 40
ORDER BY Active_researches DESC , researcher_id; 


# =======================
# Error Code: 4025. CONSTRAINT `CONSTRAINT_1` failed for `elidek`.`research`
#       QUERY 3.7
# =======================

SELECT 
    elidek_manager.*,
    SUM(funding_program.budget) AS Total_budget
FROM
    elidek_manager
        INNER JOIN
    funding_program ON elidek_manager.elidek_address = funding_program.elidek_address
GROUP BY elidek_manager.manager_id
ORDER BY SUM(funding_program.budget) DESC
LIMIT 5;


# =======================
#       QUERY 3.8
# =======================

SELECT 
    worker_id, COUNT(research_id) AS `Researches without reports` 
FROM 
    research_worker 
WHERE 
    EXISTS( SELECT 
            research_id 
        FROM 
            research_worker 
        WHERE 
            NOT EXISTS( SELECT 
                    research_id 
                FROM 
                    report) 
        GROUP BY research_id) 
GROUP BY worker_id 
HAVING COUNT(research_id) >= 1 
ORDER BY COUNT(research_id) DESC;
