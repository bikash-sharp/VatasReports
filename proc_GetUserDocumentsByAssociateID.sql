
CREATE PROCEDURE proc_GetUserDocumentsByAssociateID
 @UserId INT = 227,  
 @PageNumber INT = 1,    
 @PageSize   INT = 10  
 As 
BEGIN  
SET NOCOUNT ON;  
  
IF @PageSize = -1   
BEGIN  
 SELECT TOP 1 @PageSize = COUNT(*) FROM tblAssociateUsers where AssociateId = @UserId  
 END  
SELECT 
assusr.Id as AssociateUserId,
assusr.FirstName +' '+assusr.LastName as UserName,
assusr.AssociateId,
assusr.Contact,
assusr.EmailId,
usrdoc.UserId,  
usrdoc.DocumentId,  
usrdoc.DocumentTitle,   
usrdoc.DocumentNotes,   
usrdoc.IsProcessed,   
usrdoc.DateAdded,   
usrdoc.DateModified ,  
COUNT(*) OVER() AS RecordCount  
FROM 
tblAssociateUsers assusr INNER JOIN 
tbl_UserDocuments usrdoc ON assusr.Id = usrdoc.UserId
where assusr.AssociateId = @UserId   
ORDER BY DateAdded DESC  
OFFSET @PageSize * (@PageNumber - 1) ROWS    
    FETCH NEXT @PageSize ROWS ONLY OPTION (RECOMPILE);    
END