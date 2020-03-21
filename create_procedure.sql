--------------------------------------------------------
--  File created - Thursday-January-25-2018   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure PROC_LOB_TEST
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "TEST_USER"."PROC_LOB_TEST" AS 
 a_clob CLOB := EMPTY_CLOB();
 a_bfile BFILE := BFILENAME ('MY_DIR3','first.txt');
 n NUMBER;
 l_out CLOB; -- := EMPTY_CLOB();
 
 /* demo the use of 2 CLOBS */
 
BEGIN
 DBMS_LOB.FILECLOSEALL; -- closing all open LOBs
 UPDATE myCollType SET CLOB_DATA = EMPTY_CLOB() WHERE ID = 3 RETURNING clob_data INTO l_out; -- Incase to update an existing record with LOB
 --INSERT INTO myCollType(id,clob_data) VALUES (3,empty_clob()) RETURNING clob_data INTO a_clob; -- Incase to insert a new record
 DBMS_LOB.FILEOPEN(a_bfile);
 DBMS_LOB.LOADFROMFILE(l_out,a_bfile,DBMS_LOB.GETLENGTH(a_bfile));
 --DBMS_LOB.LOADFROMFILE(l_out,a_bfile,DBMS_LOB.LOBMAXSIZE); -- This also works
 DBMS_LOB.FILECLOSE(a_bfile);
 COMMIT;
 
 SELECT clob_data INTO a_clob FROM myCollType WHERE id = 3;
 n := DBMS_LOB.GETLENGTH(a_clob);
 DBMS_OUTPUT.PUT_LINE(n);
 
END PROC_LOB_TEST;

/
