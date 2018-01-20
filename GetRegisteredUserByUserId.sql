USE [db_Admin]
GO
/****** Object:  StoredProcedure [dbo].[GetRegisteredUserByUserId]    Script Date: 20-01-2018 13:56:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Gaurav>
-- Create date: <Create Date,Jan 20 2018>
-- Description:	<Description,Get registered user by UserId>
-- EXEC GetRegisteredUserByUserId @UserId='211'
-- =============================================
ALTER PROCEDURE [dbo].[GetRegisteredUserByUserId]
	@UserId int
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT 
		   Super_User_Id as UserId
		  ,Name as FirstName
		  ,Last_Name as LastName
		  ,EmailID as Email
		  ,Password
		  ,[MobileNumber]
		  ,[OrganizationName]
		  ,Account_Type as AccountType
		  ,Is_Login_Active as IsActive
	  FROM db_Admin.dbo.tbl_UserGroup_Registration 
	  WHERE Super_User_Id=@UserId 
END
