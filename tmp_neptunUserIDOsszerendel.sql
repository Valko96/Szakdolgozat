CREATE DEFINER=`nasma1`@`%` PROCEDURE `tmp_neptunUserIDOsszerendel`()
BEGIN
		DECLARE n INT DEFAULT 0;
		DECLARE i INT DEFAULT 0;
        DECLARE _Vizsga_ID varchar(200);
		DECLARE _Neptun_kod varchar(10);
        DECLARE _Egyedi_hash varchar(200);
		SET i=1;
        SELECT COUNT(*) FROM TMP_from_Neptun INTO n;
		WHILE i<=n DO 
			SELECT Vizsga_ID,Neptun_kod
            INTO _Vizsga_ID,_Neptun_kod
            FROM TMP_from_Neptun
            WHERE ID = i;
            SET _Egyedi_hash = MD5(concat(_Vizsga_ID,_Neptun_kod));
			UPDATE TMP_from_Neptun set Egyedi_hash = _Egyedi_hash where ID = i;
			SET i = i + 1;
		END WHILE;
END