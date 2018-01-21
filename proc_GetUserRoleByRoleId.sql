USE [db_Admin]
GO
/****** Object:  StoredProcedure [dbo].[proc_GetUserRoleByRoleId]    Script Date: 21-01-2018 14:54:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[proc_GetUserRoleByRoleId]
	-- Add the parameters for the stored procedure here
	@RoleId INT  = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

Select DISTINCT tusrrole.UserID, (tuser.Name +' '+tuser.Last_Name) as UserName ,tusrrole.RoleId,trole.Role_Name From tbl_UserRoles tusrrole
INNER JOIN  tbl_UserGroup_Registration tuser  ON tuser.Super_User_Id = tusrrole.UserID
INNER JOIN tbl_Roles trole ON trole.Role_ID = tusrrole.RoleID
Where  ( tusrrole.roleId=@RoleId OR @RoleId = 0)
ORDER BY (tuser.Name +' '+tuser.Last_Name)
END
