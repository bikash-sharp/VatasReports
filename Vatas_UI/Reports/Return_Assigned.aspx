﻿<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="Return_Assigned.aspx.cs" Inherits="Vatas_UI.Reports.Return_Assigned" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>Return Assigned</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>Reports</a></li>
            <li><a href="javascript:;">Return Assigned</a></li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <!-- Default box -->
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
                                <tfoot>
                                    <asp:Repeater ID="rptPager" runat="server">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkPage" runat="server" Text='<%#Eval("Text") %>' CommandArgument='<%# Eval("Value") %>'
                                                CssClass='<%# Convert.ToBoolean(Eval("Enabled")) ? "page_enabled" : "page_disabled" %>'
                                                OnClick="Page_Changed" OnClientClick='<%# !Convert.ToBoolean(Eval("Enabled")) ? "return false;" : "" %>'></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tfoot>
                            </table>
                            <ul id="pagination-demo" class="pagination-lg pull-right"></ul>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.box-body -->
            <div class="box-footer">
                <% if (this.rptReport.Items.Count > 0)
                    { %>
                <asp:Button ID="btnExport" runat="server" Text="Export To Excel" CssClass="btn btn-info pull-right btn-lg submit" OnClick="btnExport_Click" />
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
    <!-- /.content -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceFooter" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#liReport').addClass('active');
            $('#liReport2').addClass('active');
        });
    </script>
</asp:Content>
