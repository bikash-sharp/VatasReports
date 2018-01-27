<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="Process_VerifyReturns.aspx.cs" Inherits="Vatas_UI.Process.Process_VerifyReturns" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>Verify Returns</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>Process</a></li>
            <li><a href="javascript:;">Verify Returns</a></li>
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
                                <div class="table-responsive">
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
                                                <th>Data Entry Operator</th>
                                                <th>TAN</th>
                                                <th>Account Name</th>
                                                <th>Financial Year(FY)</th>
                                                <th>Form Type</th>
                                                <th>Quarter</th>
                                                <th>Return Type</th>
                                                <th>Operator Comments</th>
                                                <th>View Details</th>
                                                <%--<th>SuperVisor Name</th>
                                            <th>SuperVisor Comments</th>--%>
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
                                                            <asp:HiddenField ID="hfMasterId" runat="server" Value='<%# Eval("MasterID") %>' />
                                                            <asp:HiddenField ID="hfId" runat="server" Value='<%# Eval("JobID") %>' />
                                                            <asp:HiddenField ID="hdnSrno" runat="server" Value='<%# Container.ItemIndex + 1 %>' />
                                                            <asp:Label ID="lblJobNo" Text='<%# Eval("JobNo") %>' runat="server" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblOperator" Text='<%# Eval("AssignedUser") %>' runat="server" />
                                                            <asp:HiddenField ID="hfSelectedUserID" runat="server" Value='<%# Eval("NextUserID") %>' />
                                                        </td>
                                                        <%--<asp:DropDownList ID="ddlOperator" runat="server" CssClass="form-control" DataSource='<%# Eval("SupervisorList") %>' DataTextField="DataText" DataValueField="DataValue"></asp:DropDownList></td>--%>

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
                                                        <td><a href="javascript:;" title="View Details" class="btn btn-info view-details" data-tan='<%# Eval("TAN") %>' data-fy='<%# Eval("FinancialYear") %>' data-qtr='<%# Eval("Quarter") %>' data-ret='<%# Eval("ReturnType") %>' data-frm='<%# Eval("FormNumber") %>' data-id='<%# Eval("MasterID") %>'><i class="glyphicon glyphicon-eye-open"></i>&nbsp;View</td>
                                                        <%--<td><asp:Label ID="lblSuperVisorName" Text='<%# Eval("SupervisorName") %>' runat="server" /></td>--%>
                                                        <%--<td><asp:TextBox ID="txtSupervisorComments" CssClass="form-control" TextMode="MultiLine" Style="resize: none; overflow-wrap: break-word; overflow-y: auto;" Rows="4" Columns="40" runat="server"></asp:TextBox></td>--%>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </tbody>
                                    </table>
                                </div>
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
                <asp:LinkButton ID="lnkExportToPdf" runat="server" CssClass="btn btn-info pull-right" Style="margin-left: 10px;" OnClick="lnkExportToPdf_Click">Export To PDF</asp:LinkButton>
                <asp:LinkButton ID="btnExport" runat="server" CssClass="btn btn-info pull-right" OnClick="btnExport_Click">Export To Excel</asp:LinkButton>
                <asp:LinkButton Visible="false" ValidationGroup="Grid" Text="" CausesValidation="true" ID="btnConfirm" OnClick="btnConfirm_Click" Style="margin-right: 10px;" runat="server" CssClass="btn btn-info pull-right submit"><i class="fa fa-check"></i>&nbsp;Process</asp:LinkButton>
                <%     
                    } %>
            </div>
            <!-- /.box-footer-->
        </div>
        <!-- /.box -->
        <div class="overlay">
            <i class="fa fa-refresh fa-spin"></i>
        </div>
        <div class="modal fade" id="DetailModel" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="DetailModelLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Return Details</h4>
                    </div>
                    <div class="modal-body">
                        <asp:HiddenField ID="hdnTAN" runat="server" />
                        <asp:HiddenField ID="hdnQuarter" runat="server" />
                        <asp:HiddenField ID="hdnFY" runat="server" />
                        <asp:HiddenField ID="hdnFormNo" runat="server" />
                        <asp:HiddenField ID="hdnRetType" runat="server" />
                        <asp:HiddenField ID="hdnMasterID" runat="server" />
                        <div class="form-inline overflow">
                            <div class="table-responsive">
                                <table id="tblTaxDetail" class="table table-bordered table-striped dataTable">
                                    <thead>
                                        <tr>
                                            <th>TAX Deducted</th>
                                            <th>TAX Deposited</th>
                                            <th>Amount Paid</th>
                                            <th>Deductee Count</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">Submit</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
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
            $('#liProcess5').addClass('active');

            
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

            $('.view-details').on('click',function(e){
                e.preventDefault();
                var id=$(this).data('id');
                var fy = $(this).data('fy').split('-')[0]+$(this).data('fy').split('-')[1].substr(2,3);
                var tan = $(this).data('tan');
                var qtr=$(this).data('qtr');
                var frmno=$(this).data('frm');
                var rettype=$(this).data('ret')
                
                $.ajax({
                    url: $('[id$=hfServicePath]').val()+"ReportService.asmx/GetReturnDetails",
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    type: "POST",
                    data: {"TAN":tan,"Quarter":qtr,"FY":fy,"FormNo":frmno,"RetType":rettype,"MasterID":id },
                    dataType: "json",
                    success: function (result) {
                        $("#EquipmentModel div.modal-body").html(result);
                        $('#EquipmentModel').modal('show');
                        $.validator.unobtrusive.parse('#EquipmentModel form');
                    }
                });
                $('#DetailModel').modal('show');
            });

            $("#processTable [id*=chkHeader]").on("click", headerclick);
            $("#processTable [id*=chkRow]").on("click", rowclick);
        });
    </script>
</asp:Content>
