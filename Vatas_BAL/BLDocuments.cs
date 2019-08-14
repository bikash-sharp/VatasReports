using System;
using System.Collections.Generic;
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

        public bool SaveDocument(int userId, string documentId, string documentTitle, string documentNotes, bool isProcessed = false, DateTime? modifiedDate = null)
        {
            bool result = false;
            try
            {
                result = (_admin.proc_SaveDocument(userId, documentId, documentTitle, documentNotes, isProcessed, modifiedDate) > 0 ? true : false);
            }
            catch (Exception ex)
            {
                var error = ex.Message;
            }
            return result;
        }

        public List<UserDocumentsCL> GetDocumentByUserId(int userId, int PageNumber, int PageSize)
        {
            List<UserDocumentsCL> result = new List<UserDocumentsCL>();
            try
            {
                var userDocuments = _admin.proc_GetDocumentsByUserID(userId, PageNumber, PageSize);
                foreach (var item in userDocuments)
                {
                    result.Add(new UserDocumentsCL()
                    {
                        DateAdded = item.DateAdded,
                        DocumentId = item.DocumentId,
                        DocumentNotes = item.DocumentNotes,
                        DocumentTitle = item.DocumentTitle,
                        IsProcessed = item.IsProcessed,
                        ModifiedDate = item.DateModified,
                        UserId = item.UserId,
                        RecordCount = item.RecordCount
                    });
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
                var lst = _admin.proc_SaveAssociateUser(associateId, tableUserId, firstName, lastName, emailId, contact, dateModified);
                foreach (var item in lst)
                {
                    int.TryParse(item.Id.ToString(), out result);
                }
            }
            catch (Exception)
            {

            }
            return result;
        }

        public List<AssociateUserDocumentsCL> GetDocumentByAssociateId(int userId, int PageNumber, int PageSize)
        {
            List<AssociateUserDocumentsCL> result = new List<AssociateUserDocumentsCL>();
            try
            {
                var userDocuments = _admin.proc_GetUserDocumentsByAssociateID(userId, PageNumber, PageSize);
                foreach (var item in userDocuments)
                {
                    result.Add(new AssociateUserDocumentsCL()
                    {
                        AssociateId = item.AssociateId,
                        AssociateUserId = item.AssociateUserId,
                        Contact = item.Contact,
                        UserName = item.UserName,
                        EmailId = item.EmailId,
                        DateAdded = item.DateAdded,
                        DocumentId = item.DocumentId,
                        DocumentNotes = item.DocumentNotes,
                        DocumentTitle = item.DocumentTitle,
                        IsProcessed = item.IsProcessed,
                        ModifiedDate = item.DateModified,
                        UserId = item.UserId,
                        RecordCount = item.RecordCount
                    });
                }

            }
            catch (Exception ex)
            {
                var error = ex.Message;
            }
            return result;
        }

        public List<AssociateUserDocumentsCL> GetAllUserDocuments(bool IsProcessed, int PageNumber, int PageSize)
        {
            List<AssociateUserDocumentsCL> result = new List<AssociateUserDocumentsCL>();
            try
            {
                var userDocuments = _admin.proc_GetAllDocuments(IsProcessed, PageNumber, PageSize);
                foreach (var item in userDocuments)
                {
                    result.Add(new AssociateUserDocumentsCL()
                    {
                        AssociateId = item.AssociateId.GetValueOrDefault(0),
                        AssociateUserId = item.AssociateUserId.GetValueOrDefault(0),
                        Contact = item.Contact,
                        UserName = item.UserName,
                        EmailId = item.EmailId,
                        DateAdded = item.DateAdded,
                        DocumentId = item.DocumentId,
                        DocumentNotes = item.DocumentNotes,
                        DocumentTitle = item.DocumentTitle,
                        IsProcessed = item.IsProcessed,
                        ModifiedDate = item.DateModified,
                        UserId = item.UserId,
                        RecordCount = item.RecordCount,
                        Users = BLSiteUser.Instance(_admin).GetUserRolesByRoleId((int)Roles.DataEntryOperator)
                    });
                }
            }
            catch (Exception ex)
            {
                var error = ex.Message;
            }
            return result;
        }
    }
}
