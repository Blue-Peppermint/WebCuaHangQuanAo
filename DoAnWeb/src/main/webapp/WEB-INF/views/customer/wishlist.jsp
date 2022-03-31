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
<title>Sản Phẩm Yêu Thích</title>
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
	font-weight: 600;
}

#info {
	font-size: 120%;
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
					<h2>Sản phẩm yêu thích</h2>
					<ul class="breadcrumb">
						<li class="breadcrumb-item"><a href="my-account/home.htm">Tài
								Khoản Của Tôi</a></li>
						<li class="breadcrumb-item active">Sản Phẩm Yêu Thích</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End All Title Box -->

	<!-- Start Wishlist  -->
	<div class="wishlist-box-main">
		<c:if test="${not empty showInfo }">
			<div id="info" class="alert alert-info alert-dismissable  ">
				<a class="panel-close close" data-dismiss="alert">×</a>
				<div class=" d-flex justify-content-center">
					<i class="fad fa-info-circle"></i>${showInfo }
				</div>
			</div>

			<%-- 			<div id="info" class="d-flex justify-content-center">
				<i class="fad fa-info-circle"></i> ${showInfo }
				
			</div> --%>
		</c:if>

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
									<th>Tình Trạng</th>
									<th>Thêm Hàng Vào Giỏ</th>
									<th style="text-align: center;">Xóa</th>
								</tr>
							</thead>
							<tbody>
								<!-- Hint: 1 tr = 1 sản phẩm -->
								<c:forEach var="wishlist" items="${wishlists}">
									<tr>
										<input name="idProduct" value="${wishlist.product.idProduct }"
											type="hidden" />
										<input name="sizeProduct" value="${wishlist.size }"
											type="hidden" />

										<td class="thumbnail-img"><a
											href="shop-detail/showProduct.htm?idProduct=${wishlist.product.idProduct}">
												<img class="img-fluid"
												src="images/${wishlist.product.productImgs[0].source }" alt="" />
										</a></td>
										<td class="name-pr"><a
											href="shop-detail/showProduct.htm?idProduct=${wishlist.product.idProduct}">
												${wishlist.product.name } </a></td>
										<td>
											<p>${wishlist.size }</p>
										</td>
										<c:choose>
											<c:when test="${wishlist.product.discount != 0  }">
												<td class="price-pr">
													<p class="discount">
														<fmt:formatNumber type="currency" pattern="#₫"
															value="${wishlist.product.price * (100 - wishlist.product.discount)/100}" />
														<span>&nbsp; ${wishlist.product.price}₫</span>
													</p>
												</td>
											</c:when>
											<c:otherwise>
												<td class="price-pr">
													<p>${wishlist.product.price}₫</p>
												</td>
											</c:otherwise>
										</c:choose>

										<c:choose>
											<c:when test="${wishlist.product.getInStock(wishlist.size) != 0 }">
												<td class="quantity-box">Còn hàng</td>
											</c:when>
											<c:otherwise>
												<td class="quantity-box">Hết hàng</td>
											</c:otherwise>
										</c:choose>

										<td class="add-pr"><a class="btnAddToCart btn hvr-hover"
											href="my-account/wishlist/addToCart.htm?idProduct=${wishlist.product.idProduct}&size=${wishlist.size}">Thêm
												Vào giỏ hàng</a></td>

										<td class="remove-pr"><a
											href="my-account/wishlist/deleteWishlist.htm?idProduct=${wishlist.product.idProduct}&size=${wishlist.size}">
												<i class="fas fa-times"></i>
										</a></td>
									</tr>



								</c:forEach>
								<!-- <tr>
									<td class="thumbnail-img"><a href="#"> <img
											class="img-fluid" src="images/img-pro-01.jpg" alt="" />
									</a></td>
									<td class="name-pr"><a href="#"> Lorem ipsum dolor sit
											amet </a></td>
									<td>
										<p>XL</p>
									</td>
									<td class="price-pr">
										<p>
											80 000 đ<span>12 000 000đ</span>
										</p>
									</td>
									<td class="quantity-box">Còn hàng</td>
									<td class="add-pr"><a class="btn hvr-hover" href="#">Thêm
											giỏ hàng</a></td>
									<td class="remove-pr"><a href="#"> <i
											class="fas fa-times"></i>
									</a></td>
								</tr>
								<tr>
									<td class="thumbnail-img"><a href="#"> <img
											class="img-fluid" src="images/img-pro-02.jpg" alt="" />
									</a></td>
									<td class="name-pr"><a href="#"> Lorem ipsum dolor sit
											amet </a></td>
									<td class="price-pr">
										<p>$ 60.0</p>
									</td>
									<td class="quantity-box">In Stock</td>
									<td class="add-pr"><a class="btn hvr-hover" href="#">Add
											to Cart</a></td>
									<td class="remove-pr"><a href="#"> <i
											class="fas fa-times"></i>
									</a></td>
								</tr>
								<tr>
									<td class="thumbnail-img"><a href="#"> <img
											class="img-fluid" src="images/img-pro-03.jpg" alt="" />
									</a></td>
									<td class="name-pr"><a href="#"> Lorem ipsum dolor sit
											amet </a></td>
									<td class="price-pr">
										<p>$ 30.0</p>
									</td>
									<td class="quantity-box">In Stock</td>
									<td class="add-pr"><a class="btn hvr-hover" href="#">Add
											to Cart</a></td>
									<td class="remove-pr"><a href="#"> <i
											class="fas fa-times"></i>
									</a></td> -->
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Wishlist -->

	<jsp:include page="../include/footer.jsp" />

	<script type="text/javascript">
		var carts = ${jsonCarts}
		var products = ${jsonProducts}
		
		var btnAddToCarts = document.querySelectorAll('.btnAddToCart');
		// Enable hay Disable nút Thêm vào giỏ hàng
		for(var btnAddToCart of btnAddToCarts){
			var trElement = btnAddToCart.parentElement.parentElement;
			
			var inputIdProduct = trElement.querySelector('input[name="idProduct"]')
			var inputSizeProduct = trElement.querySelector('input[name="sizeProduct"]')
			
			var idProduct = inputIdProduct.value
			var sizeProduct = inputSizeProduct.value
			
			console.log('idProduct :' + idProduct)
			console.log('sizeProduct :' + sizeProduct)
			
			var cart = getCartByID_Size(inputIdProduct.value, inputSizeProduct.value)
			//var product = getProductByID(inputIdProduct.value)
			
			
			console.log(cart)
			console.log(getInStockOfProduct(idProduct, sizeProduct))
			// Nếu tìm thấy sản phẩm này trong giỏ hàng hoặc số lượng hàng tồn == 0 thì disable btnAddToCart
			if( typeof cart != 'undefined' || getInStockOfProduct(idProduct, sizeProduct) == 0){
				btnAddToCart.style['pointer-events'] = 'none';
				btnAddToCart.style.cursor = 'none';
				btnAddToCart.style.backgroundColor = '#ff3333';
			}
				
		}
		
		function getCartByID_Size(idProduct, size) {
			for (var cart of carts) {
				if (cart.idProduct == idProduct && cart.size == size ) {
					return cart;
				}
			}
		}
		
		function getInStockOfProduct (idProduct, size) {
			for (var product of products) {
				if (product.idProduct == idProduct ) {
					//console.log(product)
					return product.productStocks[size];
				}
			}
		}
		
		
	
	</script>
</body>

</html>