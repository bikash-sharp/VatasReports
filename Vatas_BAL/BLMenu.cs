using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Vatas_DAL;

namespace Vatas_BAL
{
    public sealed class BLMenu
    {
        private static readonly BLMenu _instance;
        private static AdminEntities _context;
        static BLMenu()
        {
            _instance = new BLMenu();
        }

        private BLMenu() {}
        public static BLMenu Instance(AdminEntities context)
        {
            _context = context;
            return _instance;
        }
    }

    public sealed class BLCities
    {
        private static readonly BLCities _instance;
        private static AdminEntities _context;
        static BLCities()
        {
            _instance = new BLCities();
        }

        private BLCities() { }
        public static BLCities Instance(AdminEntities context)
        {
            _context = context;
            return _instance;
        }
        
    }

    public sealed class BLCountries
    {
        private static readonly BLCountries _instance;
        private static AdminEntities _context;
        static BLCountries()
        {
            _instance = new BLCountries();
        }

        private BLCountries() {}
        public static BLCountries Instance(AdminEntities context)
        {
            _context = context;
            return _instance;
        }

    }

    public sealed class BLBankBranches
    {
        private static readonly BLBankBranches _instance;
        private static AdminEntities _context;
        static BLBankBranches()
        {
            _instance = new BLBankBranches();
        }

        private BLBankBranches() { }
        public static BLBankBranches Instance(AdminEntities context)
        {
            _context = context;
            return _instance;
        }
     }
    public sealed class BLStates
    {
        private static readonly BLStates _instance;
        private static AdminEntities _context;
        static BLStates()
        {
            _instance = new BLStates();
        }

        private BLStates() {}
        public static BLStates Instance(AdminEntities context)
        {
            _context = context;
            return _instance;
        }

        
    }
}
