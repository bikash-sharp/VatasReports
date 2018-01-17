-- =============================================
-- Author:		<Gaurav Singla>
-- Create date: <06-01-2018>
-- Description:	<To get the returns by passing job status like ASS,DEC,DEP.... ETC>
-- =============================================
ALTER PROCEDURE [dbo].[proc_Report_GetReturnsByJobStatus] 
	@JobStatus varchar(MAX)
AS
BEGIN
	SET NOCOUNT ON;
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
		PS.Process_Name AS StatusDesc
	FROM 
		Returns_Copy RC 
		INNER JOIN Accounts AC ON RC.CusID = AC.AccID 
		INNER JOIN tbl_ProcessesHistoryofjob PHJ ON RC.Job_ID = PHJ.MasterID 
		INNER JOIN tbl_Firm TF ON RC.FirmID = TF.FirmId
		INNER JOIN tbl_ProcessStatus PS ON PHJ.Job_Status = PS.Process_Code
	WHERE 
		(PHJ.Job_Status IN (SELECT item FROM DelimitedSplit8K(@JobStatus,','))) AND (PHJ.Is_Sent = '') ORDER BY RC.SerialNo_By_Job_Firm
END