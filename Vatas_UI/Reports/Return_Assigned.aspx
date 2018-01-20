<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="Return_Assigned.aspx.cs" Inherits="Vatas_UI.Reports.Return_Assigned" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .pagination > li > a {
            background: #fff;
        }

        .pagination {
            margin: 0;
        }

        .dataTables_info {
            display: none !important;
        }

        .dataTables_paginate {
            display: none !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>Return Assigned</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>Reports</a></li>
            <li><a href="javascript:;">Return Assigned</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">Return Assigned</h3>
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
                                        <th>Assigned Date</th>
                                        <th>Operator Name</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptReport" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <%# Container.ItemIndex + 1 %>
                                                </td>
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
                            <div class="">
                                <ul id="pagination-demo" class="pagination-lg pull-right">
                                    <asp:Repeater ID="rptPager" runat="server">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkPage" CssClass='<%# string.Format("lnkPage_{0}", Eval("Text")) %>' runat="server" Text='<%#Eval("Text") %>' CommandArgument='<%# Eval("Value") %>'
                                                OnClick="Page_Changed"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-5">
                            <div id="content"></div>
                        </div>
                        <div class="col-sm-7">
                            <div id="pagination-here" style="float: right"></div>
                        </div>
                        <asp:HiddenField ID="hdnPages" Value="0" runat="server" />
                        <asp:HiddenField ID="hdnPageSize" Value="0" runat="server" />
                        <asp:HiddenField ID="hdnPageNumber" Value="0" runat="server" />
                        <asp:HiddenField ID="hdnRecordCount" Value="0" runat="server" />
                    </div>
                </div>
            </div>
            <div class="box-footer">
                <% if (this.rptReport.Items.Count > 0)
                    { %>
                <asp:Button ID="btnExport" runat="server" Text="Export To Excel" CssClass="btn btn-info pull-right btn-lg submit" OnClick="btnExport_Click" />
                <%     
                    } %>
            </div>
        </div>
        <div class="overlay">
            <i class="fa fa-refresh fa-spin"></i>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceFooter" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#liReport').addClass('active');
            $('#liReport2').addClass('active');
        });
    </script>

    <script>
        $(document).ready(function () {
            var Pages = parseInt($('input[id^=hdnPages]').val());
            var PageSize = parseInt($('input[id^=hdnPageNumber]').val());
            var PageNumber = parseInt($('input[id^=hdnPageSize]').val());
            var RecordCount = parseInt($('input[id^=hdnRecordCount]').val());

            $('#pagination-here').bootpag({
                total: Pages,
                page: 1,
                maxVisible: 5,
                next: 'Next',
                prev: 'Previous'
            })

            if (RecordCount > 0)
                $("#content").html("Showing " + (0) + " to " + ((1 * 10) < RecordCount ? 1 * 10 : RecordCount) + " of " + RecordCount + " entries");

            $('#pagination-here').on("page", function (event, num) {
                var RecordLengthPerPage = $('select[name=example1_length] :selected').text();
                debugger;
                var href = $('a[data-page=lnkPage_' + num + ']')[0].href;
                href = href.replace('javascript:', '');
                href.click();
                $("#content").html("Showing " + (((num - 1) * 10) + 1) + " to " + ((num * 10) < RecordCount ? num * 10 : RecordCount) + " of " + RecordCount + " entries");
            });
        });
    </script>
</asp:Content>
