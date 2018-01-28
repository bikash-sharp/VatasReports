<%@ Page Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="404.aspx.cs" Inherits="Vatas_UI.ErrorPages._404" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>404 Error</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>Error</a></li>
            <li><a href="javascript:;">404 Error</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="error-page">
            <h2 class="headline text-yellow">404</h2>
            <div class="error-content">
                <h3><i class="fa fa-warning text-yellow"></i>Oops! Page not found.</h3>
                <p>
                    We could not find the page you were looking for.
            Meanwhile, you may <a href="<%= this.AppPath() + "Index" %>">return to dashboard</a>.
                </p>
            </div>
        </div>
        <div>
        </div>
        <div class="overlay">
            <i class="fa fa-refresh fa-spin"></i>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceFooter" runat="server">
</asp:Content>
