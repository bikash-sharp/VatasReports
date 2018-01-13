
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Gaurav Singla>
-- Create date: <07-01-2018>
-- Description:	<Get all distinct firm name>
-- =============================================
ALTER PROCEDURE proc_Report_GetAllFirmName
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT FirmId, NameOfFirm FROM tbl_Firm
END
GO
