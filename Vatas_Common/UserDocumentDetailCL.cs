using System;

namespace Vatas_Common
{
    public class UserDocumentDetailCL
    {
        public long Id { get; set; }
        public long DocumentTableId { get; set; }
        public string FileName { get; set; }
        public string FolderPath { get; set; }
        public string DisplayAs { get; set; }
        public bool IsValid { get; set; }
        public DateTime DateAdded { get; set; }
        public DateTime? DateModified { get; set; }
    }
}
