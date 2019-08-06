USE [db_admin]
GO
/****** Object:  StoredProcedure [dbo].[proc_SaveAssociateUser]    Script Date: 06-08-2019 05:42:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[proc_SaveAssociateUser]
@AssociateId bigint = 0,
@Id bigint =0,
@FirstName varchar(MAX)=NULL,
@LastName varchar(MAX) =NULL,
@EmailId varchar(MAX) =NULL,
@Contact varchar(MAX) =NULL,
@DateModified smalldatetime=NULL
AS
BEGIN
IF EXISTS( SELECT * FROM tblAssociateUsers WHERE Id = @Id)
BEGIN
--Perform Update
UPDATE tblAssociateUsers SET 
FirstName = @FirstName,
LastName = @LastName,
EmailId = @EmailId,
Contact = @Contact,
DateModified=@DateModified
WHERE
Id = @Id
END
ELSE
BEGIN
INSERT INTO tblAssociateUsers(AssociateId,FirstName,LastName,EmailId,Contact,DateModified)
VALUES
(@AssociateId,@FirstName,@LastName,@EmailId,@Contact,@DateModified) SELECT SCOPE_IDENTITY()
END


END