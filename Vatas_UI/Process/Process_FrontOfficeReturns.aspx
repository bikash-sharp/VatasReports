﻿<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="Process_FrontOfficeReturns.aspx.cs" Inherits="Vatas_UI.Process.Process_FrontOfficeReturns" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>Return Received at Front Office</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>Process</a></li>
            <li><a href="javascript:;">Returns at Front Office</a></li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <!-- Default box -->
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">Return Received at Front Office</h3>
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
                                <table id="processTable" class="table table-bordered table-striped dataTable">
                                    <thead>
                                        <tr>
                                            <th>
                                                <div class="checkbox icheck">
                                                    <asp:CheckBox ID="chkHeader" CssClass="chkheader" runat="server" />
                                                </div>
                                            </th>
                                            <th>Job No</th>
                                            <%--<th>SNo</th>--%>
                                            <th>Name Of Supervisor</th>
                                            <th>Priority</th>
                                            <th>TAN</th>
                                            <th>Account Name</th>
                                            <th>Financial Year(FY)</th>
                                            <th>Form Type</th>
                                            <th>Quarter</th>
                                            <th>Return Type</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rptProcess" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <div class="checkbox icheck">
                                                            <asp:CheckBox ID="chkRow" CssClass="chkrow" runat="server" />
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <asp:HiddenField ID="hfId" runat="server" Value='<%# Eval("JobID") %>' />
                                                        <asp:Label ID="lblJobNo" Text='<%# Eval("JobNo") %>' runat="server" />
                                                    </td>
                                                    <%--<td><asp:Label ID="lblSrno" Text='<%# Container.ItemIndex + 1 %>' runat="server" /></td>--%>
                                                    <td>
                                                        <asp:DropDownList ID="ddlSupervisor" runat="server" CssClass="form-control" DataSource='<%# Eval("SupervisorList") %>' DataTextField="DataText" DataValueField="DataValue"></asp:DropDownList></td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlPriorities" runat="server" CssClass="form-control" DataSource='<%# Eval("PriorityList") %>' DataTextField="DataText" DataValueField="DataValue"></asp:DropDownList></td>

                                                    <td>
                                                        <asp:Label ID="lblTAN" Text='<%# Eval("TAN") %>' runat="server" />
                                                        <td>
                                                            <asp:Label ID="lblAccountName" Text='<%# Eval("AccountName") %>' runat="server" /></td>
                                                        <td>
                                                            <asp:Label ID="lblFinancialYear" Text='<%# Eval("FinancialYear") %>' runat="server" /></td>
                                                        <td>
                                                            <asp:Label ID="lblFormNumber" Text='<%# Eval("FormNumber") %>' runat="server" /></td>
                                                        <td>
                                                            <asp:Label ID="lblQuarter" Text='<%# Eval("Quarter") %>' runat="server" /></td>
                                                        <td>
                                                            <asp:Label ID="lblReturnType" Text='<%# Eval("ReturnType") %>' runat="server" /></td>
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
                <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Please select at least one record."
                    ClientValidationFunction="ValidateCheckboxes" ForeColor="Red" Display="None" ValidationGroup="Grid"></asp:CustomValidator>

                <% if (this.rptProcess.Items.Count > 0)
                    { %>
                <asp:LinkButton ID="lnkExportToPdf" runat="server" CssClass="btn btn-info pull-right" style="margin-left: 10px;" OnClick="lnkExportToPdf_Click">Export To PDF</asp:LinkButton>
                <asp:LinkButton ID="btnExport" runat="server" CssClass="btn btn-info pull-right" OnClick="btnExport_Click">Export To Excel</asp:LinkButton>
                <asp:LinkButton Visible="true" ValidationGroup="Grid" Text="" CausesValidation="true" ID="btnConfirm" OnClick="btnConfirm_Click" runat="server" Style="margin-right: 10px;" CssClass="btn btn-info pull-right submit"><i class="fa fa-check"></i>&nbsp;Process</asp:LinkButton>
                <%     
                    } %>
            </div>
            <!-- /.box-footer-->
        </div>
        <!-- /.box -->
        <div class="overlay">
            <i class="fa fa-refresh fa-spin"></i>
        </div>
        <asp:HiddenField runat="server" ID="hidPages" />
        <asp:HiddenField runat="server" ID="hidPageNo" Value="1" />
        <asp:Button UseSubmitBehavior="true" ID="btnSearch" Text="" CausesValidation="false" OnClick="btnSearch_Click" Style="display: none" CssClass="submit" runat="server" />
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceFooter" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#liProcess').addClass('active');
            $('#liProcess1').addClass('active');

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

            $('[id$=txtSearch]').on('input',function(e){
                $('[id$=hidPageNo]').val('1');
            });

            $('[id$=txtSearch]').on('keydown', function (e) {
                if (e.keyCode == 13) {
                    $('[id$=hidPageNo]').val('1');
                    $('[id$=btnSearch]').click();
                }
            });
        });

        $("#processTable [id*=chkHeader]").on("click", headerclick);
        $("#processTable [id*=chkRow]").on("click", rowclick);

    </script>
</asp:Content>
