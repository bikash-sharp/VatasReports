<%@ Page Title="Tax Help Desk | Login" Language="C#" MasterPageFile="~/StaticPage.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Vatas_UI.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-group {
            margin-bottom: 10px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class=" login-page">
        <div class="login-box">
            <div class="login-logo">
                <a href="javascript:;"><b>Tax </b>Help Desk</a>
            </div>
            <div class="login-box-body">
                <p class="login-box-msg">Sign in to start your session</p>
                <div class="form-group has-feedback">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email" AutoCompleteType="Disabled"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" ControlToValidate="txtEmail" EnableClientScript="true" ValidationGroup="Login" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>

                </div>
                <div class="form-group has-feedback">
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Password" TextMode="Password" AutoCompleteType="Disabled"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" ControlToValidate="txtPassword" EnableClientScript="true" ValidationGroup="Login" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <div class="row">
                    <div class="col-md-8">
                        <div class="checkbox icheck">
                            <label>
                                <asp:CheckBox ID="chkRememberMe" runat="server" />&nbsp;Remember Me</label>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <asp:Button ID="BtnSubmit" CssClass="btn btn-primary btn-block btn-flat" runat="server" Text="Sign In" OnClick="BtnSubmit_Click" ValidationGroup="Login" />
                    </div>
                </div>
                <br />
                <a href="<%= this.AppPath() + "SignUp" %>" class="text-center">Register a new membership</a>
                <div class="social-auth-links text-center hide">
                    <p>- OR -</p>
                    <a href="#" class="btn btn-block btn-social btn-facebook btn-flat"><i class="fa fa-facebook"></i>Sign in using
        Facebook</a>
                    <a href="#" class="btn btn-block btn-social btn-google btn-flat"><i class="fa fa-google-plus"></i>Sign in using
        Google+</a>
                </div>
                <%--OnClick="lnkRecoverPassword_Click"--%>
                <asp:LinkButton ID="lnkRecoverPassword" runat="server" CssClass="hide">I forgot my password</asp:LinkButton>
            </div>
        </div>
    </section>
</asp:Content>
