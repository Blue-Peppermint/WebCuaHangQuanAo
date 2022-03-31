<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<base href="${pageContext.servletContext.contextPath}/">
<!-- Start Main Top -->
<header class="main-header">
	<!-- Start Navigation -->
	<nav
		class="navbar navbar-expand-lg navbar-light bg-light navbar-default bootsnav">
		<div class="container">
			<!-- Start Header Navigation -->
			<div class="navbar-header">
				<a class="navbar-brand" href="home/index.htm"><img
					src="images/my-logo.png" class="logo" alt=""></a>
			</div>
			<!-- End Header Navigation -->

			<!-- Hint: Navigate Bar  -->
			<div class="collapse navbar-collapse" id="navbar-menu">
				<ul class="nav navbar-nav ml-auto" data-in="fadeInDown"
					data-out="fadeOutUp">
					<!-- <li class="nav-item active "><a class="nav-link"
						href="home/index.htm">Trang Chủ</a></li> -->
					<li class="nav-item "><a class="nav-link"
						href="home/index.htm">Trang Chủ</a></li>

					<!-- <li  class="nav-item"  ><a class="nav-link" href="shop/all.htm">Tất Cả</a></li> -->
					<c:forEach var="category" items="${sessionScope.categories}">
						<li class="nav-item"><a class="nav-link"
							href="shop/${category.name}.htm">${category.name }</a></li>
					</c:forEach>
					<%-- <li class="dropdown"><a href="#" class="nav-link"
						data-toggle="dropdown">Cửa Hàng <i class="fas fa-caret-down"></i></a>
						<ul class="dropdown-menu">
							<li><a href="shop/all.htm">Tất Cả</a></li>
							<c:forEach var="category" items="${sessionScope.categories}">
								<li><a href="shop/${category.name}.htm">${category.name }</a></li>
							</c:forEach>
						</ul></li> --%>
					<!-- <li class="nav-item"><a class="nav-link" href="gallery.html">Gallery</a></li>
						<li class="nav-item"><a class="nav-link"
							href="contact-us.html">Contact Us</a></li> -->
				</ul>
			</div>

			<!-- Hint: Phẩn Login, Giỏ hàng ở vị trí này -->
			<div class="attr-nav">
				<div class=" navbar-collapse">
					<ul class="nav" data-in="fadeInDown" data-out="fadeOutUp">
						<li class="search"><a href="#"><i class="fad fa-search"></i></a></li>
						<li class="side-menu dropdown">
							<%
								//System.out.println("vao duoc ne"); 

								//System.out.println("checkLogin " + request.getAttribute("checkLogin"));
								//System.out.println("userTest " + request.getAttribute("userTest"));

								//System.out.println("user " + session.getAttribute("user").getUserDetail());
								%> <c:choose>
								<c:when test="${not empty sessionScope.userDetail}">
									<a href="#" data-toggle="dropdown"><i class="fad fa-user"></i>
										<p style="font-size: 80%;">
											${sessionScope.userDetail.name}</p></a>
									<ul class="dropdown-menu">
										<c:if test="${sessionScope.user.userRole.roleName =='admin'}">
											<li><a href="admin/editProduct.htm">DashBoard</a></li>
										</c:if>
										<li><a href="my-account/home.htm">Tài Khoản Của Tôi</a></li>
										<li><a href="my-account/bills.htm">Đơn Hàng Của Tôi</a></li>
										<li><a href="my-account/wishlist/showWishlist.htm">Sản
												Phẩm Yêu Thích</a></li>
										<li><a href="my-account/settingAccount.htm">Cài Đặt
												Tài Khoản</a></li>
										<li><a href="admin/logout.htm">Đăng Xuất</a></li>

									</ul>
								</c:when>
								<c:otherwise>
									<a href="home/login.htm"><i class="fad fa-user"></i> Đăng
										Nhập</a>
								</c:otherwise>
							</c:choose>
						</li>
						<c:choose>
							<c:when test="${not empty sessionScope.userDetail}">
								<li class="side-menu"><a href="cart/showCart.htm"> <i
										class="fad fa-shopping-cart"></i> <span class="badge"
										style="position: absolute; top: 50%; margin-top: -15px; right: 15px; font-size: 12px; padding: 0; width: 15px; height: 15px; padding-top: 2px;">
											${sessionScope.cartItemSize} </span>
										<p style="font-size: 80%;">Giỏ Hàng</p>
								</a></li>
							</c:when>
							<c:otherwise>
								<li class="side-menu"><a href="home/login.htm"> <i
										class="fad fa-shopping-cart"></i> <span class="badge"
										style="position: absolute; top: 50%; margin-top: -15px; right: 15px; font-size: 12px; padding: 0; width: 15px; height: 15px; padding-top: 2px;">0</span>
										<p style="font-size: 80%;">Giỏ Hàng</p>
								</a></li>
							</c:otherwise>
						</c:choose>

					</ul>
				</div>

			</div>
			<!-- End Atribute Navigation -->
		</div>
	</nav>
	<!-- End Navigation -->
</header>
<!-- End Main Top -->


