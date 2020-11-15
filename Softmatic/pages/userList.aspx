<%@ Page Title="" Language="C#" MasterPageFile="~/BaseFrame.Master" AutoEventWireup="true" CodeBehind="userList.aspx.cs" Inherits="Softmatic.pages.userList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="server">
    <style>
        body {
            padding-bottom: 0;
        }

        .profile-image1 {
            border: 2px solid #03b1ce;
        }

        .img-circle {
            border-radius: 50%;
            height: 150px;
            width: 150px;
            object-fit: cover;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bodyContent" runat="server">
    <!--================ Banner Area =================-->
    <section class="banner_area" style="min-height: 370px;">
        <div class="banner_inner d-flex align-items-center" style="min-height: 370px;">
            <div class="overlay"></div>
            <div class="container">
                <div class="banner_content text-center">
                    <h2>User Management</h2>
                    <div class="page_link">
                        <a href="../index.aspx">Home</a>
                        <a href="./userList.aspx">User Management</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--================End Banner Area =================-->
    <div class="row">
        <div class="col-lg-1 col-md-1">
        </div>
        <div class="col-lg-10 col-md-10">
            <div id="toolbar">
                <button id="add" class="btn btn-primary" onclick="openNewUserDialog();">
                    Add User
                </button>
            </div>
            <table
                id="userList"
                data-toolbar="#toolbar"
                data-search="true"
                data-show-refresh="true"
                data-show-toggle="true"
                data-show-fullscreen="true"
                data-show-columns="true"
                data-show-columns-toggle-all="true"
                data-show-export="true"
                data-click-to-select="true"
                data-minimum-count-columns="2"
                data-show-pagination-switch="true"
                data-detail-formatter="userDetailFormatter"
                data-pagination="true"
                data-detail-view="true"
                data-id-field="userId"
                data-page-list="[10, 25, 50, 100, all]"
                data-side-pagination="client"
                data-response-handler="responseHandler">
            </table>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script2" runat="server">
    <link href="https://unpkg.com/bootstrap-table@1.16.0/dist/bootstrap-table.min.css" rel="stylesheet">

    <script src="https://unpkg.com/tableexport.jquery.plugin/tableExport.min.js"></script>
    <script src="https://unpkg.com/bootstrap-table@1.16.0/dist/bootstrap-table.min.js"></script>
    <script src="https://unpkg.com/bootstrap-table@1.16.0/dist/bootstrap-table-locale-all.min.js"></script>
    <script src="https://unpkg.com/bootstrap-table@1.16.0/dist/extensions/export/bootstrap-table-export.min.js"></script>

    <script>
        var selections = [];

        window.userEvents = {
            'click .activate': function (e, value, row, index) {
                UpdateRole(row.userId, true);

            },
            'click .deactivate': function (e, value, row, index) {
                UpdateRole(row.userId, false);
            }
        }

        var userColumns = [{
            field: 'firstName',
            title: 'First Name',
            sortable: true,
            align: 'center'
        }, {
            field: 'lastName',
            title: 'Last Name',
            sortable: true,
            align: 'center'
        }, {
            field: 'email',
            title: 'Email',
            sortable: true,
            align: 'center'
        }, {
            field: 'createdOn',
            title: 'Create Date',
            sortable: true,
            align: 'center',
            formatter: dateTimeFormatter
        }, {
            field: 'role',
            title: 'Role',
            sortable: true,
            align: 'center'
        }, {
            field: 'status',
            title: 'Status',
            sortable: true,
            align: 'center',
            formatter: statusFormatter
        }, {
            field: 'operate',
            title: 'Action',
            align: 'center',
            clickToSelect: false,
            events: window.userEvents,
            formatter: operateFormatter
        }]

        $(function () {
            initTable('#userList', userColumns, [], 'getUserList()');
            getUserList();
        })

        function validateUser(firstName, lastName, email, role, password, confirmPassword) {
            var result = { 'isSuccess': false, 'returnMsg': 'Please fill in all field' };

            var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

            if (!re.test(email)) {
                result.returnMsg = 'Invalid email address'
                return result;
            }

            var pwdValid = checkPassword(password, confirmPassword);

            if (!pwdValid.isSuccess) {
                result.returnMsg = pwdValid.returnMsg;
                return result;
            }

            if (firstName != '' || lastName != '' || email != '' || role != '') {
                result.isSuccess = true;
                result.returnMsg = '';

                return result;
            }

            return result;
        }

        function generatePassword() {
            var length = 8,
                charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-={}|[]\~`<>?,./",
                retVal = "";
            for (var i = 0, n = charset.length; i < length; ++i) {
                retVal += charset.charAt(Math.floor(Math.random() * n));
            }

            return retVal;
        }

        function addNewUser(firstName, lastName, email, role, password) {
            var data = { 'firstName': firstName, 'lastName': lastName, 'email': email, 'role': role, 'password': password };

            $.ajax({
                type: "POST",
                async: false,
                url: "userList.aspx/addNewUser",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    Swal.fire({
                        icon: response.d.isSuccess ? 'success' : 'error',
                        title: response.d.returnMsg
                    });
                    getUserList();
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

        function assignRoleSubmit(role, userId) {
            var data = { 'role': role, 'userid': userId };
            debugger;
            $.ajax({
                type: "POST",
                async: false,
                url: "userList.aspx/AssignRole",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    Swal.fire({
                        icon: response.d.isSuccess ? 'success' : 'error',
                        title: response.d.returnMsg
                    });
                    getUserList();
                },
                error: function (response) {
                    alert(response);
                    console.log(response);
                    showErrorMsg();
                },
                failure: function (response) {
                    alert(response);

                    console.log(response);
                    showErrorMsg();
                }
            });
        }

        function updateUserStatus(userId, status) {
            var data = { 'userId': userId, 'isActive': status };

            $.ajax({
                type: "POST",
                async: false,
                url: "userList.aspx/updateUserStatus",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    Swal.fire({
                        icon: response.d.isSuccess ? 'success' : 'error',
                        title: response.d.returnMsg
                    })
                    getUserList();
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

        function UpdateRole(userId, status) {
            assignRoleModal(userId, status);
        }

        function getUserList() {
            $.ajax({
                type: "POST",
                url: "userList.aspx/getUserList",
                data: '',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    initTable('#userList', userColumns, response.d, 'getUserList()');
                },
                error: function (response) {
                    console.log(response)
                    showErrorMsg()
                },
                failure: function (response) {
                    console.log(response)
                    showErrorMsg()
                }
            });
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

        function openNewUserDialog() {
            Swal.fire({
                width: 1000,
                title: 'Create New User',
                html:
                    '<div class="row"> <div class="col-lg-6 col-md-6">' +
                    '<label for="txtFirstName">First Name</label><br />' +
                    '<input type="text" name="txtFirstName" id="txtFirstName" maxlength="100" style="width: 100%" class="swal2-input" >' +

                    '</div> <div class="col-lg-6 col-md-6">' +
                    '<label for="txtLastName">Last Name</label><br />' +
                    '<input type="text" name="txtLastName" id="txtLastName" maxlength="100" style="width: 100%" class="swal2-input" >' +

                    '</div> <div class="col-lg-4 col-md-4">' +
                    '<label for="txtEmail">Email</label><br />' +
                    '<input type="email" name="txtEmail" id="txtEmail" maxlength="200" style="width: 100%" class="swal2-input">' +

                    '</div> <div class="col-lg-4 col-md-4">' +
                    '<label for="ddlRole">Role</label><br />' +
                    '<select id="ddlRole" name="ddlRole" required style="width: 100%" class="swal2-input"> <option value="" >-- Please Select Role --</option >' +
                    '<option value="dvp" >Developer</option >' +
                    '<option value="rvr" >Reviewer</option >' +
                    '<option value="tgi" >Taiger</option >  </select >' +

                    '</div> </div> <div class="row"> <div class="col-lg-6 col-md-6">' +
                    '<label for="txtPassword">Password</label><br />' +
                    '<input type="password" name="txtPassword" id="txtPassword" maxlength="100" style="width: 100%" class="swal2-input" >' +
                    '</div> <div class="col-lg-6 col-md-6">' +
                    '<label for="txtConfirmPassword">Confirm Password</label><br />' +
                    '<input type="password" name="txtConfirmPassword" id="txtConfirmPassword" maxlength="100" style="width: 100%" class="swal2-input" >' +
                    '</div> </div>',
                showCloseButton: true,
                showCancelButton: true,
                focusConfirm: false,
                confirmButtonText: 'Create',
                cancelButtonText: 'Cancel',
                showLoaderOnConfirm: true,
                onOpen: function () {

                },
                preConfirm: (user) => {
                    return $.when(validateUser($('#txtFirstName').val(), $('#txtLastName').val(), $('#txtEmail').val(), $('#ddlRole').val(), $('#txtPassword').val(), $('#txtConfirmPassword').val())).then(function (result) {
                        if (!result.isSuccess) {
                            Swal.showValidationMessage(
                                result.returnMsg
                            )
                        }
                    });
                }
            }).then((result) => {
                if (result.isConfirmed) {
                    addNewUser($('#txtFirstName').val(), $('#txtLastName').val(), $('#txtEmail').val(), $('#ddlRole').val(), $('#txtPassword').val());
                }
            })
        }

        function assignRoleModal(userId) {
            Swal.fire({
                width: 500,
                title: 'Assign Role',
                html:
                    '<div class="row"> '+

                    '</div> <div class="col-lg-12 col-md-12">' +
                    '<label for="ddlRoleAssign">Role</label><br />' +
                    '<select id="ddlRoleAssign" name="ddlRole" required style="width: 100%" class="swal2-input"> <option value="" >-- Please Select Role --</option >' +
                    '<option value="unassigned" >Un-assigned</option >' +
                    '<option value="dvp" >Developer</option >' +
                    '<option value="rvr" >Reviewer</option >' +
                    '<option value="rpt" >Reporter</option >' +
                    '<option value="tgi" >Taiger</option >  </select >' +
                    '</div> </div>',
                showCloseButton: true,
                showCancelButton: true,
                focusConfirm: false,
                confirmButtonText: 'Assign',
                cancelButtonText: 'Cancel',
                showLoaderOnConfirm: true,
                onOpen: function () {
                },
                preConfirm: (user) => {
                    if ($('#ddlRoleAssign').val() == '') {
                        return false;
                    }
                    else {
                        return true;
                    }
                }
            }).then((result) => {
                if (result.isConfirmed) {
                    assignRoleSubmit($('#ddlRoleAssign').val(), userId);
                }
            })
        }


        function initTable(tableId, columns, data, dataFunction) {
            $(tableId).bootstrapTable('destroy').bootstrapTable({
                exportTypes: ['csv', 'txt', 'excel'],
                locale: 'en-US',
                columns: columns,
                data: data
            });

            $(tableId).on('all.bs.table', function (e, name, args) {
                if (name == "refresh.bs.table") {
                    eval(dataFunction);
                }
            });
        }


        function operateFormatter(value, row, index) {
            var actionOptions = [];

            if (row.status == 'True') {
                actionOptions.push('<a class="deactivate" href="javascript:void(0)" title="Deactivate"> <i class="fa fa-times-circle"></i> </a>&nbsp;');
            } else {
                actionOptions.push('<a class="activate" href="javascript:void(0)" title="Activate"> <i class="fa fa-check-circle"></i> </a>&nbsp;');
            }

            return actionOptions.join('')
        }

        function dateTimeFormatter(data) {
            return changeDateFormat(data);
        }

        function statusFormatter(data) {
            return (data == 'True' ? 'Active' : 'Inactive');
        }


    </script>
</asp:Content>
