using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Vatas_Common;
using Vatas_DAL;

namespace Vatas_BAL
{
    public sealed class BLDocumentStatus
    {
        private static readonly BLDocumentStatus _instance;
        private static AdminEntities _admin;
        static BLDocumentStatus()
        {
            _instance = new BLDocumentStatus();
        }

        private BLDocumentStatus()
        {

        }

        /// <summary>
        /// creates object of the class
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public static BLDocumentStatus Instance(AdminEntities context)
        {
            _admin = context;
            return _instance;
        }

        public List<DropDownCL> GetDocumentStatuses()
        {
            List<DropDownCL> result = new List<DropDownCL>();
            try
            {
                string Query = "EXEC proc_GetAllDocumentStatus";
                var resultSet = _admin
               .MultipleResults(Query)
               .With<DocumentStatusCL>()
               .Execute();
                result = (resultSet[0] as List<DocumentStatusCL>).Where(p => p.IsActive == true).Select(p => new DropDownCL() { DataText = p.StatusName, DataValue = p.StatusId.ToString() }).ToList();
            }
            catch (Exception ex)
            {
                var error = ex.Message;
            }
            return result;
        }
        public long InsertDocumentStatusDetails(DocumentStatusDetailCL documentStatusDetail)
        {
            long result = 0;
            try
            {
                string Query = "EXEC proc_InsertDocumentStatus @DocumentId=N'"+documentStatusDetail.DocumentId+"'" +
                               ",@DocumentStatusId='"+documentStatusDetail.DocumentStatusId+"',@SupervisorId='"+ documentStatusDetail.SupervisorId+ "'" +
                               ",@StaffId='"+ documentStatusDetail.StaffId+ "',@AssociateId='"+ documentStatusDetail.AssociateId+ "'" +
                               ",@PotentialUserId='"+ documentStatusDetail.PotentialUserId+ "',@IsChecked='"+ documentStatusDetail.IsChecked+ "',@DateModified='"+ Convert.ToString(documentStatusDetail.DateModified) +"'";
                var resultSet = _admin
               .MultipleResults(Query)
               .With<decimal>()
               .Execute();
                long.TryParse( (resultSet[0] as List<decimal>).FirstOrDefault().ToString(), out result);
            }
            catch (Exception ex)
            {
                var error = ex.Message;
            }
            return result;
        }
    }
}
