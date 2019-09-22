using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Vatas_Common
{
    public class UserDocumentRemarkCL
    {
        public long RemarkTableId { get; set; }
        public string DocumentId { get; set; }
        public long UserId { get; set; }
        public int RemarkTypeId { get; set; }
        public string RemarkTypeName { get; set; }
        public string Remarks { get; set; }
        public DateTime DateAdded { get; set; }
        public DateTime? DateModified { get; set; }
    }
}
