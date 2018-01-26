USE [db_Admin]
GO
/****** Object:  StoredProcedure [dbo].[proc_AddUpdatePathByPathId]    Script Date: 26-01-2018 17:11:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Gaurav>
-- Create date: <Create Date,Jan 26 2018>
-- Description:	<Description,Add Update Path using PathId>
-- =============================================
CREATE PROCEDURE [dbo].[proc_AddUpdatePathByPathId]
	@PathId INT,
	@PathName NVARCHAR(100)='',
	@Host NVARCHAR(100)='',
	@Path NVARCHAR(100)='',
	@PathProject NVARCHAR(100)=''
AS
BEGIN
	SET NOCOUNT ON;

	IF(@PathId>0)
	BEGIN
		UPDATE 
			tbl_Path 
		SET 
			Path_Name=@PathName,
			Host=@Host,
			Path=@Path,
			Path_Project=@PathProject
		WHERE 
			Path_ID=@PathId
	END
	ELSE
	BEGIN
		INSERT 
		INTO 
			tbl_Path 
		VALUES
		(
			@PathName,
			@Host,
			@Path,
			@PathProject,
			''
		)
	END
END
