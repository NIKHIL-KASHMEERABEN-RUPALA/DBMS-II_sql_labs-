INSTEAD OF TRIGGER

Table : Log(LogMessage varchar(100), logDate Datetime) 



1) 
Create or alter trigger tr_delete_block
On Student 
Instead of Delete 
AS 
Begin 
	insert into Log
		Values( ‘Cannot delete anything from Student Table’ , getDate()) )

End


2)
Create or alter trigger tr_course_readOnly
On Course 
Instead of Insert , Update , Delete
As
Begin 
		insert into Log
		Values( ‘Cannot do any DML on Course Table’ , getDate()) )
End


3)
Create or alter trigger tr_faculty_remove
On Faculty 
Instead of Delete 
AS
Begin 
		insert into Log
		Values( ‘Cannot delete anything from Faculty Table’ , getDate()) )
End


4) 

Create or alter trigger tr_operations_course
On Course 
Instead of Insert , update , delete 
AS 
Begin 
	if exists ( select * from inserted) 
	insert into Log
		Values( ‘Cannot insert into course Table’ , getDate()) )

	if exists(select * from deleted)
	insert into Log
		Values( ‘Cannot delete anything from Course Table’ , getDate()) )
	else 
	insert into Log
		Values( ‘Cannot update anything into Course Table’ , getDate()) )
End 







5) 
	Create or alter trigger tr_update 
	on Student 
	instead of update 
	AS 
	Begin 
		Print ‘students are not allowed to update their enrollment year’
	End 


6) 

	Create or alter trigger tr_validation 
	On Student 
	instead of insert 
	As 
	Begin 
		declare @age int , @dob dateTime  
		declare @Id int , @name varchar(100) , @mail varchar(100) , @phone varchar(10) 
		declare @dept varchar(100) ,  @enroll int 
		select @dob = StuDateOfBirth From inserted 
		select @id = StudentId from inserted 
		select @name = StuName from inserted 
		select @mail = StuEmail from inserted 
		select @phone = StuPhone from inserted 
		select @dept = StuDepartment from inserted 
		select @enroll = StuEnrollmentYear from inserted 
		
		set @age = dateDiff(year,@dob,getDate())

		if(@age > 18) 
		insert into student 
			Values(@id , @name , @mail , @phone , @dept , @dob,@enroll )
			Print(‘YOu are above 18 and hence successfully inserted’
		else 
			Print(‘Cannot get inserted as below age of 18’)
	

	End 


7) 
	Create or Alter trigger tr_fac_mail
	On Faculty 
	Instead of insert 
	AS
	Begin 
		declare @mail varchar(100) 
		select @mail = FacultyEmail from inserted 
		
		if @mail in 
		( Select FacultyEmail from Faculty)
		print ‘Change the mail coz it already exists’ 	
	End 
	
	
8) 
	Create or Alter trigger tr_prevent_duplicate
	On Student 
	instead of inserted 
	As
 	Begin 
		declare @stuID int , @cId int 
		select @stuId = StudentId from inserted 
		select @cid = CourseId from inserted 
		
		if @stuID not in
		 (
		select StudentID from Student 
		)
		 and 
		if @cID not in 
		(
		select CourseID from Course 
		) 
		print ‘Successfully inserted’ 
		Insert into Enrollement 
			Select * from inserted 

		Else 
			Print ‘Cannot be inserted as fields are not unique’
	End 


9) and 10) Homework 

