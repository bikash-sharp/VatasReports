using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Vatas_Common
{
    public class ServiceCL
    {
        public int ServiceId { get; set; }
        public string ServiceName {get;set;}
        public bool IsActive { get; set; }
        public DateTime DateAdded { get; set; }
    }
}
