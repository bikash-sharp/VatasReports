using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Vatas_Common
{
    public class DocumentStatusDetailCL
    {
        public long Id { get; set; }
        public string DocumentId { get; set; }
        public long DocumentStatusId { get; set; }
        public int SupervisorId { get; set; }
        public int StaffId { get; set; }
        public int AssociateId { get; set; }
        public int PotentialUserId { get; set; }
        public bool IsChecked { get; set; }
        public DateTime DateAdded { get; set; }
        public DateTime? DateModified { get; set; }

    }
}
