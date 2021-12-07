CREATE DEFINER=`nasma1`@`%` PROCEDURE `addCourse`( _subjectcode VARCHAR(90), _term VARCHAR(9), _shortname VARCHAR(255),_name VARCHAR(255),_lang VARCHAR(255), _faculty VARCHAR(255), _startdate bigint(10),_enddate bigint(10))
BEGIN
		DECLARE actual_course int DEFAULT 0;
        DECLARE countrows int;
        DECLARE to_category int;
        
        SELECT id 
		INTO to_category
        FROM moodle.mdl_course_categories
        WHERE name = concat(_faculty,'/',_term);
        
		SELECT count(shortname) 
        INTO actual_course
        FROM moodle.mdl_course 
        WHERE shortname = _shortname;
        
        SELECT max(sortorder)+1
        INTO countrows
        FROM moodle.mdl_course;
        -- todo max sortodert kivenni +1eé hozzáadni az inserthez
        
        IF (actual_course = 0) THEN
			 insert into moodle.mdl_course (sortorder,category,idnumber,fullname, shortname,visible,lang, startdate,enddate) -- a dátumok viccesek meg kell majd nézni mi ez, a term nem látom melyik oszlop lesz
			 values (countrows,to_category,concat(_subjectcode,'/',_term), concat('[', _subjectcode,'] ', _name), _shortname,'1',_lang, _startdate, _enddate);	-- code gondolom az id de az még csak itt jön létre 
		END IF;
	END