<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đặt Hàng Thành Công</title>

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
<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
	integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p"
	crossorigin="anonymous" />

<style>
i.check-icon {
	color: #9ABC66;
	font-size: 100px;
	line-height: 200px;
	margin-left: -15px;
}
</style>

</head>

<body>

	<jsp:include page="../include/header.jsp" />

	<!-- Start All Title Box -->
	<div class="all-title-box">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<h2>Kết quả đặt hàng</h2>
					<ul class="breadcrumb">
						<li class="breadcrumb-item"><a href="home/index.htm">Trang
								Chủ</a></li>
						<li class="breadcrumb-item active">Kết Quả Đặt Hàng</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End All Title Box -->

	<!-- End Main Top -->
	<div class="jumbotron text-center">
		<div
			style="border-radius: 200px; height: 200px; width: 200px; background: #F8FAF5; margin: 0 auto;">
			<i class="check-icon checkmark">✓</i>
		</div>
		<h1 class="display-3">Đặt Hàng Thành Công</h1>
		<p class="lead">
			Cảm ơn quý khách đã mua hàng tại cửa hàng của chúng tôi <br> <strong>Xin
				Kiểm Tra Lại Email</strong> để theo dõi chi tiết đơn hàng
		</p>
		<hr>
		<p class="lead">
			<a id="loadMoreSpecialItems" class="btn" href="home/index.htm">Quay
				Về Trang Chủ</a>
		</p>
	</div>

	<jsp:include page="../include/footer.jsp" />
</body>

</html>