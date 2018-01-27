<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="Vatas_UI.ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>Change Password</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>User</a></li>
            <li><a href="javascript:;">Change Password</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">Change Password</h3>
            </div>
            <div class="box-body">
                <div class="form-inline">
                    <div class="row">
                        <div class="col-md-6 col-md-offset-3">
                            <div class="box box-info">
                                <div class="form-horizontal">
                                    <div class="box-body">
                                        <div class="form-group has-feedback" style="margin-bottom: 13px;">
                                            <label for="txtPassword" class="col-sm-2 control-label">Old Password</label>
                                            <div class="col-xs-10 col-sm-9" style="padding-right: 0px;">
                                                <asp:TextBox ID="txtOldPassword" MaxLength="15" runat="server" class="form-control oldpwd" Style="width: 100%;" placeholder="Old Password" TextMode="Password" />
                                                <asp:RequiredFieldValidator ID="rfvOldPassword" ControlToValidate="txtOldPassword" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="ChangePassword" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="col-xs-1" style="padding-left: 0px;">
                                                <span class="input-group-btn">
                                                    <button class="btn btn-default revealOldPwd" style="padding: 6px 15px;" type="button"><i class="glyphicon glyphicon-eye-close"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="form-group has-feedback" style="margin-bottom: 0px;">
                                            <label for="txtPassword" class="col-sm-2 control-label">New Password</label>
                                            <div class="col-xs-10 col-sm-9" style="padding-right: 0px;">
                                                <asp:TextBox ID="txtPassword" MaxLength="15" runat="server" class="form-control pwd" Style="width: 100%;" placeholder="Password" TextMode="Password" />
                                                <asp:RequiredFieldValidator ID="rfvPassword" ControlToValidate="txtPassword" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="ChangePassword" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="col-xs-1" style="padding-left: 0px;">
                                                <span class="input-group-btn">
                                                    <button class="btn btn-default reveal" style="padding: 6px 15px;" type="button"><i class="glyphicon glyphicon-eye-close"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="form-group has-feedback" style="margin-bottom: 0px;">
                                            <label for="txtConfirmPassword" class="col-sm-2 control-label">New Confirm Password</label>
                                            <div class="col-xs-10 col-sm-9" style="padding-right: 0px;">
                                                <asp:TextBox ID="txtConfirmPassword" MaxLength="15" runat="server" class="form-control cfrmpwd" Style="width: 100%;" placeholder="Confirm Password" TextMode="Password" />
                                                <asp:CompareValidator ID="cmConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" ValidationGroup="ChangePassword" />
                                                <asp:RequiredFieldValidator ID="rfvConfirmPassword" ControlToValidate="txtConfirmPassword" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="ChangePassword" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="col-xs-1" style="padding-left: 0px;">
                                                <span class="input-group-btn">
                                                    <button class="btn btn-default revealCfrmPwd" style="padding: 6px 15px;" type="button"><i class="glyphicon glyphicon-eye-close"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="box-footer">
                                        <asp:Button ID="btnCancel" Text="Cancel" runat="server" CssClass="btn btn-default pull-right" OnClick="btnCancel_Click" />
                                        <asp:Button ID="btnSubmit" CssClass="btn btn-info pull-right submit" runat="server" Style="margin-right: 10px;" Text="Save" OnClick="btnSubmit_Click" ValidationGroup="ChangePassword" />
                                    </div>
                                </div>
                                <div class="box-footer">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--<div class="overlay">
            <i class="fa fa-refresh fa-spin"></i>
        </div>--%>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceFooter" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#liUser').addClass('active');
            $('#liChangePassword').addClass('active');
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

        $(".revealOldPwd").on('click', function () {
            var $pwd = $(".oldpwd");
            if ($pwd.attr('type') === 'password') {
                $pwd.attr('type', 'text');
                $('.revealOldPwd .glyphicon').removeClass('glyphicon-eye-close').addClass('glyphicon-eye-open');
            } else {
                $pwd.attr('type', 'password');
                $('.revealOldPwd .glyphicon').removeClass('glyphicon-eye-open').addClass('glyphicon-eye-close');
            }
        });

    </script>
</asp:Content>










