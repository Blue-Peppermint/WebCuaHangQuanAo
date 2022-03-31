<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!doctype html>
<html>

<head>
<meta charset='utf-8'>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<title>Đánh Giá Sản Phẩm</title>
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

<link rel="stylesheet" href="css/grid.css">
<!--[if lt IE 9]>
   <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
   <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
 <![endif]-->

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
	integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p"
	crossorigin="anonymous" />

<style>
@import
	url('https://fonts.googleapis.com/css2?family=Manrope:wght@200&display=swap')
	;

.card {
	position: relative;
	display: flex;
	flex-direction: column;
	min-width: 0;
	padding: 30px;
	width: 750px;
	word-wrap: break-word;
	background-color: #fff;
	background-clip: border-box;
	border-radius: 6px;
	box-shadow: 0px 0px 5px 0px rgba(212, 182, 212, 1);
}

.comment-box {
	padding: 5px
}

.comment-area textarea {
	resize: none;
	border: 1px solid #ad9f9f
}

.form-control:focus {
	color: #495057;
	background-color: #fff;
	border-color: #ffffff;
	outline: 0;
	box-shadow: 0 0 0 1px rgb(122, 216, 165) !important
}

.send {
	color: #fff;
	background-color: #ff0000;
	border-color: #ff0000
}

.send:hover {
	color: #fff;
	background-color: #f50202;
	border-color: #f50202
}
/* @import url(https://pro.fontawesome.com/releases/v5.10.0/css/all.css); */
/*reset css*/
/****** Style Star Rating Widget *****/
#rating {
	border: none;
	float: left;
}

#rating>input {
	display: none;
}
/*ẩn input radio - vì chúng ta đã có label là GUI*/
#rating>label:before {
	margin: 5px;
	font-size: 2em;
	font-family: FontAwesome;
	display: inline-block;
	content: "\f005";
}
/*1 ngôi sao*/
#rating>.half:before {
	content: "\f089";
	position: absolute;
}
/*0.5 ngôi sao*/
#rating>label {
	color: #ddd;
	float: right;
}
/*float:right để lật ngược các ngôi sao lại đúng theo thứ tự trong thực tế*/
/*thêm màu cho sao đã chọn và các ngôi sao phía trước*/
#rating>input:checked ~label, #rating:not(:checked)>label:hover, #rating:not(:checked)>label:hover
	 ~label {
	color: #FFD700;
}
/* Hover vào các sao phía trước ngôi sao đã chọn*/
#rating>input:checked+label:hover, #rating>input:checked ~label:hover,
	#rating>label:hover ~input:checked ~label, #rating>input:checked ~label:hover
	 ~label {
	color: #FFED85;
}

.avatar {
	width: 100px;
	height: 100px;
	object-fit: cover;
	border-radius: 50rem !important;
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
					<h2>Đánh giá sản phẩm</h2>
					<ul class="breadcrumb">
						<li class="breadcrumb-item"><a href="my-account/home.htm">Tài
								Khoản Của Tôi</a></li>
						<li class="breadcrumb-item"><a href="my-account/bills.htm">Quản
								lý đơn hàng</a></li>
						<li class="breadcrumb-item active">Đánh Giá Sản Phẩm</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End All Title Box -->

	<div class="d-flex justify-content-center " style="margin: 100px 0;">
		<div class="card">
			<div class="row">
				<div class="col-2">
					<img src="images/${imgAvatar}" class="avatar">
				</div>
				<div class="col-10">
					<div class="comment-box ml-2">
						<h4>Đánh Giá Và Bình Luận</h4>
						<%-- <form:form
							action="my-account/ratingComment.htm?idBill=${idBill}&idProduct=${idProduct}&productSize=${size}"
							modelAttribute="productReview" method="POST"> --%>
							
							<form:form
							action="my-account/ratingComment.htm"
							modelAttribute="productReview" method="POST">
							<form:hidden path="bill.idBill"  />
							<form:hidden path="product.idProduct" />
							<form:hidden path="productSize" />
							
							<form:errors path="ratingScore" />
							<div class="rating">
								<div id="rating">
									<%-- <form:input type="radio" id="star5" path="ratingScore" value="5" /> <label
									class="full" for="star5" title="Awesome - 5 stars"></label> <form:input
									type="radio" id="star4" path="ratingScore" value="4" /> <label
									class="full" for="star4" title="Pretty good - 4 stars"></label>

								<form:input type="radio" id="star3" path="ratingScore" value="3" /> <label
									class="full" for="star3" title="Meh - 3 stars"></label> <form:input
									type="radio" id="star2" path="ratingScore" value="2" /> <label
									class="full" for="star2" title="Kinda bad - 2 stars"></label> <form:input
									type="radio" id="star1" path="ratingScore" value="1" /> <label
									class="full" for="star1" title="Sucks big time - 1 star"></label> --%>

									<form:radiobutton id="star5" path="ratingScore" value="5" />
									<label class="full" for="star5" title="Awesome - 5 stars"></label>
									<form:radiobutton id="star4" path="ratingScore" value="4" />
									<label class="full" for="star4" title="Pretty good - 4 stars"></label>

									<form:radiobutton id="star3" path="ratingScore" value="3" />
									<label class="full" for="star3" title="Meh - 3 stars"></label>
									<form:radiobutton id="star2" path="ratingScore" value="2" />
									<label class="full" for="star2" title="Kinda bad - 2 stars"></label>
									<form:radiobutton id="star1" path="ratingScore" value="1" />
									<label class="full" for="star1" title="Sucks big time - 1 star"></label>
								</div>
							</div>

							<div class="comment-area">
								<form:textarea path="contentText" class="form-control"
									placeholder="Bạn nhận xét như thế nào về sản phẩm này ?"
									rows="5" />
							</div>
							<div class="comment-btns mt-2">
								<div class="row">
									<div class="col-6">
										<div class="pull-left">
											<a href="#" class="btn btn-success btn-sm">Hủy Bỏ</a>
										</div>
									</div>
									<div class="col-6">
										<div class="pull-right">
											<!-- <btn class="btn btn-success send btn-sm">Bình Luận <i
												class="fa fa-long-arrow-right ml-1"></i></btn> -->
											<form:button type="submit"
												class="btn btn-success send btn-sm">Bình Luận <i
													class="fa fa-long-arrow-right ml-1"></i>
											</form:button>
										</div>
									</div>
								</div>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>

	</div>

	<jsp:include page="../include/footer.jsp" />
</body>

</html>