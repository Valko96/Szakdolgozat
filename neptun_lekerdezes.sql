
select 
  * 
from 
  (
    SELECT 
      t110.C_FROMDATE AS "Vizsgakezdete", 
      t110.C_IDENTIFIER || '_' || t100.C_CODE AS "Egyediazonosito", 
      t121.C_NEPTUNCODE AS "Neptunkod", 
      t100.C_IDENTIFIER AS "Kurzuskod", 
      (
        SELECT 
          d.C_NAME 
        FROM 
          T_DICTIONARYITEMBASE d 
        WHERE 
          d.ID = t100.C_TERM
      ) AS "term", 
      'examinee' AS "Role", 
      t130.LASTCHANGED AS "modositas datuma", 
      t130.CREATED AS "letrehozas datuma", 
      t130.CREATOR AS "letrehozo", 
      t130.MODIFIER AS "modosito", 
      "insert into TMP_from_Neptun(Vizsga_ID, Vizsga_kezdete, Neptun_kod, Kurzskod) VALUES('" || t110.C_IDENTIFIER || '_' || t100.C_CODE || "'," || "CONVERT('" || t110.C_FROMDATE || "',datetime), '" || t121.C_NEPTUNCODE || "','" || t100.C_IDENTIFIER || AS "string beszurni" 
    FROM 
      T_EXAM t110, 
      T_CourseExam t17, 
      T_EXAMSIGNIN t130, 
      T_PARTNER t120, 
      T_USER t121, 
      T_STUDENT t122, 
      T_COURSE t100, 
      T_ORGANIZATION t140, 
      T_INTERIORORGANIZATION t141 
    WHERE 
      t100.C_INTERIORORGANIZATIONID = t141.ID 
      AND t110.ID = t130.C_EXAMID 
      AND t110.ID = t17.C_EXAMID 
      AND t17.C_COURSEID = t100.ID 
      AND t120.ID = t121.ID 
      AND t121.ID = t122.ID 
      AND t130.C_STUDENTID = t122.ID 
      AND t140.ID = t141.ID --  (t140.C_CODE LIKE 'I%')
    UNION 
    SELECT 
      t130.C_FROMDATE AS "Vizsga kezdete", 
      t130.C_IDENTIFIER || '_' || t100.C_CODE AS "Egyediazonosito", 
      t111.C_NEPTUNCODE AS "Neptunkod", 
      t100.C_IDENTIFIER AS "Kurzuskod", 
      (
        SELECT 
          d.C_NAME 
        FROM 
          T_DICTIONARYITEMBASE d 
        WHERE 
          d.ID = t100.C_TERM
      ) AS "term", 
      'examiner' AS "Role", 
      t18.CREATED AS "letrehozas datuma", 
      t18.LASTCHANGED AS "modositas datuma", 
      t18.CREATOR AS "lrtrehozo", 
      t18.MODIFIER AS "modosito", 
      "INSERT INTO TMP_from_Neptun(Vizsga_ID, Vizsga_kezdete, Neptun_kod, Kurzskod) VALUES('" || t130.C_IDENTIFIER || '_' || t100.C_CODE || "'," || "CONVERT('" || t130.C_FROMDATE || "',datetime), '" || t111.C_NEPTUNCODE || "','" || t100.C_IDENTIFIER || AS "string beszurni" 
    FROM 
      T_EXAM t130, 
      T_CourseExam t17, 
      T_ExamTutor t18, 
      T_COURSE t100, 
      T_ORGANIZATION t140, 
      T_INTERIORORGANIZATION t141, 
      T_PARTNER t120, 
      T_USER t121, 
      T_EMPLOYEE t122, 
      T_PARTNER t110, 
      T_USER t111, 
      T_EMPLOYEE t112 
    WHERE 
      t100.C_INTERIORORGANIZATIONID = t141.ID 
      AND t110.ID = t111.ID 
      AND t111.ID = t112.ID 
      AND t120.ID = t121.ID 
      AND t121.ID = t122.ID 
      AND t121.ID = t110.C_OWNERID 
      AND t130.ID = t17.C_EXAMID 
      AND t17.C_COURSEID = t100.ID 
      AND t130.ID = t18.C_EXAMID 
      AND t18.C_TUTORID = t122.ID 
      AND t140.ID = t141.ID --  (t140.C_CODE LIKE 'I%')
      ) 
WHERE 
  "term" = '2020/21/2' 
ORDER BY 
  2 DESC
