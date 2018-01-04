using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Vatas_Common;
using Vatas_DAL;

namespace Vatas_BAL
{
    public sealed class BLErrorLog
    {
        private static readonly BLErrorLog instance = new BLErrorLog();


        private static readonly BLErrorLog _instance;

        private static AdminEntities _context;

        static BLErrorLog()
        {
            _instance = new BLErrorLog();
        }

        public static BLErrorLog Instance(AdminEntities context)
        {
            _context = context;
            return _instance;
        }
    }
}
