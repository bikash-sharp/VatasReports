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
-- Author:		<Author,Gaurav Singla>
-- Create date: <Create Date,Jan, 22 2018>
-- Description:	<Description,Add Update Menu>
-- =============================================
CREATE PROCEDURE proc_AddUpdateMenu
	@MenuId INT,
	@MenuName NVARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;

	IF(@MenuId>0)
		BEGIN
			UPDATE tbl_Menu 
			SET 
				Menu_Name=@MenuName 
			WHERE Menu_id=@MenuId
		END
	ELSE
		BEGIN
			INSERT INTO tbl_Menu 
			(
				Menu_Name,
				Menu_Level,
				Menu_Order,
				Menu_Status,
				Parent_Menu,
				Is_Deleted
			) 
			VALUES 
			(
				@MenuName,
				1,
				1,
				1,
				1,
				'N'
			)
	END
END
GO
