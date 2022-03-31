<%@page import="ptithcm.entity.Product"%>
<%@page import="ptithcm.entity.Cart"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<!-- Basic -->

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<!-- Mobile Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Site Metas -->
<title>Kiểm Tra Hóa Đơn</title>
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

<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

<style type="text/css">
i.icon {
	color: rgba(245, 10, 10, 0.7);
	font-size: 18px;
}

*[id$=errors] {
	color: rgba(245, 10, 10, 0.9);
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
					<h2>Kiểm tra hóa đơn</h2>
					<ul class="breadcrumb">
						<li class="breadcrumb-item"><a href="home/index.htm">Trang
								Chủ</a></li>
						<li class="breadcrumb-item"><a href="cart/showCart.htm">Giỏ Hàng</a></li>
						<li class="breadcrumb-item active">Kiểm Tra Hóa Đơn</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End All Title Box -->

	<!-- Start Cart  -->
	<div class="cart-box-main">
		<div class="container">
			<form:form action="cart/checkout.htm" modelAttribute="billCheckout"
				method="post">
				<div class="row">
					<div class="col-sm-6 col-lg-6 mb-3">
						<div class="checkout-address">
							<div class="title-left">
								<h3>Thông Tin Người Nhận</h3>
								<%-- <spring:hasBindErrors name="billCheckout">
									<c:forEach var="error" items="${errors.allErrors}">
										<b><spring:message message="${error}" /></b>
										<br />
									</c:forEach>
								</spring:hasBindErrors> --%>
							</div>
							<div class="mb-3">
								<label>Họ & Tên *</label> <br>
								<form:errors path="bill.recipientName" />
								<form:input path="bill.recipientName"
									value="${userDetail.name }" type="text" class="form-control" />
							</div>
							<div class="mb-3">
								<label>Số Điện Thoại *</label> <br>
								<form:errors path="bill.recipientPhone" />
								<form:input path="bill.recipientPhone"
									value="${userDetail.phone }" type="text" class="form-control" />
							</div>
							<div class="mb-3">
								<label>Địa Chỉ Email *</label> <br>
								<form:errors path="bill.recipientEmail" />
								<form:input path="bill.recipientEmail"
									value="${userDetail.email }" type="email" class="form-control" />

							</div>
							<div class="mb-3">
								<label>Địa Chỉ Nhận Hàng *</label> <br>
								<form:errors path="bill.recipientAddress" />
								<form:input path="bill.recipientAddress"
									value="${userDetail.address }" type="text" class="form-control" />
							</div>
							<div class="mb-3">
								<label>Lời Nhắn Đến Cửa Hàng</label>
								<form:textarea path="bill.note" class="form-control" rows="5"
									style="resize: none;" />
							</div>
							<hr class="mb-4">
							<div class="title">
								<span>Phương Thức Thanh Toán</span>
							</div>
							<div class="d-block my-3">
								<div class="custom-control custom-radio">
									<input id="credit" name="paymentMethod" type="radio"
										class="custom-control-input" checked> <label
										class="custom-control-label" for="credit">Tiền Mặt</label>
								</div>
								<div class="custom-control custom-radio">
									<input id="debit" name="paymentMethod" type="radio"
										class="custom-control-input"> <label
										class="custom-control-label" for="debit">Khác</label>
								</div>
							</div>
							<hr class="mb-1">

						</div>
					</div>
					<div class="col-sm-6 col-lg-6 mb-3">
						<div class="row">
							<div class="col-md-12 col-lg-12">
								<div class="shipping-method-box">
									<div class="title-left">
										<h3>Phương Thức Giao Hàng</h3>
									</div>
									<div class="mb-4">
										<div class="custom-control custom-radio">
											<input id="shippingOption1" name="shipping-option"
												class="custom-control-input" checked="checked" type="radio">
											<label class="custom-control-label" for="shippingOption1">Vận
												Chuyển Thông Thường</label> <span
												class="float-right font-weight-bold">Miễn Phí</span>
										</div>
										<div class="ml-4 mb-2 small">(3-7 ngày giao hàng)</div>
										<div class="custom-control custom-radio">
											<input id="shippingOption2" name="shipping-option"
												class="custom-control-input" type="radio"> <label
												class="custom-control-label" for="shippingOption2">Vận
												Chuyển Nhanh</label> <span class="float-right font-weight-bold">99
												000đ</span>
										</div>
										<div class="ml-4 mb-2 small">(2-4 ngày giao hàng))</div>
									</div>
								</div>
							</div>
							<div class="col-md-12 col-lg-12">
								<div class="odr-box">
									<div class="title-left">
										<h3>Danh Sách Sản Phẩm Mua</h3>
									</div>
									<div class="rounded p-2 bg-light">
										<c:forEach var="cart" items="${ carts}" varStatus="tagStatus">
											<form:hidden
												path="billDetails[${tagStatus.index}].product.idProduct"
												value="${cart.product.idProduct }" />
											<form:hidden
												path="billDetails[${tagStatus.index}].productSize"
												value="${cart.size }" />
											<form:hidden path="billDetails[${tagStatus.index}].quantity"
												value="${cart.quantity }" />
											<form:hidden path="billDetails[${tagStatus.index}].discount"
												value="${cart.product.discount }" />
											<%-- <form:hidden
												path="billDetails[${tagStatus.index}].product.inStock"
												value="${cart.product.inStock }" /> --%>
											<form:hidden
												path="billDetails[${tagStatus.index}].product.name"
												value="${cart.product.name }" />
											<form:hidden
												path="billDetails[${tagStatus.index}].product.price"
												value="${cart.product.price }" />

											<fmt:formatNumber var="unitPrice" pattern="#"
												value="${cart.product.price }" />
											<fmt:formatNumber var="unitDiscount" pattern="#"
												value="${cart.product.discount }" />
											<fmt:formatNumber var="unitNewPrice" pattern="#"
												value="${unitPrice * (100 - unitDiscount)/100}" />
											<fmt:formatNumber var="unitQuantity" pattern="#"
												value="${cart.quantity}" />

											<fmt:formatNumber var="intTotalPrice" pattern="#"
												value="${unitNewPrice * unitQuantity}" />

											<form:hidden
												path="billDetails[${tagStatus.index}].totalPrice"
												value="${intTotalPrice}" />
											<c:choose>
												<c:when test="${tagStatus.index == carts.size() - 1 }">
													<div class="media mb-2">
												</c:when>
												<c:otherwise>
													<div class="media mb-2 border-bottom">
												</c:otherwise>
											</c:choose>

											<div class="media-body">
												<a
													href="shop-detail/showProduct.htm?idProduct=${cart.product.idProduct}">
													${cart.product.name}</a>
												<div class="small text-muted">
													Size: ${cart.size} <span class="mx-2">|</span> Đơn giá:
													${cart.product.price * (100 - cart.product.discount)/100}₫
													<span class="mx-2">|</span> Số lượng: ${cart.quantity} <span
														class="mx-2">|</span> Thành tiền: ${intTotalPrice}₫
												</div>
											</div>
									</div>
									</c:forEach>

								</div>
							</div>
						</div>
						<div class="col-md-12 col-lg-12">
							<div class="order-box">
								<div class="title-left">
									<h3>Hóa Đơn Thanh Toán</h3>
								</div>
								<%
									List<Cart> carts = (List<Cart>) request.getAttribute("carts");
									int totalPriceNoDiscount = 0;
									int totalPriceWithDiscount = 0;
									for (Cart cart : carts) {
										Product product = cart.getProduct();
										int unitPriceNoDiscount = product.getPrice();
										int unitPriceWithDiscount = product.getPrice() * (100 - product.getDiscount())/100;
										totalPriceNoDiscount += unitPriceNoDiscount *cart.getQuantity();
										totalPriceWithDiscount += unitPriceWithDiscount * cart.getQuantity();
									}
									%>
								<div class="d-flex">
									<h4>Tổng Giá Tiền Gốc</h4>
									<div class="ml-auto font-weight-bold"><%=totalPriceNoDiscount%>₫
									</div>
								</div>
								<div class="d-flex">
									<h4>Tổng Tiền Được Giảm</h4>
									<div class="ml-auto font-weight-bold"><%=totalPriceNoDiscount - totalPriceWithDiscount%>₫
									</div>
								</div>
								<hr class="my-1">
								<div class="d-flex">
									<h4>Phí Giao Hàng</h4>
									<div class="ml-auto font-weight-bold">Miễn Phí</div>
								</div>
								<hr>
								<div class="d-flex gr-total">
									<h5>Tổng Cộng</h5>
									<div class="ml-auto h5"><%= totalPriceWithDiscount %>₫
									</div>
								</div>
								<hr>
							</div>
						</div>
						<div class="col-12 d-flex shopping-box">
							<button class=" ml-auto btn hvr-hover"
								style="font-size: 18px; color: #ffffff; border: none; padding: 10px 20px;">
								Đặt Hàng</button>
							<!-- <a href="#checkout1.html" class="ml-auto btn hvr-hover">Đặt
									Hàng</a> -->
						</div>
					</div>
				</div>
		</div>
		</form:form>
	</div>
	</div>
	<!-- End Cart -->

	<jsp:include page="../include/footer.jsp" />
</body>

</html>