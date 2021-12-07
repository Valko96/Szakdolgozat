CREATE DEFINER=`nasma1`@`%` PROCEDURE `insert_rows`()
BEGIN
INSERT INTO moodle.mdl_groups_members(groupid, userid) SELECT distinct Vizsga_ID, Neptunkod_ID FROM TMP_from_Neptun;
END