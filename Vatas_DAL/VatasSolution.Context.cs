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
    
        public virtual ObjectResult<proc_ReturnsAtFrontOffice_Result> proc_ReturnsAtFrontOffice()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<proc_ReturnsAtFrontOffice_Result>("proc_ReturnsAtFrontOffice");
        }
    
        public virtual ObjectResult<proc_ReturnsAssigned_Result> proc_ReturnsAssigned()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<proc_ReturnsAssigned_Result>("proc_ReturnsAssigned");
        }
    
        public virtual ObjectResult<proc_GetReturnsByJobStatus_Result> proc_GetReturnsByJobStatus(string jobStatus)
        {
            var jobStatusParameter = jobStatus != null ?
                new ObjectParameter("JobStatus", jobStatus) :
                new ObjectParameter("JobStatus", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<proc_GetReturnsByJobStatus_Result>("proc_GetReturnsByJobStatus", jobStatusParameter);
        }
    
        public virtual ObjectResult<proc_SearchJobsBetweenDates_Result> proc_SearchJobsBetweenDates(Nullable<System.DateTime> startDate, Nullable<System.DateTime> endDate)
        {
            var startDateParameter = startDate.HasValue ?
                new ObjectParameter("StartDate", startDate) :
                new ObjectParameter("StartDate", typeof(System.DateTime));
    
            var endDateParameter = endDate.HasValue ?
                new ObjectParameter("EndDate", endDate) :
                new ObjectParameter("EndDate", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<proc_SearchJobsBetweenDates_Result>("proc_SearchJobsBetweenDates", startDateParameter, endDateParameter);
        }
    }
}