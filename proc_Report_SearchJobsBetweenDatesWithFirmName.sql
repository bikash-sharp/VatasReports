USE [VatasSolution]
GO
/****** Object:  StoredProcedure [dbo].[proc_Report_SearchJobsBetweenDatesWithFirmName]    Script Date: 18-01-2018 07:55:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Gaurav Singla>
-- Create date: <09-01-2017>
-- Description:	<Report: Search jobs between two dates with firmname>
-- =============================================
ALTER PROCEDURE [dbo].[proc_Report_SearchJobsBetweenDatesWithFirmName] 
	@StartDate DateTime,
	@EndDate DateTime,
	@FirmId INT = NULL,
	@PageNumber INT = 1,
	@PageSize   INT = 10,
	@SearchText VARCHAR(MAX) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF OBJECT_ID('tempdb..#SearchResult') IS NOT NULL    
	BEGIN    
    DROP TABLE #SearchResult;    
	END  

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
			--RecordCount = COUNT(*) OVER()
			INTO #SearchResult
		FROM 
			Returns_Copy RC LEFT OUTER JOIN Accounts AC ON RC.CusID = AC.AccID 
			LEFT OUTER JOIN tbl_ProcessesHistoryofjob PHJ ON RC.Job_ID = PHJ.MasterID 
			LEFT OUTER JOIN tbl_Firm tf ON rc.FirmID = tf.FirmId
		WHERE 
			( TF.FirmId = @FirmId Or @FirmId IS NULL AND TF.NameOfFirm IS NOT NULL AND TF.NameOfFirm !='') AND ( RC.Quarter IS NOT NULL AND RC.Quarter != '' AND RC.[TAN] IS NOT NULL AND RC.[TAN] !='' AND RC.FY IS NOT NULL AND RC.FY !='' AND RC.FY != '---Select---' )
			AND (CONVERT(DATETIME,RC.Job_Date,103)>=CONVERT(DATETIME,@StartDate,103) and CONVERT(DATETIME,RC.Job_Date,103)<=CONVERT(DATETIME,@EndDate,103))
		ORDER BY RC.SerialNo_By_Job_Firm
	IF @PageSize = -1 
	SELECT TOP 1 @PageSize = COUNT(*) FROM #SearchResult

	; WITH FinalResult AS (
	SELECT * from #SearchResult rs Where (rs.TAN LIKE ''+@SearchText+'%')
	UNION ALL
	SELECT * from #SearchResult rs Where (rs.[Job No] LIKE '%'+@SearchText+'%'  OR @SearchText IS NULL)
	UNION ALL 
	SELECT * from #SearchResult rs Where (rs.FirmName LIKE '%'+@SearchText+'%' OR @SearchText IS NULL)
	UNION ALL
	SELECT * from #SearchResult rs Where (rs.AccountName LIKE '%'+@SearchText+'%' OR @SearchText IS NULL)
	UNION ALL
	SELECT * from #SearchResult rs Where (rs.FinancialYear LIKE '%'+@SearchText+'%'  OR @SearchText IS NULL)
	UNION ALL
	SELECT * from #SearchResult rs Where (rs.ReturnType LIKE '%'+@SearchText+'%'  OR @SearchText IS NULL)
	UNION ALL
	SELECT * from #SearchResult rs Where (rs.[Quarter] LIKE '%'+@SearchText+'%'  OR @SearchText IS NULL)
	UNION ALL
	SELECT * from #SearchResult rs Where (rs.FormType LIKE '%'+@SearchText+'%'  OR @SearchText IS NULL)
	)


	SELECT FirmId,FirmName,[Job No],AccountName,[TAN],FinancialYear,ReturnType,[Quarter],FormType,JobDate, COUNT(*) OVER() AS RecordCount from FinalResult 
		   GROUP BY
		   FirmId,FirmName,[Job No],AccountName,[TAN],FinancialYear,ReturnType,[Quarter],FormType,JobDate
ORDER BY [Job No]
	OFFSET @PageSize * (@PageNumber - 1) ROWS
    FETCH NEXT @PageSize ROWS ONLY OPTION (RECOMPILE);
END	