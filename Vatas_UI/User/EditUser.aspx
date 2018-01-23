<%@ Page Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="EditUser.aspx.cs" Inherits="Vatas_UI.User.EditUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .toggle.android {
            border-radius: 0px;
        }

            .toggle.android .toggle-handle {
                border-radius: 0px;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>Edit/Update User</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>User</a></li>
            <li><a href="javascript:;">Edit/Update User</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="row">
            <div class="col-md-6 col-md-offset-3">
                <div class="box box-info">
                    <div class="box-header with-border">
                        <h3 class="box-title">Edit User</h3>
                    </div>
                    <div class="form-horizontal">
                        <div class="box-body">
                            <div class="form-group has-feedback">
                                <label for="txtFirstName" class="col-sm-2 control-label">First Name</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="txtFirstName" runat="server" MaxLength="15" class="form-control" placeholder="First Name" />
                                    <asp:RequiredFieldValidator ID="rfvFirstName" ControlToValidate="txtFirstName" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="EditUser" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group has-feedback">
                                <label for="txtLastName" class="col-sm-2 control-label">Last Name</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="txtLastName" runat="server" MaxLength="15" class="form-control" placeholder="Last Name" />
                                    <asp:RequiredFieldValidator ID="rfvLastName" ControlToValidate="txtLastName" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="EditUser" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group has-feedback">
                                <label for="txtEmail" class="col-sm-2 control-label">Email</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="txtEmail" runat="server" class="form-control" MaxLength="30" placeholder="Email" />
                                    <asp:RequiredFieldValidator ID="rfvEmail" ControlToValidate="txtEmail" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="EditUser" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revEmail" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtEmail" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="EditUser" SetFocusOnError="true" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                            <asp:HiddenField ID="hfPassword" runat="server" />
                            <%if (BLFunction.GetRoleName().ToLower() == "superadmin")
                                {
                            %>
                            <div class="form-group has-feedback">
                                <label for="txtPassword" class="col-sm-2 control-label">Password</label>
                                <div class="col-xs-10 col-sm-9" style="padding-right: 0px;">
                                    <asp:TextBox ID="txtPassword" MaxLength="15" runat="server" class="form-control pwd" placeholder="Password" TextMode="Password" />
                                    <asp:RequiredFieldValidator ID="rfvPassword" ControlToValidate="txtPassword" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="EditUser" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-xs-1" style="padding-left: 0px;">
                                    <span class="input-group-btn">
                                        <button class="btn btn-default reveal" style="padding: 6px 15px;" type="button"><i class="glyphicon glyphicon-eye-close"></i></button>
                                    </span>
                                </div>
                            </div>
                            <div class="form-group has-feedback" style="margin-bottom: 0px;">
                                <label for="txtConfirmPassword" class="col-sm-2 control-label">Confirm Password</label>
                                <div class="col-xs-10 col-sm-9" style="padding-right: 0px;">
                                    <asp:TextBox ID="txtConfirmPassword" MaxLength="15" runat="server" class="form-control cfrmpwd" placeholder="Confirm Password" TextMode="Password" />
                                    <asp:CompareValidator ID="cmConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" ValidationGroup="EditUser" />
                                    <asp:RequiredFieldValidator ID="rfvConfirmPassword" ControlToValidate="txtConfirmPassword" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="EditUser" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-xs-1" style="padding-left: 0px;">
                                    <span class="input-group-btn">
                                        <button class="btn btn-default revealCfrmPwd" style="padding: 6px 15px;" type="button"><i class="glyphicon glyphicon-eye-close"></i></button>
                                    </span>
                                </div>
                            </div>
                            <%} %>
                            <div class="form-group has-feedback" style="margin-bottom: 0px;">
                                <label for="txtMobileNumber" class="col-sm-2 control-label">Mobile Number</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="txtMobileNumber" runat="server" MaxLength="10" class="form-control" placeholder="Mobile Number" />
                                    <asp:RegularExpressionValidator runat="server" ID="revMobileNumber" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ControlToValidate="txtMobileNumber" ValidationGroup="EditUser" SetFocusOnError="true" Display="Dynamic" ValidationExpression="[0-9]{10}"></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="rfvMobileNumber" ControlToValidate="txtMobileNumber" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="EditUser" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group has-feedback hide">
                                <label for="txtAccountType" class="col-sm-2 control-label">Account Type</label>
                                <div class="col-sm-10">
                                    <asp:DropDownList ID="ddlAccountType" runat="server" class="form-control">
                                        <asp:ListItem Value="U">User</asp:ListItem>
                                        <asp:ListItem Value="A">Admin</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group has-feedback">
                                <label for="txtAccountType" class="col-sm-2 control-label">Roles</label>
                                <div class="col-sm-10">
                                    <asp:DropDownList ID="ddlRoles" runat="server" CssClass="form-control pull-left" ValidationGroup="EditUser" AppendDataBoundItems="true">
                                        <asp:ListItem Value="0" Selected="True">Select Role</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvdllRoles" ControlToValidate="ddlRoles" InitialValue="0" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="EditUser" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group has-feedback">
                                <label for="chkIsEnabled" class="col-sm-2 control-label">Enabled</label>
                                <div class="col-sm-5">
                                    <asp:CheckBox ID="chkIsEnabled" runat="server" />
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <%if (BLFunction.GetRoleName().ToLower() == "superadmin")
                                {
                            %>
                            <asp:Button ID="btnCancel" Text="Cancel" runat="server" CssClass="btn btn-default pull-right" OnClick="btnCancel_Click" />
                            <asp:Button ID="btnSubmit" CssClass="btn btn-info pull-right submit" Style="margin-right: 10px;" runat="server" Text="Save" OnClick="btnSubmit_Click" ValidationGroup="EditUser" />
                            <%} %>
                        </div>
                    </div>
                    <div class="box-footer">
                    </div>
                </div>
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
            $('#liUserListing').addClass('active');
            $('[id$=chkIsEnabled]').bootstrapToggle({
                on: 'Enabled',
                off: 'Disabled',
                onstyle: 'success',
                offstyle: 'danger',
                style: 'android'
            });
        });

        $(".reveal").on('click', function () {
            var $pwd = $(".pwd");
            if ($pwd.attr('type') === 'password') {
                $pwd.attr('type', 'text');
                $('.reveal .glyphicon').removeClass('glyphicon-eye-close').addClass('glyphicon-eye-open');
            } else {
                $pwd.attr('type', 'password');
                $('.reveal .glyphicon').removeClass('glyphicon-eye-open').addClass('glyphicon-eye-close');
            }
        });

        $(".revealCfrmPwd").on('click', function () {
            var $pwd = $(".cfrmpwd");
            if ($pwd.attr('type') === 'password') {
                $pwd.attr('type', 'text');
                $('.revealCfrmPwd .glyphicon').removeClass('glyphicon-eye-close').addClass('glyphicon-eye-open');
            } else {
                $pwd.attr('type', 'password');
                $('.revealCfrmPwd .glyphicon').removeClass('glyphicon-eye-open').addClass('glyphicon-eye-close');
            }
        });

    </script>
</asp:Content>











