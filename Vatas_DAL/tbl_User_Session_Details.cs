//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Vatas_DAL
{
    using System;
    using System.Collections.Generic;
    
    public partial class tbl_User_Session_Details
    {
        public int ID { get; set; }
        public Nullable<int> User_ID { get; set; }
        public string Login_Time { get; set; }
        public string Logout_Time { get; set; }
        public string Session_ID { get; set; }
        public string Logout_Nature { get; set; }
        public Nullable<int> ID_Admin { get; set; }
    }
}
