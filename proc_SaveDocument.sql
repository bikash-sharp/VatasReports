USE [db_admin]
GO
/****** Object:  StoredProcedure [dbo].[proc_SaveDocument]    Script Date: 06-08-2019 02:33:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[proc_SaveDocument]
@UserId INT,
@DocumentId varchar(MAX),
@DocumentTitle varchar(MAX),
@DocumentNotes varchar(MAX) = NULL,
@IsProcessed BIT = 0,
@DateModified smalldatetime = NULL
AS
BEGIN
IF EXISTS(SELECT * FROM tbl_UserDocuments where DocumentId = @DocumentId)
BEGIN
UPDATE tbl_UserDocuments SET
UserId = @UserId,
DocumentTitle = @DocumentTitle,
DocumentNotes = @DocumentNotes,
IsProcessed = @IsProcessed,
DateModified = @DateModified
WHERE
DocumentId = @DocumentId
END
ELSE
BEGIN
INSERT INTO tbl_UserDocuments (UserId,DocumentId,DocumentTitle,DocumentNotes,IsProcessed)
VALUES
(@UserId,@DocumentId,@DocumentTitle,@DocumentNotes,@IsProcessed)
END

 IF @@ERROR  > -0
RETURN 0
ELSE
RETURN 1

END