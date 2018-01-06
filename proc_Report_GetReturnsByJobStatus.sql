USE [VatasSolution]
GO
/****** Object:  StoredProcedure [dbo].[proc_ReturnsByJobStatus]    Script Date: 07-01-2018 00:02:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Gaurav Singla>
-- Create date: <06-01-2018>
-- Description:	<To get the returns by passing job status like ASS,DEC,DEP.... ETC>
-- =============================================
Create PROCEDURE [dbo].[proc_Report_GetReturnsByJobStatus] 
	@JobStatus varchar(10)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT 
		DISTINCT 
		TF.NameOfFirm AS FirmName,
		RC.SerialNo_By_Job_Firm AS [Job No],
		--PHJ.ID AS [JobID],
		AC.AccName AS AccountName, 
		RC.TAN, 
		RC.FY AS FinancialYear, 
		RC.OC AS ReturnType, 
		RC.Quarter, 
		RC.RetType AS FormType,
		RC.Job_Date AS JobDate,
		PHJ.Next_UserID AS UserID,
		PHJ.Date_Time_Stamp AS AssignedDate 
		
	FROM 
		Returns_Copy RC INNER JOIN Accounts AC ON RC.CusID = AC.AccID 
		INNER JOIN tbl_ProcessesHistoryofjob PHJ ON RC.Job_ID = PHJ.MasterID 
		INNER JOIN tbl_Firm TF ON RC.FirmID = TF.FirmId
		
	WHERE 
		(PHJ.Job_Status = @JobStatus) AND (PHJ.Is_Sent = '') ORDER BY RC.SerialNo_By_Job_Firm

END
