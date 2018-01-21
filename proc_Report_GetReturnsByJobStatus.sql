-- =============================================
-- Author:		<Gaurav Singla>
-- Create date: <06-01-2018>
-- Description:	<To get the returns by passing job status like ASS,DEC,DEP.... ETC>
-- =============================================
ALTER PROCEDURE [dbo].[proc_Report_GetReturnsByJobStatus] 
	@JobStatus varchar(MAX),
	@PageNumber INT = 1,
	@PageSize   INT = 10,
	@SearhText VARCHAR(MAX) = NULL
AS
BEGIN
	SET NOCOUNT ON;

	--DECLARE @JobStatus varchar(10)='ASS'
	--DECLARE @PageNumber INT = 1
	--DECLARE @PageSize   INT = 10

	SELECT 
		DISTINCT 
		TF.NameOfFirm AS FirmName,
		RC.SerialNo_By_Job_Firm AS [JobNo],
		PHJ.ID AS [JobID],
		AC.AccName AS AccountName, 
		RC.TAN, 
		RC.FY AS FinancialYear, 
		RC.OC AS ReturnType, 
		RC.Quarter, 
		RC.RetType AS FormType,
		RC.Job_Date AS JobDate,
		PHJ.Next_UserID AS UserID,
		PHJ.Date_Time_Stamp AS AssignedDate,
		PHJ.Reason_for_Delay AS Comments,
		PHJ.MasterID AS MasterID,
		PHJ.Previous_UserID AS PreviousAssignedUserID,
		PHJ.PRN_No As PRN,
		PHJ.Supervisor AS SuperVisorName,
		PHJ.Job_Status As StatusCode,
		PS.Process_Name AS StatusDesc,
		RecordCount = COUNT(*) OVER()
	FROM 
		Returns_Copy RC 
		INNER JOIN Accounts AC ON RC.CusID = AC.AccID 
		INNER JOIN tbl_ProcessesHistoryofjob PHJ ON RC.Job_ID = PHJ.MasterID 
		INNER JOIN tbl_Firm TF ON RC.FirmID = TF.FirmId
		INNER JOIN tbl_ProcessStatus PS ON PHJ.Job_Status = PS.Process_Code
	WHERE (PHJ.Job_Status = @JobStatus) AND (PHJ.Is_Sent = '') AND ( RC.Quarter IS NOT NULL AND RC.Quarter != '') 
	AND (TF.NameOfFirm  LIKE '%'+@SearhText+'%')
	AND (PHJ.ID LIKE '%'+@SearhText+'%')
	AND (AC.AccName LIKE '%'+@SearhText+'%')
	AND (RC.[TAN] LIKE '%'+@SearhText+'%')
	AND (RC.FY LIKE '%'+@SearhText+'%')
	AND (RC.OC LIKE '%'+@SearhText+'%')
	AND (RC.[Quarter] LIKE '%'+@SearhText+'%')
	AND (RC.RetType LIKE '%'+@SearhText+'%')
	ORDER BY RC.SerialNo_By_Job_Firm

	OFFSET @PageSize * (@PageNumber - 1) ROWS
    FETCH NEXT @PageSize ROWS ONLY OPTION (RECOMPILE);
END
