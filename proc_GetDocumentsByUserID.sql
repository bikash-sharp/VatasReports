ALTER PROCEDURE [dbo].[proc_GetDocumentsByUserID]
@UserId INT,
 @PageNumber INT = 1,  
 @PageSize   INT = 10
AS
BEGIN
SET NOCOUNT ON;
IF @PageSize = -1 
BEGIN
 SELECT TOP 1 @PageSize = COUNT(*) FROM tbl_UserDocuments where UserId = @UserId
 END
SELECT 
UserId,
DocumentId,
DocumentTitle,	
DocumentNotes,	
IsProcessed,	
DateAdded,	
DateModified 
FROM tbl_UserDocuments where UserId = @UserId 
ORDER BY DateAdded DESC
OFFSET @PageSize * (@PageNumber - 1) ROWS  
    FETCH NEXT @PageSize ROWS ONLY OPTION (RECOMPILE);  
END