CREATE PROCEDURE proc_GetUserRoleByUserId
	-- Add the parameters for the stored procedure here
	@UserId INT  = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

Select tusrrole.UserID, tuser.EmailId as UserName ,tusrrole.RoleId,trole.Role_Name From 
tbl_UserRoles tusrrole
INNER JOIN  tbl_UserGroup_Registration tuser  ON tuser.Super_User_Id = tusrrole.UserID
INNER JOIN tbl_Roles trole ON trole.Role_ID = tusrrole.RoleID
Where  ( tusrrole.UserID=@UserId)
END