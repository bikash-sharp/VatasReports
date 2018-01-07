<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="Search_Jobs_Between_Dates.aspx.cs" Inherits="Vatas_UI.Reports.Search_Jobs_Between_Dates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>Search Jobs Between Two Dates</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>Reports</a></li>
            <li><a href="javascript:;">Search Jobs Between Two Dates</a></li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <!-- Default box -->
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">Search Jobs Between Two Dates</h3>
            </div>
            <div class="box-header">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="col-md-4 col-sm-3 col-xs-3 control-label" style="text-align: right;">Date range:</label>
                            <div class="col-md-4 col-sm-6 col-xs-6" style="padding: 0">
                                <div class="input-group jobSearch-DateRange">
                                    <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                    <asp:TextBox ID="txtDateRange" class="form-control pull-left txtDateRange" runat="server" />
                                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" ControlToValidate="txtDateRange" EnableClientScript="true" ValidationGroup="DateRange" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-3 col-xs-3">
                                <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" UseSubmitBehavior="true" class="btn btn-info" Text="Search" ValidationGroup="DateRange"></asp:Button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="box-body">
                <div class="form-inline">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="example1" class="table table-bordered table-striped dataTable">
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
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.box-body -->
            <div class="box-footer">
                <% if (this.rptReport.Items.Count > 0)
                    { %>
                <asp:Button ID="btnExport" runat="server" UseSubmitBehavior="true" Text="Export To Excel" CssClass="btn btn-info pull-right btn-lg submit" OnClick="btnExport_Click" />
                <%     
                    } %>
            </div>
            <!-- /.box-footer-->
        </div>
        <!-- /.box -->
        <%-- <div class="overlay">
            <i class="fa fa-refresh fa-spin"></i>
        </div>--%>
    </section>
    <!-- /.content -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceFooter" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#liReport').addClass('active');
            $('#liReport7').addClass('active');
            $('.jobSearch-DateRange').daterangepicker({
                autoUpdateInput: true,
                locale: {
                    cancelLabel: 'Clear',
                    format: 'DD-MM-YYYY'
                }
            });
            $('.jobSearch-DateRange').on('apply.daterangepicker', function (ev, picker) {
                $('.txtDateRange').val(picker.startDate.format('DD-MM-YYYY') + " - " + picker.endDate.format('DD-MM-YYYY'));
            });

            $('.jobSearch-DateRange').on('cancel.daterangepicker', function (ev, picker) {
                $('.txtDateRange').val('');
            });
        });
    </script>
</asp:Content>
