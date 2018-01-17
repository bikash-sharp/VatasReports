<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="Process_CompletedReturns.aspx.cs" Inherits="Vatas_UI.Process.Process_CompletedReturns" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>Completed Returns</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>Process</a></li>
            <li><a href="javascript:;">Completed Returns</a></li>
        </ol>
    </section>
    <section class="content">
        <!-- Default box -->
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">Assign Verified Returns To Operator</h3>
            </div>
            <div class="box-body">

                <div class="form-inline overflow">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="processTable" class="table table-bordered table-striped dataTable">
                                <thead>
                                    <tr>
                                        <th>
                                            <div class="checkbox icheck">
                                                <asp:CheckBox ID="chkHeader" CssClass="chkheader" runat="server" />
                                            </div>
                                        </th>
                                        <th>SNo</th>
                                        <th>Data Entry Operator</th>
                                        <th>Job No</th>
                                        <th>TAN</th>
                                        <th>Account Name</th>
                                        <th>Financial Year(FY)</th>
                                        <th>Form Type</th>
                                        <th>Quarter</th>
                                        <th>Return Type</th>
                                        <th>Operator Comments</th>
                                        <th>SuperVisor Name</th>
                                        <th>SuperVisor Comments</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptProcess" runat="server" OnItemDataBound="rptProcess_ItemDataBound">
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <div class="checkbox icheck">
                                                        <asp:CheckBox ID="chkRow" CssClass="chkrow" runat="server" />
                                                    </div>
                                                </td>
                                               <td><asp:Label ID="lblSrno" Text='<%# Container.ItemIndex + 1 %>' runat="server" /></td></td>
                                                <td><asp:HiddenField ID="hfSelectedUserID" runat="server" Value='<%# Eval("NextUserID") %>' />
                                                    <asp:DropDownList ID="ddlOperator" runat="server" CssClass="form-control" DataSource='<%# Eval("SupervisorList") %>' DataTextField="DataText" DataValueField="DataValue" ></asp:DropDownList></td>
                                                <td><asp:HiddenField ID="hfId" runat="server" Value='<%# Eval("JobID") %>' />
                                                    <asp:Label ID="lblJobNo" Text='<%# Eval("JobNo") %>' runat="server" />
                                                </td>
                                                <td><asp:Label ID="lblTAN" Text='<%# Eval("TAN") %>' runat="server" /></td>
                                                <td><asp:Label ID="lblAccountName" Text='<%# Eval("AccountName") %>' runat="server" /></td>
                                                <td><asp:Label ID="lblFinancialYear" Text='<%# Eval("FinancialYear") %>' runat="server" /></td>
                                                <td><asp:Label ID="lblFormNumber" Text='<%# Eval("FormNumber") %>' runat="server" /></td>
                                                <td><asp:Label ID="lblQuarter" Text='<%# Eval("Quarter") %>' runat="server" /></td>
                                                <td><asp:Label ID="lblReturnType" Text='<%# Eval("ReturnType") %>' runat="server" /></td>
                                                <td><asp:Label ID="lblOperatorComments" Text='<%# Eval("ReasonforReturn") %>' runat="server" /></td>
                                                <td><asp:Label ID="lblSuperVisorName" Text='<%# Eval("SupervisorName") %>' runat="server" /></td>
                                                <td><asp:TextBox ID="txtSupervisorComments" CssClass="form-control" TextMode="MultiLine" Style="resize: none; overflow-wrap: break-word; overflow-y: auto;" Rows="4" Columns="40" runat="server"></asp:TextBox></td>
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
                <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Please select at least one record."
                    ClientValidationFunction="ValidateCheckboxes" ForeColor="Red" Display="None" ValidationGroup="Grid"></asp:CustomValidator>

                <% if (this.rptProcess.Items.Count > 0)
                    { %>
                <asp:Button ID="btnExport" runat="server" Text="Export To Excel" CssClass="btn btn-info pull-right submit" OnClick="btnExport_Click" />
                <asp:LinkButton Visible="true" ValidationGroup="Grid" Text="" CausesValidation="true" Style="margin-right: 10px;" ID="btnConfirm" OnClick="btnConfirm_Click" runat="server" CssClass="btn btn-info pull-right submit"><i class="fa fa-check"></i>&nbsp;Process</asp:LinkButton>
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceFooter" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#liProcess').addClass('active');
            $('#liProcess6').addClass('active');

            $("#processTable [id*=chkHeader]").on("click", headerclick);

            $("#processTable [id*=chkRow]").on("click", rowclick);
        });
    </script>
</asp:Content>
