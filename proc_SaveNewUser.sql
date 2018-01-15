
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Gaurav Singla
-- Create date: Jan, 15 2018
-- Description:	Save new user
-- =============================================
CREATE PROCEDURE proc_SaveNewUser
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
		@Telephone nvarchar(50),
		@OrganizationName nvarchar(75)

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
GO
