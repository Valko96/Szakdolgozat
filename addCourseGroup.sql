CREATE DEFINER=`nasma1`@`%` PROCEDURE `addCourseGroup`(_subjectcode varchar(255), _term varchar(255), _groupcode  varchar(255))
BEGIN
	DECLARE actual_group int;
    DECLARE course_id BIGINT(10);
    
	SELECT COUNT(id)
	INTO actual_group 
    FROM moodle.mdl_groups
	WHERE name = _groupcode;
        
        SELECT id 
        INTO course_id
        FROM moodle.mdl_course
        WHERE idnumber = concat(_subjectcode,'/',_term);
        
         IF (actual_group = 0) THEN
			 insert into moodle.mdl_groups(courseid,idnumber, name,descriptionformat)
			 values (course_id,concat(_subjectcode,'/',_term),_groupcode, '1'); 
		END IF;
       
  END