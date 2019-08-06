using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Vatas_Common
{
    public enum ResponseType
    {
        INFO,
        PRIMARY,
        SUCCESS,
        WARNING,
        DANGER,
        DEFAULT
    }

    public enum Roles
    {
        Admin=5,
        SuperAdmin=10,
        Staff=16,
        DataEntrySupervisor=24,
        DataEntryOperator=23,
        All=0,
        PotentialUser=30

    }

    internal static class ExtensionsCls
    {
        public static string RemoveWhitespace(this string str)
        {
            return string.Join("", str.Split(default(string[]), StringSplitOptions.RemoveEmptyEntries));
        }
    }
}
