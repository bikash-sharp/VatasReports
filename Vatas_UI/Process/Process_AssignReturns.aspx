<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="Process_AssignReturns.aspx.cs" Inherits="Vatas_UI.Process.Process_AssignReturns" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table-bar {
            margin-bottom: 0 !important;
        }

            .table-bar > tbody > tr > td {
                vertical-align: auto !important;
            }

        #page-selection .pagination {
            margin: 0px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>Assign Returns to Operator</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>Process</a></li>
            <li><a href="javascript:;">Assign Returns</a></li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <!-- Default box -->
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">Assign Verified Returns To Operator</h3>
            </div>
            <div class="box-body">
                <asp:Panel ID="pnl" runat="server" DefaultButton="btnSearch">
                    <div class="form-inline overflow">
                        <div class="row">
                            <div class="col-sm-12">
                                <table class="table table-responsive table-bar">
                                    <tr>
                                        <td colspan="9">
                                            <asp:DropDownList ID="ddlPageLength" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlPageLength_SelectedIndexChanged">
                                                <asp:ListItem Value="10" Selected="True">10</asp:ListItem>
                                                <asp:ListItem Value="20">20</asp:ListItem>
                                                <asp:ListItem Value="30">30</asp:ListItem>
                                                <asp:ListItem Value="50">50</asp:ListItem>
                                            </asp:DropDownList>

                                            <div id="page-selection" class="pull-right"></div>
                                        </td>
                                        <asp:TextBox ID="txtSearch" CssClass="form-control hide" placeholder="Search.." runat="server"></asp:TextBox>
                                        
                                    </tr>
                                </table>
                                <table id="processTable" class="table table-bordered table-striped dataTable" style="width:100%!important;">
                                    <thead>
                                        <tr style="width:100%!important">
                                            <th style="width:5%!important">
                                                <div class="checkbox icheck">
                                                    <asp:CheckBox ID="chkHeader" CssClass="chkheader" runat="server" />
                                                </div>
                                            </th>
                                            <th style="width:5%!important">Job No<br /><asp:TextBox ID="txtJobNo" CssClass="form-control search" placeholder="Job No" runat="server"></asp:TextBox></th>
                                            <th style="width:15%!important">Data Entry Operator<br /><asp:TextBox ID="txtOperator" CssClass="form-control search" placeholder="Operator" runat="server"></asp:TextBox></th>
                                            <th style="width:10%!important">TAN<br /><asp:TextBox ID="txtTAN" CssClass="form-control search" placeholder="TAN" runat="server"></asp:TextBox></th>
                                            <th style="width:45%!important">Account Name<br /><asp:TextBox ID="txtAccount" CssClass="form-control search" placeholder="Account Name" runat="server"></asp:TextBox></th>
                                            <th style="width:5%!important">Financial Year(FY)<br /><asp:TextBox ID="txtFY" CssClass="form-control search" placeholder="FY" runat="server"></asp:TextBox></th>
                                            <th style="width:5%!important">Form Type<br /><asp:TextBox ID="txtFormType" CssClass="form-control search" placeholder="Form Type" runat="server"></asp:TextBox></th>
                                            <th style="width:5%!important">Quarter<br /><asp:TextBox ID="txtQuarter" CssClass="form-control search" placeholder="Quarter" runat="server"></asp:TextBox></th>
                                            <th style="width:5%!important">Return Type<br /><asp:TextBox ID="txtReturnType" CssClass="form-control search" placeholder="Return Type" runat="server"></asp:TextBox></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rptProcess" runat="server">
                                            <ItemTemplate>
                                                <tr style="width:100%!important">
                                                    <td style="width:5%!important">
                                                        <div class="checkbox icheck">
                                                            <asp:CheckBox ID="chkRow" CssClass="chkrow" runat="server" />
                                                        </div>
                                                    </td>
                                                    <td style="width:5%!important">
                                                        <asp:HiddenField ID="hfId" runat="server" Value='<%# Eval("JobID") %>' />
                                                        <asp:Label ID="lblJobNo" Text='<%# Eval("JobNo") %>' runat="server" />
                                                    </td>
                                                    <%--<td>
                                                    <asp:Label ID="lblSrno" Text='<%# Container.ItemIndex + 1 %>' runat="server" /></td>
                                                </td>--%>

                                                    <td style="width:15%!important">
                                                        <asp:DropDownList ID="ddlOperator" runat="server" CssClass="form-control" DataSource='<%# Eval("SupervisorList") %>' DataTextField="DataText" DataValueField="DataValue"></asp:DropDownList></td>

                                                    <td style="width:10%!important">
                                                        <asp:Label ID="lblTAN" Text='<%# Eval("TAN") %>' runat="server" /></td>
                                                    <td style="width:45%!important">
                                                        <asp:Label ID="lblAccountName" Text='<%# Eval("AccountName") %>' runat="server" /></td>
                                                    <td style="width:5%!important">
                                                        <asp:Label ID="lblFinancialYear" Text='<%# Eval("FinancialYear") %>' runat="server" /></td>
                                                    <td style="width:5%!important">
                                                        <asp:Label ID="lblFormNumber" Text='<%# Eval("FormNumber") %>' runat="server" /></td>
                                                    <td style="width:5%!important">
                                                        <asp:Label ID="lblQuarter" Text='<%# Eval("Quarter") %>' runat="server" /></td>
                                                    <td style="width:5%!important">
                                                        <asp:Label ID="lblReturnType" Text='<%# Eval("ReturnType") %>' runat="server" /></td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
            </div>
            <!-- /.box-body -->
            <div class="box-footer">
                <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Please select at least one record."
                    ClientValidationFunction="ValidateCheckboxes" ForeColor="Red" Display="None" ValidationGroup="Grid"></asp:CustomValidator>

                <% if (this.rptProcess.Items.Count > 0)
                    { %>
                <asp:Button ID="btnExport" UseSubmitBehavior="true" runat="server" Text="Export To Excel" CssClass="btn btn-info pull-right" OnClick="btnExport_Click" />
                <asp:LinkButton Visible="true" ValidationGroup="Grid" Text="" CausesValidation="true" ID="btnConfirm" Style="margin-right: 10px;" OnClick="btnConfirm_Click" runat="server" CssClass="btn btn-info pull-right submit"><i class="fa fa-check"></i>&nbsp;Process</asp:LinkButton>
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
            $('#liProcess').addClass('active');
            $('#liProcess3').addClass('active');

            $("#page-selection").bootpag({
                next: 'Next',
                prev: 'Prev',
                total: <%=hidPages.Value == ""? "0" : hidPages.Value %>,
                page: <%=hidPageNo.Value %>,
                maxVisible: 5
            }).on("page", function(event,num){
                $('[id$=hidPageNo]').val(num);
                $('[id$=btnSearch]').click();
            });

            $('[id$=txtSearch]').on('keydown',function(e){
                if(e.keyCode == 13)
                {
                    $('[id$=btnSearch]').click();
                }
            });

            $("#processTable [id*=chkHeader]").on("click", headerclick);
            $("#processTable [id*=chkRow]").on("click", rowclick);
        });
    </script>
</asp:Content>
