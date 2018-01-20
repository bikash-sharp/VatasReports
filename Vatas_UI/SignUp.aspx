<%@ Page Title="Vatas | New User" Language="C#" MasterPageFile="~/StaticPage.Master" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="Vatas_UI.SignUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .glyphicon-remove {
            padding: 0px 0px 0px 20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="register-page">
        <div class="register-box">
            <div class="register-logo">
                <a href="javascript:;"><b>Vatas </b>Infotech</a>
            </div>
            <div class="register-box-body">
                <p class="login-box-msg">Register a new membership</p>
                <div>
                    <div class="form-group has-feedback">
                        <asp:TextBox ID="txtFirstName" runat="server" MaxLength="15" class="form-control" placeholder="First Name" />
                        <span class="glyphicon glyphicon-user form-control-feedback"></span>
                        <asp:RequiredFieldValidator ID="rfvFirstName" ControlToValidate="txtFirstName" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="CreateUser" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group has-feedback">
                        <asp:TextBox ID="txtLastName" runat="server" MaxLength="15" class="form-control" placeholder="Last Name" />
                        <span class="glyphicon glyphicon-user form-control-feedback"></span>
                        <asp:RequiredFieldValidator ID="rfvLastName" ControlToValidate="txtLastName" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="CreateUser" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group has-feedback">
                        <asp:TextBox ID="txtEmail" runat="server" class="form-control" MaxLength="30" placeholder="Email" />
                        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                        <asp:RequiredFieldValidator ID="rfvEmail" ControlToValidate="txtEmail" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="CreateUser" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revEmail" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtEmail" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="CreateUser" SetFocusOnError="true" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>
                    <div class="form-group has-feedback">
                        <asp:TextBox ID="txtPassword" MaxLength="15" runat="server" class="form-control" placeholder="Password" TextMode="Password" />
                        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                        <asp:RequiredFieldValidator ID="rfvPassword" ControlToValidate="txtPassword" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="CreateUser" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group has-feedback">
                        <asp:TextBox ID="txtConfirmPassword" MaxLength="15" runat="server" class="form-control" placeholder="Confirm Password" TextMode="Password" />
                        <span class="glyphicon glyphicon-log-in form-control-feedback"></span>
                        <asp:CompareValidator ID="cmConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" ValidationGroup="CreateUser" />
                        <asp:RequiredFieldValidator ID="rfvConfirmPassword" ControlToValidate="txtConfirmPassword" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="CreateUser" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group has-feedback">
                        <asp:TextBox ID="txtMobileNumber" runat="server" MaxLength="10" class="form-control" placeholder="Mobile Number" />
                        <span class="glyphicon glyphicon-phone form-control-feedback"></span>
                        <asp:RegularExpressionValidator runat="server" ID="revMobileNumber" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ControlToValidate="txtMobileNumber" ValidationGroup="CreateUser" SetFocusOnError="true" Display="Dynamic" ValidationExpression="[0-9]{10}"></asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="rfvMobileNumber" ControlToValidate="txtMobileNumber" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="CreateUser" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <asp:Button ID="btnSubmit" CssClass="btn btn-primary btn-block btn-flat" runat="server" Text="Register" OnClick="btnSubmit_Click" ValidationGroup="CreateUser" />
                        </div>
                    </div>

                    <div class="form-group has-feedback" style="margin: 15px;">
                    </div>
                </div>
                <div class="social-auth-links text-center">
                    <p>- OR -</p>
                    <a href="#" class="btn btn-block btn-social btn-facebook btn-flat"><i class="fa fa-facebook"></i>Sign up using Facebook</a>
                    <a href="#" class="btn btn-block btn-social btn-google btn-flat"><i class="fa fa-google-plus"></i>Sign up using Google+</a>
                </div>
                <a href="<%= this.AppPath() + "Login" %>" class="text-center">I already have a membership</a>

            </div>
        </div>
    </section>
</asp:Content>
