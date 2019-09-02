<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="ViewUsers.aspx.cs" Inherits="Vatas_UI.Associate.ViewUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        span > i {
            cursor: pointer;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>View Users</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>Home</a></li>
            <li><a href="javascript:;">View User</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">Users Listings</h3>
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
                            <th>Sr.No</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Contact</th>
                            <th>Date Added</th>
                            <th>Last Modified</th>
                            <th>View Details</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptProcess" runat="server">
                            <ItemTemplate>
                                <tr style="width: 100%!important">
                                    <td><%# Container.ItemIndex + 1  %></td>
                                    <td><asp:Label ID="lblUserName" Text='<%# Eval("UserName") %>' runat="server" /></td>
                                    <td><asp:Label ID="lblEmail" Text='<%# Eval("EmailId") %>' runat="server" /></td>
                                    <td><asp:Label ID="lblContact" Text='<%# Eval("Contact") %>' runat="server" /></td>
                                    <td><asp:Label ID="lblDateAdded" Text='<%# Eval("DateAdded") %>' runat="server" /></td>
                                    <td><asp:Label ID="lblDateModified" Text='<%# Eval("DateModified") %>' runat="server" /></td>
                                    <td><asp:HyperLink ID="hlViewDetails" Target="_blank" runat="server" NavigateUrl='<%# Page.ResolveUrl("~/Customers/") + Eval("AssociateUserId") %>'><span title="Click to view details"><i class="fa fa-eye fa-2x"></i></span></asp:HyperLink> </td>
                                    <%--<td><asp:Label ID="lblProcessed" Text='<%# ((Eval("IsProcessed")+"").ToLower() == "true" ? "Processing":"Pending")%>' ForeColor='<%# ((Eval("IsProcessed")+"").ToLower() == "true" ? System.Drawing.Color.Green:System.Drawing.Color.Red)%>' runat="server" /></td> --%>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
            <div class="box-footer clearfix">
                <div id="page-selection" class="pull-right" style="margin-top: 10px;"></div>
            </div>
        </div>
        <!-- /.box -->
        <div class="overlay">
            <i class="fa fa-refresh fa-spin"></i>
        </div>
    </section>
    <asp:HiddenField runat="server" ID="hidPages" />
    <asp:HiddenField runat="server" ID="hidPageNo" Value="1" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceFooter" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
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

            $('span > i').hover(
                function () { $(this).addClass('text-green') },
                function () { $(this).removeClass('text-green') }
            );
        });
        
    </script>
</asp:Content>
