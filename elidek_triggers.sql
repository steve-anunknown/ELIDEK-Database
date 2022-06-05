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


delimiter #
create trigger check_senior_scientist before insert on research for each row
if (exists(select * from institute_worker as iw, research as res
		where iw.worker_id = new.senior_scientist_id
        and not iw.inst_id = new.inst_id))
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

delimiter #
create trigger update_institute_worker before insert on research_worker for each row
	if not exists (select * from institute_worker, research_worker, research
    where institute_worker.worker_id = new.worker_id)
    then insert into institute_worker (worker_id, inst_id) values (new.worker_id, (select research.inst_id from research, institute
																					where research.research_id = new.research_id
																					and research.inst_id = institute.inst_id));
	end if #
delimiter ;

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