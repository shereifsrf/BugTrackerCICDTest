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
        <div class="overlay"></div>
        <div class="banner_inner d-flex align-items-center">
            <div class="container">
                <div class="banner_content row">
                    <div class="offset-lg-2 col-lg-8">



                        <a class="main_btn mr-10" href="/pages/userProfile.aspx">Report Bugs</a>
                        <a class="main_btn mr-10" href="/pages/bugList.aspx">Browse</a>
                        <br />
                        <br />
                        <div class="container" style="padding-top: 25px;">
                            <div class="row">
                                <div class="col-lg-10">
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="txtSearchText" maxlength="100" placeholder="Search text">
                                    </div>
                                </div>
                                <div class="col-lg-2 text-right">
                                    <button type="submit" value="submit" onclick="return getCampaigns(1, 9);" class="btn submit_btn">Search</button>
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
