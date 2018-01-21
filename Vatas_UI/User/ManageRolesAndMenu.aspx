<%@ Page Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="ManageRolesAndMenu.aspx.cs" Inherits="Vatas_UI.User.ManageRolesAndMenu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>Manage Roles and Menu</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>User</a></li>
            <li><a href="javascript:;">Manage Roles and Menu</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">Manage Roles and Menu</h3>
                <a href="<%= this.AppPath() + "AddRole" %>" class="btn btn-info text-center" style="float: right">Add Role</a>
            </div>
            <div class="box-body">
                <div class="form-inline">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="example1" class="table table-bordered table-striped dataTable">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Role Name</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptRole" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Container.ItemIndex + 1 %></td>
                                                <td><%# Eval("RoleName") %></td>
                                                <td>
                                                    <asp:Button ID="btnViewMenu" Text="View Menu" runat="server" CommandArgument='<%# Eval("RoleId") %>' CssClass="btn btn-info" OnClick="btnViewMenu_Click" />
                                                    <asp:Button ID="btnEditRole" Text="Edit" runat="server" CommandArgument='<%# Eval("RoleId") %>' CssClass="btn btn-success" OnClick="btnEditRole_Click" />
                                                    <asp:Button ID="btnDeleteRole" CommandArgument='<%# Eval("RoleId") %>' Text="Delete" CssClass="btn btn-danger" runat="server" OnClick="btnDeleteRole_Click" />
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
        <!-- /.box -->
        <div class="overlay">
            <i class="fa fa-refresh fa-spin"></i>
        </div>
    </section>
    <!-- /.content -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceFooter" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#liUser').addClass('active');
            $('#liManageRolesAndMenu').addClass('active');
        });
    </script>
</asp:Content>
