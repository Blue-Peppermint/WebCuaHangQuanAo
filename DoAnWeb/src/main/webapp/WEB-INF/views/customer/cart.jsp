<%@page import="ptithcm.bean.ListCart"%>
<%@page import="ptithcm.entity.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html >
<!-- Basic -->

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<!-- Mobile Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Site Metas -->
<title>Giỏ Hàng</title>
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
#info, #info i {
	font-weight: 800;
	color: red;
}

#info {
	font-size: 150%;
}

#info i {
	font-size: 100%;
}
</style>

</head>

<body>

	<jsp:include page="../include/header.jsp"/>
	
	<!-- Hint: Thanh Navigate Mini Shop/Cart -->
	<!-- Start All Title Box -->
	<div class="all-title-box">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<h2>Giỏ hàng</h2>
					<ul class="breadcrumb">
						<li class="breadcrumb-item"><a href="home/index.htm">Trang Chủ</a></li>
						<li class="breadcrumb-item active">Giỏ Hàng</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End All Title Box -->


	<!-- Start Cart  -->
	<div class="cart-box-main">
		<c:if test="${not empty showInfo }">
			<div id="info" class="d-flex justify-content-center">
				<i class="fad fa-info-circle"></i> ${showInfo }
			</div>
		</c:if>


		<div class="container">
			<form:form action="cart/updateCart.htm" modelAttribute="listCart"
				method="post">
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
										<th style="text-align: center;">Số Lượng</th>
										<th>Thành Tiền</th>
										<th style="text-align: center;">Hủy</th>
									</tr>
								</thead>
								<tbody>



									<% 
							ListCart listCart = (ListCart) request.getAttribute("listCart");
							ArrayList<Cart> carts = (ArrayList<Cart>) listCart.getCarts();
							/* for(Cart c : carts){
								System.out.println("id :" + c.getProduct().getIdProduct() 
										+ " size:"+ c.getSize() + " quantity :" + c.getQuantity()); 
							} */
							int cartIndex = 0;
							%>
									<c:forEach var="cart" items="${listCart.carts}"
										varStatus="tagStatus">
										
										<%-- <form:input path="carts[${tagStatus.index}]" value ="${cart }" readonly="true"/> --%>
										<%-- <form:input path="carts[${tagStatus.index}].product"/> --%>
										<form:hidden path="carts[${tagStatus.index}].user.id" />
										<form:hidden
											path="carts[${tagStatus.index}].product.idProduct" />
										<form:hidden path="carts[${tagStatus.index}].size" />



										<% Cart c = (Cart) request.getAttribute("cart"); 
										/* System.out.println("id :" + c.getProduct().getIdProduct() 
										+ " size:"+ c.getSize() + " quantity :" + c.getQuantity()); */
								%>
										<tr id="${cart.product.idProduct}_${cart.size}">
											<td class="thumbnail-img">
											<a href="shop-detail/showProduct.htm?idProduct=${cart.product.idProduct}"> <img
													class="img-fluid"
													src="images/${cart.product.productImgs[0].source }" alt="" />
											</a></td>
											<td class="name-pr"><a href="shop-detail/showProduct.htm?idProduct=${cart.product.idProduct}"> 
											${cart.product.name }</a></td>
											<td>
												<p>${cart.size }</p>
											</td>
											<c:choose>
												<c:when test="${cart.product.discount != 0  }">
													<td class="price-pr">
														<p class="discount">
															<fmt:formatNumber type="currency" pattern="#₫"
																value="${cart.product.price * (100 - cart.product.discount)/100}" />
															<span>&nbsp; ${cart.product.price}₫</span>
														</p>
													</td>
												</c:when>
												<c:otherwise>
													<td class="price-pr">
														<p>${cart.product.price}₫</p>
													</td>
												</c:otherwise>
											</c:choose>

											<td class="quantity-box">
												<%-- <input name="cart[${tagStatus.index}]" type="number" size="4"
											value="${cart.quantity }" min="1" step="1"
											max="${cart.product.inStock}" class="c-input-text qty text"> --%>
												<form:input path="carts[${tagStatus.index}].quantity"
													type="number" size="4" min="0" step="1"
													max="${cart.product.getInStock(cart.size)}" class="c-input-text qty text" />

											</td>
											<td class="total-pr">
												<% 
										Cart cart = carts.get(cartIndex);  
										cartIndex++;
										int unitPriceNow = cart.getProduct().getPrice() * (100 - cart.getProduct().getDiscount())/100;
										%>

												<p><%= (int)unitPriceNow*cart.getQuantity()%>₫
												</p>
											</td>
											<td class="remove-pr"><a
												href="cart/deleteCart.htm?idProduct=${cart.product.idProduct}&size=${cart.size}">
													<i class="fas fa-times"></i>
											</a></td>
										</tr>

									</c:forEach>
								</tbody>

							</table>
						</div>
					</div>
				</div>

				<!-- Hint: Update Cart -->
				<div class="row my-5">
					<div class="col-lg-8 col-sm-6">
						<!--  <div class="coupon-box">
                        <div class="input-group input-group-sm">
                            <input class="form-control" placeholder="Enter your coupon code" aria-label="Coupon code" type="text">
                            <div class="input-group-append">
                                <button class="btn btn-theme" type="button">Apply Coupon</button>
                            </div>
                        </div>
                    </div> -->
					</div>
					<div class="col-lg-4 col-sm-6">
						<div class="update-box price-box-bar">
							<!-- <a href="cart/updateCart.htm?" class="ml-auto btn hvr-hover">Cập Nhật Giỏ Hàng</a> -->
							<input id="btnUpdate" value="Cập Nhật Giỏ Hàng" type="submit">

						</div>
					</div>
				</div>
			</form:form>
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
								130đ</div>
						</div>
						<div class="d-flex">
							<h4>Tổng Tiền Được Giảm</h4>
							<div id='totalSavingPrice' class="ml-auto font-weight-bold">
								40đ</div>
						</div>
						<hr class="my-1">
						<div class="d-flex">
							<h4>Phí Giao Hàng</h4>
							<div class="ml-auto font-weight-bold">Miễn Phí</div>
						</div>
						<hr>
						<div class="d-flex gr-total">
							<h5>Tổng Cộng</h5>
							<div id='totalPriceWithDiscount' class="ml-auto h5">388đ</div>
						</div>
						<hr>
					</div>
				</div>
				<div class="col-12 d-flex shopping-box">
					<a href="cart/checkout.htm" class="ml-auto btn hvr-hover">Mua
						Hàng</a>
				</div>
			</div>

		</div>
	</div>
	<!-- End Cart -->

	<jsp:include page="../include/footer.jsp"/>

	<script type="text/javascript">
	var spinners = document.querySelectorAll('.cart-box-main .table tbody input[type="number"]')
	var carts = ${jsonCarts}
	
	// Update mục tổng kết đơn hàng
	var totalPriceNoDiscount = calTotalPriceNoDiscount()
	var totalPriceWithDiscount = calToTalPriceWithDiscount()

	var totalOrderPriceNoDiscountElement = document.querySelector('#totalPriceNoDiscount')
	totalOrderPriceNoDiscountElement.innerHTML = totalPriceNoDiscount + '₫'

	var totalSavingPriceElement = document.querySelector('#totalSavingPrice')
	totalSavingPriceElement.innerHTML = totalPriceNoDiscount - totalPriceWithDiscount + '₫'

	var totalOrderPriceWithDiscountElement = document.querySelector('#totalPriceWithDiscount')
	totalOrderPriceWithDiscountElement.innerHTML = totalPriceWithDiscount + '₫'
	
	var btnUpdateCart = document.querySelector('#btnUpdate');
	btnUpdateCart.addEventListener ('click', function(e){
		btnUpdateCart.style.backgroundColor ='#000000'
	})
	
	//console.log(carts)
	for (var spinner of spinners) {
		spinner.onchange = function(e) {
			btnUpdateCart.style.backgroundColor ='#ff3333'
			
			console.log(`U just change value of :${e.target}`)
			var trElement = e.target.parentElement.parentElement;
			var idProduct = trElement.id.split('_')[0]
			var sizeProduct = trElement.id.split('_')[1]
			
			var cart = getCartByID_Size(idProduct, sizeProduct)
			cart.quantity = Number(e.target.value);

			// Nếu mục đơn giá có discount thì lấy newUnitPrice bằng cách khác
			var newUnitPrice;
			if (cart.discount != 0) {
				newUnitPrice = cart.price * (100 - cart.discount) / 100;
			} else {
				newUnitPrice = cart.price;
			}

			// Update table data Thành Tiền
			var trTotalPriceElement = trElement.querySelector('.total-pr p');
			trTotalPriceElement.innerHTML = newUnitPrice * cart.quantity + '₫'

			// Update mục tổng kết đơn hàng
			var totalPriceNoDiscount = calTotalPriceNoDiscount()
			var totalPriceWithDiscount = calToTalPriceWithDiscount()

			var totalOrderPriceNoDiscountElement = document.querySelector('#totalPriceNoDiscount')
			totalOrderPriceNoDiscountElement.innerHTML = totalPriceNoDiscount + '₫'

			var totalSavingPriceElement = document.querySelector('#totalSavingPrice')
			totalSavingPriceElement.innerHTML = totalPriceNoDiscount - totalPriceWithDiscount + '₫'

			var totalOrderPriceWithDiscountElement = document.querySelector('#totalPriceWithDiscount')
			totalOrderPriceWithDiscountElement.innerHTML = totalPriceWithDiscount + '₫'
		}
	}
	
	function getCartByID_Size(id, size) {
		for (var cart of carts) {
			if (cart.idProduct == id && cart.size == size) {
				return cart;
			}
		}
	}

	function calTotalPriceNoDiscount() {
		var total = 0;
		//console.log(carts)
		for (var cart of carts) {
			
			total += cart.price * cart.quantity
		}
		return total
	}

	function calToTalPriceWithDiscount() {
		var total = 0;
		for (var cart of carts) {
			if (cart.discount != 0) {
				var newPrice = cart.price * (100 - cart.discount) / 100;
				total += newPrice * cart.quantity
			} else {
				total += cart.price * cart.quantity
			}
		}
		return total
	}
	
	
	</script>
</body>

</html>