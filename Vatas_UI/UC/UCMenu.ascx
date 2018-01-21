<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UCMenu.ascx.cs" Inherits="Vatas_UI.UC.UCMenu" %>

<ul class="sidebar-menu">
    <li id="lihome"><a href="<%=Page.ResolveUrl("~/Index")%>" title="Home">
        <i class="fa fa-dashboard"></i><span>Dashboard</span></a>
    </li>
    <%if (BLFunction.GetRoleName().ToLower() == "superadmin")
        {
    %>
    <li id="liUser" class="treeview">
        <a href="javascript:;" title="Reports"><i class="fa fa-users"></i><span>User</span>
            <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
            <li id="liCreateUser"><a href="<%=Page.ResolveUrl("~/CreateUser")%>" title="Create User"><i class="fa fa-user"></i>Create User</a></li>
            <li id="liUserListing"><a href="<%=Page.ResolveUrl("~/UserListing")%>" title="Create User"><i class="fa fa-user"></i>Listing User</a></li>
        </ul>
    </li>
    <% } %>
    <li id="liProcess" class="treeview">
        <a href="javascript:;" title="Reports"><i class="fa fa-stack-overflow"></i><span>Process</span>
            <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
            <li id="liProcess1"><a href="<%=Page.ResolveUrl("~/ProcessFrontOfficeReturn")%>" title="Process Front Office"><i class="fa fa-server"></i>Return Received at Front Office</a></li>
            <li id="liProcess2"><a href="<%=Page.ResolveUrl("~/ProcessBackOfficeReturn")%>" title="Process Back Return"><i class="fa fa-server"></i>Return at Back Office</a></li>
            <li id="liProcess3"><a href="<%=Page.ResolveUrl("~/ProcessAssignReturn")%>" title="Process Assign Return"><i class="fa fa-server"></i>Assign Return </a></li>
            <li id="liProcess4"><a href="<%=Page.ResolveUrl("~/ProcessReAssignReturn")%>" title="Process Re-Assign Return"><i class="fa fa-server"></i>Re-Assign Return</a></li>
            <li id="liProcess5"><a href="<%=Page.ResolveUrl("~/ProcessVerifyReturn")%>" title="Process Verify Return"><i class="fa fa-server"></i>Verify Return Completed</a></li>
            <li id="liProcess6"><a href="<%=Page.ResolveUrl("~/ProcessCompletedReturn")%>" title="Process Completed Returns"><i class="fa fa-server"></i>Completed Returns</a></li>
            <%--<li id="liProcess7"><a href="<%=Page.ResolveUrl("~/ProcessInCompletedReturn")%>" title="Process InComplete Returns"><i class="fa fa-server"></i>Pending/Incompleted Returns</a></li>--%>
            <li id="liProcess8"><a href="<%=Page.ResolveUrl("~/ProcessUploadReturn")%>" title="Process Upload Returns"><i class="fa fa-server"></i>Completed Returns for Upload</a></li>
        </ul>
    </li>
    <li id="liReport" class="treeview">
        <a href="javascript:;" title="Reports"><i class="fa fa-pie-chart"></i><span>Reports</span>
            <i class="fa fa-angle-left pull-right"></i>
        </a>
        <ul class="treeview-menu">
            <li id="liReport1"><a href="<%=Page.ResolveUrl("~/FrontOfficeReturn")%>" title="Front Office Report"><i class="fa fa-files-o"></i>Return Received at Front Office</a></li>
            <li id="liReport2"><a href="<%=Page.ResolveUrl("~/ReturnAssigned")%>" title="Return Assigned"><i class="fa fa-files-o"></i>Return Assigned</a></li>
            <li id="liReport3"><a href="<%=Page.ResolveUrl("~/ReturnCompleted")%>" title="Return Completed"><i class="fa fa-files-o"></i>Return Completed</a></li>
            <li id="liReport4"><a href="<%=Page.ResolveUrl("~/ReturnIncompleted")%>" title="Return Incompleted"><i class="fa fa-files-o"></i>Return Incompleted</a></li>
            <li id="liReport5"><a href="<%=Page.ResolveUrl("~/ReturnUploaded")%>" title="Return Uploaded"><i class="fa fa-files-o"></i>Return Uploaded</a></li>
            <li id="liReport6"><a href="<%=Page.ResolveUrl("~/ReturnPending")%>" title="Pending Returns For Upload"><i class="fa fa-files-o"></i>Pending Returns for Upload</a></li>
            <li id="liReport7"><a href="<%=Page.ResolveUrl("~/SearchJobsBetweenDates")%>" title="Search Jobs Between Dates"><i class="fa fa-files-o"></i>Search Jobs Between Dates</a></li>
        </ul>
    </li>
</ul>
