<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.master" AutoEventWireup="true" CodeBehind="UserForm.aspx.cs" Inherits="Vatas_UI.User.UserForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        table {
            counter-reset: section;
        }

        .count:before {
            counter-increment: section;
            content: counter(section);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceBody" runat="server">
    <section class="content-header">
        <h1>Upload Document</h1>
        <ol class="breadcrumb">
            <li><a href="javascript:;"><i class="fa fa-dashboard"></i>User</a></li>
            <li><a href="javascript:;">Upload Document</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">Upload Documents</h3>
            </div>
            <div class="box-body">
                <div class="col-md-6 col-md-offset-3">
                    <div class="box box-info">
                        <div class="form-horizontal">
                            <div class="box-body">
                                 <div class="form-group has-feedback">
                                    <label for="txtServiceType" class="col-sm-2 control-label">Service</label>
                                    <div class="col-sm-10">
                                        <asp:DropDownList ID="ddlService" runat="server" AppendDataBoundItems="true" ValidationGroup="SaveDoc" CssClass="form-control">
                                            <asp:ListItem Text="Select" Value="0" Selected="True"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvServiceType" InitialValue="0" ControlToValidate="ddlService" runat="server"   ErrorMessage="<span class='glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="SaveDoc" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="form-group has-feedback">
                                    <label for="txtDocumentTitle" class="col-sm-2 control-label">Document Title</label>
                                    <div class="col-sm-10">
                                        <asp:TextBox ID="txtDocumentTitle" runat="server" MaxLength="50" class="form-control" placeholder="Document Title" ValidationGroup="SaveDoc" />
                                        <asp:RequiredFieldValidator ID="rfvDocumentTitle" ControlToValidate="txtDocumentTitle" runat="server" ErrorMessage="<span class='glyphicon glyphicon-remove form-control-feedback' style='color:#d84a38;'></span>" ForeColor="#d84a38" EnableClientScript="true" ValidationGroup="SaveDoc" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="form-group has-feedback">
                                    <label for="txtDocumentNotes" class="col-sm-2 control-label">Notes</label>
                                    <div class="col-sm-10">
                                        <asp:TextBox ID="txtDocumentNotes" runat="server" MaxLength="15" TextMode="MultiLine" Rows="4" class="form-control" placeholder="Document Notes" />
                                    </div>
                                </div>

                                <div class="form-group has-feedback">
                                    <label for="fupFile" class="col-sm-2 control-label">Upload</label>
                                    <div class="col-sm-10">
                                        <asp:FileUpload ID="fupFile" runat="server" AllowMultiple="true" />
                                        <p class="help-block">List of uploaded files</p>
                                        <table id="tblFiles" class="table table-bordered">
                                            <thead>
                                                <th style="width: 10px">#</th>
                                                <th>File Name</th>
                                                <th style="width: 40px"></th>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="box-footer">
                                <asp:Button ID="btnCancel" Text="Cancel" runat="server" CssClass="btn btn-default pull-right" OnClick="btnCancel_Click" />
                                <asp:Button ID="btnSubmit" CssClass="btn btn-info pull-right" ValidationGroup="SaveDoc" runat="server" Style="margin-right: 10px;" Text="Save" OnClick="btnSubmit_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="overlay">
            <i class="fa fa-refresh fa-spin"></i>
        </div>
    </section>
    <asp:HiddenField ID="hfCustomerId" runat="server" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceFooter" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#liUserForm').addClass('active');
            $('#fupFile').on("change", function () {
                $('.overlay').css('display', 'block');
                var fileUpload = $("#fupFile").get(0);
                var files = fileUpload.files;
                var filedata = new FormData();
                for (var i = 0; i < files.length; i++) {
                    filedata.append(files[i].name, files[i]);
                }

                $.ajax({
                    url: "<%= this.CurrentPagePath + "WebHandler/FileUpload.ashx"%>",
                    type: "POST",
                    contentType: false,
                    processData: false,
                    data: filedata,
                    success: function (result) {
                        var tbody = $("#tblFiles tbody");
                        $.each(result, function (index, value) {
                            var templaterow = '<tr><td class="count"></td><td>' + value.displayAs + '</td><td><a href="javascript:;" data-fname=' + value.fileName + ' class="btn-box-tool deletefile"><i class="fa fa-times fa-2x"></i></a></td></tr>'
                            tbody.append(templaterow);
                        });
                        $('.overlay').css('display', 'none');
                    },
                    error: function (err) {
                        alert(err.statusText);
                        $('.overlay').css('display', 'none');
                    }
                });
                $('#fupFile').val('');
            });

            $(document.body).on('click', '.deletefile', function (e) {
                $('.overlay').css('display', 'block');
                var rowCount = $('.count').length;
                var fname = $(this).data("fname");
                $.ajax({
                    type: "POST",
                    url: "<%= this.CurrentPagePath + "User/UserForm.aspx/DeleteFile"%>",
                    data: '{filename: "' + fname + '" }',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (rowCount > response.d.length) {
                            var tbody = $("#tblFiles tbody");
                            tbody.html('');
                            $.each(response.d, function (index, value) {
                                var templaterow = '<tr><td class="count"></td><td>' + value.displayAs + '</td><td><a href="javascript:;" data-fname=' + value.fileName + ' class="btn-box-tool deletefile"><i class="fa fa-times fa-2x"></i></a></td></tr>'
                                tbody.append(templaterow);
                            });
                        }
                        $('.overlay').css('display', 'none');
                    },
                    failure: function (response) {
                        alert(response.d);
                        $('.overlay').css('display', 'none');
                    }
                });
            });
        });


    </script>
</asp:Content>
