﻿-- =============================================
-- Author:		Gaurav Singla
-- Create date: Jan, 15 2018
-- Description:	Add or Update user
-- EXEC proc_AddUpdateUser @UserId=0,@FirstName='GauravSingla',@LastName='Singla',@Email='asd@fsd.com',@Password='1',@MobileNumber='1111111111',@AccountType='U',@RoleId=2
-- =============================================
ALTER PROCEDURE [dbo].[proc_AddUpdateUser]
	@UserId int,
	@FirstName VARCHAR(50),
	@LastName VARCHAR(50),
	@Email VARCHAR(50),
	@Password VARCHAR(50),
	@MobileNumber VARCHAR(50),
	@AccountType VARCHAR(50),
	@RoleId INT,
	@IsActive VARCHAR(1)
AS 
BEGIN

	IF(@UserId=0) 
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
				@IsActive,
				@State,
				@PinCode,
				@STDCode,
				@Telephone,
				@OrganizationName
			)

		Select @UserId = SCOPE_IDENTITY();
		INSERT INTO tbl_UserRoles VALUES(@UserId,@RoleId)


		END
		ELSE
			BEGIN
				UPDATE 
					tbl_UserGroup_Registration 
					SET 
						Name=@FirstName,
						Last_Name=@LastName, 
						EmailID=@Email,
						[Password]=@Password,
						Confirm_Password=@Password,
						MobileNumber=@MobileNumber,
						Account_Type=@AccountType,
						Is_Login_Active=@IsActive
				WHERE Super_User_Id=@UserId

				IF NOT EXISTS (SELECT UserRoleId FROM tbl_UserRoles WHERE UserId=@UserId)
				BEGIN
					  INSERT 
					  INTO tbl_UserRoles 
					  VALUES(@UserId,@RoleId)
				END
				ELSE
				BEGIN
					   UPDATE 
					   tbl_UserRoles 
					   SET RoleId=@RoleId 
					   WHERE UserId=@UserId
				END
			END
END
