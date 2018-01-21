-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Gaurav>
-- Create date: <Create Date,Jan 21 2018>
-- Description:	<Description,Add Update Roles using RoleId>
-- =============================================
CREATE PROCEDURE proc_AddUpdateRolesByRoleId
	@RoleId INT,
	@RoleName NVARCHAR(100)=''
AS
BEGIN
	SET NOCOUNT ON;

	IF(@RoleId>0)
	BEGIN
		UPDATE 
			tbl_Roles 
		SET 
			Role_Name=@RoleName 
		WHERE 
			Role_ID=@RoleId
	END
	ELSE
	BEGIN
		INSERT 
		INTO 
			tbl_Roles 
		VALUES(@RoleName,'N','')
	END
END
GO
