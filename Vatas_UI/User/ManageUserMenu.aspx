<%@ Page Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="ManageUserMenu.aspx.cs" Inherits="Vatas_UI.User.ManageMenu" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .select2-container .select2-selection--single {
            height: 34px !important;
        }

        .select2-container--default.select2-container--open {
            width: 100% !important;
        }

        .select2-container--default .select2-selection--single .select2-selection__rendered {
            line-height: 28px !important;
        }

        .select2-container .select2-selection--single .select2-selection__rendered {
            padding-left: 0px !important;
        }

        .select2-container--default .select2-selection--single .select2-selection__arrow {
            height: 34px !important;
        }

        .select2-container--default .select2-selection--single .select2-selection__arrow {
            height: 34px !important;
        }

        .select2-container {
            width: 100% !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>Manage User Menu</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>User</a></li>
            <li><a href="javascript:;">Manage User Menu</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">Manage User Menu</h3>
                <a href="<%= this.AppPath() + "ManageRoles" %>" class="btn btn-info text-center" style="float: right">Back</a>
                <button type="button" class="btn btn-info text-center addMenu" data-toggle="modal" data-target="#exampleModal" data-whatever="Add Menu To Role" style="float: right; margin-right: 10px;">Add Menu To Role</button>
            </div>
            <div class="box-body">
                <div class="form-inline">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="example1" class="table table-bordered table-striped dataTable">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Menu Name</th>
                                        <th>Menu Level</th>
                                        <th>Project Name</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptMenu" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Container.ItemIndex + 1 %></td>
                                                <td><%# Eval("MenuName") %></td>
                                                <td><%# Eval("MenuLevel") %></td>
                                                <td><%# Eval("ProjectName") %></td>
                                                <td>
                                                    <asp:Button ID="btnDeleteMenu" CommandArgument='<%# Eval("MenuId") %>' Text="Delete" CssClass="btn btn-danger" runat="server" OnClick="btnDeleteMenu_Click" />
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
        <div class="overlay">
            <i class="fa fa-refresh fa-spin"></i>
        </div>

        <div class="modal fade" id="exampleModal" role="dialog" aria-labelledby="exampleModalLabel">
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
                                <label for="Role-name" class="control-label">Select Menu:</label>
                                <asp:DropDownList ID="ddlMenu" runat="server" CssClass="form-control pull-left select2" ValidationGroup="AddUpdateMenu" AppendDataBoundItems="true">
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="btnAddUpdateMenu" Text="Add" class="btn btn-primary" runat="server" ValidationGroup="AddUpdateMenu" OnClick="btnAddUpdateMenu_Click" />
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceFooter" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('.select2').select2();
            $('#liUser').addClass('active');
            $('#liManageRoles').addClass('active');
        });

        $('#exampleModal').on('show.bs.modal', function (event) {
            var Button = $(event.relatedTarget)
            var Rec = Button.data('whatever')
            var modal = $(this)
            modal.find('.modal-title').text(Rec)
        })

    </script>
</asp:Content>
