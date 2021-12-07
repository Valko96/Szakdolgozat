CREATE DEFINER=`nasma1`@`%` PROCEDURE `enrollStudent`(_subjectcode varchar(100), _term varchar(100), _groupcode varchar(255), _neptun varchar(255), _startdate bigint(10), _enddate bigint(10))
BEGIN
    DECLARE course_id int;
    DECLARE enrol_id int;
    DECLARE user_id int;
    DECLARE group_id int;
    DECLARE context_id int;
        
        SELECT id 
        INTO course_id
        FROM moodle.mdl_course
        WHERE idnumber = concat(_subjectcode,'/',_term);
         
		SELECT userid
		INTO user_id
		FROM moodle.mdl_user_info_data
        WHERE data = _neptun;
        
        SELECT id 
        INTO group_id
        FROM moodle.mdl_groups
        WHERE name = _groupcode;
		
	insert into moodle.mdl_enrol(enrol,status,courseid,sortorder,roleid) -- ez elég az enrol kezdéshez, ennek az id-ját kell menteni
						values('self','0',course_id,'0','5'); -- ebből létrejön egy beiratkozás ID a módszerhez :551
			
        SELECT id 
		INTO enrol_id
        FROM moodle.mdl_enrol
        WHERE enrol = 'self' AND courseid = course_id AND id = (select max(id) from moodle.mdl_enrol where enrol = 'self');
                        
	insert into moodle.mdl_user_enrolments(status, enrolid, userid) -- a fenti manual enrollal insertálni kell a usert és megvan a felületen is
								 values('0',enrol_id, user_id);
                                 
	insert into moodle.mdl_groups_members(groupid, userid)
				values(group_id, user_id);
                
      SELECT id
      INTO context_id
      FROM moodle.mdl_context
      WHERE contextlevel = 50
      AND instanceid = course_id;
      
	insert into moodle.mdl_role_assignments(roleid,userid,contextid) -- kurzus_id legyen változó ahol az instanceid alapján és a kontextlevel alapján kapok id-t
values('5',user_id,context_id);

  END