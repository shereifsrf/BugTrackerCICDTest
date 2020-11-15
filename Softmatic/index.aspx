<%@ Page Title="" Language="C#" MasterPageFile="~/BaseFrame.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Softmatic.index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .owl-stage-outer, .owl-stage {
            height: 100%;
        }

        .owl-item {
            height: 85%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bodyContent" runat="server">
    <!--================ Home Banner Area =================-->
    <section class="home_banner_area">
        <input id="currentUserRole" runat="server" hidden />
        <div class="overlay"></div>
        <div class="banner_inner d-flex align-items-center">
            <div class="container">
                <div class="banner_content row">
                    <div class="offset-lg-2 col-lg-8">
                        <a class="main_btn mr-10" href="/pages/userProfile.aspx" id="TitlePageBtnLbl">Report Bugs</a>
                        <a class="main_btn mr-10" href="/pages/bugList.aspx">Browse All Cases</a>
                        <br />
                        <br />
                        <div class="" style="padding-top: 25px;">
                        </div>

                    </div>
                </div>
                


                <div class="row">
                    <%--<div class="col-lg-10">
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="txtSearchText" maxlength="100" placeholder="Search text">
                                    </div>
                                </div>--%>
                    <%--<div class="col-lg-2 text-right">
                                    <button type="submit" value="submit" onclick="return getCampaigns(1, 9);" class="btn submit_btn">Search</button>
                                </div>--%>
                    <div class="col-2"></div>
                    <div class="col-8">
                        
                            <h4 class="h4 text-dark">Main Statitics</h4>
                        <table class="table table-light table-bordered">
                            <thead class="thead-dark">
                                <tr>
                                    <th></th>
                                    <th>All Time</th>
                                    <th><span id="spanMonthName"></span> Month</th>
                                    <th>This Week</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Total Users</td>
                                    <td id="totalUsers"></td>
                                    <td id="monthlyUsers"></td>
                                    <td id="weeklyUsers"></td>
                                </tr>
                                <tr>
                                    <td>Total Reports</td>
                                    <td id="totalReports"></td>
                                    <td id="monthlyReports"></td>
                                    <td id="weeklyReports"></td>
                                </tr>
                                <tr>
                                    <td>Total Resolved</td>
                                    <td id="totalResolved"></td>
                                    <td id="monthlyResolved"></td>
                                    <td id="weeklyResolved"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-2"></div>
                </div>
                
                            <h4 class="h4 text-dark">Developer Statitics</h4>
                <div class="row">

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-4 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col-6 mr-4">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                All Time Best: </div>
                                        </div>
                                        <div class="col-auto">
                                            <span id="bestDeveloperAll"></span>
                                        </div>
                                    </div>
                                    <div class="row no-gutters align-items-center">
                                        <div class="col-6 mr-4">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                Number of Cases: </div>
                                        </div>
                                        <div class="col-auto">
                                            <span id="bestDeveloperAllTotReports"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        
                    

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-4 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col-6 mr-4">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                <span id="spanMonthNameD"></span> Month: </div>
                                        </div>
                                        <div class="col-auto">
                                            <span id="bestDeveloperMonth"></span>
                                        </div>
                                    </div>
                                    <div class="row no-gutters align-items-center">
                                        <div class="col-6 mr-4">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                Number of Cases: </div>
                                        </div>
                                        <div class="col-auto">
                                            <span id="bestDeveloperMonthTotReports"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-4 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col-6 mr-4">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                Current Week: </div>
                                        </div>
                                        <div class="col-auto">
                                            <span id="bestDeveloperWeek"></span>
                                        </div>
                                    </div>
                                    <div class="row no-gutters align-items-center">
                                        <div class="col-6 mr-4">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                Number of Cases: </div>
                                        </div>
                                        <div class="col-auto">
                                            <span id="bestDeveloperWeekTotReports"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                
                
                            <h4 class="h4 text-dark">Reporter Statitics</h4>
                <div class="row">

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-4 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col-6 mr-4">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                All Time Best: </div>
                                        </div>
                                        <div class="col-auto">
                                            <span id="bestReporterAll"></span>
                                        </div>
                                    </div>
                                    <div class="row no-gutters align-items-center">
                                        <div class="col-6 mr-4">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                Number of Cases: </div>
                                        </div>
                                        <div class="col-auto">
                                            <span id="bestReporterAllTotReports"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        
                    

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-4 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col-6 mr-4">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                <span id="spanMonthNameR"></span> Month: </div>
                                        </div>
                                        <div class="col-auto">
                                            <span id="bestReporterMonth"></span>
                                        </div>
                                    </div>
                                    <div class="row no-gutters align-items-center">
                                        <div class="col-6 mr-4">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                Number of Cases: </div>
                                        </div>
                                        <div class="col-auto">
                                            <span id="bestReporterMonthTotReports"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-4 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col-6 mr-4">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                Current Week: </div>
                                        </div>
                                        <div class="col-auto">
                                            <span id="bestReporterWeek"></span>
                                        </div>
                                    </div>
                                    <div class="row no-gutters align-items-center">
                                        <div class="col-6 mr-4">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                Number of Cases: </div>
                                        </div>
                                        <div class="col-auto">
                                            <span id="bestReporterWeekTotReports"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
        </div>
        </div>
    </section>
    <!--================ End Home Banner Area =================-->




</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script2" runat="server">
    <script>


        debugger;
        var role = $("#bodyContent_currentUserRole").val();
        if (role == "dvp") {
            $("#TitlePageBtnLbl").text("Bugs assigned to me");
        }
        else if (role == "rvr") {
            $("#TitlePageBtnLbl").text("My Cases");
        }
        else if (role == "tgi") {
            $("#TitlePageBtnLbl").text("Un-Assigned Cases");
        }

        $(document).ready(function () {
            getTableValues();
        });
        function getTableValues() {
            const monthNames = ["January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"
            ];

            const d = new Date();
            $("#spanMonthName").html(monthNames[d.getMonth()])
            $("#spanMonthNameD").html(monthNames[d.getMonth()])
            $("#spanMonthNameR").html(monthNames[d.getMonth()])

            $.ajax({
                async: true,
                type: "POST",
                url: "/index.aspx/getTableValues",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $('#totalUsers').html(response.d.totalUsers);
                    $('#monthlyUsers').html(response.d.monthlyUsers);
                    $('#weeklyUsers').html(response.d.weeklyUsers);
                    $('#totalReports').html(response.d.totalReports);
                    $('#monthlyReports').html(response.d.monthlyReports);
                    $('#weeklyReports').html(response.d.weeklyReports);
                    $('#totalResolved').html(response.d.totalResolved);
                    $('#monthlyResolved').html(response.d.monthlyResolved);
                    $('#weeklyResolved').html(response.d.weeklyResolved);
                    $('#bestDeveloperAll').html(response.d.bestDeveloperAll);
                    $('#bestDeveloperAllTotReports').html(response.d.bestDeveloperAllTotReports);
                    $('#bestDeveloperMonth').html(response.d.bestDeveloperMonth);
                    $('#bestDeveloperMonthTotReports').html(response.d.bestDeveloperMonthTotReports);
                    $('#bestDeveloperWeek').html(response.d.bestDeveloperWeek);
                    $('#bestDeveloperWeekTotReports').html(response.d.bestDeveloperWeekTotReports);
                    $('#bestReporterAll').html(response.d.bestReporterAll);
                    $('#bestReporterAllTotReports').html(response.d.bestReporterAllTotReports);
                    $('#bestReporterMonth').html(response.d.bestReporterMonth);
                    $('#bestReporterMonthTotReports').html(response.d.bestReporterMonthTotReports);
                    $('#bestReporterWeek').html(response.d.bestReporterWeek);
                    $('#bestReporterWeekTotReports').html(response.d.bestReporterWeekTotReports);
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

    </script>

</asp:Content>
