<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="Process_UploadReturns.aspx.cs" Inherits="Vatas_UI.Process.Process_UploadReturns" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>Uploaded Returns</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>Process</a></li>
            <li><a href="javascript:;">Uploaded Returns</a></li>
        </ol>
    </section>
    <section class="content">
        <!-- Default box -->
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">Assign Verified Returns To Operator</h3>
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
                                                <td>
                                                    <asp:Label ID="lblSrno" Text='<%# Container.ItemIndex + 1 %>' runat="server" /></td>
                                                <td>
                                                    <asp:HiddenField ID="hfSelectedUserID" runat="server" Value='<%# Eval("NextUserID") %>' />
                                                    <asp:DropDownList ID="ddlOperator" runat="server" CssClass="form-control" DataSource='<%# Eval("SupervisorList") %>' DataTextField="DataText" DataValueField="DataValue"></asp:DropDownList></td>
                                                <td>
                                                    <asp:HiddenField ID="hfId" runat="server" Value='<%# Eval("JobID") %>' />
                                                    <asp:Label ID="lblJobNo" Text='<%# Eval("JobNo") %>' runat="server" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblTAN" Text='<%# Eval("TAN") %>' runat="server" /></td>
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
                                                <td>
                                                    <asp:Label ID="lblOperatorComments" Text='<%# Eval("ReasonforReturn") %>' runat="server" /></td>
                                                <td>
                                                    <asp:Label ID="lblSuperVisorName" Text='<%# Eval("SupervisorName") %>' runat="server" /></td>
                                                <td>
                                                    <asp:TextBox ID="txtSupervisorComments" CssClass="form-control" TextMode="MultiLine" Style="resize: none; overflow-wrap: break-word; overflow-y: auto;" Rows="4" Columns="40" runat="server"></asp:TextBox></td>
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
                <asp:Button ID="btnExport" runat="server" Text="Export To Excel" CssClass="btn btn-info pull-right" OnClick="btnExport_Click" />
                <asp:LinkButton Visible="true" ValidationGroup="Grid" Text="" CausesValidation="true" ID="btnConfirm" OnClick="btnConfirm_Click" Style="margin-right: 10px;" runat="server" CssClass="btn btn-info pull-right submit"><i class="fa fa-check"></i>&nbsp;Process</asp:LinkButton>
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
            $('#liProcess8').addClass('active');

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
