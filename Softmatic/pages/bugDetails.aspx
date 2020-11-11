﻿<%@ Page Title="" Language="C#" MasterPageFile="~/BaseFrame.Master" AutoEventWireup="true" CodeBehind="bugDetails.aspx.cs" Inherits="Softmatic.pages.bugDetails" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="server">
    <style>
        .profile-image1 {
            width: 100px;
            height: 100px;
            border: 2px solid #03b1ce;
        }

        .profile-image2 {
            width: 70px;
            height: 70px;
            border: 2px solid #03b1ce;
        }

        .img-circle {
            border-radius: 50%;
            object-fit: cover;
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
    </style>
    <link rel="stylesheet" href="../css/slider.css" />
    <script src="../js/slider.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bodyContent" runat="server">

    <!--================Home Banner Area =================-->
    <section class="banner_area">
        <div class="banner_inner d-flex align-items-center">
            <div class="overlay"></div>
            <div class="container">
                <div class="banner_content text-center">
                    <h2>Bug Details</h2>
                    <div class="page_link">
                        <a href="../index.aspx">Home</a>
                        <a href="#">Bug Details</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--================End Home Banner Area =================-->

    <form id="form1" runat="server">
        <!--================Blog Area =================-->
        <section class="blog_area single-post-area p_120">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 posts-list">
                        <div class="single-post row">
                            <div class="col-lg-12">
                                <div class="feature-img">
                                    <ul class="bo-slider" id="lstGallery">
                                    </ul>
                                </div>
                            </div>
                            <div class="col-lg-9 col-md-9 blog_details">
                                <h1 id="lblTitle"></h1>
                                     <pre class="excert" id="lblDescription">
                                </pre>
                           
                            </div>
                           
                        </div>
                        <div class="comments-area">
                            <h4 id="hdCommentCount">Comments</h4>
                            <div id="divComments">
                            </div>
                            <div style="text-align: right;">
                                <div class="customPagination" id="commentPager">
                                </div>
                            </div>
                        </div>
                        <div class="comment-form" id="commentForm" runat="server" visible="false">
                            <h4>Leave a Comment</h4>
                            <div class="form-group">
                                <textarea id="txtComment" class="form-control mb-10" rows="5" name="message" placeholder="Messege" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Messege'"
                                    required=""></textarea>
                            </div>
                            <button type="submit" value="submit" onclick="return addComment();" class="primary-btn submit_btn">Post Comment</button>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="blog_right_sidebar">
                            <aside class="single_sidebar_widget author_widget">
                                <img id="imgUserPic" class="img-circle img-responsive profile-image1" src="../Images/User/defaultPic.jpg" alt="">

                                <h4 id="lblUserName"></h4>
                                <h4>Bug Reporter</h4>



                                <div id="progressbar"></div>
                                <div id="fundRaised"></div>
                                <div class="br"></div>
                                <div id="dayRemain" style="display: none"></div>

                            </aside>
                        </div>
                    </div>

                </div>
            </div>
        </section>
    </form>
    <!--================Blog Area =================-->
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script2" runat="server">
    <script>
        var bugId;

        $(function () {

            bugId = getUrlParam('bugId', 0);
            getBugDetails();
            getBugComments(1, 5);

        });


        function getBugDetails() {
            $.ajax({
                type: "POST",
                url: "bugDetails.aspx/getBugDetails",
                data: JSON.stringify({ 'bugId': bugId }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d.title != null) {

                        $('#lblTitle').text(response.d.title);
                        $('#lblCategory').text(response.d.category);
                        $('#lblDescription').text(response.d.description);
                        $('#lblCreatedBy, #lblUserName').text(response.d.createdBy);


                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Bug not found'
                        }).then((result) => {
                            if (result.value) {
                                window.location.href = './bugList.aspx';
                            }
                        })
                    }
                },
                error: function (response) {
                    console.log(JSON.stringify(response));
                    showErrorMsg();
                },
                failure: function (response) {
                    console.log(JSON.stringify(response));
                    showErrorMsg();
                }
            });
        }

        function getBugComments(pageIndex, pageSize) {
            $('#divComments').html('');
            $.ajax({
                type: "POST",
                url: "bugDetails.aspx/getBugComments",
                data: JSON.stringify({ 'bugId': bugId, 'pageIndex': pageIndex, 'pageSize': pageSize }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $('#hdCommentCount, #lblCommentCount').text(response.d.bugCommentListCount + ' Comments');

                    if (response.d.bugCommentListCount > 0) {
                        var bugCommentList = response.d.bugCommentList;
                        for (var i = 0; i < bugCommentList.length; i++) {
                            var imagePath = '<%= Page.ResolveUrl("~/Images/")%>' + (bugCommentList[i].createdByUserPic == '' ? 'User/defaultPic.jpg' : bugCommentList[i].createdByUserPic);
                            var commentHtml = '<div class="comment-list">' +
                                '<div class="single-comment justify-content-between d-flex">' +
                                '<div class="user d-flex comment-container">' +
                                //                                '<div class="thumb"> <img class="img-circle profile-image2" src="' + imagePath + '" alt=""> </div>' +
                                '<div class="desc"> <h5>' + bugCommentList[i].createdBy + '</h5>' +
                                '<p class="date">' + changDateTimeFormat(bugCommentList[i].createdOn) + '</p>' +
                                '<p class="comment">' + htmlEncode(bugCommentList[i].content) + '</p>' +
                                '</div>' + '<div class="comment-like-container" align="center"><img class="comment-like-button" src="/img/comment-' + (bugCommentList[i].islikedByCurrentUser ? '' : 'dis') + 'like.png" onclick="likeComment(this, ' + bugCommentList[i].commentId + ')" alt="like" /> </br> <span style="font-size:smaller;">' + bugCommentList[i].likeCount + ' likes</span> </div>' + ' </div> </div> </div>';

                            $('#divComments').append(commentHtml);
                        }
                        populatePager('#commentPager', pageIndex, pageSize, response.d.bugCommentListCount, 'getBugComment');
                    }
                },
                error: function (response) {
                    console.log(JSON.stringify(response));
                    showErrorMsg();
                },
                failure: function (response) {
                    console.log(JSON.stringify(response));
                    showErrorMsg();
                }
            });
        }

        function likeComment(element, commentId) {
            var data = { 'commentId': commentId };

            $.ajax({
                type: "POST",
                url: "bugDetails.aspx/addCommentLike",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    console.log(response);
                    if (response.d.isSuccess) {
                        if ($(element).attr('src') == "/img/comment-like.png") {
                            $(element).attr('src', '/img/comment-dislike.png');
                        } else {
                            $(element).attr('src', '/img/comment-like.png');
                        }

                        var currentPage = $('#commentPager').find('.page_disabled').length > 0 ? $('#commentPager').find('.page_disabled')[0].text : 1;

                        getBugComments(currentPage, 5);
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: response.d.returnMsg
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

        function addComment() {
            var data = { 'comment': $('#txtComment').val(), 'bugId': bugId };

            $.ajax({
                type: "POST",
                url: "bugDetails.aspx/addComment",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    console.log(JSON.stringify(response));
                    Swal.fire({
                        icon: response.d.isSuccess ? 'success' : 'error',
                        title: response.d.returnMsg
                    })

                    var currentPage = $('#commentPager').find('.page_disabled').length > 0 ? $('#commentPager').find('.page_disabled')[0].text : 1;

                    getBugComments(currentPage, 5);
                },
                error: function (response) {
                    console.log(JSON.stringify(response));
                    showErrorMsg();
                },
                failure: function (response) {
                    console.log(JSON.stringify(response));
                    showErrorMsg()
                }
            });

            return false;
        }


    </script>
</asp:Content>
