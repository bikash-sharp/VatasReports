 CREATE PROCEDURE proc_GetAllDocuments
 @IsProcessed BIT = '0' ,  
 @PageNumber INT = 1,    
 @PageSize   INT = 10  
 As 
BEGIN  
SET NOCOUNT ON;  
  
IF @PageSize = -1   
BEGIN  
 SELECT TOP 1 @PageSize = COUNT(*) FROM tbl_UserDocuments where IsProcessed = @IsProcessed  
 END  

 ;WITH FinalResult AS(
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
usrdoc.DateModified
--COUNT(*) OVER() AS RecordCount  
FROM 
tblAssociateUsers assusr INNER JOIN 
tbl_UserDocuments usrdoc ON assusr.Id = usrdoc.UserId
where usrdoc.IsProcessed = @IsProcessed   
UNION ALL


SELECT 
'0' as AssociateUserId,
usr.Name +' '+usr.Last_Name as UserName,
'0' as AssociateId,
usr.MobileNumber as Contact,
usr.EmailId,
usrdoc.UserId,  
usrdoc.DocumentId,  
usrdoc.DocumentTitle,   
usrdoc.DocumentNotes,   
usrdoc.IsProcessed,   
usrdoc.DateAdded,   
usrdoc.DateModified
FROM 
tbl_UserGroup_Registration usr INNER JOIN 
tbl_UserDocuments usrdoc ON usr.Super_User_Id = usrdoc.UserId
where usrdoc.IsProcessed = @IsProcessed   
)

Select AssociateId,UserName,AssociateId ,Contact,EmailId,UserId,DocumentId,DocumentTitle,
DocumentNotes,IsProcessed,DateAdded,DateModified,
COUNT(*) OVER() AS RecordCount
from FinalResult
ORDER BY DateAdded DESC  
OFFSET @PageSize * (@PageNumber - 1) ROWS    
FETCH NEXT @PageSize ROWS ONLY OPTION (RECOMPILE);
END