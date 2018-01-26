USE [db_Admin]
GO
/****** Object:  StoredProcedure [dbo].[proc_AddUpdateProjectByProjectId]    Script Date: 26-01-2018 17:29:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Gaurav>
-- Create date: <Create Date,Jan 26 2018>
-- Description:	<Description,Add Update Project using ProjectId>
-- =============================================
CREATE PROCEDURE [dbo].[proc_AddUpdateProjectByProjectId]
	@ProjectId INT,
	@ProjectName NVARCHAR(100)=''
AS
BEGIN
	SET NOCOUNT ON;

	IF(@ProjectId>0)
	BEGIN
		UPDATE 
			tbl_Project 
		SET 
			Project_Name=@ProjectName 
		WHERE 
			Project_ID=@ProjectId
	END
	ELSE
	BEGIN
		INSERT 
		INTO 
			tbl_Project 
		VALUES(@ProjectName)
	END
END
