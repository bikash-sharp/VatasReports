using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using Vatas_Common;
using Vatas_DAL;

namespace Vatas_BAL
{
    public sealed class BLDocuments
    {
        private static readonly BLDocuments _instance;
        private static AdminEntities _admin;
        static BLDocuments()
        {
            _instance = new BLDocuments();
        }

        private BLDocuments()
        {

        }

        /// <summary>
        /// creates object of the class
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public static BLDocuments Instance(AdminEntities context)
        {
            _admin = context;
            return _instance;
        }

        public List<DropDownCL> GetAllServices()
        {
            List<DropDownCL> result = new List<DropDownCL>();
            try
            {
                string Query = "EXEC proc_GetServices";
                var resultSet = _admin
               .MultipleResults(Query)
               .With<ServiceCL>()
               .Execute();
                result = (resultSet[0] as List<ServiceCL>).Where(p=>p.IsActive == true).Select(p=> new DropDownCL() { DataText = p.ServiceName, DataValue=p.ServiceId.ToString() }).ToList();
            }
            catch (Exception ex)
            {
                var error = ex.Message;
            }
            return result;
        }
        public UserDocumentsCL GetDocumentById(long DocumentTableId)
        {
            UserDocumentsCL result = new UserDocumentsCL();
            try
            {
                string Query = "EXEC proc_GetDocumentById @Id = '" + DocumentTableId + "'";
                var resultSet = _admin
                .MultipleResults(Query)
                .With<UserDocumentsCL>()
                .Execute();
                result = (resultSet[0] as List<UserDocumentsCL>).FirstOrDefault();
            }
            catch (Exception ex)
            {
                var err = ex;
                result = null;
            }
            return result;

        }
        public long SaveDocument(int userId, int ServiceId, string documentId, string documentTitle, string documentNotes, bool isProcessed = false, DateTime? modifiedDate = null, bool IsAssociateUser = false)
        {
            long result = 0;
            try
            {
                string Query = "EXEC proc_SaveDocument @UserId = '"+userId+"',@ServiceId ='"+ServiceId+"',@DocumentId =N'"+documentId+"',@DocumentTitle=N'"+documentTitle+"',  @DocumentNotes= N'"+documentNotes+"',  @IsProcessed=N'"+Convert.ToInt32(isProcessed)+"',  @DateModified= '"+ Convert.ToString(modifiedDate) + "', @IsAssociateUser=N'"+Convert.ToInt32(IsAssociateUser)+"'";
                var resultSet = _admin
               .MultipleResults(Query)
               .With<decimal>()
               .Execute();
                long.TryParse((resultSet[0] as List<decimal>).FirstOrDefault().ToString(), out result);
            }
            catch (Exception ex)
            {
                var error = ex.Message;
            }
            return result;
        }

       
        public List<UserDocumentDetailedWrapper> GetDocumentByUserId(long userId, int PageNumber, int PageSize, string SearchText)
        {
            List<UserDocumentDetailedWrapper> result = new List<UserDocumentDetailedWrapper>();
            try
            {
                string Query = "EXEC proc_GetUserDocumentDetailedStatus @UserId='" + userId + "',@PageNumber ='" + PageNumber + "',@PageSize='" + PageSize + "',@SearhText=N'" + SearchText + "'";
                var resultSet = _admin
                .MultipleResults(Query)
                .With<UserDocumentDetailedWrapper>()
                .With<UserDocumentDetailCL>()
                .Execute();
                var DocDetails = resultSet[1] as List<UserDocumentDetailCL>;
                result = resultSet[0] as List<UserDocumentDetailedWrapper>;
                foreach(var item in result)
                {
                    item.userDocumentDetails = DocDetails.Where(p => p.DocumentTableId == item.DocumentTableId).ToList();
                }
                
            }
            catch (Exception ex)
            {
                var error = ex.Message;
            }
            return result;
        }

        public int SaveAssociateUser(int tableUserId, int associateId, string firstName, string lastName, string emailId, string contact, DateTime? dateModified)
        {
            int result = 0;
            try
            {
                string Query = "EXEC proc_SaveAssociateUser @AssociateId='" + associateId + "', @Id='" + tableUserId + "',@Firstname=N'" + firstName + "',@LastName=N'" + lastName + "',@EmailId=N'" + emailId + "',@Contact=N'" + contact + "',@DateModified= '" + Convert.ToString(dateModified)+"'";
                var resultSet = _admin
                .MultipleResults(Query)
                .With<decimal>()
                .Execute();
               int.TryParse( (resultSet[0] as List<decimal>).FirstOrDefault().ToString(), out result);
            }
            catch (Exception)
            {

            }
            return result;
        }

        public List<AssociateUserCL> GetUsersByAssociateId(int userId, int PageNumber, int PageSize, string SearchText)
        {
            List<AssociateUserCL> result = new List<AssociateUserCL>();
            try
            {
                string Query = "EXEC proc_GetUsersByAssociateId @UserId = '" + userId + "', @PageNumber = '" + PageNumber + "', @PageSize = '" + PageSize + "', @SearchText = N'"+SearchText+"'";
                var resultSet = _admin
                .MultipleResults(Query)
                .With<AssociateUserCL>()
                .Execute();
                result = resultSet[0] as List<AssociateUserCL>;
            }
            catch(Exception ex)
            {
                var err = ex;
            }
            return result;
        }
        public AssociateUserCL GetCustomerById(long userId)
        {
            AssociateUserCL result = new AssociateUserCL();
            try
            {
                string Query = "EXEC proc_GetCustomerByAssociateID @UserId = '" + userId + "'";
                var resultSet = _admin
                .MultipleResults(Query)
                .With<AssociateUserCL>()
                .Execute();
                result = (resultSet[0] as List<AssociateUserCL>).ToList().FirstOrDefault();
            }
            catch (Exception ex)
            {
                var err = ex;
            }
            return result;
        }

        public List<UserDocumentDetailedWrapper> GetAllUserDocuments(bool IsProcessed, int PageNumber, int PageSize,string SearchText)
        {
            List<UserDocumentDetailedWrapper> result = new List<UserDocumentDetailedWrapper>();
            try
            {
                string Query = "EXEC proc_GetAllDocuments @IsProcessed = '" + IsProcessed + "', @PageNumber = '" + PageNumber + "', @PageSize = '" + PageSize + "', @SearchText = N'" + SearchText + "'";
                var resultSet = _admin
                .MultipleResults(Query)
                .With<UserDocumentDetailedWrapper>()
                .With<UserDocumentRemarkCL>()
                .Execute();
                result = (resultSet[0] as List<UserDocumentDetailedWrapper>).ToList();
                var DocumentRemarks = (resultSet[1] as List<UserDocumentRemarkCL>).ToList();

                foreach(var item in result)
                {
                    item.userDocumentRemarks.AddRange(DocumentRemarks.Where(p => p.DocumentId == item.DocumentId).ToList());
                }
            }
            catch (Exception ex)
            {
                var err = ex;
            }
            return result;
        }
    }
}
