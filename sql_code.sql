drop database joc;
create database joc;
use joc;

CREATE TABLE IF NOT EXISTS tip_joc(
id INT(20) UNIQUE AUTO_INCREMENT PRIMARY KEY,
nume_tip VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS jucatori(
ID_jucator INT UNIQUE AUTO_INCREMENT PRIMARY KEY,
Nume VARCHAR(30) UNIQUE,
Data_inscrierii DATE,
Data_nasterii DATE,
nr_jocuri_castigate INT,
nr_jocuri_pierdute INT,
id_tip_joc INT(20),
INDEX(id_tip_joc),
FOREIGN KEY (id_tip_joc) REFERENCES tip_joc(id)
);

CREATE TABLE IF NOT EXISTS jocuri(
ID_joc INT UNIQUE AUTO_INCREMENT PRIMARY KEY,
ID_jucator1 INT ,
ID_jucator2 INT ,
ID_invingator INT,
nr_partide_jucate INT(100),
nr_partide INT(100),
data_inceput_joc DATE NOT NULL,
data_sfarsit_joc DATE,
scor_jucator1 INT(2),
scor_jucator2 INT(2),
id_tip_joc INT(20),
INDEX(ID_joc),
FOREIGN KEY (id_tip_joc) REFERENCES tip_joc (id)
);

CREATE TABLE IF NOT EXISTS joc_activ(
id INT AUTO_INCREMENT UNIQUE PRIMARY KEY,
ID_jucator1 INT ,
ID_jucator2 INT ,
data_inceput_joc DATE NOT NULL,
nr_partide_jucate INT(100),
nr_partide INT(100),
id_tip_joc INT(20),
INDEX(id_tip_joc),
INDEX(id),
FOREIGN KEY (id_tip_joc) REFERENCES tip_joc(id),
FOREIGN KEY (id) REFERENCES jocuri(ID_joc)
);

CREATE TABLE IF NOT EXISTS jucator1(
id INT UNIQUE PRIMARY KEY,
scor INT,
id_joc_activ INT,
INDEX(id),
INDEX(id_joc_activ),
FOREIGN KEY (id) REFERENCES jucatori(ID_jucator),
FOREIGN KEY (id_joc_activ) REFERENCES joc_activ(id)
);

CREATE TABLE IF NOT EXISTS jucator2(
id INT UNIQUE PRIMARY KEY,
scor INT,
id_joc_activ INT,
INDEX(id),
INDEX(id_joc_activ),
FOREIGN KEY (id) REFERENCES jucatori(ID_jucator),
FOREIGN KEY (id_joc_activ) REFERENCES joc_activ(id)
);

ALTER TABLE joc_activ
ADD CONSTRAINT FK_jucator1
FOREIGN KEY (ID_jucator1) REFERENCES jucator1(id);

ALTER TABLE joc_activ
ADD CONSTRAINT FK_jucator2
FOREIGN KEY (ID_jucator2) REFERENCES jucator2(id);

insert into tip_joc
(nume_tip)
VALUES
('Sah'),
('Table');

DROP PROCEDURE IF EXISTS INSERARE_JUCATORI;
DELIMITER //

CREATE PROCEDURE
INSERARE_JUCATORI(IN p_nume VARCHAR(30), IN p_data_inscrierii DATE, IN p_data_nasterii DATE, IN p_nr_jocuri_castigate INT, IN p_nr_jocuri_pierdute INT, IN p_id_tip_joc INT(20))
	BEGIN
		IF p_data_inscrierii > p_data_nasterii AND p_data_inscrierii < curdate() THEN
         insert into jucatori
			(nume, data_inscrierii, data_nasterii, nr_jocuri_castigate, nr_jocuri_pierdute, id_tip_joc)
		VALUES
			(p_nume, p_data_inscrierii, p_data_nasterii, p_nr_jocuri_castigate, p_nr_jocuri_pierdute, p_id_tip_joc);
		END IF;
    END; //
DELIMITER ;

#Inserare jucatori de sah

call INSERARE_JUCATORI('Tudor Pal', '2009-07-28', '2001-01-31', 190, 220, 1);				# 18 - 40
call INSERARE_JUCATORI('Jacob Aagaard', '1985-06-27', '1980-02-21', 589, 572, 1); 			# 40 - 50 
call INSERARE_JUCATORI('Leonardo Dicaprio', '1975-01-30', '1968-05-23', 1200, 1039, 1);  	# >50
call INSERARE_JUCATORI('Magnus Carlsen', '1995-02-03', '1990-11-30', 630, 500, 1);			# 18 - 40
call INSERARE_JUCATORI('Alireza Firouzja', '2012-09-22', '2008-04-18', 178, 152, 1);		# 10 - 18 
call INSERARE_JUCATORI('Fabiano Caruana', '2001-01-31', '1994-11-07', 399, 400, 1);			# 18 - 40 
call INSERARE_JUCATORI('Ian Nepomniachtchi', '1981-02-22', '1975-08-28', 720, 695, 1);  	# 40 - 50 
call INSERARE_JUCATORI('Hugh Heffner', '2009-12-14', '2006-02-09', 200, 180, 1);			# 10 - 18
call INSERARE_JUCATORI('Hikaru Nakamura', '2018-02-20', '2014-03-31', 15, 20, 1); 			# <10 
call INSERARE_JUCATORI('Ding Liren', '2017-09-30', '2012-12-25', 23, 18, 1); 				# <10 
call INSERARE_JUCATORI('Gica Hagi', '1977-08-18', '1965-10-06', 1129, 1280, 1);  			# >50
call INSERARE_JUCATORI('Dan Petrescu', '1983-11-30', '1978-07-08', 589, 572, 1); 			# 40 - 50 

#Inserare jucatori de table

call INSERARE_JUCATORI('Anish Giri', '1997-11-28', '1992-01-09', 280, 230, 2);				# 18 - 40
call INSERARE_JUCATORI('Wesley So', '2012-08-08', '2007-10-09', 170, 187, 2);				# 10 - 18
call INSERARE_JUCATORI('Toby Maguire', '1960-01-13', '1954-12-07', 1490, 1300, 2);			# >50
call INSERARE_JUCATORI('Levon Aronian', '1986-12-15', '1982-10-06', 417, 320, 2);			# 18 - 40
call INSERARE_JUCATORI('Tom Holland', '2010-12-22', '2006-03-14', 210, 190, 2);				# 10 - 18
call INSERARE_JUCATORI('Barry Allen', '2019-03-19', '2013-09-26', 59, 46, 2);				# <10
call INSERARE_JUCATORI('Alexander Grischuk', '1990-04-10', '1981-12-31', 450, 388, 2);		# 40 - 50
call INSERARE_JUCATORI('Ion Popescu', '1999-10-10', '1990-04-25', 217, 250, 2);				# 18 - 40
call INSERARE_JUCATORI('Marian Costea', '2019-03-19', '2015-01-16', 43, 31, 2);				# <10
call INSERARE_JUCATORI('Idris Elba', '1963-08-08', '1950-11-01', 1329, 1230, 2);			# >50
call INSERARE_JUCATORI('Andrew Garfield', '1988-07-20', '1979-04-19', 782, 600, 2);			# 40 - 50

DROP PROCEDURE IF EXISTS INSERARE_JOCURI;
DELIMITER //

CREATE PROCEDURE 
INSERARE_JOCURI(IN p_ID_joc INT, IN p_ID_jucator1 INT, IN p_ID_jucator2 INT, IN p_ID_invingator INT, IN p_nr_partide_jucate INT(100), IN p_nr_partide INT(100), IN p_data_inceput_joc DATE, IN p_data_sfarsit_joc DATE, IN p_scor_jucator1 INT(2), IN p_scor_jucator2 INT(2), IN p_id_tip_joc INT(20))   
  BEGIN 
    IF p_data_sfarsit_joc IS NULL THEN
        insert into joc_activ
			(id, ID_jucator1, ID_jucator2, nr_partide_jucate, nr_partide, data_inceput_joc, id_tip_joc)
		VALUES
			(p_ID_joc, p_ID_jucator1, p_ID_jucator2, p_nr_partide_jucate, p_nr_partide, p_data_inceput_joc, p_id_tip_joc);
		insert into jucator1
			(id, id_joc_activ)
		VALUES
			(p_ID_jucator1, p_ID_joc);
		insert into jucator2
			(id, id_joc_activ)
		VALUES
			(p_ID_jucator2, p_ID_joc);
    END IF;
	insert into jocuri
		(ID_joc, ID_jucator1, ID_jucator2, ID_invingator, nr_partide_jucate, nr_partide, data_inceput_joc, data_sfarsit_joc, scor_jucator1, scor_jucator2, id_tip_joc)
	VALUES
		(p_ID_joc,p_ID_jucator1, p_ID_jucator2, p_ID_invingator, p_nr_partide_jucate, p_nr_partide, p_data_inceput_joc, p_data_sfarsit_joc, p_scor_jucator1, p_scor_jucator2, p_id_tip_joc);
  END; //
DELIMITER ;

SET FOREIGN_KEY_CHECKS=0;

call INSERARE_JOCURI(1, 8, 9, NULL, 6, 11,'2022-01-10', NULL, 3, 3, 1); 
call INSERARE_JOCURI(2, 1, 3, 1, 7, 11,'2010-02-09', '2010-03-07', 4, 3, 1);			# 2010
call INSERARE_JOCURI(3, 2, 4, 4, 11, 13,'2009-12-28', '2010-01-15', 5, 6, 1);			# 2010
call INSERARE_JOCURI(4, 3, 4, 3, 7, 9,'2005-05-12', '2005-06-17', 4, 3, 1);
call INSERARE_JOCURI(5, 3, 5, 3, 4, 7,'2018-02-24', '2018-03-08', 4, 0, 1);
call INSERARE_JOCURI(6, 8, 4, 4, 10, 11,'2010-01-02', '2010-01-27', 4, 6, 1);			# 2010
call INSERARE_JOCURI(7, 9, 10, 10, 7, 7,'2021-11-10', '2021-12-01', 3, 4, 1);
call INSERARE_JOCURI(8, 1, 8, 1, 15, 15,'2010-11-01', '2010-11-15', 8, 7, 1);			# 2010 (NU)
call INSERARE_JOCURI(9, 12, 7, 7, 12, 15,'2020-09-15', '2020-11-15', 4, 8, 1);
call INSERARE_JOCURI(10, 6, 11, 6, 5, 5,'2010-01-31', '2010-02-07', 3, 2, 1);			# 2010
call INSERARE_JOCURI(11, 7, 2, 7, 8, 9,'2010-02-15', '2010-02-28', 5, 3, 1);			# 2010
call INSERARE_JOCURI(12, 5, 10, 5, 3, 3,'2019-09-20', '2019-09-24', 2, 1, 1);
call INSERARE_JOCURI(13, 8, 12, 12, 5, 5,'2010-03-14', '2010-03-31', 2, 3, 1);			# 2010

call INSERARE_JOCURI(14, 13, 15, 13, 15, 17,'2010-01-11', '2010-01-21', 8, 7, 2);		# 2010			
call INSERARE_JOCURI(15, 21, 18, 18, 13, 19,'2021-06-28', '2021-07-30', 3, 10, 2);
call INSERARE_JOCURI(16, 16, 20, 20, 11, 13,'2010-03-18', '2010-03-25', 7, 6, 2);		# 2010
call INSERARE_JOCURI(17, 22, 14, 22, 7, 7,'2010-02-01', '2010-02-09', 4, 3, 2);			# 2010
call INSERARE_JOCURI(18, 17, 23, 23, 8, 9,'2016-08-20', '2016-08-30', 6, 7, 2);
call INSERARE_JOCURI(19, 15, 20, 15, 5, 5,'2019-03-19', '2019-04-19', 3, 2, 2);
call INSERARE_JOCURI(20, 19, 13, 13, 10, 15,'2010-02-01', '2010-02-09', 2, 8, 2);			# 2010
call INSERARE_JOCURI(21, 14, 17, 14, 6, 7,'2019-03-19', '2019-04-19', 4, 2, 2);

DROP PROCEDURE IF EXISTS CREARE_JOC;
DELIMITER //

CREATE PROCEDURE 
CREARE_JOC(IN nume1 VARCHAR(40), IN nume2 VARCHAR(40), IN p_nr_partide INT(100), IN p_id_tip_joc INT(20), IN p_id_joc INT)
	BEGIN
    START TRANSACTION;
		SET @ID_J1 := NULL, @ID_J2 := NULL, @p_data_inceput_joc := curdate();
        
        SELECT @ID_J1 := ID_jucator FROM jucatori WHERE Nume LIKE nume1;
        SELECT @ID_J2 := ID_jucator FROM jucatori WHERE Nume LIKE nume2;
        
        IF(p_nr_partide %2 = 1) THEN
			BEGIN
				call INSERARE_JOCURI(p_id_joc, @ID_J1, @ID_J2, NULL, 0, p_nr_partide, @p_data_inceput_joc, NULL, 0, 0, p_id_tip_joc); 
				COMMIT;
            END;
		ELSE ROLLBACK;
        END IF;
        
	END;
    
call CREARE_JOC('Gica Hagi', 'Dan Petrescu', 9, 1, 22);

DROP TRIGGER IF EXISTS adauga_invingator;

delimiter //

CREATE TRIGGER adauga_invingator AFTER UPDATE ON joc_activ
  FOR EACH ROW BEGIN
	IF (scor_jucator1 > nr_partide/2 OR scor_jucator2 > nr_partide/2) THEN
		IF (scor_jucator1 > scor_jucator2) THEN
			INSERT INTO  jocuri 
			(ID_invingator, data_sfarsit_joc) VALUES 
			(ID_jucator1, curdate());
		ELSE 
			INSERT INTO jocuri
            (ID_invingator, data_sfarsit_joc) VALUES
            (ID_jucator2, curdate());
		END IF;
     END IF;
  END; //

delimiter ;

# f) jocurile dintre 1 ian 2010 - 4 apr 2010 sortate dupa tip joc si data inceput

SELECT ID_joc AS 'Id Joc', nume_tip AS 'Tip Joc', nr_partide AS 'Nr Partide', data_inceput_joc AS 'Data Inceput_joc', data_sfarsit_joc AS 'Data Sfarsit_joc',DATEDIFF(data_sfarsit_joc, data_inceput_joc) AS 'Durata Joc (zile)', Nume AS 'Invingator' FROM jocuri JOIN tip_joc JOIN jucatori
WHERE jocuri.id_tip_joc = tip_joc.id AND jocuri.data_sfarsit_joc >= '2010-01-01' AND jocuri.data_sfarsit_joc <= '2010-04-01' AND jocuri.ID_invingator = jucatori.ID_jucator
ORDER BY nume_tip, data_inceput_joc;

# g) cel mai bun jucator de sah

SELECT nr_jocuri_castigate*100/(nr_jocuri_castigate+nr_jocuri_pierdute) AS 'Procentaj castig', nume FROM jucatori
WHERE id_tip_joc = 1
ORDER BY nr_jocuri_castigate*100/(nr_jocuri_castigate+nr_jocuri_pierdute) DESC;

# h) jucatorul care a participat la cele mai multe jocuri

SELECT nr_jocuri_castigate+nr_jocuri_pierdute AS 'Total jocuri', nume, nume_tip AS 'Tip Joc' FROM jucatori JOIN tip_joc
WHERE jucatori.id_tip_joc = tip_joc.id
ORDER BY nr_jocuri_castigate+nr_jocuri_pierdute DESC limit 1;

# i) pentru fiecare jucator, jocurile la care acesta a participat

SELECT nume AS 'Nume', ID_joc AS 'Id Joc', nume_tip AS 'Tip Joc', data_inceput_joc, data_sfarsit_joc, IF(ID_invingator = ID_jucator, "DA", "NU") AS 'Castigator' FROM jucatori JOIN jocuri JOIN tip_joc
WHERE jocuri.id_tip_joc = tip_joc.id AND (jucatori.ID_jucator = jocuri.ID_jucator1 OR jucatori.ID_jucator = jocuri.ID_jucator2)
ORDER BY nume;

# j) cel mai bun jucator de sah <10

SELECT nr_jocuri_castigate*100/(nr_jocuri_castigate+nr_jocuri_pierdute) AS 'Procentaj castig', nume FROM jucatori
WHERE timestampdiff(year, data_nasterii, curdate()) < 10 AND id_tip_joc = 1
ORDER BY nr_jocuri_castigate*100/(nr_jocuri_castigate+nr_jocuri_pierdute) DESC limit 1;


# j) cel mai bun jucator de table <10

SELECT nr_jocuri_castigate*100/(nr_jocuri_castigate+nr_jocuri_pierdute) AS 'Procentaj castig', nume FROM jucatori
WHERE timestampdiff(year, data_nasterii, curdate()) < 10 AND id_tip_joc = 2
ORDER BY nr_jocuri_castigate*100/(nr_jocuri_castigate+nr_jocuri_pierdute) DESC limit 1;

# j) cel mai bun jucator de sah 10 - 18

SELECT nr_jocuri_castigate*100/(nr_jocuri_castigate+nr_jocuri_pierdute) AS 'Procentaj castig', nume FROM jucatori
WHERE timestampdiff(year, data_nasterii, curdate()) >= 10 AND timestampdiff(year, data_nasterii, curdate()) <= 18 AND id_tip_joc = 1
ORDER BY nr_jocuri_castigate*100/(nr_jocuri_castigate+nr_jocuri_pierdute) DESC limit 1;

# j) cel mai bun jucator de table 10 - 18

SELECT nr_jocuri_castigate*100/(nr_jocuri_castigate+nr_jocuri_pierdute) AS 'Procentaj castig', nume FROM jucatori
WHERE timestampdiff(year, data_nasterii, curdate()) >= 10 AND timestampdiff(year, data_nasterii, curdate()) <= 18 AND id_tip_joc = 2
ORDER BY nr_jocuri_castigate*100/(nr_jocuri_castigate+nr_jocuri_pierdute) DESC limit 1;

# j) cel mai bun jucator de sah 18 - 40

SELECT nr_jocuri_castigate*100/(nr_jocuri_castigate+nr_jocuri_pierdute) AS 'Procentaj castig', nume FROM jucatori
WHERE timestampdiff(year, data_nasterii, curdate()) >= 18 AND timestampdiff(year, data_nasterii, curdate()) < 40 AND id_tip_joc = 1
ORDER BY nr_jocuri_castigate*100/(nr_jocuri_castigate+nr_jocuri_pierdute) DESC limit 1;

# j) cel mai bun jucator de table 18 - 40

SELECT nr_jocuri_castigate*100/(nr_jocuri_castigate+nr_jocuri_pierdute) AS 'Procentaj castig', nume FROM jucatori
WHERE timestampdiff(year, data_nasterii, curdate()) >= 18 AND timestampdiff(year, data_nasterii, curdate()) < 40 AND id_tip_joc = 2
ORDER BY nr_jocuri_castigate*100/(nr_jocuri_castigate+nr_jocuri_pierdute) DESC limit 1;

# j) cel mai bun jucator de sah 40 - 50

SELECT nr_jocuri_castigate*100/(nr_jocuri_castigate+nr_jocuri_pierdute) AS 'Procentaj castig', nume FROM jucatori
WHERE timestampdiff(year, data_nasterii, curdate()) >= 40 AND timestampdiff(year, data_nasterii, curdate()) < 50 AND id_tip_joc = 1
ORDER BY nr_jocuri_castigate*100/(nr_jocuri_castigate+nr_jocuri_pierdute) DESC limit 1;

# j) cel mai bun jucator de table 40 - 50

SELECT nr_jocuri_castigate*100/(nr_jocuri_castigate+nr_jocuri_pierdute) AS 'Procentaj castig', nume FROM jucatori
WHERE timestampdiff(year, data_nasterii, curdate()) >= 40 AND timestampdiff(year, data_nasterii, curdate()) < 50 AND id_tip_joc = 2
ORDER BY nr_jocuri_castigate*100/(nr_jocuri_castigate+nr_jocuri_pierdute) DESC limit 1;

# j) cel mai bun jucator de sah >50

SELECT nr_jocuri_castigate*100/(nr_jocuri_castigate+nr_jocuri_pierdute) AS 'Procentaj castig', nume FROM jucatori
WHERE timestampdiff(year, data_nasterii, curdate()) >= 50 AND id_tip_joc = 1
ORDER BY nr_jocuri_castigate*100/(nr_jocuri_castigate+nr_jocuri_pierdute) DESC limit 1;

# j) cel mai bun jucator de table >50

SELECT nr_jocuri_castigate*100/(nr_jocuri_castigate+nr_jocuri_pierdute) AS 'Procentaj castig', nume FROM jucatori
WHERE timestampdiff(year, data_nasterii, curdate()) >= 50 AND id_tip_joc = 2
ORDER BY nr_jocuri_castigate*100/(nr_jocuri_castigate+nr_jocuri_pierdute) DESC limit 1;
