<%@ Page Title="" Language="C#" MasterPageFile="~/BaseFrame.Master" AutoEventWireup="true" CodeBehind="bugList.aspx.cs" Inherits="Softmatic.pages.campaignAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="server">
    <link rel="stylesheet" href="../css/slider.css" />
    <script src="../js/slider.js"></script>
    <script>document.getElementsByTagName("html")[0].className += " js";</script>
    <link rel="stylesheet" href="../css/tabNav.css">
    <style>
        .cd-tabs__list {
            width: 100%;
        }

        .profile-image1 {
            cursor: pointer;
            border: 2px solid #03b1ce;
        }

        .img-circle {
            border-radius: 50%;
            height: 150px;
            width: 150px;
            object-fit: cover;
        }

        .edit.disable {
            pointer-events: none;
            cursor: default;
        }

        body {
            padding-bottom: 0;
        }

        .wrapper {
            position: relative;
            display: inline-block;
        }

        .close:before {
            content: '✕';
        }

        .close {
            position: absolute;
            top: 0;
            right: 0;
            cursor: pointer;
        }

        .comment-container {
            position: relative;
            width: 100%;
        }

        .comment-like-container {
            position: absolute;
            top: 0px;
            right: 0px;
        }

        .comment-like-button {
            cursor: pointer;
            width: 30%;
        }

        .profile-image2 {
            width: 70px;
            height: 70px;
            border: 2px solid #03b1ce;
        }
    </style>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bodyContent" runat="server">
    <!--================Home Banner Area =================-->
    <section class="banner_area" style="min-height: 370px;">
        <div class="banner_inner d-flex align-items-center" style="min-height: 370px;">
            <div class="overlay"></div>
            <div class="container">
                <div class="banner_content text-center">
                    <h2>Profile Details</h2>
                    <div class="page_link">
                        <a href="../index.aspx">Home</a>
                        <a href="./userProfile.aspx">Profile Details</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--================End Home Banner Area =================-->

    <div class="row">
        <div class="col-lg-12 col-md-12">
            <div class="row">
                <div class="cd-tabs cd-tabs--vertical container max-width-xxl margin-top-md margin-bottom-md js-cd-tabs">
                    <nav class="cd-tabs__navigation">
                        <ul class="cd-tabs__list">
                            <asp:PlaceHolder runat="server" ID="userTabs">
                                <li id="caseTab">
                                    <a href="#tab-case"  class="cd-tabs__item cd-tabs__item--selected">
                                        <span>My Case</span>
                                    </a>
                                </li>
                            </asp:PlaceHolder>
                        </ul>
                        <!-- cd-tabs__list -->
                    </nav>

                    <ul class="cd-tabs__panels">

                        <li id="tab-case" class="cd-tabs__panel cd-tabs__panel--selected text-component">
                            <div id="toolbar">
                            </div>
                            <table
                                id="myCase"
                                data-toolbar="#toolbar"
                                data-search="true"
                                data-show-refresh="true"
                                data-show-toggle="false"
                                data-show-fullscreen="true"
                                data-show-columns="true"
                                data-show-columns-toggle-all="false"
                                data-detail-view="true"
                                data-show-export="true"
                                data-click-to-select="false"
                                data-detail-formatter="campaignDetailFormatter"
                                data-minimum-count-columns="2"
                                data-show-pagination-switch="true"
                                data-pagination="true"
                                data-id-field="bugId"
                                data-page-list="[10, 25, 50, 100, all]"
                                data-side-pagination="client"
                                data-response-handler="responseHandler">
                            </table>
                        </li>
                    </ul>
                    <!-- cd-tabs__panels -->
                </div>
                <!-- cd-tabs -->
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script2" runat="server">
    <script src="../js/tabUtil.js"></script>
    <!-- util functions included in the CodyHouse framework -->
    <script src="../js/tabMain.js"></script>
    <link href="https://unpkg.com/bootstrap-table@1.16.0/dist/bootstrap-table.min.css" rel="stylesheet">

    <script src="https://unpkg.com/tableexport.jquery.plugin/tableExport.min.js"></script>
    <script src="https://unpkg.com/bootstrap-table@1.16.0/dist/bootstrap-table.min.js"></script>
    <script src="https://unpkg.com/bootstrap-table@1.16.0/dist/bootstrap-table-locale-all.min.js"></script>
    <script src="https://unpkg.com/bootstrap-table@1.16.0/dist/extensions/export/bootstrap-table-export.min.js"></script>

    <link href="../css/select2.css" rel="stylesheet" />
    <script src="../js/select2.js"></script>

    <style>
        .select,
        #locale {
            width: 100%;
        }

        .like {
            margin-right: 10px;
        }
    </style>
    <script>
        var $table = $('#myCase');
        var selections = [];

        window.operateEvents = {
            'click .edit': function (e, value, row, index) {
                var bugId = row.bugId,
                    title = row.title,
                    description = row.description;


                openNewBugDialog(bugId, title, description);
            }
        }

        var bugColumn = [{
            title: 'Bug ID',
            field: 'bugId',
            align: 'center',
            valign: 'middle',
            formatter: campaignLinkFormatter,
            sortable: true
        }, {
            title: 'Title',
            field: 'title',
            sortable: true,
            align: 'center'
        }, {
            field: 'createdOn',
            title: 'Create Date',
            sortable: true,
            align: 'center',
            formatter: dateFormatter
        }, {
            field: 'createdBy',
            title: 'Create By',
            sortable: true,
            align: 'center'
        }, {
            field: 'status',
            title: 'Status',
            sortable: true,
            align: 'center'
        }, {
            field: 'operate',
            title: 'Edit',
            align: 'center',
            clickToSelect: false,
            events: window.operateEvents,
            formatter: operateFormatter
        }]


        $(function () {
            getmyCase();
        })

        

        function getmyCase() {
            $.ajax({
                type: "POST",
                url: "bugList.aspx/getBugList",
                data: '',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    initTable('#myCase', bugColumn, response.d, 'getmyCase()');
                },
                error: function (response) {
                    console.log(response);
                },
                failure: function (response) {
                    console.log(response);
                }
            });
        }

       

        function getIdSelections() {
            return $.map($table.bootstrapTable('getSelections'), function (row) {
                return row.id
            })
        }

        function responseHandler(res) {
            $.each(res.rows, function (i, row) {
                row.state = $.inArray(row.id, selections) !== -1
            })
            return res
        }

        function campaignDetailFormatter(index, row) {
            var html = [];

            //html.push('<div style="background-color:lightgrey;">');
            html.push('<div class="row">');
            html.push('<div class="col-lg-4 col-md-4"> <b>Title: </b> <span>' + htmlEncode(row.title) + '</span> </div>');
            html.push('<div class="col-lg-4 col-md-4"> <b>Status: </b> <span>' + htmlEncode(row.status) + '</span> </div>');
            html.push('</div>');

            html.push('<div class="row">');
            html.push('<div class="col-lg-4 col-md-4"> <b>Created By: </b> <span>' + row.createdBy + '</span> </div>');
            html.push('<div class="col-lg-4 col-md-4"> <b>Created On: </b> <span>' + changDateTimeFormat(row.createdOn) + '</span> </div>');
            html.push('</div>');

            return html.join('')
        }


        function dateTimeFormatter(data) {
            return changDateTimeFormat(data);
        }

        function dateFormatter(data) {
            return changeDateFormat(data);
        }


        function printDiv(divID) {

            var contents = $("#" + divID).html();
            var frame1 = $('<iframe />');
            frame1[0].name = "frame1";
            frame1.css({ "position": "absolute", "top": "-1000000px" });
            $("body").append(frame1);
            var frameDoc = frame1[0].contentWindow ? frame1[0].contentWindow : frame1[0].contentDocument.document ? frame1[0].contentDocument.document : frame1[0].contentDocument;
            frameDoc.document.open();
            //Create a new HTML document.
            frameDoc.document.write('<html><head><title>DIV Contents</title>');
            frameDoc.document.write('</head><body>');
            //Append the external CSS file.
            frameDoc.document.write('<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet" type="text/css" />');
            frameDoc.document.write("<script type=\"text/javascript\" src=\"https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js\"><\/script>");
            frameDoc.document.write("<script type=\"text/javascript\" src=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js\"><\/script>");
            //Append the DIV contents.
            frameDoc.document.write(contents);
            frameDoc.document.write('</body></html>');
            frameDoc.document.close();
            setTimeout(function () {
                window.frames["frame1"].focus();
                window.frames["frame1"].print();
                frame1.remove();
            }, 1000);

        }

        function operateFormatter(value, row, index) {
            if (row.status == 'New') {
                return [
                    '<a class="edit" href="javascript:void(0)" title="Edit">',
                    '<i class="fa fa-edit"></i>',
                    '</a>'
                ].join('')
            } else {
                return '-'
            }
        }

        function totalTextFormatter(data) {
            return 'Total'
        }

        function totalNameFormatter(data) {
            return data.length
        }

        function totalPriceFormatter(data) {
            var field = this.field
            return '$' + data.map(function (row) {
                return eval('+row.' + field);
            }).reduce(function (sum, i) {
                return sum + i
            }, 0)
        }

        function initTable(tableId, columns, data, dataFunction) {
            $(tableId).bootstrapTable('destroy').bootstrapTable({
                exportTypes: ['csv', 'txt', 'excel'],
                locale: 'en-US',
                columns: columns,
                data: data
            })

            $(tableId).on('all.bs.table', function (e, name, args) {
                //console.log(name, args)
                if (name == "refresh.bs.table") {
                    eval(dataFunction);
                }
            })
        }

    </script>
</asp:Content>
