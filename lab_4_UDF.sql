1)

Create or alter function fn_welcome 
Returns Varchar(100)
As 
Begin 
	return ’Welcome to the dbms lab ’
End;

Select dbo.fn_welcome 

2)

Create or alter function fn_SI
(
@principal float ,
@rate float ,
@time float
)
Returns float 
As
Begin 
	declare @result 
	set @result = (@principal * @rate * @time)/100
	return @result 
End

Select dbo.fn_SI(10000,5,2)


3)

Create or alter function fn_day_diff
(
@day1 DATE,
@day2 DATE
)
Returns int 
AS
Begin 
	declare @result 
	set @result = datediff(day,@day1,@day2)
	return @result 
End;

Select dbo.fn_day_diff(‘2024-01-01’,’2024-01-31’)


4)

Create or alter function fn_sumCred
(
@cid1 varchar(10),
@cid2 varchar(10)
) returns int 
As  Begin 
	declare @total int 
	select @total = SUM(CourseCredits)
	from COURSE
	Where CourseId in (@cid1 , @cid2);
	return @total 
End;

SELECT dbo.fn_sumCred('CS101', 'CS201');




5) 

Create or alter function fn_check 
(
@number int 
) returns varchar(10)
As 
Begin 
	return 
		Case
			When @number%2 = 0 THEN ‘EVEN’
			Else ‘ODD’
END;

SELECT dbo.fn_check(7);



6) 

Create or alter function fn_printN
(
@number int 
)
Returns varchar(MAX)
AS
Begin 
	declare @i int = 1;
	declare @result varchar(max)
	
While(@i<=@number)
Begin 
	
	set @result = @result + cast(@i as varchar(100) + ‘’;
	set @i = @i+1	

End 
Return @result 
End;

SELECT dbo.fn_printN(10);




7)


Create or alter function fn_factCred
(
@cid varchar(10)
)
Returns int 
As
Begin 

	declare @credit_copy int , @fact BigInt = 1;
	select @credit_copy = CourseCredit 
	from Course 
	where CourseId = @cid 

	while @credit_copy>0
	Begin 
	
	
	set @fact = @fact*@credit_copy
	set @credit_copy = @credit_copy -1
		

	End 

Return @fact
End;

SELECT dbo.fn_factCred(‘CS101');



8)


Create or alter function checkYear
(
@Year int 
)
Returns varchar(10)
AS
Begin 
	returns 
		Case
			When @Year > Year(getDate()) Then ‘future’
			when @year < Year(getDate()) Then ‘Past’
			Else ‘Current’
		End
End;

SELECT dbo.fn_checkYear(2026);




9)

Create or alter function fn_stuName
( 
@letter char(1)
)
Returns table 
AS 

Return ( select * from student 
Where stuName like @letter+’%’);

SELECT * FROM dbo.fn_stuName(‘R');



10)

Create or alter function fn_unqDept()
Returns Table 
As 
Return ( select distinct StuDepartment 
	from Student );

SELECT * FROM dbo.fn_unqDept();



11)

Create or alter function fn_age
( 
@dob date 
)
Returns int 
As 
Begin 
	@declare age int 
	set @age = datediff(year,@dob,getdate())
	return age
End;

SELECT dbo.fn_age(‘2003-05-15');



12)

Create or alter function fn_palindrome 
(
@num int 
)
Returns varchar(10)
AS
Begin 
	declare @copy varchar(100) = cast(@num as varchar(100))
	declare @reverse varchar(100) = REVERSE(@copy)
	return 
		Case
			When @copy = @reverse then ‘Palindrome’
			Else ‘Not palindrome’

		End
End;


SELECT dbo.fn_palindrome(121);




13)

Create or alter function fn_cseCred
Returns int 
AS 
Begin 
	@declare sum int 
	select @sum = SUM(CourseCredits)
	from Course 
	where CourseDepartment = ‘CSE’;
Return @sum
End;

SELECT dbo.fn_cseCred();


14) 


Create or alter function fn_facCourse
(
@designation varchar(10)
)
Returns table 
AS
	RETURN
	(
	select CourseName , FacultyName , FacultyDesgination 
	from Course c
	join CourseAssignment CA
	on c.CourseId = CA.CourseId
	join faculty f 
	on CA.facultyID = f.facultId
	where f.FacultyDesignation = @designation 
	
	);

SELECT * FROM dbo.fn_facCourse(‘Professor’);



15)

Create or Alter function fn_totCred
(
@sid int 
) returns int 
As 
Begin 
	declare @total int 
	Select @total = SUM(CourseCredits)
	from Enrollment e
	join Course C 
	on e.courseID = C.courseID 
	where E.studentID = @sid
	and E.enrollmentStatus = ‘Active’;
	return ISNULL(@total , 0); 
End;
SELECT dbo.fn_totCred(1);

16) 

CREATE FUNCTION fn_FacultyCountByJoiningDate
(
    @FromDate DATE,
    @ToDate DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @Count INT;

    SELECT @Count = COUNT(*)
    FROM FACULTY
    WHERE FacultyJoiningDate BETWEEN @FromDate AND @ToDate;

    RETURN @Count;
END;

SELECT dbo.fn_FacultyCountByJoiningDate('2010-01-01', '2015-12-31');





	








	


