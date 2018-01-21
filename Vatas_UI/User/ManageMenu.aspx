<%@ Page Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="ManageMenu.aspx.cs" Inherits="Vatas_UI.User.ManageMenu" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>Manage Menu</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>User</a></li>
            <li><a href="javascript:;">Manage Menu</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">Manage Menu</h3>
                <a href="<%= this.AppPath() + "ManageRoles" %>" class="btn btn-info text-center" style="float: right">Back</a>
            </div>
            <div class="box-body">
                <div class="form-inline">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="example1" class="table table-bordered table-striped dataTable">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Menu Name</th>
                                        <th>Menu Level</th>
                                        <th>Project Name</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptMenu" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Container.ItemIndex + 1 %></td>
                                                <td><%# Eval("MenuName") %></td>
                                                <td><%# Eval("MenuLevel") %></td>
                                                <td><%# Eval("ProjectName") %></td>
                                                <td>
                                                    <asp:Button ID="btnDeleteMenu" CommandArgument='<%# Eval("MenuId") %>' Text="Delete" CssClass="btn btn-danger" runat="server" OnClick="btnDeleteMenu_Click" />
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="box-footer">
            </div>
        </div>
        <div class="overlay">
            <i class="fa fa-refresh fa-spin"></i>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceFooter" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#liUser').addClass('active');
            $('#liManageRoles').addClass('active');
        });
    </script>
</asp:Content>
