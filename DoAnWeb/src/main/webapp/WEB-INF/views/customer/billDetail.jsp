<%@page import="ptithcm.entity.BillDetail"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<!-- Basic -->

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<base href="${pageContext.servletContext.contextPath}/">
<!-- Mobile Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Site Metas -->
<title>Chi Tiết Đơn Hàng Của Tôi</title>
<meta name="keywords" content="">
<meta name="description" content="">
<meta name="author" content="">

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

</head>

<body>

	<jsp:include page="../include/header.jsp" />

	<!-- Hint: Thanh Navigate Mini Shop/Cart -->
	<!-- Start All Title Box -->
	<div class="all-title-box">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<h2>Chi tiết đơn hàng</h2>
					<ul class="breadcrumb">
						<li class="breadcrumb-item"><a href="my-account/home.htm">Tài
								Khoản Của Tôi</a></li>
						<li class="breadcrumb-item"><a href="my-account/bills.htm">Quản
								lý đơn hàng</a></li>
						<li class="breadcrumb-item active">Chi Tiết</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End All Title Box -->

	<!-- Hint: Thông tin người nhận  -->
	<div class="account-setting">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="title-all text-center">
						<h1>Đơn hàng #0397d6</h1>
					</div>
				</div>
			</div>

			<div class="row detai-info-receipter">
				<div class="col-lg-4 col-md-12 col-sm-12">
					<div class=" footer-link-contact">
						<h4 style="text-align: center;">Địa Chỉ Người Nhận</h4>
						<form:form action="bill/detail.htm" modelAttribute="bill">
							<ul>
								<li><form:label path="recipientName" type="text"
										style="overflow-wrap: break-word; font-size: 120%; font-weight: 700;">
										<i class="fad fa-person-carry" style="font-size: 120%;"></i>Người Nhận: ${bill.recipientName }</form:label>
								</li>
								<li><form:label path="recipientAddress" type="text"
										style="overflow-wrap: break-word;">Địa Chỉ: ${bill.recipientAddress }</form:label>
								</li>
								<li><form:label path="recipientPhone" type="text"
										style="overflow-wrap: break-word;">Điện thoại: ${bill.recipientPhone }</form:label>
								</li>
								<li><form:label path="recipientEmail" type="text"
										style="overflow-wrap: break-word;">Email: ${bill.recipientEmail }</form:label>
								</li>
							</ul>
						</form:form>
					</div>
				</div>
				<div class="col-lg-4 col-md-12 col-sm-12">
					<div class="footer-link">
						<h4 style="text-align: center;">Hình Thức Giao Hàng</h4>
						<p>Vận Chuyển Thông Thường</p>
						<p>Giao Vào ${bill.timeCreated }</p>
						<p>Phí Vận Chuyển: Miễn Phí</p>
					</div>
				</div>
				<div class="col-lg-4 col-md-12 col-sm-12">
					<div class="footer-widget">
						<h4 style="text-align: center;">Lời Nhắn Đến Cửa Hàng</h4>
						<p>${bill.note }</p>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Hint: Chi tiết các sản phẩm đã mua -->
	<div class="cart-box-main">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="table-main table-responsive">
						<table class="table">
							<thead>
								<tr>
									<th>Ảnh Sản Phẩm</th>
									<th>Tên Sản Phẩm</th>
									<th>Size</th>
									<th>Đơn Giá</th>
									<th>Số Lượng</th>
									<th>Giảm Giá</th>
									<th>Thành Tiền</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${listBillDetail}" var="item">
									<tr>
										<%-- <td class="hidden-xs">${item.idBill}</td> --%>
										<td class="thumbnail-img">
										<a href="shop-detail/showProduct.htm?idProduct=${item.product.idProduct}"> 
										<img class="img-fluid"
											src="images/${item.product.productImgs[0].source }" alt="" /></td>
										<td class="name-pr">
										<a href="shop-detail/showProduct.htm?idProduct=${item.product.idProduct}"> 
										${item.product.name}<c:if
												test="${item.getProductReview() == null }">
												<br>
												<a
													href="my-account/ratingComment.htm?idBill=${item.bill.idBill}&idProduct=${item.product.idProduct}&productSize=${item.productSize}"
													class="btn" style="background-color: gold;">Viết nhận
													xét </a>
											</c:if> <%-- <br>
					                    	<a>${item.getProductReview() }</a> --%>
										</td>
										<td><p>${item.productSize }</p></td>
										<td class="price-pr">${item.product.price}</td>
										<td class="quantity-box">${item.quantity}</td>
										<td class="discount">${item.discount}</td>
										<td class="total-pr">${item.totalPrice}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>

			<!-- Hint: Tạm chưa xóa, có thể cần -->
			<!-- <div class="row my-5">
                <div class="col-lg-6 col-sm-6">
                    <a href="" class="btn" style="background-color: gold;">Viết nhận xét </a>
                    <div class="coupon-box">
                        <div class="input-group input-group-sm">
                            <input class="form-control" placeholder="Enter your coupon code" aria-label="Coupon code" type="text">
                            <div class="input-group-append">
                                <button class="btn btn-theme" type="button">Viết nhận xét</button>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-sm-6">
                    <div class="update-box">
                        <input value="Update Cart" type="submit">
                    </div>
                </div>
            </div> -->

			<%
			List<BillDetail> list = (List<BillDetail>) request.getAttribute("listBillDetail");
			int length = list.size();
			float total = 0;
			float discount = 0;
			for (int i = 0; i < length; i++) {

				total += list.get(i).getTotalPrice();
				discount += (list.get(i).getDiscount() * list.get(i).getTotalPrice()) / 100;
			}
			%>


			<!-- Hint: Tổng Cộng Hóa Đơn mua hàng -->
			<div class="row my-5">
				<!-- Hint: Kỹ thuật này hay: diện tích tổng cộng 12 phần:
                     8 phần cho phần trống bên trái, 4 phần content bên phải -->
				<div class="col-lg-8 col-sm-12"></div>
				<div class="col-lg-4 col-sm-12">
					<div class="order-box">
						<h3>TỔNG KẾT ĐƠN HÀNG</h3>
						<div class="d-flex">
							<h4>Tổng Giá Tiền Gốc</h4>
							<div id='totalPriceNoDiscount' class="ml-auto font-weight-bold">
								<%=total + discount%>đ
							</div>
						</div>
						<div class="d-flex">
							<h4>Tổng Tiền Được Giảm</h4>
							<div id='totalSavingPrice' class="ml-auto font-weight-bold">
								<%=discount%>đ
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
							<div id='totalPriceWithDiscount' class="ml-auto h5">
								<%=total%>đ
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>


	<jsp:include page="../include/footer.jsp" />
</body>

</html>