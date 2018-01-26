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
    
    public partial class AdminEntities : DbContext
    {
        public AdminEntities()
            : base("name=AdminEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<tbl_User_Credential> tbl_User_Credential { get; set; }
        public virtual DbSet<tbl_User_Session_Details> tbl_User_Session_Details { get; set; }
        public virtual DbSet<tbl_User_Transaction> tbl_User_Transaction { get; set; }
        public virtual DbSet<tbl_UserGroup_Registration> tbl_UserGroup_Registration { get; set; }
        public virtual DbSet<tbl_User_Info> tbl_User_Info { get; set; }
        public virtual DbSet<tbl_Roles> tbl_Roles { get; set; }
        public virtual DbSet<tbl_UserRoles> tbl_UserRoles { get; set; }
        public virtual DbSet<tbl_UserMenu> tbl_UserMenu { get; set; }
        public virtual DbSet<tbl_Menu> tbl_Menu { get; set; }
        public virtual DbSet<tbl_Path> tbl_Path { get; set; }
        public virtual DbSet<tbl_Project> tbl_Project { get; set; }
    
        public virtual ObjectResult<proc_GetRegisteredUserByUserId_Result> proc_GetRegisteredUserByUserId(Nullable<int> userId)
        {
            var userIdParameter = userId.HasValue ?
                new ObjectParameter("UserId", userId) :
                new ObjectParameter("UserId", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<proc_GetRegisteredUserByUserId_Result>("proc_GetRegisteredUserByUserId", userIdParameter);
        }
    
        public virtual ObjectResult<proc_GetUserRoleByRoleId_Result> proc_GetUserRoleByRoleId(Nullable<int> roleId)
        {
            var roleIdParameter = roleId.HasValue ?
                new ObjectParameter("RoleId", roleId) :
                new ObjectParameter("RoleId", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<proc_GetUserRoleByRoleId_Result>("proc_GetUserRoleByRoleId", roleIdParameter);
        }
    
        public virtual int proc_AddUpdateRolesByRoleId(Nullable<int> roleId, string roleName)
        {
            var roleIdParameter = roleId.HasValue ?
                new ObjectParameter("RoleId", roleId) :
                new ObjectParameter("RoleId", typeof(int));
    
            var roleNameParameter = roleName != null ?
                new ObjectParameter("RoleName", roleName) :
                new ObjectParameter("RoleName", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("proc_AddUpdateRolesByRoleId", roleIdParameter, roleNameParameter);
        }
    
        public virtual ObjectResult<proc_GetMenuByRoleId_Result> proc_GetMenuByRoleId(Nullable<int> roleId)
        {
            var roleIdParameter = roleId.HasValue ?
                new ObjectParameter("RoleId", roleId) :
                new ObjectParameter("RoleId", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<proc_GetMenuByRoleId_Result>("proc_GetMenuByRoleId", roleIdParameter);
        }
    
        public virtual int proc_AddMenuToUserMenuByRoleId(Nullable<int> roleId, Nullable<int> menuId)
        {
            var roleIdParameter = roleId.HasValue ?
                new ObjectParameter("RoleId", roleId) :
                new ObjectParameter("RoleId", typeof(int));
    
            var menuIdParameter = menuId.HasValue ?
                new ObjectParameter("MenuId", menuId) :
                new ObjectParameter("MenuId", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("proc_AddMenuToUserMenuByRoleId", roleIdParameter, menuIdParameter);
        }
    
        public virtual int proc_AddUpdateMenu(Nullable<int> menuId, string menuName)
        {
            var menuIdParameter = menuId.HasValue ?
                new ObjectParameter("MenuId", menuId) :
                new ObjectParameter("MenuId", typeof(int));
    
            var menuNameParameter = menuName != null ?
                new ObjectParameter("MenuName", menuName) :
                new ObjectParameter("MenuName", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("proc_AddUpdateMenu", menuIdParameter, menuNameParameter);
        }
    
        public virtual ObjectResult<proc_GetUserRoleByUserId_Result> proc_GetUserRoleByUserId(Nullable<int> userId)
        {
            var userIdParameter = userId.HasValue ?
                new ObjectParameter("UserId", userId) :
                new ObjectParameter("UserId", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<proc_GetUserRoleByUserId_Result>("proc_GetUserRoleByUserId", userIdParameter);
        }
    
        public virtual ObjectResult<proc_GetAllRegisteredUsers_Result> proc_GetAllRegisteredUsers()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<proc_GetAllRegisteredUsers_Result>("proc_GetAllRegisteredUsers");
        }
    
        public virtual int proc_AddUpdatePathByPathId(Nullable<int> pathId, string pathName, string host, string path, string pathProject)
        {
            var pathIdParameter = pathId.HasValue ?
                new ObjectParameter("PathId", pathId) :
                new ObjectParameter("PathId", typeof(int));
    
            var pathNameParameter = pathName != null ?
                new ObjectParameter("PathName", pathName) :
                new ObjectParameter("PathName", typeof(string));
    
            var hostParameter = host != null ?
                new ObjectParameter("Host", host) :
                new ObjectParameter("Host", typeof(string));
    
            var pathParameter = path != null ?
                new ObjectParameter("Path", path) :
                new ObjectParameter("Path", typeof(string));
    
            var pathProjectParameter = pathProject != null ?
                new ObjectParameter("PathProject", pathProject) :
                new ObjectParameter("PathProject", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("proc_AddUpdatePathByPathId", pathIdParameter, pathNameParameter, hostParameter, pathParameter, pathProjectParameter);
        }
    
        public virtual int proc_AddUpdateProjectByProjectId(Nullable<int> projectId, string projectName)
        {
            var projectIdParameter = projectId.HasValue ?
                new ObjectParameter("ProjectId", projectId) :
                new ObjectParameter("ProjectId", typeof(int));
    
            var projectNameParameter = projectName != null ?
                new ObjectParameter("ProjectName", projectName) :
                new ObjectParameter("ProjectName", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("proc_AddUpdateProjectByProjectId", projectIdParameter, projectNameParameter);
        }
    
        public virtual int proc_AddUpdateUser(Nullable<int> userId, string firstName, string lastName, string email, string password, string mobileNumber, string accountType, Nullable<int> roleId, string isActive)
        {
            var userIdParameter = userId.HasValue ?
                new ObjectParameter("UserId", userId) :
                new ObjectParameter("UserId", typeof(int));
    
            var firstNameParameter = firstName != null ?
                new ObjectParameter("FirstName", firstName) :
                new ObjectParameter("FirstName", typeof(string));
    
            var lastNameParameter = lastName != null ?
                new ObjectParameter("LastName", lastName) :
                new ObjectParameter("LastName", typeof(string));
    
            var emailParameter = email != null ?
                new ObjectParameter("Email", email) :
                new ObjectParameter("Email", typeof(string));
    
            var passwordParameter = password != null ?
                new ObjectParameter("Password", password) :
                new ObjectParameter("Password", typeof(string));
    
            var mobileNumberParameter = mobileNumber != null ?
                new ObjectParameter("MobileNumber", mobileNumber) :
                new ObjectParameter("MobileNumber", typeof(string));
    
            var accountTypeParameter = accountType != null ?
                new ObjectParameter("AccountType", accountType) :
                new ObjectParameter("AccountType", typeof(string));
    
            var roleIdParameter = roleId.HasValue ?
                new ObjectParameter("RoleId", roleId) :
                new ObjectParameter("RoleId", typeof(int));
    
            var isActiveParameter = isActive != null ?
                new ObjectParameter("IsActive", isActive) :
                new ObjectParameter("IsActive", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("proc_AddUpdateUser", userIdParameter, firstNameParameter, lastNameParameter, emailParameter, passwordParameter, mobileNumberParameter, accountTypeParameter, roleIdParameter, isActiveParameter);
        }
    }
}
