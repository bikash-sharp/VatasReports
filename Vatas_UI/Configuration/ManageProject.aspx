<%@ Page Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="ManageProject.aspx.cs" Inherits="Vatas_UI.Configuration.ManageProject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>Manage Project</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>User</a></li>
            <li><a href="javascript:;">Manage Project</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">Manage Project</h3>
                <button type="button" class="btn btn-info text-center addPath" data-projectid="0" data-projectname="" data-toggle="modal" data-target="#exampleModal" data-whatever="Add Project" style="float: right">Add Project</button>
            </div>
            <div class="box-body">
                <div class="form-inline">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="example1" class="table table-bordered table-striped dataTable">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Project Name</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptProject" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Container.ItemIndex + 1 %>
                                                </td>
                                                <td><%# Eval("ProjectName") %></td>
                                                <td>
                                                    <asp:LinkButton type="button" ID="btnEditProject" Text="Edit" runat="server" UseSubmitBehavior="false" OnClientClick="return" data-projectid='<%# Eval("ProjectId") %>' data-projectname='<%# Eval("ProjectName") %>' data-toggle="modal" data-target="#exampleModal" data-whatever="Edit Project" CssClass="btn btn-success"><i class="glyphicon glyphicon-edit"></i>&nbsp;Edit</asp:LinkButton>
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
                            <asp:HiddenField ID="hdnProjectId" runat="server" Value="0" />
                            <div class="form-group">
                                <label class="control-label">Project Name:</label>
                                <asp:TextBox ID="txtProjectName" runat="server" class="form-control" placeholder="Project Name" />
                                <asp:RequiredFieldValidator ID="rfvProjectName" ControlToValidate="txtProjectName" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;padding: 40px 20px 0px 0px !important;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="AddUpdateProject" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:Button ID="btnAddUpdateProject" Text="Save" class="btn btn-primary" runat="server" ValidationGroup="AddUpdateProject" OnClick="btnAddUpdateProject_Click" />
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
            $('#liManageProject').addClass('active');
        });

        $('#exampleModal').on('show.bs.modal', function (event) {
            var Button = $(event.relatedTarget)
            var Rec = Button.data('whatever')
            var projectId = Button.data('projectid')
            var ProjectName = Button.data('projectname')
            var modal = $(this)
            modal.find('.modal-title').text(Rec)
            modal.find('.modal-body #hdnProjectId').val(projectId)
            modal.find('.modal-body #txtProjectName').val(ProjectName)
        })
    </script>
</asp:Content>
