<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <!-- Mobile Metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Site Metas -->
    <title>Tài Khoản Của Tôi</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <meta name="author" content="">
    
    <base href="${pageContext.servletContext.contextPath}/">

    <!-- Site Icons -->
	<link rel="icon" href="images/my-logo-mini.png">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <!-- Site CSS -->
    <link rel="stylesheet" href="css/style.css">
    <!-- Responsive CSS -->
    <link rel="stylesheet" href="css/responsive.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/custom.css">

	
	<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />

    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

	<jsp:include page="../include/header.jsp"/>
    
    <!-- Start All Title Box -->
    <div class="all-title-box">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h2>Tài khoản của tôi</h2>
                    <ul class="breadcrumb">
                        <li class="breadcrumb-item"><a href="home/index.htm">Trang Chủ</a></li>
                        <li class="breadcrumb-item active">Tài Khoản Của Tôi</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- End All Title Box -->

    <!-- Start My Account  -->
    <div class="my-account-box-main">
        <div class="container">
            <div class="my-account-page">
                <div class="row">
                    <!-- Hint: 1 mục trong my account -->
                    <div class="col-lg-4 col-md-12">
                        <div class="account-box">
                            <div class="service-box">
                                <div class="service-icon">
                                    <a href="my-account/settingAccount.htm"><i class="fad fa-lock-alt"></i></a>
                                </div>
                                <div class="service-desc">
                                    <h4>Thông tin tài khoản &amp; bảo mật</h4>
                                    <p>Chỉnh sửa thông tin cá nhân</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Hint: Thông Báo -->
                    <!-- <div class="col-lg-4 col-md-12">
                        <div class="account-box">
                            <div class="service-box">
                                <div class="service-icon">
                                    <a href="#"> <i class="fad fa-bell"></i></a>
                                </div>
                                <div class="service-desc">
                                    <h4>Thông báo</h4>
                                    <p>Nhận thông báo đặt hàng và khuyến mãi</p>
                                </div>
                            </div>
                        </div>
                    </div> -->
                    <div class="col-lg-4 col-md-12">
                        <div class="account-box">
                            <div class="service-box">
                                <div class="service-icon">
                                    <a href="my-account/bills.htm"> <i class="fad fa-gift"></i> </a>
                                </div>
                                <div class="service-desc">
                                    <h4>Đơn hàng của tôi</h4>
                                    <p>Quản lý đơn hàng đã đặt</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4 col-md-12">
                        <div class="account-box">
                            <div class="service-box">
                                <div class="service-icon">
                                    <a href="my-account/wishlist/showWishlist.htm"> <i class="fad fa-heart"></i></a>
                                </div>
                                <div class="service-desc">
                                    <h4>Sản phẩm yêu thích</h4>
                                    <p>Quản lý sản phẩm yêu thích đã lưu</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End My Account -->

    <jsp:include page="../include/footer.jsp"/>
</body>

</html>