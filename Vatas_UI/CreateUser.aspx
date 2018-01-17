<%@ Page Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="CreateUser.aspx.cs" Inherits="Vatas_UI.CreateUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>Create User</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>User</a></li>
            <li><a href="javascript:;">Create User</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="row">
            <div class="col-md-6 col-md-offset-3">
                <div class="box box-info">
                    <div class="box-header with-border">
                        <h3 class="box-title">Create User</h3>
                    </div>
                    <div class="form-horizontal">
                        <div class="box-body">
                            <div class="form-group has-feedback">
                                <label for="txtFirstName" class="col-sm-2 control-label">First Name</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="txtFirstName" runat="server" MaxLength="15" class="form-control" placeholder="First Name" />
                                    <asp:RequiredFieldValidator ID="rfvFirstName" ControlToValidate="txtFirstName" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="CreateUser" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group has-feedback">
                                <label for="txtLastName" class="col-sm-2 control-label">Last Name</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="txtLastName" runat="server" MaxLength="15" class="form-control" placeholder="Last Name" />
                                    <asp:RequiredFieldValidator ID="rfvLastName" ControlToValidate="txtLastName" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="CreateUser" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group has-feedback">
                                <label for="txtEmail" class="col-sm-2 control-label">Email</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="txtEmail" runat="server" class="form-control" MaxLength="30" placeholder="Email" />
                                    <asp:RegularExpressionValidator ID="revEmail" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtEmail" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="CreateUser" SetFocusOnError="true" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                            <div class="form-group has-feedback">
                                <label for="txtPassword" class="col-sm-2 control-label">Password</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="txtPassword" MaxLength="15" runat="server" class="form-control" placeholder="Password" TextMode="Password" />
                                    <asp:RequiredFieldValidator ID="rfvPassword" ControlToValidate="txtPassword" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="CreateUser" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group has-feedback">
                                <label for="txtConfirmPassword" class="col-sm-2 control-label">Confirm Password</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="txtConfirmPassword" MaxLength="15" runat="server" class="form-control" placeholder="Confirm Password" TextMode="Password" />
                                    <asp:CompareValidator ID="cmConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" />
                                    <asp:RequiredFieldValidator ID="rfvConfirmPassword" ControlToValidate="txtConfirmPassword" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="CreateUser" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group has-feedback">
                                <label for="txtMobileNumber" class="col-sm-2 control-label">Mobile Number</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="txtMobileNumber" runat="server" MaxLength="10" class="form-control" placeholder="Mobile Number" />
                                    <asp:RegularExpressionValidator runat="server" ID="revMobileNumber" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ControlToValidate="txtMobileNumber" ValidationGroup="CreateUser" SetFocusOnError="true" Display="Dynamic" ValidationExpression="^([0-9\(\)\/\+ \-]*)$"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                            <div class="form-group has-feedback">
                                <label for="txtAccountType" class="col-sm-2 control-label">Account Type</label>
                                <div class="col-sm-10">
                                    <asp:DropDownList ID="ddlAccountType" runat="server" class="form-control">
                                        <asp:ListItem Value="U">User</asp:ListItem>
                                        <asp:ListItem Value="A">Admin</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <button type="submit" class="btn btn-default">Cancel</button>
                            <asp:Button ID="btnSubmit" CssClass="btn btn-info pull-right submit" runat="server" Text="Submit" OnClick="btnSubmit_Click" ValidationGroup="CreateUser" />
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
            $('#liCreateUser').addClass('active');
        });
    </script>
</asp:Content>











