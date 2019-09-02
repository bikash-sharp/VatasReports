<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="UserDetails.aspx.cs" Inherits="Vatas_UI.Associate.UserDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        td.details-control {
            background: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAACjElEQVR4Aa2V30uTURjHnVBUgglCaXVTJJVLMdhQm7+1JEvJiKAggmgSQiKJl0V0E13UVf0HQZmBLcvlpqa55tqV0YoMzIhY6js0yDH11X17vuO8Sq5Zgl/48DznPD/G63nOMSmBkoUNwhYhTUgn9NUeY8z5p0wqOVXYKRwQLMJhhYV7Kpaqck2rNdskbBPMdrv9osfjcQaDwW/RaHSR0OceY8xhrqox/a3ZZmGHkO9wOB7ouj6PBGKMOcxlzcqmdDYKGZmZmSWjo6PvIYosRuDWXGj50IwTb4+hxleN5sAVvJh4jvBCGBRzWSO121UPk3EAaUKuz+d7ycTp+Wnc/nwL1d4qHBVidmjZv/npBkJzGiiv19vFWmGrcVDsvKupqeky/056VMf1j9dQOViBKo9Aa/ixdbnYcrQGWsBc1jQ2NtrZQ/VKShHM8kvdEPVN9qJsoBRl/aUoHyiJ+UpcCxJTtmfCDYoHJT2yYyOlPtcaCoUmGGwdbkVRbxGK+2y0gg2GisUvNmJCy/BVUJqm/eBIxXqpgbUtiBise12HQlc+ClwFSKRCiZH6wXpQs7OzETWn6XENa/trYemywuK0IpGsTotgRU3fcVBzouWG6pOnpqY0BhuGGpDXeUjIW7JKcfuX3tjjP9k4FBkZN4PtY+042JGzzNMcGDJ35C7tmcU++tJmjE63OpSUuLEJ62GcfXUO+59kr8rJnlOY0WfAGtYaY/PHYPv9fhdEY7++4nz/BWS17UPWY0Es2avWp3vOYOTnCCheBtaqHskJr95kZBL3AvdR2XkEex5mYbdQ+qwCd97dRTAcXHn1Moyrt16PA2tN//V8jY+Pf4cS/VWerzU9sDay1gd2Xf4F/AZqlpeB9836LwAAAABJRU5ErkJggg==') no-repeat center center;
            cursor: pointer;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>View Users</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>Home</a></li>
            <li><a href="javascript:;">User Detail</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">User Detail</h3>
                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                        <i class="fa fa-minus"></i>
                    </button>
                </div>
            </div>
            <div class="form-horizontal">
                <div class="box-body">
                    <div class="form-group">
                        <label for="txtFirstName" class="col-sm-1 control-label">First Name</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtFirstName" runat="server" MaxLength="50" class="form-control" placeholder="First Name" />
                            <asp:RequiredFieldValidator ID="rfvFirstName" ControlToValidate="txtFirstName" runat="server" ErrorMessage="<span class='glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="UpdateUser" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <label for="txtLast" class="col-sm-1 control-label">Last Name</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtLastName" runat="server" MaxLength="15" class="form-control" placeholder="Last Name" />
                        </div>
                        <label for="txtContact" class="col-sm-1 control-label">Contact</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtMobileNumber" runat="server" MaxLength="10" class="form-control" placeholder="Mobile Number" />
                            <asp:RegularExpressionValidator runat="server" ID="revMobileNumber" ErrorMessage="<span class='glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ControlToValidate="txtMobileNumber" ValidationGroup="UpdateUser" SetFocusOnError="true" Display="Dynamic" ValidationExpression="[0-9]{10}"></asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="rfvMobileNumber" ControlToValidate="txtMobileNumber" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="UpdateUser" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtEmail" class="col-sm-1 control-label">Email Id</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtEmail" runat="server" class="form-control" MaxLength="30" placeholder="Email" />
                            <asp:RegularExpressionValidator ID="revEmail" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtEmail" runat="server" ErrorMessage="<span class='glyphicon glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="UpdateUser" SetFocusOnError="true" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                </div>
                <div class="box-footer clearfix">
                    <a class="btn btn-default" href='<%= Page.ResolveUrl("~/Customers/") %>' title="Cancel">Cancel</a>
                    <asp:Button ID="btnSubmit" CssClass="btn btn-info submit" runat="server" Style="margin-right: 10px;" Text="Update" OnClick="btnSubmit_Click" ValidationGroup="UpdateUser" />
                </div>
            </div>
        </div>
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">User Documents</h3>
                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                        <i class="fa fa-minus"></i>
                    </button>
                </div>
            </div>
            <asp:Panel ID="pnl" runat="server" DefaultButton="btnSearch">
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-3">
                            <asp:Button ID="btnUploadDocument" Text="Upload Document" OnClick="btnUploadDocument_Click" CssClass="btn btn-info submit" runat="server" />
                        </div>
                        <div class="col-md-5"></div>
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
                        <div class="col-md-2">
                            <asp:TextBox ID="txtSearch" CssClass="form-control" Style="float: right;" placeholder="Search.." runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <table id="userTable" class="table table-bordered table-striped dataTable table-responsive overflow">
                        <thead>
                            <tr>
                                <th></th>
                                <th>Sr.No</th>
                                <th>Name of Job</th>
                                <th>Date Added</th>
                                <th>Date Modified</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                           <asp:Repeater ID="rptProcess" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td class="details-control"></td>
                                        <td><%# Container.ItemIndex + 1  %></td>
                                        <td><asp:Label ID="lblServiceName" Text='<%# Eval("ServiceName") %>' runat="server" /></td>
                                        <td><asp:Label ID="lblDateAdded" Text='<%# Eval("DateAdded") %>' runat="server" /></td>
                                        <td><asp:Label ID="lblDateModified" Text='<%# Eval("ModifiedDate") %>' runat="server" /></td>
                                        <td><asp:Label ID="lblDocumentStatus" Text='<%# Eval("DocumentStatusName")%>' ForeColor='<%# ((Eval("DocumentStatusName")+"").ToLower() == "received" ? System.Drawing.Color.Green:System.Drawing.Color.Red)%>' runat="server" /></td>
                                    </tr>
                                    <tr class="hide">
                                        <td colspan="6">
                                            <table class="table table-bordered table-striped table-responsive overflow">
                                                <thead>
                                                    <tr>
                                                        <th>Sr.No</th>
                                                        <th>FileName</th>
                                                        <th>Date Uploaded</th>
                                                        <th>Verified</th>
                                                        <th>Date Verified</th>
                                                        <th>Download</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:Repeater ID="rptFiles" runat="server" DataSource='<%# Eval("userDocumentDetails") %>'>
                                                        <ItemTemplate>
                                                            <td><%# Container.ItemIndex + 1  %></td>

                                                            <td><asp:Label ID="lblFileName" Text='<%# Eval("DisplayAs") %>' runat="server" /></td>
                                                            <td><asp:Label ID="lblFileUploadDate" Text='<%# Eval("DateAdded") %>' runat="server" /></td>
                                                            <td><asp:Label ID="lblIsVerified" Text='<%# Eval("IsValid").ToString().ToLower() == "true" ? "Verified":"Pending" %>' ForeColor='<%# Eval("IsValid").ToString().ToLower() == "true" ? System.Drawing.Color.Green:System.Drawing.Color.Red %>' runat="server" /></td>
                                                            <td><asp:Label ID="lblFileStatusModifiedDate" Font-Bold="true" Text='<%# Eval("DateModified") %>' runat="server" /></td>
                                                            <td><asp:HyperLink ID="hlDownload" Target="_blank" runat="server" NavigateUrl='<%# this.CurrentPagePath + "WebHandler/FileDownload.ashx?Id=" + BLSecurity.Encrypt(Eval("Id").ToString()) %>'><span title="Click to download"><i class="fa fa-download fa-2x"></i></span></asp:HyperLink></td>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
                <div class="box-footer clearfix">
                    <div id="page-selection" class="pull-right" style="margin-top: 10px;"></div>
                </div>
            </asp:Panel>
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
            $('.details-control').on('click', function () {
                var tr = $(this).parent('tr').next('tr');
                if (tr.hasClass('hide'))
                    tr.removeClass('hide');
                else
                    tr.addClass('hide');
            });
        });

    </script>
</asp:Content>
