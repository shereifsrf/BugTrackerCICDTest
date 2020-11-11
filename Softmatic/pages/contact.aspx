<%@ Page Title="" Language="C#" MasterPageFile="~/BaseFrame.Master" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="Softmatic.pages.contact" %>


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
                    <h2>Contact Us</h2>
                    <div class="page_link">
                        <a href="../index.aspx">Home</a>
                        <a href="./contactUs.aspx">Contact Us</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--================End Banner Area =================-->

    <!--================Contact Area =================-->
    <section class="contact_area p_120">
        <div class="container">
            <div id="mapBox" style="z-index: 98" class="mapBox">
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <div class="contact_info">
                        <div class="info_item">
                            <i class="lnr lnr-home"></i>
                            <h6>Singapore</h6>
                            <p>461 Clementi Rd, Singapore 599491</p>
                        </div>
                        <div class="info_item">
                            <i class="lnr lnr-phone-handset"></i>
                            <h6>
                                <a href="#">+65 6248 9746</a>
                            </h6>
                            <p>Mon to Fri 9am to 6pm</p>
                        </div>
                        <div class="info_item">
                            <i class="lnr lnr-envelope"></i>
                            <h6>
                                <a href="#">fundsomething.softmatic@gmail.com</a>
                            </h6>
                            <p>Send us your query anytime!</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-8">
                    <form>
                        <div class="row contact_form" id="contactForm">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <input type="text" class="form-control" id="name" required maxlength="100" name="name" placeholder="Enter your name">
                                </div>
                                <div class="form-group">
                                    <input type="email" class="form-control" id="email" required maxlength="100" name="email" placeholder="Enter email address">
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control" id="subject" required maxlength="100" name="subject" placeholder="Enter Subject">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <textarea class="form-control" name="message" required id="message" maxlength="300" rows="5" placeholder="Enter Message"></textarea>
                                </div>
                            </div>
                            <div class="col-md-12 text-right">
                                <button type="submit" value="submit" onclick="return submitContactUsForm();" class="btn submit_btn">Send Message</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
    <!--================Contact Area =================-->
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script2" runat="server">
    <script>
        $(function () {

        });

        function submitContactUsForm() {
            if (!$('#email')[0].validity.valid || !$('#name')[0].validity.valid || !$('#subject')[0].validity.valid || !$('#message')[0].validity.valid) {
                return;
            }

            var html = `
            <table style="border-collapse: collapse; margin: auto; max-width: 700px; min-width: 320px; background: #f5f5f5; width: 100%;">
        <tbody>
            <tr>
                <td style="padding: 0px 20px;" valign="top">
                    <table style="border-collapse: collapse; color: #545454; font-family: 'Helvetica Neue', Arial, sans-serif; font-size: 13px; line-height: 20px; margin: 0 auto; max-width: 100%; width: 100%;"
                           cellspacing="0"
                           cellpadding="0"
                           border="0"
                           align="center">
                        <tbody>
                            <tr>
                                <td style="padding: 0 20px; text-align: center; height: 90px;">
                                    <img src="cid:logo.png"
                                         style="vertical-align: middle;"
                                         class="CToWUd" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <table style="background-clip: padding-box; border-collapse: collapse; color: #545454; font-family: 'Helvetica Neue', Arial, sans-serif; font-size: 13px; line-height: 20px; margin: 0 auto; width: 100%;"
                           cellspacing="0"
                           cellpadding="0"
                           border="0"
                           align="center">
                        <tbody>
                            <tr>
                                <td valign="top">
                                    <table style="background-clip: padding-box; border-collapse: separate; width: 100%; background: #fff; border-radius: 3px; padding-bottom: 20px;" cellspacing="0" cellpadding="0" border="0">
                                        <tbody>
                                            <tr>
                                                <td style="background-clip: padding-box; color: #545454; font-family: 'Helvetica Neue', Arial, sans-serif; font-size: 14px; line-height: 20px; overflow: hidden; padding: 15px 20px;" colspan="3">
                                                    <p style="margin: 10px 0; font-size: 20px; text-align: center;">
                                                        Contact us form submitted by `+ $('#name').val() + `
                                                    </p>
                                                    <div style="width: 100%; height: 1px; background: #e4e4e4; margin: 20px 0;"></div>
                                                    <p style="margin: 5px 0; text-align: center;">
                                                        Form submitted on `+ new Date() + `
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding: 5px 5px 5px 20px; text-align: right; vertical-align: top; width: 20%; min-width: 60px;">
                                                    Name
                                                </td>
                                                <td style="width: 5%; min-width: 20px; text-align: center; vertical-align: top; padding: 5px 0;">&nbsp;:&nbsp;</td>
                                                <td style="overflow: hidden; padding: 5px 20px 5px 5px; width: 80%; vertical-align: top;">
                                                    `+ $('#name').val() + `
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding: 5px 5px 5px 20px; text-align: right; vertical-align: top; width: 20%; min-width: 60px;">
                                                    Email
                                                </td>
                                                <td style="width: 5%; min-width: 20px; text-align: center; vertical-align: top; padding: 5px 0;">&nbsp;:&nbsp;</td>
                                                <td style="overflow: hidden; padding: 5px 20px 5px 5px; width: 80%; vertical-align: top;">
                                                    <a href="mailto:`+ $('#email').val() + `" target="_blank">` + $('#email').val() + `</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding: 5px 5px 5px 20px; text-align: right; vertical-align: top; width: 20%; min-width: 60px;">
                                                    Message
                                                </td>
                                                <td style="width: 5%; min-width: 20px; text-align: center; vertical-align: top; padding: 5px 0;">&nbsp;:&nbsp;</td>
                                                <td style="overflow: hidden; padding: 5px 20px 5px 5px; width: 80%; vertical-align: top;">
                                                    `+ $('#message').val() + `
                                                </td >
                                            </tr >
                                        </tbody >
                                    </table >
                                </td >
                            </tr >
                        </tbody >
                    </table >
                <table style="border-collapse: collapse; color: #545454; font-family: 'Helvetica Neue', Arial, sans-serif; font-size: 13px; line-height: 20px; margin: 0 auto; max-width: 100%; width: 100%;"
                    cellspacing="0"
                    cellpadding="0"
                    border="0"
                    align="center">
                    <tbody>
                        <tr>
                            <td style="padding: 20px; color: #8b8b8b; text-align: center;">
                                <p style="margin: 6px 0 0;">This is an auto generated message, if you wish to add on to the current enquiry, kindly reply to this email.</p>
                            </td>
                        </tr>
                    </tbody>
                </table>
                </td >
            </tr >
        </tbody >
    </table >`;

            var data = { 'subject': $('#subject').val(), 'content': html, 'toEmail': $('#email').val() };

            $.ajax({
                type: "POST",
                url: "contact.aspx/submitContactUsForm",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    Swal.fire({
                        icon: response.d.isSuccess ? 'success' : 'error',
                        title: response.d.returnMsg
                    })

                    $('#subject').val('');
                    $('#name').val('');
                    $('#email').val('');
                    $('#message').val('');
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
