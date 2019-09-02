using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Vatas_Common
{
    public class UserDocumentsCL
    {
        public long DocumentTableId { get; set; }
        public int UserId { get; set; }
        public int DocumentStatusId { get; set; }
        public string DocumentStatusName { get; set; }
        public int ServiceId { get; set; }
        public string ServiceName { get; set; }
        public string DocumentId { get; set; }
        public string DocumentTitle { get; set; }
        public string DocumentNotes { get; set; }
        public bool IsProcessed { get; set; }
        public DateTime DateAdded { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public int RecordCount { get; set; }
    }
}
