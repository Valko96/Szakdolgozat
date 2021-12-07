CREATE DEFINER=`nasma1`@`%` PROCEDURE `createExamGroup`(_subjectcode varchar(255), _term varchar(255), _examstartdate varchar(255), _idnumber varchar(255))
BEGIN
	DECLARE actual_group int;
    DECLARE course_id BIGINT(10);
    
	SELECT COUNT(id)
	INTO actual_group 
    FROM moodle.mdl_groups
	WHERE idnumber = _idnumber;
        
        SELECT id 
        INTO course_id
        FROM moodle.mdl_course
        WHERE idnumber = concat(_subjectcode,'-',_term);
        
         IF (actual_group = 0) THEN
			 insert into moodle.mdl_groups(courseid,idnumber, name,descriptionformat)
			 values (course_id,_idnumber,concat(_subjectcode,'-',_examstartdate), '1'); 
		END IF;
       
  END