using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Vatas_Common
{
    public class AssociateUserCL
    {
        public long AssociateUserId { get; set; }
        public int ServiceId { get; set; }
        public string ServiceName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string UserName { get { return FirstName + ' ' + LastName; } }
        public int AssociateId { get; set; }
        public string Contact { get; set; }
        public string EmailId { get; set; }
        public DateTime DateAdded { get; set; }
        public Nullable<DateTime> DateModified { get; set; }
        public int RecordCount { get; set; }
    }
}
