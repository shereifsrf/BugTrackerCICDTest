<%@ Page Title="" Language="C#" MasterPageFile="~/BaseFrame.Master" AutoEventWireup="true" CodeBehind="faq.aspx.cs" Inherits="Softmatic.pages.aboutUs" %>


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
                    <h2>FAQ</h2>
                    <div class="page_link">
                        <a href="../index.aspx">Home</a>
                        <a href="./faq.aspx">FAQ</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--================End Banner Area =================-->

    <!--================ Start About Us Section =================-->
    <section class="about_us section_gap">
        <!--Accordion wrapper-->
        <div class="accordion md-accordion" id="accordionEx1" role="tablist" aria-multiselectable="true" style="width: 50%; margin: 0 auto;">

            <!-- Accordion card -->
            <div class="card">

                <!-- Card header -->
                <div class="card-header" role="tab" id="headingTwo1">
                    <a class="collapsed" data-toggle="collapse" data-parent="#accordionEx1" href="#collapseTwo1"
                        aria-expanded="false" aria-controls="collapseTwo1">
                        <h5 class="mb-0">What is FundSomething?  <i class="fas fa-angle-down rotate-icon"></i>
                        </h5>
                    </a>
                </div>

                <!-- Card body -->
                <div id="collapseTwo1" class="collapse" role="tabpanel" aria-labelledby="headingTwo1"
                    data-parent="#accordionEx1">
                    <div class="card-body">
                        FundSomething is a platform that gather donors and fundraisers with the purposeful goal of achieving the targeted donation to ease 
the fundraiser’s liabilities on their children’s hefty medical expenses. 

FundSomething’s platform is a safe and secure integrated giving platform that is committed in ensuring the utmost security, assurring donors whom are utilizing the platform.
                    </div>
                </div>

            </div>
            <!-- Accordion card -->

            <!-- Accordion card -->
            <div class="card">

                <!-- Card header -->
                <div class="card-header" role="tab" id="headingTwo2">
                    <a class="collapsed" data-toggle="collapse" data-parent="#accordionEx1" href="#collapseTwo21"
                        aria-expanded="false" aria-controls="collapseTwo21">
                        <h5 class="mb-0">Do i need to create an account to be a donor or fundraise?  <i class="fas fa-angle-down rotate-icon"></i>
                        </h5>
                    </a>
                </div>

                <!-- Card body -->
                <div id="collapseTwo21" class="collapse" role="tabpanel" aria-labelledby="headingTwo21"
                    data-parent="#accordionEx1">
                    <div class="card-body">
                        Yes, you do need to sign up for an account with us at FundSomething- then you can choose to donate or fundraise.
                    </div>

                </div>
                <!-- Accordion card -->

                <!-- Accordion card -->
                <div class="card">

                    <!-- Card header -->
                    <div class="card-header" role="tab" id="headingThree31">
                        <a class="collapsed" data-toggle="collapse" data-parent="#accordionEx1" href="#collapseThree31"
                            aria-expanded="false" aria-controls="collapseThree31">
                            <h5 class="mb-0">How do i know the campaign i am supporting on FundSomething is not a scam?  <i class="fas fa-angle-down rotate-icon"></i>
                            </h5>
                        </a>
                    </div>

                    <!-- Card body -->
                    <div id="collapseThree31" class="collapse" role="tabpanel" aria-labelledby="headingThree31"
                        data-parent="#accordionEx1">
                        <div class="card-body">
                            Every campaign listed on FundSomething is subject to strict verification. We owe that due diligence to our donors.

                The procedure includes home visits, checking records such as utilities &/or hospital bills, CPF and bank statements to recognize the financial condition, and consulting with social workers and officials to know the scope of the aid already offered and the void that needs to be resolved.

                        </div>
                    </div>

                </div>
                <!-- Accordion card -->

                <!-- Accordion card -->
                <div class="card">

                    <!-- Card header -->
                    <div class="card-header" role="tab" id="headingFour41">
                        <a class="collapsed" data-toggle="collapse" data-parent="#accordionEx1" href="#collapseFour41"
                            aria-expanded="false" aria-controls="collapseFour41">
                            <h5 class="mb-0">Can i cancel my donation?  <i class="fas fa-angle-down rotate-icon"></i>
                            </h5>
                        </a>
                    </div>

                    <!-- Card body -->
                    <div id="collapseFour41" class="collapse" role="tabpanel" aria-labelledby="headingFour41"
                        data-parent="#accordionEx1">
                        <div class="card-body">
                            Please note that all donations made are non-refundable.
                        </div>
                    </div>

                </div>
                <!-- Accordion card -->


                <!-- Accordion card -->
                <div class="card">

                    <!-- Card header -->
                    <div class="card-header" role="tab" id="headingSix61">
                        <a class="collapsed" data-toggle="collapse" data-parent="#accordionEx1" href="#collapseSix61"
                            aria-expanded="false" aria-controls="collapseSix61">
                            <h5 class="mb-0">I am concerned about general risk related to donation made via the platform. Can you highlight some of the associated risk that i should be aware of? <i class="fas fa-angle-down rotate-icon"></i>
                            </h5>
                        </a>
                    </div>

                    <!-- Card body -->
                    <div id="collapseSix61" class="collapse" role="tabpanel" aria-labelledby="headingFour41"
                        data-parent="#accordionEx1">
                        <div class="card-body">
                             FundSomething takes all necessary steps to ensure safe and secure giving.
Please be assured that every care has been taken at our end to address potential risks. We subscribe to The Code of Practice for Charitable Online Fund-Raising Appeals issued by the Commissioner of Charities and liaise closely with the COC’s Office to ensure that our systems and processes are in accordance with the Code.
                        </div>
                    </div>

                </div>
                <!-- Accordion card -->

                <!-- Accordion card -->
                <div class="card">

                    <!-- Card header -->
                    <div class="card-header" role="tab" id="headingSeven71">
                        <a class="collapsed" data-toggle="collapse" data-parent="#accordionEx1" href="#collapseSeven71"
                            aria-expanded="false" aria-controls="collapseSeven71">
                            <h5 class="mb-0">How can i be a fundraiser? <i class="fas fa-angle-down rotate-icon"></i>
                            </h5>
                        </a>
                    </div>

                    <!-- Card body -->
                    <div id="collapseSeven71" class="collapse" role="tabpanel" aria-labelledby="headingFour41"
                        data-parent="#accordionEx1">
                        <div class="card-body">
                            Is your family going through a difficult period and require urgent and immediate assistance? 
							
								- Have a household income of $1,900 and below, or a per capita household income of $650 and below; and
								- At least one immediate family member in the same household must be a Singapore Citizen
								- Disclosure of clear and accurate information to donors about the beneficiary
								- Purpose of the donation and how you will be utilizeds
                        </div>
                    </div>

                </div>
                <!-- Accordion card -->

                <!-- Accordion card -->
                <div class="card">

                    <!-- Card header -->
                    <div class="card-header" role="tab" id="headingEight1">
                        <a class="collapsed" data-toggle="collapse" data-parent="#accordionEx1" href="#collapseEight1"
                            aria-expanded="false" aria-controls="collapseEight1">
                            <h5 class="mb-0">I want to raise funds. How do i get started? <i class="fas fa-angle-down rotate-icon"></i>
                            </h5>
                        </a>
                    </div>

                    <!-- Card body -->
                    <div id="collapseEight1" class="collapse" role="tabpanel" aria-labelledby="headingFour41"
                        data-parent="#accordionEx1">
                        <div class="card-body">
                            Login your account and launch your campaign. You are required to tell a detailed story by adding a personal touch to the story through photos and videos, starting with a realistic fundraising target, and running your campaign for a fixed period of time (i.e. one month) to the urgency of potential donors. 

							You can share your campaign using your social media to reach out more supporters.
                        </div>
                    </div>

                </div>
                <!-- Accordion card -->



                <!-- Accordion card -->
                <div class="card">

                    <!-- Card header -->
                    <div class="card-header" role="tab" id="headingTen1">
                        <a class="collapsed" data-toggle="collapse" data-parent="#accordionEx1" href="#collapseTen1"
                            aria-expanded="false" aria-controls="collapseTen1">
                            <h5 class="mb-0">Is there a minimum or maximum goal that i can set for fundraising a campaign? <i class="fas fa-angle-down rotate-icon"></i>
                            </h5>
                        </a>
                    </div>

                    <!-- Card body -->
                    <div id="collapseTen1" class="collapse" role="tabpanel" aria-labelledby="headingFour41"
                        data-parent="#accordionEx1">
                        <div class="card-body">
                            You can set a minimum fundraising target of S$100, and up to a maximum of S$2,000,000.
                        </div>
                    </div>

                </div>
                <!-- Accordion card -->


                <!-- Accordion card -->
                <div class="card">

                    <!-- Card header -->
                    <div class="card-header" role="tab" id="headingEleven1">
                        <a class="collapsed" data-toggle="collapse" data-parent="#accordionEx1" href="#collapseEleven1"
                            aria-expanded="false" aria-controls="collapseEleven1">
                            <h5 class="mb-0">What happens if the funds are not fully raised? <i class="fas fa-angle-down rotate-icon"></i>
                            </h5>
                        </a>
                    </div>

                    <!-- Card body -->
                    <div id="collapseEleven1" class="collapse" role="tabpanel" aria-labelledby="headingFour41"
                        data-parent="#accordionEx1">
                        <div class="card-body">
                            We would disburse all funds to our beneficiaries, even though the goal has not been reached.
                        </div>
                    </div>

                </div>
                <!-- Accordion card -->



            </div>
            <!-- Accordion wrapper -->
    </section>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script2" runat="server">
</asp:Content>
