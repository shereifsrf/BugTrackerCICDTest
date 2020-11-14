function openMessageDialog(userId) {
    Swal.fire({
        title: 'Send Message',
        html:
            '<div class="row"> <div class="col-lg-12 col-md-12">' +
            '<label for="txtMessage">Message</label><br />' +
            '<textarea name="txtMessage" id="txtMessage" style="height: 300px" class="swal2-textarea"></textarea>' +
            '</div> </div>',
        showCloseButton: true,
        showCancelButton: true,
        focusConfirm: false,
        confirmButtonText: 'Send',
        cancelButtonText: 'Cancel',
        showLoaderOnConfirm: true,
        onOpen: function () {
            $('#txtCardNo').on('input', (function () {
                $('#cardType').text(' (' + checkCardType($('#txtCardNo').val()) + ')');
            }))
        },
        preConfirm: (message) => {
            return $.when(validateMsg($('#txtMessage').val())).then(function (result) {
                if (!result.isSuccess) {
                    Swal.showValidationMessage(
                        result.returnMsg
                    )
                }
            });
        }
    }).then((result) => {
        if (result.isConfirmed) {
            sendMessage(userId, $('#txtMessage').val());
        }
    })

    return false;
}

function isUserLogin(callback) {
    $.ajax({
        type: "POST",
        url: "../Common.asmx/isUserLogin",
        data: '',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            if (!response.d) {
                Swal.fire({
                    icon: 'info',
                    title: 'Login required'
                })
            } else {
                eval(callback);
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

function htmlEncode(str) {
    return String(str).replace(/[^\w. ]/gi, function (c) {
        return '&#' + c.charCodeAt(0) + ';';
    });
}

function sendMessage(userId, message) {
    if ($.trim(message).length == 0) {
        Swal.fire({
            icon: 'warning',
            title: 'Message cannot be empty'
        })
        return;
    }

    var data = { 'toUserId': userId, 'message': message };

    return $.ajax({
        type: "POST",
        url: "../Common.asmx/sendMessage",
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
            showErrorMsg();
        },
        failure: function (response) {
            console.log(response);
            showErrorMsg();
        }
    });
}

function validateMsg(message) {
    var result = { 'isSuccess': false, 'returnMsg': 'error' };

    if (message == "") {
        result.returnMsg = "Please fill in message!"
    } else {
        result.isSuccess = true;
    }

    return result;
}


function campaignLinkFormatter(data, row) {
    return '<a href="/pages/bugDetails.aspx?bugId=' + row.bugId + '" >' + data + '</a>';
}

function populatePager(id, pageNumber, pageSize, totalRecords, callbackFunction) {
    $(id).html('');

    pageNumber = parseInt(pageNumber);
    pageSize = parseInt(pageSize);
    totalRecords = parseInt(totalRecords);

    var pageCount = Math.ceil(totalRecords / pageSize);

    if (pageNumber > 1) {
        $(id).append('<a href="javascript:' + callbackFunction + '(' + (pageNumber - 1) + ', ' + pageSize + ')" class="page_enabled">Prev</a>');
    }

    if ((pageNumber - 3) > 2) {
        $(id).append('<a href="javascript:' + callbackFunction + '(' + 1 + ', ' + pageSize + ')" class="page_enabled">1...</a>');
    } else if ((pageNumber - 3) == 2) {
        $(id).append('<a href="javascript:' + callbackFunction + '(' + 1 + ', ' + pageSize + ')" class="page_enabled">1</a>');
    }

    for (var i = pageNumber - 3; i <= pageNumber; i++) {
        if (i >= 1) {
            if (pageNumber != i) {
                $(id).append('<a href="javascript:' + callbackFunction + '(' + i + ', ' + pageSize + ')" class="page_enabled">' + i + '</a>');
            } else {
                $(id).append('<a href="javascript:' + callbackFunction + '(' + i + ', ' + pageSize + ')" class="page_disabled">' + i + '</a>');
            }
        }
    }

    for (var i = pageNumber + 1; i <= pageNumber + 3; i++) {
        if (i <= pageCount) {
            if (pageNumber != i) {
                $(id).append('<a href="javascript:' + callbackFunction + '(' + i + ', ' + pageSize + ')" class="page_enabled">' + i + '</a>');
            } else {
                $(id).append('<a href="javascript:' + callbackFunction + '(' + i + ', ' + pageSize + ')" class="page_disabled">' + i + '</a>');
            }
        }
    }

    if ((pageNumber + 4) < pageCount) {
        $(id).append('<a href="javascript:' + callbackFunction + '(' + pageCount + ', ' + pageSize + ')" class="page_enabled">...' + pageCount + '</a>');
    }
    else if ((pageNumber + 4) == pageCount) {
        $(id).append('<a href="javascript:' + callbackFunction + '(' + pageCount + ', ' + pageSize + ')" class="page_enabled">' + pageCount + '</a>');
    }

    if (pageNumber < pageCount) {
        $(id).append('<a href="javascript:' + callbackFunction + '(' + (pageNumber + 1) + ', ' + pageSize + ')" class="page_enabled">Next</a>');
    }
}

function pad(str, max) {
    str = str.toString();
    return str.length < max ? pad("0" + str, max) : str;
}

function changeDateFormat(jsonDate) {
    var monthNames = ["Jan", "Feb", "Mar", "Apr",
        "May", "Jun", "Jul", "Aug",
        "Sep", "Oct", "Nov", "Dec"]

    var dateString = jsonDate.substr(6);

    var currentTime = new Date(parseInt(dateString));

    var month = currentTime.getMonth();
    var day = currentTime.getDate();
    var year = currentTime.getFullYear();
    var date = day + " " + monthNames[month] + " " + year;

    return date;
}

function dayDifference(jsonDate) {
    var dateString = jsonDate.substr(6);

    var date = new Date(parseInt(dateString));

    var diff = new Date(date - new Date());

    return Math.ceil(diff / 1000 / 60 / 60 / 24);
}

function changeDateFormat2(jsonDate) {
    var dateString = jsonDate.substr(6);

    var currentTime = new Date(parseInt(dateString));

    var month = currentTime.getMonth() + 1;
    var day = currentTime.getDate();
    var year = currentTime.getFullYear();
    var date = year + '-' + pad(month, 2) + '-' + pad(day, 2);

    return date;
}

function changDateTimeFormat(jsonDate) {
    var monthNames = ["Jan", "Feb", "Mar", "Apr",
        "May", "Jun", "Jul", "Aug",
        "Sep", "Oct", "Nov", "Dec"]

    var dateString = jsonDate.substr(6);

    var currentTime = new Date(parseInt(dateString));

    var month = currentTime.getMonth();
    var day = currentTime.getDate();
    var year = currentTime.getFullYear();

    var n = currentTime.toLocaleString([], {
        hour: '2-digit',
        minute: '2-digit'
    });

    var date = monthNames[month] + " " + day + ", " + year + ' at ' + n;

    return date;
}


function showErrorMsg() {
    Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: 'Something went wrong, please contact support.'
    })
}

function getUrlVars() {
    var vars = {};
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function (m, key, value) {
        vars[key] = value;
    });
    return vars;
}

function getUrlParam(parameter, defaultvalue) {
    var urlparameter = defaultvalue;
    if (window.location.href.indexOf(parameter) > -1) {
        urlparameter = getUrlVars()[parameter];
    }
    return urlparameter;
}

; (function ($) {
    $(document).ajaxStart(function () {
        $('#loadingGif').show();
    });

    $(document).ajaxStop(function () {
        $('#loadingGif').hide();
    });

    "use strict"
    var nav_offset_top = $('.header_area').height() + 50;
    /*-------------------------------------------------------------------------------
	  Navbar 
    -------------------------------------------------------------------------------*/

    //* Navbar Fixed  
    function navbarFixed() {
        if ($('.header_area').length) {
            $(window).scroll(function () {
                var scroll = $(window).scrollTop();
                if (scroll >= nav_offset_top) {
                    $(".header_area").addClass("navbar_fixed");
                } else {
                    $(".header_area").removeClass("navbar_fixed");
                }
            });
        };
    };
    navbarFixed();


    //--------  Carousel --------// 
    //if ($('#our-major-cause').length) {
    //    $('#our-major-cause').owlCarousel({
    //        loop: true,
    //        margin: 30,
    //        items: 3,
    //        nav: false,
    //        dots: true,
    //        responsiveClass: true,
    //        // autoplay: 2500,
    //        slideSpeed: 300,
    //        paginationSpeed: 500,
    //        responsive: {
    //            0: {
    //                items: 1,
    //            },
    //            768: {
    //                items: 2,
    //            },
    //            1224: {
    //                items: 3
    //            }
    //        }
    //    })
    //}

    if ($('.clients_slider').length) {
        $('.clients_slider').owlCarousel({
            loop: true,
            margin: 30,
            items: 5,
            nav: false,
            dots: false,
            responsiveClass: true,
            autoplay: 2500,
            slideSpeed: 300,
            paginationSpeed: 500,
            responsive: {
                0: {
                    items: 1,
                },
                768: {
                    items: 3,
                },
                1024: {
                    items: 4,
                },
                1224: {
                    items: 5
                }
            }
        })
    }

    //------- Mailchimp js --------//  

    function mailChimp() {
        $('#mc_embed_signup').find('form').ajaxChimp();
    }
    mailChimp();


    //$('select').niceSelect();

    /*----------------------------------------------------*/
    /*  One map with leaflet js
    /*----------------------------------------------------*/
    // Partner Map
    if (document.getElementById('mapBox')) {
        var center = L.bounds([1.3294012, 103.7739858], [1.16, 103.502]).getCenter();
        var map = L.map('mapBox').setView([1.329147, 103.7764964], 18);

        var basemap = L.tileLayer('https://maps-{s}.onemap.sg/v3/Default/{z}/{x}/{y}.png', {
            detectRetina: true,
            maxZoom: 18,
            minZoom: 11,
            attribution: '<img src="https://docs.onemap.sg/maps/images/oneMap64-01.png" style="height:20px;width:20px;"/> New OneMap | Map data &copy; contributors, <a href="http://SLA.gov.sg">Singapore Land Authority</a>'
        });

        map.setMaxBounds([[1.56073, 104.1147], [1.16, 103.502]]);

        basemap.addTo(map);

        var marker = new L.Marker([1.329147, 103.7764964], { bounceOnAdd: false }).addTo(map);
        var popup = L.popup()
            .setLatLng([1.329147, 103.7764964])
            .setContent('We are here!')
            .openOn(map);
    }

})(jQuery)