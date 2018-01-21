USE [db_Admin]
GO
/****** Object:  StoredProcedure [dbo].[proc_GetRegisteredUserByUserId]    Script Date: 21-01-2018 08:24:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Gaurav>
-- Create date: <Create Date,Jan 20 2018>
-- Description:	<Description,Get registered user by UserId>
-- EXEC proc_GetRegisteredUserByUserId @UserId='211'
-- =============================================
ALTER PROCEDURE [dbo].[proc_GetRegisteredUserByUserId]
	@UserId int
AS
BEGIN
	SET NOCOUNT ON;
	
	--DECLARE @UserId INT =211
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
	  WHERE UGR.Super_User_Id=@UserId 
END
