
Create or alter trigger tr_student_registration 
On Student 
After insert 
AS 
Begin 
	declare @id int , @name varchar(100) 
	select top 1 
	@id = StudentID
	@name = StudentName 
	from inserted 

	PRINT ‘Student with id’+cast(@id to varchar(40))+’and name’+@name+’was registered’
END



2)
Create or alter trigger tr_faculty_delete
On faculty 
For delete 
AS 
Begin 
	declare @id int , @name varchar(50)
	select top 1 
	@id = FacultyID
	@name = FacultyName 
	from deleted 
	PRINT 'Faculty with ID ' + CAST(@id AS VARCHAR(10)) +
          	' and name ' + @name + ' has been deleted’

END


NOTE — FacultyID primary key , so create a new Faculty and enter it inside that and then remove it  




3)
Create or alter trigger tr_course_dml
On course 
For insert, update, delete 
As 
Begin 
	if exists(select * from inserted) and exists(select * from deleted) 
	PRINT 'Course record updated’;
	if exists(select * from inserted)
	PRINT 'Course record inserted’;
	else 
	PRINT 'Course record deleted’;
End 


4)

Create or alter trigger tr_log
On Student 
After insert 
AS 
Begin 
	declare @id int , @name varchar(100)
	select @id = StudentID from inserted 
	select @name = StuName from inserted 
	Insert Into Log_table 
VALUES
( ‘Student with student id ’+ cast(@id to varchar(50) )+ ‘and name ’ + @name + ‘was inserted on’ +cast(getDATE() to varchar(50))  )
END;


5)
Create or trigger tr_upper
On Faculty 
After Insert 
AS 
Begin 
	declare @id int , @facname varchar(50) 
	select @id = facultyID from inserted 
	select @facname = FacultyName from inserted 
	update Faculty 
	set FacultyName = UPPER(@facname)
	where FacultyId = @id 
END 


6) 
ALTER TABLE FACULTY 
ADD Experience INT
GO

Create or alter trigger tr_experience 
On Faculty 
After insert 
AS 
Begin 
	Update f 
	set experience = DATEDIFF(year,FacultyJoiningDate,getDate())
	from faculty f
	join inserted I
	on f.faucltyID = I.facultyId;
End;


7)
CREATE OR ALTER TRIGGER tr_auto
ON ENROLLMENT
AFTER INSERT
AS
BEGIN
    DECLARE @id INT;

    SELECT TOP 1
        @id = EnrollmentID
    FROM inserted;

    UPDATE ENROLLMENT
    SET EnrollmentDate = GETDATE()
    WHERE EnrollmentID = @id
      AND EnrollmentDate IS NULL;
END;


8) 
CREATE TABLE LogCourseAssign
(
    LogMessage VARCHAR(200),
    LogDate DATETIME DEFAULT GETDATE()
);


CREATE OR ALTER TRIGGER tr_ca
ON COURSE_ASSIGNMENT
AFTER INSERT
AS
BEGIN
    DECLARE @cid VARCHAR(10), @fid INT;

    SELECT TOP 1
        @cid = CourseID,
        @fid = FacultyID
    FROM inserted;

    INSERT INTO LogCourseAssign
    VALUES
    (
        'Course ' + @cid +
        ' assigned to Faculty ID ' + CAST(@fid AS VARCHAR(10)),
        GETDATE()
    );
END;



9)
CREATE OR ALTER TRIGGER tr_phone
ON STUDENT
AFTER UPDATE
AS
BEGIN
    DECLARE @old VARCHAR(15), @new VARCHAR(15), @id INT;

    SELECT TOP 1
        @old = D.StuPhone,
        @new = I.StuPhone,
        @id = I.StudentID
    FROM inserted I
    JOIN deleted D
        ON I.StudentID = D.StudentID;

    IF @old <> @new
    BEGIN
        PRINT 'Student ID ' + CAST(@id AS VARCHAR(10)) +
              ' Old Phone: ' + @old +
              ' New Phone: ' + @new;
    END
END;



10) 
CREATE TABLE LogCourseCredit
(
    LogMessage VARCHAR(200),
    LogDate DATETIME DEFAULT GETDATE()
);


Create or alter trigger tr_credit_alter
On Course 
After update 
AS 
Begin 
	declare @old int , @new int , @id varchar(50)
	select top 1 
	@old = d.CourseCredits
	@new = i.CourseCredits
	@id = i.CourseId
	from inserted I
	join deleted d 
	on I.courseID = d.courseID

If @old<>@new
	Begin 
Insert into LogCourseCredit
Values 
(
‘course’+@id+
‘credits changed from’+cast(@old to varchar(40))+
‘To’+cast(@new to varchar(40)),
GetDate()
)
;
	End
End;



