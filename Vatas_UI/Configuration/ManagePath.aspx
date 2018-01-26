<%@ Page Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="ManagePath.aspx.cs" Inherits="Vatas_UI.Configuration.ManagePath" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>Manage Menu</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>User</a></li>
            <li><a href="javascript:;">Manage Path</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">Manage Path</h3>
                <button type="button" class="btn btn-info text-center addPath" data-pathid="0" data-pathname="" data-host="" data-path=""  data-toggle="modal" data-target="#exampleModal" data-whatever="Add Path" style="float: right">Add Path</button>
            </div>
            <div class="box-body">
                <div class="form-inline">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="example1" class="table table-bordered table-striped dataTable">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Path Name</th>
                                        <th>Host</th>
                                        <th>Path</th>
                                        <th>Path Project</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptPath" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Container.ItemIndex + 1 %>
                                                </td>
                                                <td><%# Eval("PathName") %></td>
                                                <td><%# Eval("Host") %></td>
                                                <td><%# Eval("Path") %></td>
                                                <td><%# Eval("PathProject") %></td>
                                                <td>
                                                    <asp:LinkButton type="button" ID="btnEditPath" Text="Edit" runat="server" UseSubmitBehavior="false" OnClientClick="return" data-pathid='<%# Eval("PathId") %>' data-pathname='<%# Eval("PathName") %>' data-host='<%# Eval("Host") %>' data-path='<%# Eval("Path") %>' data-toggle="modal" data-target="#exampleModal" data-whatever="Edit Path" CssClass="btn btn-success"><i class="glyphicon glyphicon-edit"></i>&nbsp;Edit</asp:LinkButton>
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
                            <asp:HiddenField ID="hdnPathId" runat="server" Value="0" />
                            <div class="form-group">
                                <label class="control-label">Path Name:</label>
                                <asp:TextBox ID="txtPathName" runat="server" class="form-control" placeholder="Path Name" />
                                <asp:RequiredFieldValidator ID="rfvPathName" ControlToValidate="txtPathName" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;padding: 40px 20px 0px 0px !important;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="AddUpdatePath" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div>
                            <div class="form-group">
                                <label class="control-label">Host:</label>
                                <asp:TextBox ID="txtHost" runat="server" class="form-control" placeholder="Host" />
                                <asp:RequiredFieldValidator ID="rfvHost" ControlToValidate="txtHost" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;padding: 40px 20px 0px 0px !important;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="AddUpdatePath" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div>
                            <div class="form-group">
                                <label class="control-label">Path:</label>
                                <asp:TextBox ID="txtPath" runat="server" class="form-control" placeholder="Path" />
                                <asp:RequiredFieldValidator ID="rfvPath" ControlToValidate="txtPath" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;padding: 40px 20px 0px 0px !important;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="AddUpdatePath" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div>
                            <div class="form-group">
                                <label class="control-label">Path Project:</label>
                                <asp:DropDownList ID="ddlProject" runat="server" CssClass="form-control pull-left select2" ValidationGroup="AddUpdatePath" AppendDataBoundItems="true">
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="btnAddUpdatePath" Text="Save" class="btn btn-primary" runat="server" ValidationGroup="AddUpdatePath" OnClick="btnAddUpdatePath_Click" />
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
            $('#liConfiguration').addClass('active');
            $('#liManagePath').addClass('active');
        });

        $('#exampleModal').on('show.bs.modal', function (event) {
            var Button = $(event.relatedTarget)
            var Rec = Button.data('whatever')
            var PathId = Button.data('pathid')
            var PathName = Button.data('pathname')
            var Host = Button.data('host')
            var Path = Button.data('path')
            var modal = $(this)
            modal.find('.modal-title').text(Rec)
            modal.find('.modal-body #hdnPathId').val(PathId)
            modal.find('.modal-body #txtPathName').val(PathName)
            modal.find('.modal-body #txtPath').val(Host)
            modal.find('.modal-body #txtHost').val(Path)
        })
    </script>
</asp:Content>
