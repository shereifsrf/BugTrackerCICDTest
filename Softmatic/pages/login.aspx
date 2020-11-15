<%@ Page Title="" Language="C#" MasterPageFile="~/BaseFrame.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Softmatic.pages.login" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="server">
    <script>document.getElementsByTagName("html")[0].className += " js";</script>
    <link rel="stylesheet" href="../css/tabNav.css">
    <style>
        .cd-tabs__list {
            width: 100%;
        }

            .cd-tabs__list li {
                width: 50%;
            }

        .login-form {
            text-align: center;
        }


            .login-form .email {
                padding-right: 0px;
            }

        @media (max-width: 991px) {
            .login-form .email {
                padding-left: 0px;
            }
        }

        .login-form .form-control {
            padding: 8px 20px;
            background: #fff;
            border: none;
            border-radius: 0px;
            width: 100%;
            font-size: 14px;
            color: #777777;
            border: 1px solid;
        }

            .login-form .form-control:focus {
                box-shadow: none;
                border: 1px solid #eee;
            }

        body {
            padding-bottom: 0;
        }

        .forgotPassword:hover {
            color: dodgerblue;
            cursor: pointer;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bodyContent" runat="server">

    <!--================End Home Banner Area =================-->

    <div class="container">
        <div class="login-form row">
            <div class="col-lg-2 col-md-2">
            </div>
            <div class="col-lg-8 col-md-8">
                <div class="row">
                    <div class="cd-tabs cd-tabs--vertical container max-width-md margin-top-xl margin-bottom-lg js-cd-tabs">
                        <nav class="cd-tabs__navigation">
                            <ul class="cd-tabs__list">
                                <li>
                                    <a href="#tab-login" class="cd-tabs__item cd-tabs__item--selected">
                                        <span>Login</span>
                                    </a>
                                </li>

                                <li>
                                    <a href="#tab-register" class="cd-tabs__item">
                                        <span>Register</span>
                                    </a>
                                </li>
                                <!-- cd-tabs__list -->
                            </ul>
                        </nav>

                        <ul class="cd-tabs__panels">
                            <li id="tab-login" class="cd-tabs__panel cd-tabs__panel--selected text-component">
                                <form id="loginForm" method="post">
                                    <div class="input-group-icon mt-10">
                                        <div class="icon">
                                            <i class="fas fa-envelope"></i>
                                        </div>
                                        <input type="email" id="loginEmail" name="email" placeholder="Email" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Email'"
                                            required class="single-input">
                                    </div>
                                    <div class="input-group-icon mt-10">
                                        <div class="icon">
                                            <i class="fas fa-key"></i>
                                        </div>
                                        <input type="password" id="loginPassword" name="password" placeholder="Password" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Password'"
                                            required class="single-input">
                                    </div>
                                    <br />
                                    <br />
                                    <button id="btnLogin" onclick="return login();" class="primary-btn submit_btn">Login</button>
                                </form>
                            </li>

                            <li id="tab-register" class="cd-tabs__panel text-component">
                                <form id="registerForm" method="post">
                                    <div class="mt-10">
                                        <input type="text" id="txtFirstName" name="first_name" maxlength="100" placeholder="First Name" onfocus="this.placeholder = ''" onblur="this.placeholder = 'First Name'"
                                            required class="single-input">
                                    </div>
                                    <div class="mt-10">
                                        <input type="text" id="txtLastName" name="last_name" maxlength="100" placeholder="Last Name" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Last Name'"
                                            required class="single-input">
                                    </div>
                                    <div class="input-group-icon mt-10">
                                        <div class="icon">
                                            <i class="fas fa-envelope"></i>
                                        </div>
                                        <input type="email" id="txtRegisterEmail" name="email" maxlength="200" placeholder="Email" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Email'"
                                            required class="single-input">
                                    </div>
                                    <div class="input-group-icon mt-10">
                                        <div class="icon">
                                            <i class="fas fa-key"></i>
                                        </div>
                                        <input type="password" id="txtRegisterPassword" name="registerPassword" maxlength="100" placeholder="Password" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Password'" pattern="^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$" title="Password must be at least one upper and lower case English letter, digit and one special character with minimum 8 in length"
                                            required class="single-input">
                                    </div>
                                    <div class="input-group-icon mt-10">
                                        <div class="icon">
                                            <i class="fas fa-key"></i>
                                        </div>
                                        <input type="password" id="txtConfirmPassword" oninput="setPasswordConfirmValidity()" name="confirmPassword" maxlength="100" placeholder="Confirm Password" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Confirm Password'"
                                            required class="single-input">
                                    </div>
                                    <div class="input-group-icon mt-10">
                                        <div class="icon">
                                            <i class="fas fa-globe-asia"></i>
                                        </div>
                                        <select id="ddlRole" name="role" required class="single-input" hidden>
                                            <option value="">-- Please Select Role --</option>
                                        </select>
                                    </div>
                                    <br />
                                    <div style="display: inline-block" id="google_recaptcha"></div>
                                    <br />
                                    <button id="btnRegister" onclick="return register();" class="primary-btn submit_btn">Register</button>
                                </form>
                            </li>
                        </ul>
                        <!-- cd-tabs__panels -->
                    </div>
                    <!-- cd-tabs -->
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script2" runat="server">
    <script src="../js/tabUtil.js"></script>
    <!-- util functions included in the CodyHouse framework -->
    <script src="../js/tabMain.js"></script>
    <script>
        $(function () {

            getRoleList();
        })

        function setPasswordConfirmValidity() {
            var result = checkPassword($('#txtRegisterPassword').val(), $('#txtConfirmPassword').val());
            $('#txtConfirmPassword')[0].setCustomValidity(result.returnMsg);
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

        function getRoleList() {
            $.ajax({
                type: "POST",
                url: "../Common.asmx/getLookupList",
                data: JSON.stringify({ 'category': 'role' }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    for (i = 0; i < response.d.length; i++) {
                        $('#ddlRole').append('<option value="' + response.d[i].key + '">' + response.d[i].value + '</option>');
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

        function login() {
            if (!$('#loginEmail')[0].validity.valid || !$('#loginPassword')[0].validity.valid) {
                return;
            } else {
                var loginEmail = $('#loginEmail').val(),
                    loginPassword = $('#loginPassword').val();

                var data = { 'email': loginEmail, 'password': loginPassword };

                $.ajax({
                    type: "POST",
                    url: "login.aspx/userLogin",
                    data: JSON.stringify(data),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d.isSuccess) {
                            window.location.href = '../index.aspx'
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Oops...',
                                text: response.d.returnMsg
                            })
                        }
                    },
                    error: function (response) {
                        console.log(response);
                        showErrorMsg();
                    },
                    failure: function (response) {
                        console.log(response);
                        showErrorMsg()
                    }
                });

                return false;
            }
        }

        function clearRegisterForm() {
            $('#txtFirstName').val('');
            $('#txtLastName').val('');
            $('#txtRegisterEmail').val('');
            $('#ddlRole').val('');
            $('#txtRegisterPassword').val('');
            $('#txtConfirmPassword').val('');
        }

        function register() {
            if (!$('#txtFirstName')[0].validity.valid || !$('#txtLastName')[0].validity.valid || !$('#txtRegisterEmail')[0].validity.valid  || !$('#txtRegisterPassword')[0].validity.valid || !$('#txtConfirmPassword')[0].validity.valid) {
                return;
            } else {
                var firstName = $('#txtFirstName').val(),
                    lastName = $('#txtLastName').val(),
                    email = $('#txtRegisterEmail').val(),
                    role = $('#ddlRole').val(),
                    password = $('#txtRegisterPassword').val();

                var data = {
                    'firstName': firstName, 'lastName': lastName, 'email': email,
                    'role': role, 'password': password
                };


                $.ajax({
                    type: "POST",
                    url: "login.aspx/addNewUser",
                    data: JSON.stringify(data),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        Swal.fire({
                            icon: response.d.isSuccess ? 'success' : 'error',
                            text: response.d.returnMsg
                        })
                        if (response.d.isSuccess) {
                            clearRegisterForm();
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

                return false;
            }
        }
    </script>
</asp:Content>
