<%@ Page Title="" Language="C#" MasterPageFile="~/BaseFrame.Master" AutoEventWireup="true" CodeBehind="myCase.aspx.cs" Inherits="Softmatic.pages.userProfile" %>


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
                            <li>
                                <a href="#tab-profile" class="cd-tabs__item cd-tabs__item--selected">
                                    <span>Profile Details</span>
                                </a>
                            </li>
                            <asp:PlaceHolder runat="server" ID="userTabs">
                                <li id="caseTab">
                                    <a href="#tab-case" class="cd-tabs__item">
                                        <span>My Case</span>
                                    </a>
                                </li>
                            </asp:PlaceHolder>
                        </ul>
                        <!-- cd-tabs__list -->
                    </nav>

                    <ul class="cd-tabs__panels">
                        <li id="tab-profile" class="cd-tabs__panel cd-tabs__panel--selected text-component">
                            <%--<i class="fa fa-envelope" id="lnkMsg" style="float:right;" onclick="openMessageDialog($(this).attr('value'))"></i>--%>
                            <form>
                                <div style="text-align: center">
                                    <div class="row">
                                        <div class="col-lg-6 col-md-6">
                                            <div class="mt-10">
                                                <input type="text" id="txtFirstName" name="first_name" maxlength="100" placeholder="First Name" onfocus="this.placeholder = ''" onblur="this.placeholder = 'First Name'"
                                                    required class="single-input">
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-md-6">
                                            <div class="mt-10">
                                                <input type="text" id="txtLastName" name="last_name" maxlength="100" placeholder="Last Name" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Last Name'"
                                                    required class="single-input">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 col-md-6">
                                            <div class="input-group-icon mt-10">
                                                <div class="icon">
                                                    <i class="fas fa-envelope"></i>
                                                </div>
                                                <input type="email" id="txtEmail" disabled name="email" maxlength="200" placeholder="Email" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Email'"
                                                    required class="single-input">
                                            </div>
                                        </div>
                                    </div>
                                    <br />
                                    <div id="userAction">
                                        <button id="btnSave" type="submit" onclick="return saveProfile();" class="primary-btn submit_btn">Save</button>
                                        <button class="primary-btn submit_btn" onclick="return openPasswordDialog();">Update Password</button>
                                    </div>

                                </div>
                            </form>
                        </li>
                        <li id="tab-case" class="cd-tabs__panel text-component">
                            <div id="toolbar">
                                <button id="add" class="btn btn-primary" onclick="openNewBugDialog();">
                                    Report Bug
                                </button>
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
            $('#lnkMsg').attr('value', getUrlParam('userId', 0));

            if (getUrlParam('userId', 0) != 0) {
                $('#imgProfilePic, #txtFirstName, #txtLastName').prop('disabled', true);

                $('#caseTab, #userAction').hide()
            }

            getUserDetails();

            if ($('#caseTab').length > 0) {
                getmyCase();
            }
        })

        function getUserDetails() {
            $.ajax({
                type: "POST",
                url: "userProfile.aspx/getUserDetails",
                data: JSON.stringify({ 'userId': getUrlParam('userId', 0) }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d.email != null) {
                        var user = response.d;
                        $('#txtEmail').val(user.email);
                        $('#txtFirstName').val(user.firstName);
                        $('#txtLastName').val(user.lastName);
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error getting profile details, please try again'
                        })
                    }
                },
                error: function (response) {
                    console.log(response);
                },
                failure: function (response) {
                    console.log(response);
                }
            });
        }

        function getmyCase() {
            $.ajax({
                type: "POST",
                url: "userProfile.aspx/getmyCase",
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

        function saveProfile() {
            if (!$('#txtFirstName')[0].validity.valid || !$('#txtLastName')[0].validity.valid || !$('#txtEmail')[0].validity.valid) {
                return;
            } else {
                console.log(789)
                var firstName = $('#txtFirstName').val(),
                    lastName = $('#txtLastName').val(),
                    email = $('#txtEmail').val()

                var data = {
                    'firstName': firstName, 'lastName': lastName, 'email': email
                };

                $.ajax({
                    type: "POST",
                    async: false,
                    url: "userProfile.aspx/updateUserProfile",
                    data: JSON.stringify(data),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        Swal.fire({
                            icon: response.d.isSuccess ? 'success' : 'error',
                            title: response.d.returnMsg
                        })
                    },
                    error: function (response) {
                        console.log(response);
                    },
                    failure: function (response) {
                        console.log(response);
                    }
                });

            }
            return false;
        }

        function openNewBugDialog(bugId = 0, title = '', description = '') {
            Swal.fire({
                width: 1000,
                title: (title == '' ? 'Report New Bug' : 'Update Bug'),
                html:
                    '<div class="row"> <div class="col-lg-12 col-md-12">' +
                    '<label for="txtTitle">Title</label><br />' +
                    '<input type="text" name="txtTitle" value="' + title + '" id="txtTitle" maxlength="100" style="width: 100%" class="swal2-input" >' +
                    '</div> </div> <div class="row"> <div class="col-lg-4 col-md-4">' +
                    '</div> <div class="col-lg-4 col-md-4">' +
                    '</div> <div class="col-lg-4 col-md-4">' +
                    '</div> </div> <div class="row"> <div class="col-lg-12 col-md-12">' +
                    '<label for="txtDescription">Description</label><br />' +
                    '<textarea name="txtDescription" id="txtDescription" style="height: 300px" class="swal2-textarea">' + description + '</textarea>' +
                    '</div> </div> <div class="row"> <div class="col-lg-12 col-md-12">' +
                    '</div> </div>',
                showCloseButton: true,
                showCancelButton: true,
                focusConfirm: false,
                confirmButtonText: (title == '' ? 'Create' : 'Update'),
                cancelButtonText: 'Cancel',
                showLoaderOnConfirm: true,

                preConfirm: (bug) => {
                    return $.when(validateBug($(Swal.getConfirmButton()).text(), $('#txtTitle').val(), $('#txtDescription').val())).then(function (result) {
                        if (!result.isSuccess) {
                            Swal.showValidationMessage(
                                result.returnMsg
                            )
                        }
                    });
                }
            }).then((result) => {
                if (result.isConfirmed) {
                    if ($(Swal.getConfirmButton()).text() == 'Create') {
                        createBug($('#txtTitle').val(), $('#txtDescription').val());
                    } else {
                        updateBug(bugId, $('#txtTitle').val(), $('#txtDescription').val());
                    }
                }
            })
        }

        function updateBug(bugId, title, description) {
            var data = {
                'bugId': bugId, 'title': title, 'description': description
            };

            $.ajax({
                type: "POST",
                url: 'userProfile.aspx/updateBug',
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    Swal.fire({
                        icon: response.d.isSuccess ? 'success' : 'error',
                        text: response.d.returnMsg
                    });
                    getmyCase();
                },
                error: function (err) {
                    console.log(err);
                }
            });

        }


        function createBug(title, description) {
            var data = {
                'title': title, 'description': description
            };

            $.ajax({
                type: "POST",
                url: 'userProfile.aspx/createBug',
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    Swal.fire({
                        icon: response.d.isSuccess ? 'success' : 'error',
                        text: response.d.returnMsg
                    });
                    getmyCase();
                },
                error: function (err) {
                    console.log(err);
                }
            });


        }

        function validateBug(action, title, description) {
            var result = { 'isSuccess': false, 'returnMsg': 'testing' };

            if (title == "" || description == "") {
                result.returnMsg = "Please fill in all data";
            } else {
                result.isSuccess = true;
            }
            return result;
        }

        function openPasswordDialog() {
            Swal.fire({
                title: 'Update Password',
                html:
                    '<label for="password">New Password</label><br /> <input type="password" name="password" maxlength="100" id="password" style="width: 100%" class= "swal2-input" > <br />' +
                    '<label for="confirmPassword">Confirm Password</label><br />' +
                    '<input type="password" name="confirmPassword" maxlength="100" id="confirmPassword" style="width: 100%" class="swal2-input">',
                showCloseButton: true,
                showCancelButton: true,
                focusConfirm: false,
                confirmButtonText: 'Update',
                cancelButtonText: 'Cancel',
                showLoaderOnConfirm: true,
                preConfirm: (login) => {
                    return $.when(checkPassword($('#password').val(), $('#confirmPassword').val())).then(function (result) {
                        if (!result.isSuccess) {
                            Swal.showValidationMessage(
                                result.returnMsg
                            )
                        }
                    });
                }
            }).then((result) => {
                if (result.isConfirmed) {
                    updateUserPassword();
                }
            });

            return false;
        }

        function checkPassword(password, confirmPassword) {
            var passwordFormat = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;
            var result = { 'isSuccess': true, 'returnMsg': '' };

            if (password == '') {
                result.returnMsg = 'Password cannot be empty, please re-enter!';
                result.isSuccess = false;
                return result;
            }
            else if (password != confirmPassword) {
                result.returnMsg = 'Both password are not the same, please re-enter!';
                result.isSuccess = false;
                return result;
            } else if (!password.match(passwordFormat)) {
                result.returnMsg = 'Password must be at least one upper and lower case English letter, digit and one special character with minimum 8 in length!';
                result.isSuccess = false;
                return result;
            }

            return result;
        }

        function updateUserPassword() {
            var data = { 'password': $("#password").val() };

            $.ajax({
                type: "POST",
                async: false,
                url: "userProfile.aspx/updateUserPassword",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    Swal.fire({
                        icon: response.d.isSuccess ? 'success' : 'error',
                        title: response.d.returnMsg
                    })
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
