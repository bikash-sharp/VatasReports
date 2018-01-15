USE [db_Admin]
GO
/****** Object:  StoredProcedure [dbo].[proc_SaveNewUser]    Script Date: 15-01-2018 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Gaurav Singla
-- Create date: Jan, 15 2018
-- Description:	Save new user
-- =============================================
ALTER PROCEDURE [dbo].[proc_SaveNewUser]
	@FirstName VARCHAR(50),
	@LastName VARCHAR(50),
	@Email VARCHAR(50),
	@Password VARCHAR(50),
	@MobileNumber VARCHAR(50),
	@AccountType VARCHAR(50)
AS 
BEGIN

    DECLARE 
		@State INT=0,
		@PinCode int=0,
		@STDCode int=0,
		@Telephone nvarchar(50)='0',
		@OrganizationName nvarchar(75)='0'

	INSERT 
		INTO tbl_UserGroup_Registration 
		(
			Name,
			Last_Name,
			EmailID,
			Password,
			Confirm_Password,
			MobileNumber,
			Account_Type,
			Is_Login_Active,
			State,
			PinCode,
			STDCode,
			Telephone,
			OrganizationName
		) 
		VALUES
		(
			@FirstName,
			@LastName,
			@Email,
			@Password,
			@Password,
			@MobileNumber,
			@AccountType,
			'Y',
			@State,
			@PinCode,
			@STDCode,
			@Telephone,
			@OrganizationName
		)
END
