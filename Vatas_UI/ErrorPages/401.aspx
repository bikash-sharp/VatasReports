<%@ Page Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="401.aspx.cs" Inherits="Vatas_UI.ErrorPages._401" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>401 Error</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>Error</a></li>
            <li><a href="javascript:;">401 Error</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="error-page">
            <h2 class="headline text-yellow">401</h2>
            <div class="error-content">

                <h3><i class="fa fa-danger text-red"></i>Oops! Access is denied.</h3>
                <p>
                    401 - Unauthorized : Access denied due to vaild permission. <br />You do not have permission to view this directory or page using the credentials that you supplied.
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
