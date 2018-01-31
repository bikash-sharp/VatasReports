Use mydatabase1
-- =============================================  
-- Author:  BIKASH  
-- Create date: 27-Jan-2018  
-- Description: GET THE DETAILS OF RETURN FILED  
-- =============================================  
CREATE PROCEDURE pr_get_returnDetails  
 @TAN VARCHAR(15),  
 @QUARTER VARCHAR(5),  
 @FY VARCHAR(8),  
 @FORMNO VARCHAR(15),  
 @RETTYPE VARCHAR(25),  
 @MasterID VARCHAR(25)  
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
    Select Distinct   
Sum(Cast(Total_IncomeTAX_Deducted as decimal))as TaxDeducted,  
Sum(Cast(Total_TaxDeposited as decimal))as TaxDeposited,  
Sum(Cast(Amountof_Payment as decimal))as AmountPaid ,  
Count(DeducteeID)as NoOfDeductee   
From tbl_DeducteeDetail_Record  
where   
ID IN(Select ChallanID From tbl_ChallanTransferVoucherDetail where   
ID IN(select ID From tbl_Master where   
[TAN]=@TAN and [Quarter]=@QUARTER and   
FY=@FY and FormNo=@FORMNO and Regular_Correction=@RETTYPE )   
and MasterID=@MasterID  )  
END  