using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Vatas_Common
{
    public class UserDocumentDetailedWrapper : UserDocumentsCL
    {
        public List<UserDocumentDetailCL> userDocumentDetails { get; set; }
        public UserDocumentDetailedWrapper()
        {
            userDocumentDetails = new List<UserDocumentDetailCL>();
        }
    }
}
