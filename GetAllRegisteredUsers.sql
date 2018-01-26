USE [db_Admin]
GO
/****** Object:  StoredProcedure [dbo].[proc_GetAllRegisteredUsers]    Script Date: 26-01-2018 18:28:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Gaurav>
-- Create date: <Create Date,Jan 20 2018>
-- Description:	<Description,Get all the registered users>
-- EXEC proc_GetAllRegisteredUsers
-- =============================================
ALTER PROCEDURE [dbo].[proc_GetAllRegisteredUsers]
	@IsActive VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT 
		   UGR.Super_User_Id AS UserId
		  ,UGR.Name AS FirstName
		  ,UGR.Last_Name AS LastName
		  ,UGR.EmailID AS Email
		  ,UGR.Password
		  ,UGR.[MobileNumber]
		  ,UGR.[OrganizationName]
		  ,UGR.Account_Type AS AccountType
		  ,UGR.Is_Login_Active AS IsActive
		  ,ISNULL(UR.RoleId, 0 ) AS RoleId
		  ,R.Role_Name AS RoleName
	  FROM db_Admin.dbo.tbl_UserGroup_Registration UGR
	  LEFT JOIN db_Admin.dbo.tbl_UserRoles UR ON UR.UserId=UGR.Super_User_Id
	  LEFT JOIN db_Admin.dbo.tbl_Roles R ON R.Role_ID=UR.RoleId 
	  WHERE Is_Login_Active=@IsActive 
END
