<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Vatas_UI.Home.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>Welcome User   
        </h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>Home</a></li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <!-- Default box -->
        <% if (Vatas_Common.BLFunction.GetRoleName().ToLower() == "associate")
            { %>
        <asp:Panel ID="AssociatePanel" runat="server">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">Services</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <!-- /. col-->
                        <div class="col-md-3 col-sm-6 col-xs-12">
                            <div class="info-box">
                                <span class="info-box-icon bg-aqua"><i class="ion ion-ios-gear-outline"></i></span>

                                <div class="info-box-content">
                                    <span class="info-box-number">
                                        <h3>PAN</h3>
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                            <!-- /.info-box -->
                        </div>
                        <!-- ./col -->
                        <!-- /. col-->
                        <div class="col-md-3 col-sm-6 col-xs-12">
                            <div class="info-box">
                                <span class="info-box-icon bg-aqua"><i class="ion ion-ios-gear-outline"></i></span>

                                <div class="info-box-content">
                                    <span class="info-box-number">
                                        <h3>TAN</h3>
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                            <!-- /.info-box -->
                        </div>
                        <!-- ./col -->
                        <!-- /. col-->
                        <div class="col-md-3 col-sm-6 col-xs-12">
                            <div class="info-box">
                                <span class="info-box-icon bg-aqua"><i class="ion ion-ios-gear-outline"></i></span>

                                <div class="info-box-content">
                                    <span class="info-box-number">
                                        <h3>ITR</h3>
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                            <!-- /.info-box -->
                        </div>
                        <!-- ./col -->
                        <!-- /. col-->
                        <div class="col-md-3 col-sm-6 col-xs-12">
                            <div class="info-box">
                                <span class="info-box-icon bg-aqua"><i class="ion ion-ios-gear-outline"></i></span>

                                <div class="info-box-content">
                                    <span class="info-box-number">
                                        <h3>GST</h3>
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                            <!-- /.info-box -->
                        </div>
                        <!-- ./col -->
                    </div>
                </div>
                <!-- /.box-body -->
                <%--<div class="box-footer">
                    Footer
                </div>--%>
                <!-- /.box-footer-->
            </div>
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">Users</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <!-- ./col -->
                        <div class="col-lg-3 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-yellow">
                                <div class="inner">
                                    <h3>New User</h3>
                                    <p>&nbsp;</p>
                                </div>
                                <div class="icon">
                                    <i class="ion ion-person-add"></i>
                                </div>
                                <a href="<%=Page.ResolveUrl("~/NewUser")%>" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                        <!-- ./col -->
                        <div class="col-lg-3 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-green">
                                <div class="inner">
                                    <h3>View Users</h3>
                                    <p>&nbsp;</p>
                                </div>
                                <div class="icon">
                                    <i class="ion ion-ios-people"></i>
                                </div>
                                <a href="<%=Page.ResolveUrl("~/UserReports")%>" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                        <!-- ./col -->
                    </div>
                </div>
            </div>
        </asp:Panel>
        <%}
            else if (Vatas_Common.BLFunction.GetRoleName().ToLower() == "potentialuser")
            { %>
        <!-- /.box -->
        <asp:Panel ID="pnlUser" runat="server">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">Reports</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-1">Show entries </div>
                        <div class="col-md-1">
                            <asp:DropDownList ID="ddlPageLength" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlPageLength_SelectedIndexChanged">
                                <asp:ListItem Value="10" Selected="True">10</asp:ListItem>
                                <asp:ListItem Value="20">20</asp:ListItem>
                                <asp:ListItem Value="30">30</asp:ListItem>
                                <asp:ListItem Value="50">50</asp:ListItem>
                                <asp:ListItem Value="-1">ALL</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <table id="processTable" class="table table-bordered table-striped dataTable table-responsive overflow">
                        <thead>
                            <tr style="width: 100%!important">
                                <th>Document Id</th>
                                <th>Title</th>
                                <th>Notes</th>
                                <th>Dated</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptProcess" runat="server">
                                <ItemTemplate>
                                    <tr style="width: 100%!important">
                                        <td>
                                            <asp:HiddenField ID="hfUserId" runat="server" Value='<%# Eval("UserId") %>' />
                                            <asp:Label ID="lblDocumentId" Text='<%# Eval("DocumentId") %>' runat="server" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblDocumentTitle" Text='<%# Eval("DocumentTitle") %>' runat="server" /></td>
                                        <td>
                                            <asp:Label ID="lblDocumentNotes" Text='<%# Eval("DocumentNotes") %>' runat="server" /></td>
                                        <td>
                                            <asp:Label ID="lblDateAdded" Text='<%# Eval("DateAdded") %>' runat="server" /></td>
                                        <td><asp:Label ID="lblProcessed" Text='<%# ((Eval("IsProcessed")+"").ToLower() == "true" ? "Processing":"Pending")%>' ForeColor='<%# ((Eval("IsProcessed")+"").ToLower() == "true" ? System.Drawing.Color.Green:System.Drawing.Color.Red)%>' runat="server" /></td>

                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
                <div class="box-footer clearfix">
                    <div id="page-selection" class="pull-right" style="margin-top: 10px;"></div>

                </div>
                <!-- /.box-body -->
            </div>
        </asp:Panel>
        <%}
            else if (Vatas_Common.BLFunction.GetRoleName().ToLower() == "superadmin")
            { %>
        <asp:Panel ID="Panel1" runat="server">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">Reports</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        Admin Area
                    </div>
                </div>
                <!-- /.box-body -->
            </div>
        </asp:Panel>
        <%}  else if (Vatas_Common.BLFunction.GetRoleName().ToLower() == "telecaller")
            { %>
        <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">Reports</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body">
                     <div class="row">
                    <div class="col-md-1">Show entries </div>
                    <div class="col-md-1">
                        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control" AutoPostBack="true">
                            <asp:ListItem Value="10" Selected="True">10</asp:ListItem>
                            <asp:ListItem Value="20">20</asp:ListItem>
                            <asp:ListItem Value="30">30</asp:ListItem>
                            <asp:ListItem Value="50">50</asp:ListItem>
                            <asp:ListItem Value="-1">ALL</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <table id="processTable" class="table table-bordered table-striped dataTable table-responsive overflow">
                    <thead>
                        <tr style="width: 100%!important">
                            <th>Name</th>
                            <th>Email</th>
                            <th>Contact</th>
                            <th>Document Id</th>
                            <th>Title</th>
                            <th>Notes</th>
                            <th>Dated</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="Repeater1" runat="server">
                            <ItemTemplate>
                                <tr style="width: 100%!important">
                                    <td><asp:HiddenField ID="hfUserId" runat="server" Value='<%# Eval("UserId") %>' />
                                        <asp:Label ID="lblDocumentId" Text='<%# Eval("DocumentId") %>' runat="server" />
                                    </td>
                                    <td><asp:Label ID="lblDocumentTitle" Text='<%# Eval("DocumentTitle") %>' runat="server" /></td>
                                    <td><asp:Label ID="lblDocumentNotes" Text='<%# Eval("DocumentNotes") %>' runat="server" /></td>
                                    <td><asp:Label ID="lblDateAdded" Text='<%# Eval("DateAdded") %>' runat="server" /></td>
                                    <td><asp:Label ID="lblProcessed" Text='<%# Eval("IsProcessed") %>' runat="server" /></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
                </div>
                <!-- /.box-body -->
            </div>
        </asp:Panel>
        <%} %>
        <div class="overlay">
            <i class="fa fa-refresh fa-spin"></i>
        </div>
    </section>
    <asp:HiddenField runat="server" ID="hidPages" />
    <asp:HiddenField runat="server" ID="hidPageNo" Value="1" />
    <!-- /.content -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceFooter" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#lihome').addClass('active');
            $("#page-selection").bootpag({
                next: 'Next',
                prev: 'Prev',
                total: <%=hidPages.Value == ""? "0" : hidPages.Value %>,
                page: <%=hidPageNo.Value %>,
                maxVisible: 5
            }).on("page", function (event, num) {
                $('[id$=hidPageNo]').val(num);
                $('[id$=btnSearch]').click();
            });
        });
    </script>
</asp:Content>
