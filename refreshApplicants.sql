CREATE DEFINER=`nasma1`@`%` PROCEDURE `refreshApplicants`()
BEGIN
		/*DECLARE n INT DEFAULT 0;
		DECLARE i INT DEFAULT 0;
		SELECT COUNT(*) FROM tmp_examApplicants INTO n;
		SET i=0;
			WHILE i<n DO 
				insert into moodle.mdl_groups_members(groupid, userid) SELECT Egyedi_vizsga_azonosito, Neptun_kod FROM tmp_examApplicants LIMIT i,1;
				SET i = i + 1;
			END WHILE;@ú*/
  DECLARE Egyedi_vizsga_azonosito VARCHAR(100);
  DECLARE Neptun_kod VARCHAR(10);
  DECLARE azonosito VARCHAR(100) DEFAULT "asd";
  DECLARE N_kod VARCHAR(100);
  DECLARE done INT DEFAULT FALSE;
  DECLARE cursor_i CURSOR FOR SELECT Egyedi_vizsga_azonosito,Neptun_kod FROM tmp_examApplicants;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cursor_i;
  read_loop: LOOP
    FETCH cursor_i INTO azonosito,N_kod;
    IF done THEN
      LEAVE read_loop;
    END IF;
    INSERT INTO moodle.mdl_groups_members(groupid, userID) VALUES(azonosito, N_kod);
  END LOOP;
  CLOSE cursor_i;
		INSERT INTO moodle.mdl_groups_members(groupid, userID) VALUES(azonosito, N_kod);
        
        select * from moodle.mdl_groups_members;
	
    END