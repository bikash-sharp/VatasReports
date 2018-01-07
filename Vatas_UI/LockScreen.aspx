<%@ Page Title="" Language="C#" MasterPageFile="~/StaticPage.Master" AutoEventWireup="true" CodeBehind="LockScreen.aspx.cs" Inherits="Vatas_UI.LockScreen" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <!-- Automatic element centering -->
    <div class="lockscreen-wrapper">
        <div class="lockscreen-logo">
            <a href="javascript:;"><b>Vatas </b>Infotech</a>
        </div>
        <!-- User name -->
        <div class="lockscreen-name" style="text-transform: capitalize">
            <asp:Literal ID="lblUserName" runat="server"></asp:Literal></div>

        <!-- START LOCK SCREEN ITEM -->
        <div class="lockscreen-item">
            <!-- lockscreen image -->
            <div class="lockscreen-image">
                <img src="<%=this.AppPath() +"Assets/dist/img/user1-128x128.jpg" %>" alt="User Image" />
            </div>
            <!-- /.lockscreen-image -->
            <asp:Panel ID="Panel1" runat="server" DefaultButton="lnkLogin">
                <!-- lockscreen credentials (contains the form) -->
                <div class="lockscreen-credentials">
                    <div class="input-group">
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Autocomplete="Off" placeholder="password" CssClass="form-control" ValidationGroup="Login"></asp:TextBox>
                        <div class="input-group-btn">
                            <asp:LinkButton ID="lnkLogin" runat="server" CssClass="btn" ValidationGroup="Login" OnClick="lnkLogin_Click">
               <i class="fa fa-arrow-right text-muted"></i>
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>
                <!-- /.lockscreen credentials -->
            </asp:Panel>
        </div>
        <!-- /.lockscreen-item -->
        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="<div class='help-block text-center text-bold' style='color:#d84a38;'>Enter your password to retrieve your session</div>" ForeColor="#d84a38" ControlToValidate="txtPassword" EnableClientScript="true" ValidationGroup="Login" SetFocusOnError="true" Display="Dynamic">
        </asp:RequiredFieldValidator>

        <div class="text-center">
            Click<a href="<%= this.AppPath() + "Login"%>" title="Login"> Here</a>  sign in as a different user
        </div>
        <div class="lockscreen-footer text-center">
            <strong>© <a href="http://www.vatasinfotech.com/">Vatas Infotech Pvt Ltd</a>.</strong>
        </div>
    </div>
    <!-- /.center -->
    <asp:HiddenField ID="hfUserName" runat="server" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceFooter" runat="server">
    <script async="async" type="text/javascript">
        $(document).ready(function () {
            $('body').addClass('lockscreen');
        });
    </script>
</asp:Content>
