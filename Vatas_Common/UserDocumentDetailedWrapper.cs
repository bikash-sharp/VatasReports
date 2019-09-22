using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Vatas_Common
{
    public class UserDocumentDetailedWrapper : UserDocumentsCL
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string EmailId { get; set; }
        public string Contact { get; set; }
        public bool IsAssociateUser { get; set; }
        public List<UserDocumentRemarkCL> userDocumentRemarks { get; set; }
        public List<UserDocumentDetailCL> userDocumentDetails { get; set; }
        public List<DropDownCL> Users { get; set; }
        public UserDocumentDetailedWrapper()
        {
            userDocumentDetails = new List<UserDocumentDetailCL>();
            userDocumentRemarks = new List<UserDocumentRemarkCL>();
            Users = new List<DropDownCL>();
        }
    }
}
