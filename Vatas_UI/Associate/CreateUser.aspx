<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="CreateUser.aspx.cs" Inherits="Vatas_UI.Associate.CreateUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .glyphicon-remove {
            padding: 0px 0px 0px 20px !important;
        }
        .form-horizontal .has-feedback .form-control-feedback{
            right:25px !important;
        }
    table {
            counter-reset: section;
        }

        .count:before {
            counter-increment: section;
            content: counter(section);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>New User</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>Home</a></li>
            <li><a href="javascript:;">New User</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">New User</h3>
            </div>
            <div class="box-body">
                <div class="col-md-6 col-md-offset-3">
                    <div class="box box-info">
                        <div class="form-horizontal">
                            <div class="box-body">
                                <div class="form-group has-feedback">
                                    <label for="txtDocumentTitle" class="col-sm-2 control-label">First Name</label>
                                    <div class="col-sm-10">
                                        <asp:TextBox ID="txtFirstName" runat="server" MaxLength="50" class="form-control" placeholder="First Name" />
                                        <asp:RequiredFieldValidator ID="rfvFirstName" ControlToValidate="txtFirstName" runat="server" ErrorMessage="<span class='glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="CreateUser" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="form-group has-feedback">
                                    <label for="txtLastName" class="col-sm-2 control-label">Last Name</label>
                                    <div class="col-sm-10">
                                        <asp:TextBox ID="txtLastName" runat="server" MaxLength="15" class="form-control" placeholder="Last Name" />
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
                                    <label for="txtMobileNumber" class="col-sm-2 control-label">Contact</label>
                                    <div class="col-sm-10">
                                        <asp:TextBox ID="txtMobileNumber" runat="server" MaxLength="10" class="form-control" placeholder="Mobile Number" />
                                        <asp:RegularExpressionValidator runat="server" ID="revMobileNumber" ErrorMessage="<span class='glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ControlToValidate="txtMobileNumber" ValidationGroup="CreateUser" SetFocusOnError="true" Display="Dynamic" ValidationExpression="[0-9]{10}"></asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="rfvMobileNumber" ControlToValidate="txtMobileNumber" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="CreateUser" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="box-footer">
                                <asp:Button ID="btnCancel" Text="Cancel" runat="server" CssClass="btn btn-default pull-right" />
                                <asp:Button ID="btnSubmit" CssClass="btn btn-info pull-right" runat="server" Style="margin-right: 10px;" Text="Save" OnClick="btnSubmit_Click" ValidationGroup="CreateUser"  />
                            </div>
                        </div>
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
    
</asp:Content>
