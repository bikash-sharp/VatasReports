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
-- Description:	<Description,Get menu by roleId>
-- =============================================
CREATE PROCEDURE proc_GetMenuByRoleId
	@RoleId INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		UM.Menu_ID
		,M.Menu_Name
		,M.Menu_Level
		,M.Menu_Link
		,M.Menu_Status
		,M.Project_Name
		,M.Menu_Order
	FROM 
		[db_Admin].[dbo].[tbl_UserMenu]  UM
	INNER JOIN [tbl_Menu] M on M.Menu_id=UM.Menu_ID
	WHERE 
		UM.Role_ID=@RoleId AND UM.Menu_Status='Y' AND M.Is_Deleted='N'
END
GO
