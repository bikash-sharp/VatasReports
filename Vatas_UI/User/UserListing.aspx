﻿<%@ Page Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="UserListing.aspx.cs" Inherits="Vatas_UI.User.UserListing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>User Listing</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>User</a></li>
            <li><a href="javascript:;">User Listing</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">User Listing</h3>
                <a href="<%= this.AppPath() + "CreateUser" %>" class="btn btn-info text-center" style="float: right;margin-left:1%;">Create New User</a>
                <asp:CheckBox ID="chkIsActive" runat="server" Checked="true" AutoPostBack="true" OnCheckedChanged="chkIsActive_CheckedChanged" style="float:right!important;" />
            </div>
            <div class="box-body">
                <div class="form-inline">
                    <div class="row">
                        <div class="col-sm-12">                            
                            <table id="example1" class="table table-bordered table-striped dataTable">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>First Name</th>
                                        <th>Last Name</th>
                                        <th>EmailId</th>
                                        <%--<th>Password</th>--%>
                                        <th>Mobile No.</th>
                                        <%--<th>Account Type</th>--%>
                                        <th>Role Name</th>
                                        <th>Login Enabled ?</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptUserListing" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <%# Container.ItemIndex + 1 %>
                                                    <asp:HiddenField ID="hdnUserId" runat="server" Value='<%# Eval("UserId") %>' />
                                                </td>
                                                <td><%# Eval("FirstName") %></td>
                                                <td><%# Eval("LastName") %></td>
                                                <td><%# Eval("Email") %></td>
                                                <%--<td><%# Eval("Password") %></td>--%>
                                                <td><%# Eval("MobileNumber") %></td>
                                                <%--<td><%# Eval("AccountType") %></td>--%>
                                                <td><%# Eval("RoleName") %></td>
                                                <td><asp:Label ID="lblActive" runat="server" Text='<%# ((Eval("IsActive")+"").ToLower() == "y" ? "Enabled":"Disabled")%>' ForeColor='<%# ((Eval("IsActive")+"").ToLower() == "y" ? System.Drawing.Color.Green:System.Drawing.Color.Red)%>'></asp:Label></td>
                                                <td>
                                                    <%--<asp:Button ID="btnUserDetail" CommandArgument='<%# Eval("UserId") %>' Text="Show Detail" CssClass="btn btn-info" runat="server" OnClick="btnUserDetail_Click"/>--%>
                                                    <%if (BLFunction.GetRoleName().ToLower() == "superadmin")
                                                        {
                                                    %>
                                                    <asp:LinkButton ID="btnEdit" CausesValidation="false" CommandArgument='<%# Eval("UserId") %>' Text="Edit" CssClass="btn btn-success" runat="server" OnClick="btnEditUser_Click"><i class="glyphicon glyphicon-edit"></i>&nbsp;Edit</asp:LinkButton>
                                                    <asp:LinkButton ID="lnkDeleteUser" CausesValidation="false" CommandArgument='<%# Eval("UserId") %>' Text="Delete" Visible='<%# chkIsActive.Checked ? true : false %>' CssClass="btn btn-danger" runat="server" OnClick="btnDeleteUser_Click" OnClientClick="if(!ConfirmMessage(this))return false;"><i class="glyphicon glyphicon-trash"></i>&nbsp;Disable</asp:LinkButton>
                                                    <asp:LinkButton ID="btnEnableUser" CausesValidation="false" CommandArgument='<%# Eval("UserId") %>' Text="Enable" Visible='<%# chkIsActive.Checked ? false : true %>' CssClass="btn btn-info" runat="server" OnClick="btnEnableUser_Click"><i class="glyphicon glyphicon-ok"></i>&nbsp;Enable</asp:LinkButton>
                                                    
                                                    <%} %>
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
        </div>
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
            $('#liUserListing').addClass('active');
            $('[id$=chkIsActive]').iCheck('destroy');           
            $('[id$=chkIsActive]').bootstrapToggle({
                on: 'Enabled Users',
                off: 'Disabled Users',
                onstyle: 'success',
                offstyle: 'danger',
                style: 'android'
            });
            $('[id$=chkIsActive]').on('change', function () {
                $(this).click();
                //$('#console-event').html('Toggle: ' + $(this).prop('checked'))
            });
        });
    </script>
</asp:Content>

