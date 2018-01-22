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
-- Description:	<Description,Add/Update menu to User Menu by RoleId>
-- =============================================
CREATE PROCEDURE proc_AddMenuToUserMenuByRoleId
	@RoleId INT,
	@MenuId INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @PageId INT=0

	SELECT @PageId = ISNULL(Page_ID,0) FROM tbl_Menu

	INSERT 
	INTO 
		tbl_UserMenu 
	VALUES
	(
		@RoleId,
		@MenuId,
		@PageId,
		'',
		'Y',
		'',
		''
	)
END
GO
