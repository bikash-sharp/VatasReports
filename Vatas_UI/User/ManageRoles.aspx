<%@ Page Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="ManageRoles.aspx.cs" Inherits="Vatas_UI.User.ManageRolesAndMenu" %>

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
                <button type="button" class="btn btn-info text-center addRole" data-roleid="0" data-rolename="" data-toggle="modal" data-target="#exampleModal" data-whatever="Add New Role" style="float: right">Add Role</button>
                <%--<a href="<%= this.AppPath() + "AddRole" %>" class="btn btn-info text-center" >Add Role</a>--%>
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
                                                <td><%# Container.ItemIndex + 1 %>
                                                </td>
                                                <td><%# Eval("RoleName") %></td>
                                                <td>
                                                    <asp:Button ID="btnViewMenu" Text="View Menu" runat="server" CommandArgument='<%# Eval("RoleId") %>' CssClass="btn btn-info" OnClick="btnViewMenu_Click" />
                                                    <asp:Button type="button" ID="btnEditRole" Text="Edit" runat="server" UseSubmitBehavior="false" OnClientClick="return"  data-rolename='<%# Eval("RoleName") %>' data-roleid='<%# Eval("RoleId") %>' data-toggle="modal" data-target="#exampleModal" data-whatever="Edit Role" CssClass="btn btn-success" />
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

        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="exampleModalLabel">New Message</h4>
                    </div>
                    <div class="modal-body">
                        <div>
                            <asp:HiddenField ID="hdnRoleId" runat="server" Value="0" />
                            <div class="form-group">
                                <label for="Role-name" class="control-label">Role Name:</label>
                                <asp:TextBox ID="txtRoleName" runat="server" class="form-control" placeholder="Role Name" />
                                <asp:RequiredFieldValidator ID="rfvRole" ControlToValidate="txtRoleName" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;padding: 40px 20px 0px 0px !important;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="AddUpdateRole" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="btnAddUpdateRole" Text="Save" class="btn btn-primary" runat="server" ValidationGroup="AddUpdateRole" OnClick="btnAddUpdateRole_Click" />
                    </div>
                </div>
            </div>
        </div>


    </section>
    <!-- /.content -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceFooter" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#liUser').addClass('active');
            $('#liManageRoles').addClass('active');
        });

        $('#exampleModal').on('show.bs.modal', function (event) {
            var Button = $(event.relatedTarget)
            var Rec = Button.data('whatever')
            var RoleId = Button.data('roleid')
            var RoleName = Button.data('rolename')
            var modal = $(this)
            modal.find('.modal-title').text(Rec)
            modal.find('.modal-body #hdnRoleId').val(RoleId)
            modal.find('.modal-body #txtRoleName').val(RoleName)
        })
    </script>
</asp:Content>
