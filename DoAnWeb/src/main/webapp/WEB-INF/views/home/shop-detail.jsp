<%@page import="java.text.SimpleDateFormat"%>
<%@page import="ptithcm.entity.UserDetail"%>
<%@page import="ptithcm.entity.ProductReview"%>
<%@page import="ptithcm.entity.ProductImg"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ptithcm.entity.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<!-- Basic -->

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<!-- Mobile Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Site Metas -->
<title>${productDetail.name }</title>
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


<!-- CSS cho phần rating + reviews sản phẩm -->
<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
	integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p"
	crossorigin="anonymous" />
<link rel="stylesheet" href="css/reviewBox.css">



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
					<!-- <h2>Shop Detail</h2> -->
					<ul class="breadcrumb">
						<li class="breadcrumb-item"><a href="home/index.htm">Trang Chủ</a></li>
						<li class="breadcrumb-item"><a href="shop/${productDetail.category.name }.htm">${productDetail.category.name }</a></li>
						<li class="breadcrumb-item active">${productDetail.name }</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End All Title Box -->

	<!-- Start Shop Detail  -->
	<div class="shop-detail-box-main">
		<div class="container">
			<!-- Hint: Div giới thiệu sản phẩm, mua hàng, thêm vào giỏ hàng, ... -->
			<div class="row">
				<div class="col-xl-5 col-lg-5 col-md-6">
					<!-- Hint: Slider hình ảnh sản phẩm -->
					<div id="carousel-example-1"
						class="single-product-slider carousel slide" data-ride="carousel">
						<div class="carousel-inner" role="listbox">

							<%
							//Product p = (Product)request.getAttribute("productDetail");
							//ArrayList<ProductImg> list = new ArrayList<>(p.getProductImgs());

							//System.out.println(list);
							/* for(ProductImg s : list){
								System.out.println(s.getSource());
							} */
							%>
							<c:forEach var="img" items="${productDetail.productImgs}">
								<c:choose>
									<c:when
										test="${img.source == productDetail.productImgs[0].source}">

										<%-- <c:out value="img" /> --%>
										<div class="carousel-item active">
											<img class="d-block w-100" src="images/${img.source}"
												alt="First slide">
										</div>
									</c:when>
									<c:otherwise>
										<div class="carousel-item">
											<img class="d-block w-100" src="images/${img.source}" alt=" slide">
										</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</div>
						<a class="carousel-control-prev" href="#carousel-example-1"
							role="button" data-slide="prev"> <i class="fa fa-angle-left"
							aria-hidden="true"></i> <span class="sr-only">Previous</span>
						</a> <a class="carousel-control-next" href="#carousel-example-1"
							role="button" data-slide="next"> <i class="fa fa-angle-right"
							aria-hidden="true"></i> <span class="sr-only">Next</span>
						</a>
						<ol class="carousel-indicators">

							<%
							Product productDetail = (Product) request.getAttribute("productDetail");
							ArrayList<ProductImg> list = new ArrayList<>(productDetail.getProductImgs());
							//System.out.println("size :" + list.size());
							if (list.size() >= 1) {
							%>

							<li data-target="#carousel-example-1" data-slide-to="0"
								class="active"><img class="d-block w-100 img-fluid"
								src="images/${ productDetail.productImgs[0].source}" alt="" /></li>


							<%
							}
							if (list.size() >= 2) {
							%>


							<li data-target="#carousel-example-1" data-slide-to="1"><img
								class="d-block w-100 img-fluid"
								src="images/${ productDetail.productImgs[1].source}" alt="" /></li>

							<%
							}
							if (list.size() == 3) {
							%>

							<li data-target="#carousel-example-1" data-slide-to="2"><img
								class="d-block w-100 img-fluid"
								src="images/${productDetail.productImgs[2].source }" alt="" /></li>


							<%
							}
							%>

						</ol>
					</div>
				</div>
				<!-- Hint: Tên sản phẩm, giá, các btn mua hàng, thêm vào yêu thích -->
				<div class="col-xl-7 col-lg-7 col-md-6">
					<div class="single-product-details">
						<h2>${productDetail.name }</h2>
						<div class="percentage-star-rating" title="70%">
							<div class="back-stars">
								<i class="fa fa-star" aria-hidden="true"></i> <i
									class="fa fa-star" aria-hidden="true"></i> <i
									class="fa fa-star" aria-hidden="true"></i> <i
									class="fa fa-star" aria-hidden="true"></i> <i
									class="fa fa-star" aria-hidden="true"></i>

								<div class="front-stars" style="width: 70%">
									<i class="fa fa-star" aria-hidden="true"></i> <i
										class="fa fa-star" aria-hidden="true"></i> <i
										class="fa fa-star" aria-hidden="true"></i> <i
										class="fa fa-star" aria-hidden="true"></i> <i
										class="fa fa-star" aria-hidden="true"></i>
								</div>
							</div>

						</div>
						<b class="star-rating text-black ml-2">(${productReviews.size()}
							đánh giá) </b>
						<p class="available-stock">
						<c:choose>
							<c:when test="${productDetail.getTotalInStock() != 0 }">
								<span> Còn Hàng </span> <br>
							</c:when>
							<c:otherwise>
								<span style="color: red;"> Hết Hàng </span> <br>
							</c:otherwise>
						</c:choose>
							
							<c:choose>
								<c:when test="${productDetail.discount != 0}">
									<h5 style="font-size: 150%">
										<fmt:formatNumber type="currency" pattern="#₫"
											value="${productDetail.price * (100 - productDetail.discount)/100}" />

										<del>${productDetail.price}₫</del>
										<p style="display: inline; font-size: 60%; color: red;">(-${productDetail.discount}%)</p>
									</h5>
								</c:when>
								<c:otherwise>
									<h5>${productDetail.price}đ</h5>
								</c:otherwise>
							</c:choose>
						<p>
						<h4>Chi Tiết Sản Phẩm:</h4>
						<p>${productDetail.decription }</p>
						<ul>
							<li>
								<div class="form-group quantity-box">
									<label class="control-label">Số Lượng</label> <input
										id="spinnerQuantity" class="form-control" value="0" min="0"
										max="${productDetail.productStocks[0].inStock }" type="number">

								</div>
							</li>
							<li>
								<div class="form-group quantity-box">
									<label class="control-label">Size</label> <select
										id="comboboxSize" class="form-control">
										<c:forEach var="productStock" items="${productDetail.productStocks }">
											<option value="${productStock.size }">${productStock.size }</option>
										</c:forEach>
										<!-- <option value="L">L</option>
										<option value="XL">XL</option>
										<option value="XXL">XXL</option> -->
									</select>
								</div>
							</li>
						</ul>

						<div class="price-box-bar">
							<div class="cart-and-bay-btn">
								<!-- <a class="btn hvr-hover" data-fancybox-close="" href="#">Buy New</a> -->
								<c:choose>
									<c:when test="${productDetail.productStocks[0].inStock == 0}">
										<a id="btnAddToCart" class="btn hvr-hover disabled"
											data-fancybox-close=""
											href="shop-detail/addToCart.htm?idProduct=${productDetail.idProduct}"><i
											class="fad fa-shopping-cart"></i> Chọn Mua</a>
									</c:when>
									<c:otherwise>
										<a id="btnAddToCart" class="btn hvr-hover"
											data-fancybox-close=""
											href="shop-detail/addToCart.htm?idProduct=${productDetail.idProduct}"><i
											class="fad fa-shopping-cart"></i> Chọn Mua</a>
									</c:otherwise>
								</c:choose>
								<a id="btnAddToWishlist" class="btn hvr-hover"
									data-fancybox-close=""
									href="shop-detail/addToWishlist.htm?idProduct=${productDetail.idProduct}"><i
									class="fad fa-heart"></i> Thêm vào yêu thích</a>
							</div>
						</div>

						<!-- <div class="add-to-btn">
                                    <div class="add-comp">
                                        <a class="btn hvr-hover" href="#"><i class="fas fa-heart"></i> Add to wishlist</a>
                                        <a class="btn hvr-hover" href="#"><i class="fas fa-sync-alt"></i> Add to Compare</a>
                                    </div>
                                    <div class="share-bar">
                                        <a class="btn hvr-hover" href="#"><i class="fab fa-facebook" aria-hidden="true"></i></a>
                                        <a class="btn hvr-hover" href="#"><i class="fab fa-google-plus" aria-hidden="true"></i></a>
                                        <a class="btn hvr-hover" href="#"><i class="fab fa-twitter" aria-hidden="true"></i></a>
                                        <a class="btn hvr-hover" href="#"><i class="fab fa-pinterest-p" aria-hidden="true"></i></a>
                                        <a class="btn hvr-hover" href="#"><i class="fab fa-whatsapp" aria-hidden="true"></i></a>
                                    </div>
                                </div> -->
					</div>
				</div>
			</div>

			<!-- Hint: Div rating + review sản phẩm   -->
			<div class="row my-5">
				<div class="card card-outline-secondary my-4">
					<div class="card-header">
						<h2>Đánh Giá - Nhận Xét Từ Khách Hàng</h2>
					</div>
					<div class="container">
						<div class="col-md-12">
							<div class="offer-dedicated-body-left">
								<div class="tab-content" id="pills-tabContent">
									<div class="tab-pane fade active show" id="pills-reviews"
										role="tabpanel" aria-labelledby="pills-reviews-tab">
										<div
											class="bg-white rounded shadow-sm p-4 mb-4 clearfix graph-star-rating">
											<h5 class="mb-0 mb-4">
												<b style="font-size: 160%;">Đánh Giá</b>
											</h5>
											<div class="graph-star-rating-header">
												<div class="percentage-star-rating" title="70%">
													<div class="back-stars">
														<i class="fa fa-star" aria-hidden="true"></i> <i
															class="fa fa-star" aria-hidden="true"></i> <i
															class="fa fa-star" aria-hidden="true"></i> <i
															class="fa fa-star" aria-hidden="true"></i> <i
															class="fa fa-star" aria-hidden="true"></i>

														<div class="front-stars" style="width: 70%">
															<i class="fa fa-star" aria-hidden="true"></i> <i
																class="fa fa-star" aria-hidden="true"></i> <i
																class="fa fa-star" aria-hidden="true"></i> <i
																class="fa fa-star" aria-hidden="true"></i> <i
																class="fa fa-star" aria-hidden="true"></i>
														</div>
													</div>
												</div>
												<b class="star-rating text-black ml-2">${productReviews.size()}
													Đánh giá</b>
												<p class="text-black mb-4 mt-2">
													Đánh giá
													<%
												int totalRating = 0;
												ArrayList<ProductReview> productReviews = (ArrayList<ProductReview>) request.getAttribute("productReviews");
												for (ProductReview review : productReviews) {
													totalRating += review.getRatingScore();
												}
												float averageRating = 0;
												if (productReviews.size() != 0) {
													averageRating = (float) totalRating / productReviews.size() * 1.0f;
												}
												%>
													<%=averageRating%>
													/ 5.0
												</p>
											</div>
											<!-- Hint: Tổng quan rating -->
											<div class="graph-star-rating-body">
												<div class="rating-list">
													<div class="rating-list-left text-black star-rating">
														<i class="fas fa-star active"></i> 5
													</div>
													<div class="rating-list-center">
														<div class="progress">
															<!-- Hint: width = độ dài thanh rating của các star -->
															<div style="width: 56%" aria-valuemax="5"
																aria-valuemin="0" aria-valuenow="5" role="progressbar"
																class="progress-bar my-bg-primary">
																<span class="sr-only">80% Complete (danger)</span>
															</div>
														</div>
													</div>
													<div class="rating-list-right text-black">56%</div>
												</div>
												<div class="rating-list">
													<div class="rating-list-left text-black star-rating">
														<i class="fas fa-star active"></i> 4
													</div>
													<div class="rating-list-center">
														<div class="progress">
															<div style="width: 23%" aria-valuemax="5"
																aria-valuemin="0" aria-valuenow="5" role="progressbar"
																class="progress-bar my-bg-primary">
																<span class="sr-only">80% Complete (danger)</span>
															</div>
														</div>
													</div>
													<div class="rating-list-right text-black">23%</div>
												</div>
												<div class="rating-list">
													<div class="rating-list-left text-black star-rating">
														<i class="fas fa-star active"></i> 3
													</div>
													<div class="rating-list-center">
														<div class="progress">
															<div style="width: 11%" aria-valuemax="5"
																aria-valuemin="0" aria-valuenow="5" role="progressbar"
																class="progress-bar my-bg-primary">
																<span class="sr-only">80% Complete (danger)</span>
															</div>
														</div>
													</div>
													<div class="rating-list-right text-black">11%</div>
												</div>
												<div class="rating-list">
													<div class="rating-list-left text-black star-rating">
														<i class="fas fa-star active"></i> 2
													</div>
													<div class="rating-list-center">
														<div class="progress">
															<div style="width: 2%" aria-valuemax="5"
																aria-valuemin="0" aria-valuenow="5" role="progressbar"
																class="progress-bar my-bg-primary">
																<span class="sr-only">80% Complete (danger)</span>
															</div>
														</div>
													</div>
													<div class="rating-list-right text-black">2%</div>
												</div>
												<div class="rating-list">
													<div class="rating-list-left text-black star-rating">
														<i class="fas fa-star active"></i> 1
													</div>
													<div class="rating-list-center">
														<div class="progress">
															<div style="width: 0%" aria-valuemax="5"
																aria-valuemin="0" aria-valuenow="5" role="progressbar"
																class="progress-bar my-bg-primary">
																<span class="sr-only">80% Complete (danger)</span>
															</div>
														</div>
													</div>
													<div class="rating-list-right text-black">0%</div>
												</div>
											</div>
										</div>
										<div
											class="bg-white rounded shadow-sm p-4 mb-4 restaurant-detailed-ratings-and-reviews"
											style="width: 1080px">
											<a href="#"
												class="btn my-btn-outline-primary btn-sm float-right">Nhận
												Xét Mới Nhất</a>
											<h5 class="mb-1">
												<b style="font-size: 160%;">Nhận Xét</b>
											</h5>
											<!-- Hint: Div review của 1 khách hàng -->
											<%
											ArrayList<UserDetail> userDetails = (ArrayList<UserDetail>) request.getAttribute("userDetail");
											//ArrayList<ProductReview> productReviews = (ArrayList<ProductReview>) request.getAttribute("productReviews");
											int numberReviewShowed = 0;
											for (int i = 0; i < 3 && i < productReviews.size(); i++) {
												numberReviewShowed++;
												ProductReview productReviewNow = productReviews.get(i);
												UserDetail userReviewNow = null;
												for (UserDetail user : userDetails) {
													if (user.getId() == productReviewNow.getBill().getUser().getId()) {
												userReviewNow = user;
												break;
													}
												}
											%>

											<div class="reviews-members pt-4 pb-4">
												<div class="media">
													<a href="#"><img alt="Avatar image"
														src="images/<%=userReviewNow.getImgAvatar()%>"
														class="mr-3 rounded-pill"></a>
													<div class="media-body">
														<div class="reviews-members-header">
															<!-- Hint: Đánh giá Sao của cá nhân -->
															<span class="star-rating float-right"> <%
 int ratingScore = productReviewNow.getRatingScore();
 for (int j = 0; j < ratingScore; j++) {
 %> <a href="#"><i class="fas fa-star active"></i></a> <%
 }
 for (int j = ratingScore; j < 5; j++) {
 %> <a href="#"><i class="fas fa-star "></i></a> <%
 }
 %>
															</span>
															<!-- Hint: Tên Khách review + Ngày review -->
															<h6 class="mb-1">
																<a class="text-black" href="#"><%=userReviewNow.getName()%></a>
															</h6>
															<%
															SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, YYYY");
															%>
															<p class="text-gray"><%=dateFormat.format(productReviewNow.getDateReview())%></p>
														</div>
														<!-- Hint: Nội dung review -->
														<div class="reviews-members-body">
															<p><%=productReviewNow.getContentText()%></p>
														</div>
														<div class="reviews-members-footer">
															<a class="my-total-like" href="#"><i
																class="fad fa-thumbs-up"></i></a> <a class="my-total-like"
																href="#"><i class="fad fa-thumbs-down"></i></a>
														</div>
													</div>
												</div>
											</div>
											<hr>

											<%
											}
											if (productReviews.size() > numberReviewShowed) {
											%>
											<p id="btnLoadMore"
												class="text-center w-100 d-block mt-4 font-weight-bold">Xem
												Tất Cả</p>
											<%
											} else {
											%>
											<hr>
											<%
											}
											%>
										</div>

									</div>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>

			<!-- Hint: Div sản phẩm tương tự   -->
			<div class="row my-5">
				<div class="col-lg-12">
					<div class="title-all text-center">
						<h1>Sản Phẩm Tương Tự</h1>
						<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
							Sed sit amet lacus enim.</p>
					</div>
					<div class="featured-products-box owl-carousel owl-theme">
						<!-- Hint: 1 sản phẩm tương tự -->
						<c:forEach var="product" items="${similarProducts}">
							<div class="item">
								<a
									href="shop-detail/showProduct.htm?idProduct=${product.idProduct}">
									<div id="productShop" class="products-single fix">
										<div class="box-img-hover">
											<img src="images/${product.productImgs[0].source}" class="img-fluid"
												alt="Image">
											<c:if test="${ product.discount != 0 }">
												<div class="type-lb">
													<p class="sale">Sale ${product.discount} %</p>
												</div>

											</c:if>
										</div>
										<div class="why-text">
											<h4>${product.name }</h4>

											<c:choose>
												<c:when test="${ product.discount != 0 }">
													<h5>
														<fmt:formatNumber type="currency" pattern="#₫"
															value="${product.price * (100 - product.discount)/100}" />
													</h5>
													<span> ${product.price}₫</span>
												</c:when>
												<c:otherwise>
													<h5>${product.price}₫</h5>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</a>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>

	</div>
	</div>
	<!-- End Cart -->


	   <!-- Start Footer  -->
    <footer>
        <div class="footer-main" style="background-color: #f4f4f4;">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-12 col-sm-12">
                        <div class="footer-top-box">
                            <h3>Business Time</h3>
                            <ul class="list-time">
                                <li>Monday - Friday: 08.00am to 05.00pm</li>
                                <li>Saturday: 10.00am to 08.00pm</li>
                                <li>Sunday: <span>Closed</span></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-12 col-sm-12">
                        <div class="footer-top-box">
                            <h3>Newsletter</h3>
                            <form class="newsletter-box">
                                <div class="form-group">
                                    <input class="" type="email" name="Email" placeholder="Email Address*" />
                                    <i class="fa fa-envelope"></i>
                                </div>
                                <button class="btn hvr-hover" type="submit">Submit</button>
                            </form>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-12 col-sm-12">
                        <div class="footer-top-box">
                            <h3>Social Media</h3>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                            <ul>
                                <li><a href="#"><i class="fab fa-facebook" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fab fa-twitter" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fab fa-linkedin" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fab fa-google-plus" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fa fa-rss" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fab fa-pinterest-p" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fab fa-whatsapp" aria-hidden="true"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-lg-4 col-md-12 col-sm-12">
                        <div class="footer-widget">
                            <h4>About Freshshop</h4>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-12 col-sm-12">
                        <div class="footer-link">
                            <h4>Information</h4>
                            <ul>
                                <li><a href="#">About Us</a></li>
                                <li><a href="#">Customer Service</a></li>
                                <li><a href="#">Our Sitemap</a></li>
                                <li><a href="#">Terms &amp; Conditions</a></li>
                                <li><a href="#">Privacy Policy</a></li>
                                <li><a href="#">Delivery Information</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-12 col-sm-12">
                        <div class="footer-link-contact">
                            <h4>Contact Us</h4>
                            <ul>
                                <li>
                                    <p><i class="fas fa-map-marker-alt"></i>Address: Michael I. Days 3756 <br>Preston Street Wichita,<br> KS 67213 </p>
                                </li>
                                <li>
                                    <p><i class="fas fa-phone-square"></i>Phone: <a href="tel:+1-888705770">+1-888 705 770</a></p>
                                </li>
                                <li>
                                    <p><i class="fas fa-envelope"></i>Email: <a href="mailto:contactinfo@gmail.com">contactinfo@gmail.com</a></p>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- End Footer  -->

    <!-- Start copyright  -->
    <div class="footer-copyright">
        <p class="footer-company">All Rights Reserved. &copy; 2018 <a href="#">ThewayShop</a> Design By :
            <a href="https://html.design/">html design</a></p>
    </div>
    <!-- End copyright  -->

    <a href="#" id="back-to-top" title="Back to top" style="display: none;">&uarr;</a>


    <!-- ALL JS FILES -->
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <!-- ALL PLUGINS -->
    <script src="js/jquery.superslides.min.js"></script>
    <script src="js/bootstrap-select.js"></script>
    <script src="js/inewsticker.js"></script>
    <script src="js/bootsnav.js."></script>
    <script src="js/images-loded.min.js"></script>
    <script src="js/isotope.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/baguetteBox.min.js"></script>
    <script src="js/form-validator.min.js"></script>
    <script src="js/contact-form-script.js"></script>
    <script src="js/custom.js"></script>

	<%
	request.setAttribute("numberReviewShowed", numberReviewShowed);
	%>

	<script type="text/javascript">
	var productDetail = ${jsonProductDetail}
	
	var spinnerQuantity = document.querySelector('#spinnerQuantity')
	var comboboxSize = document.querySelector('#comboboxSize')
	var btnAddToCart = document.querySelector('#btnAddToCart');
	var btnAddToWishlist = document.querySelector('#btnAddToWishlist')
	
	//console.log(productDetail)
	
	// Tùy chỉnh khi chọn combobox Size
	comboboxSize.addEventListener('change', function(e){
		// Tùy chỉnh Maximum value của SpinnerQuantity
		var size = comboboxSize.options[comboboxSize.selectedIndex].value;
		var sizeQuantity = productDetail.productStocks[size];
		
		spinnerQuantity.value = 0
		spinnerQuantity.max = sizeQuantity
		//console.log(productDetail.productStocks[size])
		
		// Tùy chỉnh disable nút chọn mua
		if(sizeQuantity == 0){
			btnAddToCart.classList.add("disabled")
		}else{
			btnAddToCart.classList.remove("disabled")
		}
	})
	
	btnAddToCart.addEventListener('click' , function(e){
		btnAddToCart.href += '&quantity='+ spinnerQuantity.value + 
		'&size=' + comboboxSize.options[comboboxSize.selectedIndex].value
		//console.log(spinnerQuantity.value);
	})
	
	btnAddToWishlist.addEventListener('click', function(e){
		btnAddToWishlist.href += '&size=' + comboboxSize.options[comboboxSize.selectedIndex].value
	})
	
	
	var numberReviewShowed = ${numberReviewShowed}
	var itemReviews = ${jsonProductReviews}
	//console.log(itemReviews)
	// hiển thị tổng sao rating sản phẩm
    showTotalStarRating()
    showStarRatingForAll();
	
 // Nút xem tất cả review. Sắp xếp từ mới -> cũ
    var btnLoadMore = document.querySelector('#btnLoadMore')
    btnLoadMore.onclick = function(e) {
        itemReviews.sort(function(a, b) {
            return b.dateReview - a.dateReview;
        })
        var length = itemReviews.length
        for (var i = numberReviewShowed; i < length; i++) {
            if (i == length - 1) {
                addingReview(itemReviews[i], false)
            } else {
                addingReview(itemReviews[i], true)
            }

        }
    };
    // Thêm 1 review vào 
    function addingReview(review, isFinalReview) {
        var divReviews = document.querySelector('.restaurant-detailed-ratings-and-reviews')
        btnLoadMore.remove()
        divReviews.innerHTML += `
            <div class="reviews-members pt-4 pb-4">
            <div class="media">
                <!-- Hint: Avatar cá nhân -->
                <a href="#"><img alt="Avatar User" src="" class="mr-3 rounded-pill"></a>
                <div class="media-body">
                    <div class="reviews-members-header">
                        <!-- Hint: Đánh giá Sao của cá nhân -->
                        <div class="star-rating float-right">
                            <a href="#"><i class="fas fa-star "></i></a>
                            <a href="#"><i class="fas fa-star "></i></a>
                            <a href="#"><i class="fas fa-star "></i></a>
                            <a href="#"><i class="fas fa-star "></i></a>
                            <a href="#"><i class="fas fa-star "></i></a>
                        </div>
                        <!-- Hint: Tên Khách review + Ngày review -->
                        <h6 class="mb-1"><a class="text-black" href="#">Singh Osahan</a></h6>
                        <p class="text-gray">Tue, 20 Mar 2020</p>
                    </div>
                    <!-- Hint: Nội dung review -->
                    <div class="reviews-members-body">
                        <p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin
                            professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical
                            literature, discovered the undoubtable source. Lorem Ipsum comes from sections </p>
                    </div>
                    <div class="reviews-members-footer">
                        <a class="my-total-like" href="#"><i class="fad fa-thumbs-up"></i></a> <a class="my-total-like" href="#"><i class="fad fa-thumbs-down"></i> </a>
                    </div>
                </div>
            </div>
        </div>

    `;
        var divReviewProcessing = divReviews.lastElementChild;
        // Thêm avatar, star rating, date review, content review
        divReviewProcessing.querySelector('.mr-3.rounded-pill').src = 'images/'+ review.imgAvatar
        var divStarRating = divReviewProcessing.querySelector('.star-rating.float-right').children
        for (var i = 0; i < divStarRating.length && i < review.ratingScore; i++) {
            divStarRating[i].querySelector('i').classList.add('active')
        }

        divReviewProcessing.querySelector('.text-black').innerText = review.customerName

        /* var dd = String(review.dateReview.getDate()).padStart(2, '0');
        var mm = String(review.dateReview.getMonth() + 1).padStart(2, '0'); //January is 0!
        var yyyy = review.dateReview.getFullYear();

        var hh = String(review.dateReview.getHours())
        var mm2 = String(review.dateReview.getMinutes())
        var ss = String(review.dateReview.getSeconds())
        var timeFormatted = `${mm}/${dd}/${yyyy} ${hh}:${mm2}`; */
        divReviewProcessing.querySelector('.text-gray').innerText = review.dateReview

        divReviewProcessing.querySelector('.reviews-members-body p').innerText = review.contentText

        if (isFinalReview) {
            divReviews.innerHTML += '<hr>'
        }
    }

	
	
	
	
 	// show tổng rating sản phẩm
    function showTotalStarRating() {
        var totalRating = itemReviews.reduce(function(returnVal, val) {
            return returnVal + val.ratingScore;
        }, 0)

        

        const starRatingWrapperArr = document.querySelectorAll('.percentage-star-rating');
        const frontStarsArr = document.querySelectorAll('.front-stars');
        var percentage;
        if(totalRating == 0){
        	percentage = '0%'
        }else{
        	percentage = ((totalRating / (5 * itemReviews.length)) * 100) + '%'
        }
         
        
        for (var starRating of starRatingWrapperArr) {
            starRating.title = percentage;
        }
        for (var frontStars of frontStarsArr) {
            frontStars.style.width = percentage;
        }

    }

    // show tổng rating của tất cả loại sao (trong phần đánh giá)
    function showStarRatingForAll() {

        var starRatingLvl1 = itemReviews.reduce(function(returnVal, val) {
            if (val.ratingScore == 1) {
                return returnVal += 1
            }
            return returnVal
        }, 0)
        var starRatingLvl2 = itemReviews.reduce(function(returnVal, val) {
            if (val.ratingScore == 2) {
                return returnVal += 1
            }
            return returnVal
        }, 0)
        var starRatingLvl3 = itemReviews.reduce(function(returnVal, val) {
            if (val.ratingScore == 3) {
                return returnVal += 1
            }
            return returnVal
        }, 0)
        var starRatingLvl4 = itemReviews.reduce(function(returnVal, val) {
            if (val.ratingScore == 4) {
                return returnVal += 1
            }
            return returnVal
        }, 0)
        var starRatingLvl5 = itemReviews.reduce(function(returnVal, val) {
            if (val.ratingScore == 5) {
                return returnVal += 1
            }
            return returnVal
        }, 0)
		
        	var percentageOfRatingLv1 = '0%'
            var percentageOfRatingLv2 = '0%'
            var percentageOfRatingLv3 = '0%'
            var percentageOfRatingLv4 = '0%'
            var percentageOfRatingLv5 = '0%'
        
        if(itemReviews.length != 0){
        	 percentageOfRatingLv1 = ((starRatingLvl1 / itemReviews.length) * 100 + '%')
             percentageOfRatingLv2 = ((starRatingLvl2 / itemReviews.length) * 100 + '%')
             percentageOfRatingLv3 = ((starRatingLvl3 / itemReviews.length) * 100 + '%')
             percentageOfRatingLv4 = ((starRatingLvl4 / itemReviews.length) * 100 + '%')
             percentageOfRatingLv5 = ((starRatingLvl5 / itemReviews.length) * 100 + '%')
        }
        
        showStarRatingForEach(1, starRatingLvl1, percentageOfRatingLv1)
        showStarRatingForEach(2, starRatingLvl2, percentageOfRatingLv2)
        showStarRatingForEach(3, starRatingLvl3, percentageOfRatingLv3)
        showStarRatingForEach(4, starRatingLvl4, percentageOfRatingLv4)
        showStarRatingForEach(5, starRatingLvl5, percentageOfRatingLv5)
    }

    // show tổng rating của 1 loại sao (sao 1, sao 2,...) (trong phần đánh giá)
    function showStarRatingForEach(level, total, percentageOfTotal) {
        var divGraphRatingBody = document.querySelector('.graph-star-rating-body')
        var ratingListNow = divGraphRatingBody.lastElementChild;

        var lvlNow = 1;
        while (lvlNow < level) {
            ratingListNow = ratingListNow.previousElementSibling
            lvlNow++;
        }
        ratingListNow.querySelector('.progress-bar').style.width = percentageOfTotal
        ratingListNow.querySelector('.rating-list-right').innerHTML = total
    }
	</script>

</body>

</html>