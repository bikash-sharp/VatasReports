<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="Return_Uploaded.aspx.cs" Inherits="Vatas_UI.Reports.Return_Uploaded" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>Return Uploaded</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>Reports</a></li>
            <li><a href="javascript:;">Return Uploaded</a></li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <!-- Default box -->
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">Return Uploaded</h3>
            </div>
            <div class="box-body">
                <div class="form-inline">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-10">
                                    Show entries 
                                        <asp:DropDownList ID="ddlPageLength" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlPageLength_SelectedIndexChanged">
                                            <asp:ListItem Value="10" Selected="True">10</asp:ListItem>
                                            <asp:ListItem Value="20">20</asp:ListItem>
                                            <asp:ListItem Value="30">30</asp:ListItem>
                                            <asp:ListItem Value="50">50</asp:ListItem>
                                            <asp:ListItem Value="-1">ALL</asp:ListItem>
                                        </asp:DropDownList>
                                </div>
                                <div class="col-sm-2">
                                    <asp:TextBox ID="txtSearch" CssClass="form-control" Style="float: right;" placeholder="Search.." runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-inline overflow">
                                <table id="reportTable" class="table table-bordered table-striped dataTable">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Firm Name</th>
                                            <th>File No.</th>
                                            <th>TAN</th>
                                            <th>Account Name</th>
                                            <th>Financial Year(FY)</th>
                                            <th>Form Type</th>
                                            <th>Quarter</th>
                                            <th>Return Type</th>
                                            <th>Date</th>
                                            <th>Assigned Date</th>
                                            <th>Operator Name</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rptReport" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td><%# Container.ItemIndex + 1 %></td>
                                                    <td><%# Eval("FirmName") %></td>
                                                    <td><%# Eval("JobNo") %></td>
                                                    <td><%# Eval("TAN") %></td>
                                                    <td><%# Eval("AccountName") %></td>
                                                    <td><%# Eval("FinancialYear") %></td>
                                                    <td><%# Eval("FormType") %></td>
                                                    <td><%# Eval("Quarter") %></td>
                                                    <td><%# Eval("ReturnType") %></td>
                                                    <td><%# Eval("Date") %></td>
                                                    <td><%# Eval("AssignedDate") %></td>
                                                    <td><%# Eval("Username") %></td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div id="page-selection" class="pull-right" style="margin-top: 10px;"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.box-body -->
            <div class="box-footer">
                <% if (this.rptReport.Items.Count > 0)
                    { %>

                <asp:LinkButton ID="lnkExportToPdf" runat="server" CssClass="btn btn-info pull-right" Style="margin-left: 10px;" OnClick="lnkExportToPdf_Click">Export To PDF</asp:LinkButton>
                <asp:LinkButton ID="btnExport" runat="server" CssClass="btn btn-info pull-right" OnClick="btnExport_Click">Export To Excel</asp:LinkButton>
                <%     
                    } %>
            </div>
            <!-- /.box-footer-->
        </div>
        <!-- /.box -->
        <div class="overlay">
            <i class="fa fa-refresh fa-spin"></i>
        </div>
    </section>
    <asp:HiddenField runat="server" ID="hidPages" />
    <asp:HiddenField runat="server" ID="hidPageNo" Value="1" />
    <asp:Button UseSubmitBehavior="true" ID="btnSearch" Text="" CausesValidation="false" OnClick="btnSearch_Click" Style="display: none" CssClass="submit" runat="server" />

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceFooter" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#liReport').addClass('active');
            $('#liReport5').addClass('active');

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

            $('[id$=txtSearch]').on('keydown', function (e) {
                if (e.keyCode == 13) {
                    $('[id$=btnSearch]').click();
                }
            });
        });
    </script>
</asp:Content>
