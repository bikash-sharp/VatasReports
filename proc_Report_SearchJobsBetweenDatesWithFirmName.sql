﻿-- =============================================
-- Author:		<Gaurav Singla>
-- Create date: <09-01-2017>
-- Description:	<Report: Search jobs between two dates with firmname>
-- =============================================
CREATE PROCEDURE [dbo].[proc_Report_SearchJobsBetweenDatesWithFirmName] 
	@StartDate DateTime,
	@EndDate DateTime,
	@FirmId INT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		SELECT DISTINCT 
			TF.FirmId as FirmId,
			TF.NameOfFirm As FirmName,
			RC.SerialNo_By_Job_Firm AS [Job No],
			--PHJ.ID AS [JobID],
			ac.AccName As AccountName,
			RC.TAN, 
			RC.FY AS FinancialYear,
			RC.OC AS ReturnType,
			RC.Quarter,
			RC.RetType AS FormType,
			RC.Job_Date as JobDate
		FROM 
			Returns_Copy RC LEFT OUTER JOIN Accounts AC ON RC.CusID = AC.AccID 
			LEFT OUTER JOIN tbl_ProcessesHistoryofjob PHJ ON RC.Job_ID = PHJ.MasterID 
			LEFT OUTER JOIN tbl_Firm tf ON rc.FirmID = tf.FirmId
		WHERE 
			( TF.FirmId = @FirmId Or @FirmId IS NULL)
			AND (CONVERT(DATETIME,RC.Job_Date,103)>=CONVERT(DATETIME,@StartDate,103) and CONVERT(DATETIME,RC.Job_Date,103)<=CONVERT(DATETIME,@EndDate,103))
		ORDER BY RC.SerialNo_By_Job_Firm
END	