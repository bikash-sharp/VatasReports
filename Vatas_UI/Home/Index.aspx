<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Vatas_UI.Home.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        td.details-control {
            background: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAACjElEQVR4Aa2V30uTURjHnVBUgglCaXVTJJVLMdhQm7+1JEvJiKAggmgSQiKJl0V0E13UVf0HQZmBLcvlpqa55tqV0YoMzIhY6js0yDH11X17vuO8Sq5Zgl/48DznPD/G63nOMSmBkoUNwhYhTUgn9NUeY8z5p0wqOVXYKRwQLMJhhYV7Kpaqck2rNdskbBPMdrv9osfjcQaDwW/RaHSR0OceY8xhrqox/a3ZZmGHkO9wOB7ouj6PBGKMOcxlzcqmdDYKGZmZmSWjo6PvIYosRuDWXGj50IwTb4+hxleN5sAVvJh4jvBCGBRzWSO121UPk3EAaUKuz+d7ycTp+Wnc/nwL1d4qHBVidmjZv/npBkJzGiiv19vFWmGrcVDsvKupqeky/056VMf1j9dQOViBKo9Aa/ixdbnYcrQGWsBc1jQ2NtrZQ/VKShHM8kvdEPVN9qJsoBRl/aUoHyiJ+UpcCxJTtmfCDYoHJT2yYyOlPtcaCoUmGGwdbkVRbxGK+2y0gg2GisUvNmJCy/BVUJqm/eBIxXqpgbUtiBise12HQlc+ClwFSKRCiZH6wXpQs7OzETWn6XENa/trYemywuK0IpGsTotgRU3fcVBzouWG6pOnpqY0BhuGGpDXeUjIW7JKcfuX3tjjP9k4FBkZN4PtY+042JGzzNMcGDJ35C7tmcU++tJmjE63OpSUuLEJ62GcfXUO+59kr8rJnlOY0WfAGtYaY/PHYPv9fhdEY7++4nz/BWS17UPWY0Es2avWp3vOYOTnCCheBtaqHskJr95kZBL3AvdR2XkEex5mYbdQ+qwCd97dRTAcXHn1Moyrt16PA2tN//V8jY+Pf4cS/VWerzU9sDay1gd2Xf4F/AZqlpeB9836LwAAAABJRU5ErkJggg==') no-repeat center center;
            cursor: pointer;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>Welcome User   
        </h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>Home</a></li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <!-- Default box -->
        <% if (Vatas_Common.BLFunction.GetRoleName().ToLower() == "associate")
            { %>
        <asp:Panel ID="AssociatePanel" runat="server">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">Services</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <!-- /. col-->
                        <div class="col-md-3 col-sm-6 col-xs-12">
                            <div class="info-box">
                                <span class="info-box-icon bg-aqua"><i class="ion ion-ios-gear-outline"></i></span>

                                <div class="info-box-content">
                                    <span class="info-box-number">
                                        <h3>PAN</h3>
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                            <!-- /.info-box -->
                        </div>
                        <!-- ./col -->
                        <!-- /. col-->
                        <div class="col-md-3 col-sm-6 col-xs-12">
                            <div class="info-box">
                                <span class="info-box-icon bg-aqua"><i class="ion ion-ios-gear-outline"></i></span>

                                <div class="info-box-content">
                                    <span class="info-box-number">
                                        <h3>TAN</h3>
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                            <!-- /.info-box -->
                        </div>
                        <!-- ./col -->
                        <!-- /. col-->
                        <div class="col-md-3 col-sm-6 col-xs-12">
                            <div class="info-box">
                                <span class="info-box-icon bg-aqua"><i class="ion ion-ios-gear-outline"></i></span>

                                <div class="info-box-content">
                                    <span class="info-box-number">
                                        <h3>ITR</h3>
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                            <!-- /.info-box -->
                        </div>
                        <!-- ./col -->
                        <!-- /. col-->
                        <div class="col-md-3 col-sm-6 col-xs-12">
                            <div class="info-box">
                                <span class="info-box-icon bg-aqua"><i class="ion ion-ios-gear-outline"></i></span>

                                <div class="info-box-content">
                                    <span class="info-box-number">
                                        <h3>GST</h3>
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                            <!-- /.info-box -->
                        </div>
                        <!-- ./col -->
                    </div>
                </div>
                <!-- /.box-body -->
                <%--<div class="box-footer">
                    Footer
                </div>--%>
                <!-- /.box-footer-->
            </div>
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">Users</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <!-- ./col -->
                        <div class="col-lg-3 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-yellow">
                                <div class="inner">
                                    <h3>New User</h3>
                                    <p>&nbsp;</p>
                                </div>
                                <div class="icon">
                                    <i class="ion ion-person-add"></i>
                                </div>
                                <a href="<%=Page.ResolveUrl("~/NewUser")%>" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                        <!-- ./col -->
                        <div class="col-lg-3 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-green">
                                <div class="inner">
                                    <h3>View Users</h3>
                                    <p>&nbsp;</p>
                                </div>
                                <div class="icon">
                                    <i class="ion ion-ios-people"></i>
                                </div>
                                <a href="<%=Page.ResolveUrl("~/Customers")%>" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                        <!-- ./col -->
                    </div>
                </div>
            </div>
        </asp:Panel>
        <%}
            else if (Vatas_Common.BLFunction.GetRoleName().ToLower() == "potentialuser")
            { %>
        <asp:Panel ID="pnl" runat="server" DefaultButton="btnPUSearch">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">My Requests</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-3">
                            <a class="btn btn-info" href='<%= this.CurrentPagePath + "UserForm" %>' target="_blank"> Upload Document</a>
                        </div>
                        <div class="col-md-5"></div>
                        <div class="col-md-1">Show entries </div>
                        <div class="col-md-1">
                            <asp:DropDownList ID="ddlPUPageLength" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlPUPageLength_SelectedIndexChanged">
                                <asp:ListItem Value="10" Selected="True">10</asp:ListItem>
                                <asp:ListItem Value="20">20</asp:ListItem>
                                <asp:ListItem Value="30">30</asp:ListItem>
                                <asp:ListItem Value="50">50</asp:ListItem>
                                <asp:ListItem Value="-1">ALL</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-2">
                            <asp:TextBox ID="txtPUSearch" CssClass="form-control" Style="float: right;" placeholder="Search.." runat="server"></asp:TextBox>
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
                                <th style="width:50px;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptPotentialUser" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td class="details-control"></td>
                                        <td><%# Container.ItemIndex + 1  %></td>
                                        <td>
                                            <asp:Label ID="lblServiceName" Text='<%# Eval("ServiceName") %>' runat="server" /></td>
                                        <td>
                                            <asp:Label ID="lblDateAdded" Text='<%# Eval("DateAdded") %>' runat="server" /></td>
                                        <td>
                                            <asp:Label ID="lblDateModified" Text='<%# Eval("ModifiedDate") %>' runat="server" /></td>
                                        <td>
                                            <asp:Label ID="lblDocumentStatus" Text='<%# Eval("DocumentStatusName")%>' ForeColor='<%# ((Eval("DocumentStatusName")+"").ToLower() == "received" ? System.Drawing.Color.Green:System.Drawing.Color.Red)%>' runat="server" /></td>
                                        <td>
                                            <asp:Button ID="btnAddFiles" runat="server" CssClass='btn btn-info' Text="Upload more files" OnClick="btnAddFiles_Click" CommandName='<%# Eval("DocumentTableId") %>'/>
                                        </td>
                                    </tr>
                                    <tr class="hide">
                                        <td colspan="7">
                                            <table class="table table-bordered table-striped table-responsive overflow">
                                                <thead>
                                                    <tr>
                                                        <th>Sr.No</th>
                                                        <th>FileName</th>
                                                        <th>Date Uploaded</th>
                                                        <th>Verified</th>
                                                        <th>Date Verified</th>
                                                        <th style="width:50px;">Download</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:Repeater ID="rptFiles" runat="server" DataSource='<%# Eval("userDocumentDetails") %>'>
                                                        <ItemTemplate>
                                                            <tr>
                                                            <td><%# Container.ItemIndex + 1  %></td>

                                                            <td>
                                                                <asp:Label ID="lblFileName" Text='<%# Eval("DisplayAs") %>' runat="server" /></td>
                                                            <td>
                                                                <asp:Label ID="lblFileUploadDate" Text='<%# Eval("DateAdded") %>' runat="server" /></td>
                                                            <td>
                                                                <asp:Label ID="lblIsVerified" Text='<%# Eval("IsValid").ToString().ToLower() == "true" ? "Verified":"Pending" %>' ForeColor='<%# Eval("IsValid").ToString().ToLower() == "true" ? System.Drawing.Color.Green:System.Drawing.Color.Red %>' runat="server" /></td>
                                                            <td>
                                                                <asp:Label ID="lblFileStatusModifiedDate" Font-Bold="true" Text='<%# Eval("DateModified") %>' runat="server" /></td>
                                                            <td>
                                                                <asp:HyperLink ID="hlDownload" Target="_blank" runat="server" NavigateUrl='<%# this.CurrentPagePath + "WebHandler/FileDownload.ashx?Id=" + BLSecurity.Encrypt(Eval("Id").ToString()) %>'><span title="Click to download"><i class="fa fa-download fa-2x"></i></span></asp:HyperLink></td>
                                                                </tr>
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
            </div>
        </asp:Panel>

        <%}
            else if (Vatas_Common.BLFunction.GetRoleName().ToLower() == "superadmin" || Vatas_Common.BLFunction.GetRoleName().ToLower() == "admin" || Vatas_Common.BLFunction.GetRoleName().ToLower() == "dataentrysupervisor" || Vatas_Common.BLFunction.GetRoleName().ToLower() == "frontofficesupervisor")
            { %>
        <asp:Panel ID="Panel1" runat="server">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">Reports</h3>

                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>

                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-1">Show entries </div>
                        <div class="col-md-1">
                            <asp:DropDownList ID="ddlAPageLength" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlAPageLength_SelectedIndexChanged">
                                <asp:ListItem Value="10" Selected="True">10</asp:ListItem>
                                <asp:ListItem Value="20">20</asp:ListItem>
                                <asp:ListItem Value="30">30</asp:ListItem>
                                <asp:ListItem Value="50">50</asp:ListItem>
                                <asp:ListItem Value="-1">ALL</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-10">
                            <asp:CheckBox ID="chkIsActive" runat="server" Checked="false" AutoPostBack="true" OnCheckedChanged="chkIsActive_CheckedChanged" Style="float: right!important;" />
                        </div>
                    </div>
                    <table id="processTable" class="table table-bordered table-striped dataTable table-responsive overflow">
                        <thead>
                            <tr style="width: 100%!important">
                                <th>Name</th>
                                <th>Email</th>
                                <th>Contact</th>
                                <th>Document Id</th>
                                <th>Title</th>
                                <th>Notes</th>
                                <th>Dated</th>
                                <th>Status</th>
                                <th>Assigned To</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptAdmin" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblUserName" Text='<%# Eval("UserName") %>' runat="server" /></td>
                                        <td>
                                            <asp:Label ID="lblEmail" Text='<%# Eval("EmailId") %>' runat="server" /></td>
                                        <td>
                                            <asp:Label ID="lblContact" Text='<%# Eval("Contact") %>' runat="server" /></td>
                                        <td>
                                            <asp:HiddenField ID="hfUserId" runat="server" Value='<%# Eval("UserId") %>' />
                                            <asp:Label ID="lblDocumentId" Text='<%# Eval("DocumentId") %>' runat="server" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblDocumentTitle" Text='<%# Eval("DocumentTitle") %>' runat="server" /></td>
                                        <td>
                                            <asp:Label ID="lblDocumentNotes" Text='<%# Eval("DocumentNotes") %>' runat="server" /></td>
                                        <td>
                                            <asp:Label ID="lblDateAdded" Text='<%# Eval("DateAdded") %>' runat="server" /></td>
                                        <td>
                                            <asp:Label ID="lblProcessed" Text='<%# ((Eval("IsProcessed")+"").ToLower() == "true" ? "Processing":"Pending")%>' ForeColor='<%# ((Eval("IsProcessed")+"").ToLower() == "true" ? System.Drawing.Color.Green:System.Drawing.Color.Red)%>' runat="server" /></td>
                                        <td>
                                            <asp:DropDownList ID="ddlUser" runat="server" CssClass="form-control" DataSource='<%# Eval("Users") %>' DataTextField="DataText" DataValueField="DataValue" AppendDataBoundItems="true">
                                                <asp:ListItem Selected="True" Text="--Select--" Value="0"></asp:ListItem>
                                            </asp:DropDownList></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
                <div class="box-footer clearfix">
                    <div id="page-selection" class="pull-right" style="margin-top: 10px;"></div>
                </div>
                <div class="box-footer">
                    <% if (this.rptAdmin.Items.Count > 0)
                        { %>
                    <asp:LinkButton Visible="true" ID="btnConfirm" OnClick="btnConfirm_Click" runat="server" Style="margin-right: 10px;" CssClass="btn btn-info pull-right submit"><i class="fa fa-check"></i>&nbsp;Assign</asp:LinkButton>
                    <%     
                        } %>
                </div>
            </div>
        </asp:Panel>
        <%}
            else if (Vatas_Common.BLFunction.GetRoleName().ToLower() == "telecaller")
            { %>
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">Reports</h3>
                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                        <i class="fa fa-minus"></i>
                    </button>
                </div>
            </div>
            <div class="box-body">
                <div class="row">
                    <div class="col-md-1">Show entries </div>
                    <div class="col-md-1">
                        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control" AutoPostBack="true">
                            <asp:ListItem Value="10" Selected="True">10</asp:ListItem>
                            <asp:ListItem Value="20">20</asp:ListItem>
                            <asp:ListItem Value="30">30</asp:ListItem>
                            <asp:ListItem Value="50">50</asp:ListItem>
                            <asp:ListItem Value="-1">ALL</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <table id="processTable" class="table table-bordered table-striped dataTable table-responsive overflow">
                    <thead>
                        <tr style="width: 100%!important">
                            <th>Name</th>
                            <th>Email</th>
                            <th>Contact</th>
                            <th>Document Id</th>
                            <th>Title</th>
                            <th>Notes</th>
                            <th>Dated</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="Repeater1" runat="server">
                            <ItemTemplate>
                                <tr style="width: 100%!important">
                                    <td>
                                        <asp:HiddenField ID="hfUserId" runat="server" Value='<%# Eval("UserId") %>' />
                                        <asp:Label ID="lblDocumentId" Text='<%# Eval("DocumentId") %>' runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblDocumentTitle" Text='<%# Eval("DocumentTitle") %>' runat="server" /></td>
                                    <td>
                                        <asp:Label ID="lblDocumentNotes" Text='<%# Eval("DocumentNotes") %>' runat="server" /></td>
                                    <td>
                                        <asp:Label ID="lblDateAdded" Text='<%# Eval("DateAdded") %>' runat="server" /></td>
                                    <td>
                                        <asp:Label ID="lblProcessed" Text='<%# ((Eval("IsProcessed")+"").ToLower() == "true" ? "Processing":"Pending")%>' ForeColor='<%# ((Eval("IsProcessed")+"").ToLower() == "true" ? System.Drawing.Color.Green:System.Drawing.Color.Red)%>' runat="server" /></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
            <!-- /.box-body -->
        </div>
        <%} %>
        <div class="overlay">
            <i class="fa fa-refresh fa-spin"></i>
        </div>
    </section>
    <asp:HiddenField runat="server" ID="hidPages" />
    <asp:HiddenField runat="server" ID="hidPageNo" Value="1" />
    <asp:Button UseSubmitBehavior="true" ID="btnPUSearch" Text="" CausesValidation="false" OnClick="btnPUSearch_Click" Style="display: none" CssClass="submit" runat="server" />
    <!-- /.content -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceFooter" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#lihome').addClass('active');
            $("#page-selection").bootpag({
                next: 'Next',
                prev: 'Prev',
                total: <%=hidPages.Value == ""? "0" : hidPages.Value %>,
                page: <%=hidPageNo.Value %>,
                maxVisible: 5
            }).on("page", function (event, num) {
                $('[id$=hidPageNo]').val(num);
                $('[id$=btnPUSearch]').click();
            });
            $('[id$=chkIsActive]').iCheck('destroy');
            $('[id$=chkIsActive]').bootstrapToggle({
                on: 'Processing',
                off: 'Pending',
                onstyle: 'success',
                offstyle: 'danger',
                style: 'android'
            });
            $('[id$=chkIsActive]').on('change', function () {
                $(this).click();
                //$('#console-event').html('Toggle: ' + $(this).prop('checked'))
            });
             $('.details-control').on('click', function () {
                var tr = $(this).parent('tr').next('tr');
                if (tr.hasClass('hide')) {
                    var currentElem = $(this).css('background', 'url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAACdUlEQVR4Aa2V30tTYRjHVSgsoQKhXPUPlKZMlImiIIg/pggiiDeCBAdqyC4Kf9zVhVdeelX33QnCbtYvxZsxxkoqKxiz1SzdFudMb5xO5/bt+fa+sPCw3IVf+PA+532e5ytn53lfK0qoSrggXBauCbUKxtxjjjVnq1IXXxFuCXeEFqGdMOYec6zRtZX/M6sWrgv1hmHcDwQCLxOJxM9CoZAnjLnHHGt0bbXdVG1cEm4KLp/P9yKXyx2jhJhjDWvZc9qUwUWhzuFwdMVisc8QFQ4PcbCygvT0NJLDw0gNDSH96DEyfj8KmQwo1rJHem8oD2VapX/sxlAo9Aqi/N4e9hYWsDMwgARxD2DH7ZZYren5eZxYFqhgMOhnr3BVeSnn216v98Hf3yqXg/X0CX719YFs9/WquJfPGtkzZ2fBWvZ4PB6DHtqrokaol7/0GqLM2hq2enpsxMmpvf3VVVD8UOJxV42Uet1Wy7J+M5mam8P37u6ySM7MgDJNM8mRUl5qYDtOREz+GB3FZlcXNjs7UUrMk/jYGKhsNnuo57TWZhgTw0hHO0EpRdpV/tvICKgjUdFQv/Lu7q7JZHxqCl9dLqGtSJtL4VJ80Wvc8xD2V9YfRUbmLZPp5WVstLTYaSWt+lmt1tISKH5Q/VFqbGOTl6GNTk7iQ3Oz4FSrU8UfuTqdBJHxceQz+2APe/8Zm+Jgh8PhNxBlt7YQNQysNzVivbEJ7wXGiiZEJiZwEI2C4mFgr/aoKnn0jk0TiWfPsTE4iHcN9xBuaMCn/n5sLy7iKJk8ffTqikfvfC4H9laWdX2lUqltaDEu9/o664LtIOVfsOf4L+APb5yaiwyN8+8AAAAASUVORK5CYII=) no-repeat center center');
                    tr.removeClass('hide');
                }
                else
                {
                    var currentItem = $(this).css('background', 'url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAACjElEQVR4Aa2V30uTURjHnVBUgglCaXVTJJVLMdhQm7+1JEvJiKAggmgSQiKJl0V0E13UVf0HQZmBLcvlpqa55tqV0YoMzIhY6js0yDH11X17vuO8Sq5Zgl/48DznPD/G63nOMSmBkoUNwhYhTUgn9NUeY8z5p0wqOVXYKRwQLMJhhYV7Kpaqck2rNdskbBPMdrv9osfjcQaDwW/RaHSR0OceY8xhrqox/a3ZZmGHkO9wOB7ouj6PBGKMOcxlzcqmdDYKGZmZmSWjo6PvIYosRuDWXGj50IwTb4+hxleN5sAVvJh4jvBCGBRzWSO121UPk3EAaUKuz+d7ycTp+Wnc/nwL1d4qHBVidmjZv/npBkJzGiiv19vFWmGrcVDsvKupqeky/056VMf1j9dQOViBKo9Aa/ixdbnYcrQGWsBc1jQ2NtrZQ/VKShHM8kvdEPVN9qJsoBRl/aUoHyiJ+UpcCxJTtmfCDYoHJT2yYyOlPtcaCoUmGGwdbkVRbxGK+2y0gg2GisUvNmJCy/BVUJqm/eBIxXqpgbUtiBise12HQlc+ClwFSKRCiZH6wXpQs7OzETWn6XENa/trYemywuK0IpGsTotgRU3fcVBzouWG6pOnpqY0BhuGGpDXeUjIW7JKcfuX3tjjP9k4FBkZN4PtY+042JGzzNMcGDJ35C7tmcU++tJmjE63OpSUuLEJ62GcfXUO+59kr8rJnlOY0WfAGtYaY/PHYPv9fhdEY7++4nz/BWS17UPWY0Es2avWp3vOYOTnCCheBtaqHskJr95kZBL3AvdR2XkEex5mYbdQ+qwCd97dRTAcXHn1Moyrt16PA2tN//V8jY+Pf4cS/VWerzU9sDay1gd2Xf4F/AZqlpeB9836LwAAAABJRU5ErkJggg==) no-repeat center center');
                     tr.addClass('hide');
                }
                   
            });
        });
    </script>
</asp:Content>
