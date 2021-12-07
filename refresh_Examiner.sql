delimiter $$

CREATE DEFINER=`nasma1`@`%` PROCEDURE `refresh_Examiner`()
BEGIN
    DECLARE _Neptun_kod varchar(10) DEFAULT '';
    DECLARE _Neptunkod_ID varchar(10) DEFAULT '';
    DECLARE n INT DEFAULT 0;
	DECLARE i INT DEFAULT 0;
    DECLARE deltasize INT DEFAULT 0;
    
    SELECT COUNT(*) FROM TMP_from_Neptun INTO n;
    CREATE OR REPLACE TABLE DELTA_TABLE_both_includes as (select * from TMP_from_Neptun_KORABBI where Egyedi_hash in (SELECT TFNK.Egyedi_hash from TMP_from_Neptun TFN JOIN TMP_from_Neptun_KORABBI TFNK ON TFN.Egyedi_hash = TFNK.Egyedi_hash));
    CREATE OR REPLACE TABLE DELTA_TABLE_has_to_remove as (select * from TMP_from_Neptun_KORABBI where Egyedi_hash not in (SELECT TFNK.Egyedi_hash from TMP_from_Neptun TFN JOIN TMP_from_Neptun_KORABBI TFNK ON TFN.Egyedi_hash = TFNK.Egyedi_hash));
	SET i=1;
    WHILE i<=n DO 
			SELECT Neptun_kod
            INTO _Neptun_kod
            FROM TMP_from_Neptun
            WHERE ID =  i;
            SET _Neptunkod_ID = (select id from moodle.mdl_user where idnumber = _Neptun_kod);
			UPDATE TMP_from_Neptun set Neptunkod_ID = _Neptunkod_ID where ID = i;
			SET i = i + 1;
	END WHILE;
			
				DELETE FROM TMP_from_Neptun where Egyedi_hash in (select Egyedi_hash FROM DELTA_TABLE_both_includes);
     IF ( (select count(*) from DELTA_TABLE_has_to_remove) != 0) THEN
				call delete_rows();
                DELETE FROM TMP_from_Neptun_KORABBI where Egyedi_hash in (select Egyedi_hash FROM DELTA_TABLE_has_to_remove);
     END IF;
	SELECT COUNT(*) FROM TMP_from_Neptun INTO n;
		   -- IF ( (select count(*) from DELTA_TABLE_has_to_remove) != 0) THEN
			 call insert_rows();
          -- END IF;
	  IF (n != 0) THEN
			INSERT INTO TMP_from_Neptun_KORABBI select * from TMP_from_Neptun;
		END IF;
        
     truncate table TMP_from_Neptun;
   END$$

