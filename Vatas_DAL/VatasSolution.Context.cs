﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class VatasSolutionEntities : DbContext
    {
        public VatasSolutionEntities()
            : base("name=VatasSolutionEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<tbl_ProcessPriority> tbl_ProcessPriority { get; set; }
        public virtual DbSet<tbl_ProcessStatus> tbl_ProcessStatus { get; set; }
        public virtual DbSet<tbl_ProcessesHistoryofjob> tbl_ProcessesHistoryofjob { get; set; }
    
        public virtual ObjectResult<proc_Report_GetAllFirmName_Result> proc_Report_GetAllFirmName()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<proc_Report_GetAllFirmName_Result>("proc_Report_GetAllFirmName");
        }
    
        public virtual ObjectResult<proc_Report_GetReturnsByJobStatus_Result> proc_Report_GetReturnsByJobStatus(string jobStatus, Nullable<int> pageNumber, Nullable<int> pageSize, string searhText)
        {
            var jobStatusParameter = jobStatus != null ?
                new ObjectParameter("JobStatus", jobStatus) :
                new ObjectParameter("JobStatus", typeof(string));
    
            var pageNumberParameter = pageNumber.HasValue ?
                new ObjectParameter("PageNumber", pageNumber) :
                new ObjectParameter("PageNumber", typeof(int));
    
            var pageSizeParameter = pageSize.HasValue ?
                new ObjectParameter("PageSize", pageSize) :
                new ObjectParameter("PageSize", typeof(int));
    
            var searhTextParameter = searhText != null ?
                new ObjectParameter("SearhText", searhText) :
                new ObjectParameter("SearhText", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<proc_Report_GetReturnsByJobStatus_Result>("proc_Report_GetReturnsByJobStatus", jobStatusParameter, pageNumberParameter, pageSizeParameter, searhTextParameter);
        }
    
        public virtual ObjectResult<proc_Report_SearchJobsBetweenDatesWithFirmName_Result> proc_Report_SearchJobsBetweenDatesWithFirmName(Nullable<System.DateTime> startDate, Nullable<System.DateTime> endDate, Nullable<int> firmId, Nullable<int> pageNumber, Nullable<int> pageSize)
        {
            var startDateParameter = startDate.HasValue ?
                new ObjectParameter("StartDate", startDate) :
                new ObjectParameter("StartDate", typeof(System.DateTime));
    
            var endDateParameter = endDate.HasValue ?
                new ObjectParameter("EndDate", endDate) :
                new ObjectParameter("EndDate", typeof(System.DateTime));
    
            var firmIdParameter = firmId.HasValue ?
                new ObjectParameter("FirmId", firmId) :
                new ObjectParameter("FirmId", typeof(int));
    
            var pageNumberParameter = pageNumber.HasValue ?
                new ObjectParameter("PageNumber", pageNumber) :
                new ObjectParameter("PageNumber", typeof(int));
    
            var pageSizeParameter = pageSize.HasValue ?
                new ObjectParameter("PageSize", pageSize) :
                new ObjectParameter("PageSize", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<proc_Report_SearchJobsBetweenDatesWithFirmName_Result>("proc_Report_SearchJobsBetweenDatesWithFirmName", startDateParameter, endDateParameter, firmIdParameter, pageNumberParameter, pageSizeParameter);
        }
    }
}
