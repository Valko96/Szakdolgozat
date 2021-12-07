CREATE DEFINER=`nasma1`@`%` PROCEDURE `delete_rows`()
BEGIN
DELETE FROM moodle.mdl_groups_members where userid in (select Neptunkod_ID from DELTA_TABLE_has_to_remove) and groupid in (select Vizsga_ID from DELTA_TABLE_has_to_remove);
END