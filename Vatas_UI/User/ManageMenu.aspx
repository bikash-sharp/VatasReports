<%@ Page Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="ManageMenu.aspx.cs" Inherits="Vatas_UI.User.ManageMenu1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>Manage Menu</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>User</a></li>
            <li><a href="javascript:;">Manage Menu</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">Manage Menu</h3>
                <button type="button" class="btn btn-info text-center addMenu" data-menuid="0" data-menuname="" data-toggle="modal" data-target="#exampleModal" data-whatever="Add New Menu" style="float: right">Add Menu</button>
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
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptMenu" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Container.ItemIndex + 1 %>
                                                </td>
                                                <td><%# Eval("MenuName") %></td>
                                                <td>
                                                    <asp:Button type="button" ID="btnEditMenu" Text="Edit" runat="server" UseSubmitBehavior="false" OnClientClick="return"  data-menuname='<%# Eval("MenuName") %>' data-menuid='<%# Eval("MenuId") %>' data-toggle="modal" data-target="#exampleModal" data-whatever="Edit Menu" CssClass="btn btn-success" />
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
                            <asp:HiddenField ID="hdnMenuId" runat="server" Value="0" />
                            <div class="form-group">
                                <label for="Role-name" class="control-label">Menu Name:</label>
                                <asp:TextBox ID="txtMenuName" runat="server" class="form-control" placeholder="Menu Name" />
                                <asp:RequiredFieldValidator ID="rfvMenu" ControlToValidate="txtMenuName" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;padding: 40px 20px 0px 0px !important;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="AddUpdateMenu" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="btnAddUpdateMenu" Text="Save" class="btn btn-primary" runat="server" ValidationGroup="AddUpdateMenu" OnClick="btnAddUpdateMenu_Click" />
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
            $('#liManageMenu').addClass('active');
        });

        $('#exampleModal').on('show.bs.modal', function (event) {
            var Button = $(event.relatedTarget)
            var Rec = Button.data('whatever')
            var MenuId = Button.data('menuid')
            var MenuName = Button.data('menuname')
            var modal = $(this)
            modal.find('.modal-title').text(Rec)
            modal.find('.modal-body #hdnMenuId').val(MenuId)
            modal.find('.modal-body #txtMenuName').val(MenuName)
        })
    </script>
</asp:Content>
