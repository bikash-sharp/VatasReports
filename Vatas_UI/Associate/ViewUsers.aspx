<%@ Page Title="" Language="C#" MasterPageFile="~/Root.Master" AutoEventWireup="true" CodeBehind="ViewUsers.aspx.cs" Inherits="Vatas_UI.Associate.ViewUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>View Users</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>Home</a></li>
            <li><a href="javascript:;">View User</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">Users Listings</h3>
                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                        <i class="fa fa-minus"></i>
                    </button>
                </div>
            </div>
            <div class="box-body">
                <div class="row">
                    <div class="col-md-1">Show entries </div>
                    <div class="col-md-1">
                        <asp:DropDownList ID="ddlPageLength" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlPageLength_SelectedIndexChanged">
                            <asp:ListItem Value="10" Selected="True">10</asp:ListItem>
                            <asp:ListItem Value="20">20</asp:ListItem>
                            <asp:ListItem Value="30">30</asp:ListItem>
                            <asp:ListItem Value="50">50</asp:ListItem>
                            <asp:ListItem Value="-1">ALL</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <table id="processTable" class="table table-bordered table-striped dataTable table-responsive overflow">
                    <thead>
                        <tr style="width: 100%!important">
                            <th>Name</th>
                            <th>Email</th>
                            <th>Contact</th>
                            <th>Document Id</th>
                            <th>Title</th>
                            <th>Notes</th>
                            <th>Dated</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptProcess" runat="server">
                            <ItemTemplate>
                                <tr style="width: 100%!important">
                                    <td><asp:HiddenField ID="hfUserId" runat="server" Value='<%# Eval("UserId") %>' />
                                        <asp:Label ID="lblDocumentId" Text='<%# Eval("DocumentId") %>' runat="server" />
                                    </td>
                                    <td><asp:Label ID="lblDocumentTitle" Text='<%# Eval("DocumentTitle") %>' runat="server" /></td>
                                    <td><asp:Label ID="lblDocumentNotes" Text='<%# Eval("DocumentNotes") %>' runat="server" /></td>
                                    <td><asp:Label ID="lblDateAdded" Text='<%# Eval("DateAdded") %>' runat="server" /></td>
                                    <td><asp:Label ID="lblProcessed" Text='<%# Eval("IsProcessed") %>' runat="server" /></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
            <div class="box-footer clearfix">
                <div id="page-selection" class="pull-right" style="margin-top: 10px;"></div>
            </div>
        </div>
        <!-- /.box -->
        <div class="overlay">
            <i class="fa fa-refresh fa-spin"></i>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceFooter" runat="server">
    
</asp:Content>
