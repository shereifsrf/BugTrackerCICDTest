<%@ Page Title="" Language="C#" MasterPageFile="~/BaseFrame.Master" AutoEventWireup="true" CodeBehind="inbox.aspx.cs" Inherits="Softmatic.pages.inbox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="server">
    <style>
        body {
            margin-top: 20px;
            background: #eee;
        }

        .btn-compose-email {
            padding: 10px 0px;
            margin-bottom: 20px;
        }

        .btn-danger {
            background-color: #E9573F;
            border-color: #E9573F;
            color: white;
        }

        .panel-teal .panel-heading {
            background-color: #37BC9B;
            border: 1px solid #36b898;
            color: white;
        }

        .panel .panel-heading {
            padding: 5px;
            border-top-right-radius: 3px;
            border-top-left-radius: 3px;
            border-bottom: 1px solid #DDD;
            -moz-border-radius: 0px;
            -webkit-border-radius: 0px;
            border-radius: 0px;
        }

            .panel .panel-heading .panel-title {
                padding: 10px;
                font-size: 17px;
            }

        form .form-group {
            position: relative;
            margin-left: 0px !important;
            margin-right: 0px !important;
        }

        .inner-all {
            padding: 10px;
        }

        /* ========================================================================
 * MAIL
 * ======================================================================== */
        .nav-email > li:first-child + li:active {
            margin-top: 0px;
        }

        .nav-email > li + li {
            margin-top: 1px;
        }

        .nav-email li {
            background-color: white;
        }

            .nav-email li.active {
                background-color: transparent;
            }

                .nav-email li.active .label {
                    background-color: white;
                    color: black;
                }

            .nav-email li a {
                color: black;
                -moz-border-radius: 0px;
                -webkit-border-radius: 0px;
                border-radius: 0px;
            }

                .nav-email li a:hover {
                    background-color: #EEEEEE;
                }

                .nav-email li a i {
                    margin-right: 5px;
                }

                .nav-email li a .label {
                    margin-top: -1px;
                }

        .table-email tr:first-child td {
            border-top: none;
        }

        .table-email tr td {
            vertical-align: top !important;
        }

            .table-email tr td:first-child, .table-email tr td:nth-child(2) {
                text-align: center;
                width: 35px;
            }

        .table-email tr.unread, .table-email tr.selected {
            background-color: #EEEEEE;
        }

        .table-email .media {
            margin: 0px;
            padding: 0px;
            position: relative;
        }

            .table-email .media h4 {
                margin: 0px;
                font-size: 14px;
                line-height: normal;
                text-align: left;
            }

        .table-email .media-object {
            width: 35px;
            -moz-border-radius: 2px;
            -webkit-border-radius: 2px;
            border-radius: 2px;
        }

        .table-email .media-meta, .table-email .media-attach {
            font-size: 11px;
            color: #999;
            position: absolute;
            right: 10px;
        }

        .table-email .media-meta {
            top: 0px;
            font-weight: 600;
        }

        .table-email .media-attach {
            bottom: 0px;
        }

            .table-email .media-attach i {
                margin-right: 10px;
            }

                .table-email .media-attach i:last-child {
                    margin-right: 0px;
                }

        .table-email .email-summary {
            margin: 0px 110px 0px 0px;
            text-align: left;
            font-weight: 600;
        }

            .table-email .email-summary strong {
                color: #333;
            }

            .table-email .email-summary span {
                line-height: 1;
            }

                .table-email .email-summary span.label {
                    padding: 1px 5px 2px;
                }

        .table-email .ckbox {
            line-height: 0px;
            margin-left: 8px;
        }

        .table-email .star {
            margin-left: 6px;
        }

            .table-email .star.star-checked i {
                color: goldenrod;
            }

        .nav-email-subtitle {
            font-size: 15px;
            text-transform: uppercase;
            color: #333;
            margin-bottom: 15px;
            margin-top: 30px;
        }

        .compose-mail {
            position: relative;
            padding: 15px;
        }

            .compose-mail textarea {
                width: 100%;
                padding: 10px;
                border: 1px solid #DDD;
            }

        .view-mail {
            padding: 10px;
            font-weight: 300;
        }

        .attachment-mail {
            padding: 10px;
            width: 100%;
            display: inline-block;
            margin: 20px 0px;
            border-top: 1px solid #EFF2F7;
        }

            .attachment-mail p {
                margin-bottom: 0px;
            }

            .attachment-mail a {
                color: #32323A;
            }

            .attachment-mail ul {
                padding: 0px;
            }

                .attachment-mail ul li {
                    float: left;
                    width: 200px;
                    margin-right: 15px;
                    margin-top: 15px;
                    list-style: none;
                }

                    .attachment-mail ul li a.atch-thumb img {
                        width: 200px;
                        margin-bottom: 10px;
                    }

                    .attachment-mail ul li a.name span {
                        float: right;
                        color: #767676;
                    }

        @media (max-width: 640px) {
            .compose-mail-wrapper .compose-mail {
                padding: 0px;
            }
        }

        @media (max-width: 360px) {
            .mail-wrapper .panel-sub-heading {
                text-align: center;
            }

                .mail-wrapper .panel-sub-heading .pull-left, .mail-wrapper .panel-sub-heading .pull-right {
                    float: none !important;
                    display: block;
                }

                .mail-wrapper .panel-sub-heading .pull-right {
                    margin-top: 10px;
                }

                .mail-wrapper .panel-sub-heading img {
                    display: block;
                    margin-left: auto;
                    margin-right: auto;
                    margin-bottom: 10px;
                }

            .mail-wrapper .panel-footer {
                text-align: center;
            }

                .mail-wrapper .panel-footer .pull-right {
                    float: none !important;
                    margin-left: auto;
                    margin-right: auto;
                }

            .mail-wrapper .attachment-mail ul {
                padding: 0px;
            }

                .mail-wrapper .attachment-mail ul li {
                    width: 100%;
                }

                    .mail-wrapper .attachment-mail ul li a.atch-thumb img {
                        width: 100% !important;
                    }

                    .mail-wrapper .attachment-mail ul li .links {
                        margin-bottom: 20px;
                    }

            .compose-mail-wrapper .search-mail input {
                width: 130px;
            }

            .compose-mail-wrapper .panel-sub-heading {
                padding: 10px 7px;
            }
        }

        textarea {
            width: 100%;
        }

        .media a {
            display: block;
            width: 100%;
        }

        * {
            scrollbar-width: thin;
            scrollbar-color: lightgrey white;
        }

            /* Works on Chrome/Edge/Safari */
            *::-webkit-scrollbar {
                width: 12px;
            }

            *::-webkit-scrollbar-track {
                background: white;
            }

            *::-webkit-scrollbar-thumb {
                background-color: lightgrey;
                border-radius: 20px;
                border: 3px solid lightgrey;
            }

        .notifications-count {
            -moz-border-radius: 50%;
            -webkit-border-radius: 50%;
            border-radius: 50%;
            -moz-background-clip: padding-box;
            -webkit-background-clip: padding-box;
            background-clip: padding-box;
            background: #ea2c58;
            color: #fefefe;
            font: normal 0.85em 'Lato';
            height: 16px;
            line-height: 1.55em;
            position: absolute;
            right: 1%;
            text-align: center;
            top: 25%;
            width: 16px;
        }

        .inboxUserName {
            font-size: larger;
            margin: 20px;
        }

        .profile-image {
            width: 50px;
            height: 50px;
            border: 2px solid black;
        }

        .img-circle {
            border-radius: 50%;
            object-fit: cover;
        }

        .messageTableBackground {
            background-image: url("https://ghostcode.in/wp-content/uploads/2016/09/super_hero_whatsapp_background_by_x_ama-d8fr7iz.jpg");
            opacity: 0.5;
            height: inherit;
            position: absolute;
            top: 0px;
            left: 1%;
            right: 1%;
            bottom: 0px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bodyContent" runat="server">
    <!--================Home Banner Area =================-->
    <section class="banner_area">
        <div class="banner_inner d-flex align-items-center">
            <div class="overlay"></div>
            <div class="container">
                <div class="banner_content text-center">
                    <h2>Inbox</h2>
                    <div class="page_link">
                        <a href="../index.aspx">Home</a>
                        <a href="#">Inbox</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--================End Home Banner Area =================-->

    <form id="form1" runat="server">
        <div style="margin: 5% 10%;">
            <div class="row">
                <div class="col-sm-3">
                    <div class="panel rounded shadow panel-teal">
                        <div class="panel-body no-padding">
                            <div class="table-responsive" style="overflow-y: scroll; height: 750px; padding: 15px; background-color:white;">
                                <table class="table table-hover table-email">
                                    <tbody id="inboxBody">
                                        <tr id="lblInbox" style="display: none">
                                            <td>
                                                <label>** No Message **</label>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>

                <div class="col-sm-9">
                    <div class="panel rounded shadow panel-teal">
                        <div class="panel-body no-padding">
                            <div class="table-responsive messageTable" style="overflow-y: scroll; height: 500px; padding: 15px;">
                                <div class="messageTableBackground"></div>
                                <table class="table table-hover table-email">
                                    <tbody id="msgBody">
                                        <tr id="lblMessage">
                                            <td>
                                                <label>** Select inbox to display message **</label>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                    <br />
                    <div class="panel rounded shadow panel-teal">
                        <div class="panel-body no-padding">
                            <div class="table-responsive">
                                <table class="table table-hover table-email">
                                    <tbody>
                                        <tr>
                                            <td>
                                                <div class="media">
                                                    <div class="media-body">
                                                        <p>
                                                            <textarea id="txtMessage" cols="70" rows="5"></textarea>
                                                        </p>
                                                        <button class="primary-btn submit_btn" onclick="return sendMsg(0);" id="btnSend">Send</button>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
            </div>
        </div>
    </form>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script2" runat="server">
    <script>
        function sendMsg(toUserId) {
            console.log('1:' + toUserId)

            if (toUserId != 0) {
                $.when(sendMessage(toUserId, $('#txtMessage').val())).then(function (x) {
                    $('#txtMessage').val('');
                    getMessageList(toUserId);
                });
            } else {
                Swal.fire({
                    icon: 'warning',
                    title: 'Please select a user'
                })
            }

            return false;
        }

        $(function () {
            getInboxList();

            setInterval(function () {
                getInboxList();
            }, 60000);
        });

        function getInboxList() {
            $.ajax({
                type: "POST",
                url: "inbox.aspx/getInboxList",
                data: '',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                global: false,
                success: function (response) {
                    if (response.d.length > 0) {
                        $('#inboxBody').html('');

                        for (i = 0; i < response.d.length; i++) {
                            var html = `<tr>
                                            <td>
                                                <div class="media" onclick="getMessageList(` + response.d[i].fromUserId + `);">
                                                    <a>
                                                        <img class="pull-left profile-image img-circle" alt="user" src="../Images/`+ (response.d[i].fromUserPic == '' ? `User/defaultPic.jpg` : response.d[i].fromUserPic) + `" />
                                                        <div class="media-body" style="text-align: left">
                                                            <b class="text-primary inboxUserName">` + response.d[i].fromUserName + `</b>
                                                        </div>`;
                            if (response.d[i].unreadCount > 0) {
                                html += `<div class="notifications-count">` + response.d[i].unreadCount + `</div>`;
                            }
                            html += `</a>
                                                </div>
                                            </td>
                                        </tr>`
                            $('#inboxBody').append(html);
                        }
                    } else {
                        $('#lblInbox').show();
                    }
                },
                error: function (response) {
                    console.log(response);
                    showErrorMsg();
                },
                failure: function (response) {
                    console.log(response);
                    showErrorMsg();
                }
            });
        }

        function getMessageList(fromUserId) {
            $.ajax({
                type: "POST",
                url: "inbox.aspx/getMessageList",
                data: JSON.stringify({ 'fromUserId': fromUserId }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $('#msgBody').html('');

                    $("#btnSend")[0].onclick = null;

                    for (i = 0; i < response.d.length; i++) {
                        var html = `<tr>
                                            <td>
                                                <div class="media">
                                                    <div class="media-body" style="text-align: left">
                                                        <b class="text-primary"> `+ response.d[i].byUserName + `</b>
                                                        <p class="email-summary">`+ htmlEncode(response.d[i].msgContent) + `</p>
                                                        <span class="media-meta">`+ changDateTimeFormat(response.d[i].createdOn) + `</span>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>`

                        $('#msgBody').append(html);
                    }

                    $("#btnSend").off("click").click(function () { return sendMsg(fromUserId) });

                    $(".messageTable").scrollTop($(".messageTable").prop("scrollHeight"));
                    getInboxList();
                },
                error: function (response) {
                    console.log(response);
                    showErrorMsg();
                },
                failure: function (response) {
                    console.log(response);
                    showErrorMsg();
                }
            });
        }
    </script>
</asp:Content>
