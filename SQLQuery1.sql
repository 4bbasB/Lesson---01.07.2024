CREATE DATABASE AcademyDb

CREATE TABLE Academies
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(50) NOT NULL
)

CREATE TABLE Groups
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(50) NOT NULL,
	IsDeleted BIT NOT NULL,
	AcademyId INT FOREIGN KEY REFERENCES Academies(Id)
)


CREATE TABLE Students
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(50) NOT NULL,
	Surname NVARCHAR(50) NOT NULL,
	Age INT NOT NULL,
	Adulthood BIT NOT NULL,
	GroupId INT FOREIGN KEY REFERENCES Groups(Id)
)


CREATE TABLE DeletedStudents
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(50) NOT NULL,
	Surname NVARCHAR(50) NOT NULL,
	GroupId INT
)


CREATE TABLE DeletedGroups
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(50) NOT NULL,
	AcademyId INT
)


CREATE VIEW VW_SHOW_ACADEMY
AS
SELECT * FROM Academies

SELECT * FROM VW_SHOW_ACADEMY



CREATE VIEW VW_SHOW_GROUP
AS
SELECT * FROM Groups
WHERE IsDeleted = 0

SELECT * FROM VW_SHOW_GROUP



CREATE VIEW VW_SHOW_STUDENT
AS
SELECT * FROM Students

SELECT * FROM VW_SHOW_STUDENT



ALTER PROCEDURE USP_SEARCHING_NAME @name NVARCHAR(50)
AS
SELECT * 
FROM Groups AS G
WHERE  G.Name LIKE '%' + @name + '%'


EXEC USP_SEARCHING_NAME 'A'




CREATE PROCEDURE USP_SEARCHING_FOR_LITTLE_AGE @age INT
AS
SELECT * 
FROM Students AS S
WHERE S.Age < @age

EXEC USP_SEARCHING_FOR_LITTLE_AGE 25



CREATE PROCEDURE USP_SEARCHING_FOR_BIGGER_AGE @age INT
AS
SELECT * 
FROM Students AS S
WHERE S.Age > @age

EXEC USP_SEARCHING_FOR_BIGGER_AGE 25



ALTER TRIGGER TR_INSTEAD_OF_STUDENT_DELETE
ON Students
AFTER DELETE
AS
BEGIN
INSERT INTO DeletedStudents
 
END

DELETE FROM Students
WHERE Id = 2




CREATE TRIGGER TR_INSTEAD_OF_DELETE
ON Groups
INSTEAD OF DELETE
AS
BEGIN
UPDATE Groups
SET IsDeleted = 1
WHERE Id = (SELECT Id FROM deleted)
END

DELETE FROM Groups
WHERE Id = 2




ALTER TRIGGER TR_WITH_AGE_ADULTHOOD
ON Students
AFTER UPDATE, INSERT
AS
BEGIN
UPDATE Students
SET Adulthood = 1
WHERE (SELECT Age FROM inserted) >= 18
END




UPDATE Students
SET Age = 15
WHERE Id = 1

INSERT INTO Students
VALUES('Ziya', 'Abasov',21,0,1)


INSERT INTO Students
VALUES('Ziya', 'Abasov',15,0,1)





