<%@ Page Title="" Language="C#" MasterPageFile="~/BaseFrame.Master" AutoEventWireup="true" CodeBehind="aboutUs.aspx.cs" Inherits="Softmatic.pages.aboutUs" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bodyContent" runat="server">
    <!--================ Banner Area =================-->
    <section class="banner_area">
        <div class="banner_inner d-flex align-items-center">
            <div class="overlay"></div>
            <div class="container">
                <div class="banner_content text-center">
                    <h2>About Us</h2>
                    <div class="page_link">
                        <a href="../index.aspx">Home</a>
                        <a href="./aboutUs.aspx">About Us</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--================End Banner Area =================-->

    <!--================ Start About Us Section =================-->
    <section class="about_us section_gap">
        <img src="../img/vision.png" alt="" style="width: 100%;" />
        <br />
        <br />
        <div class="container">
            <div class="row justify-content-center section-title-wrap">
                <div style="width: 80%">
                    <h1 style="color: #ea2c58">Why Give With Us?</h1>
                    <br />
                    <h2>1) Safe and Secure</h2>
                    <p>
                        We take online security seriously. Your information is kept safe and secure by using a top-of-the-line ISO27001 security certified data centre, and we are always reviewing our safety measurements.
                    </p>
                    <br />
                    <br />
                    <h2>2) 100% committed to doing good</h2>
                    <p>
                        Giving is not just about making a donation. It is about making a diffrence. 100% donation goes towards your chosen charity.
                    </p>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script2" runat="server">
</asp:Content>
