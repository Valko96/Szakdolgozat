CREATE DEFINER=`nasma1`@`%` PROCEDURE `addUser`(_uuid  varchar(255), _firstname  varchar(255), _lastname varchar(255), _email  varchar(255), _neptun varchar(255))
BEGIN
		DECLARE actual_id int;
        DECLARE tmp_id int;
        
		SELECT count(id) 
        INTO actual_id 
        FROM moodle.mdl_user 
        WHERE username = _uuid;
        
		IF (actual_id = 0) THEN
			insert into moodle.mdl_user (auth, confirmed, mnethostid, username, firstname, lastname, email)
						values('shibboleth', '1', '1', _uuid, _firstname,_lastname,_email);
                        SELECT id 
                        INTO tmp_id
                        FROM moodle.mdl_user where username = _uuid;
        --    update moodle.mdl_user_info_data  set data=_neptun where userid = (SELECT id FROM moodle.mdl_user where username = _uuid);
			insert into moodle.mdl_user_info_data(userid,fieldid,data)
						values(tmp_id,'1',_neptun);
           -- insertre cserélni
		END IF;
	END