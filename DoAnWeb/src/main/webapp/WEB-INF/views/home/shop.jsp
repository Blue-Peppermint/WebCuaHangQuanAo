<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="tg" tagdir="/WEB-INF/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<!-- Basic -->

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<!-- Mobile Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Site Metas -->
<title>Cửa Hàng</title>
<meta name="keywords" content="">
<meta name="description" content="">
<meta name="author" content="">

<base href="${pageContext.servletContext.contextPath}/">
<link rel="icon" href="images/my-logo-mini.png">



<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<!-- Site CSS -->
<link rel="stylesheet" href="css/style.css">
<!-- Responsive CSS -->
<link rel="stylesheet" href="css/responsive.css">
<!-- Custom CSS -->
<link rel="stylesheet" href="css/custom.css">

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
	<!-- Start All Title Box -->
	<div class="all-title-box">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<h2>Cửa Hàng</h2>
					<ul class="breadcrumb">
						<li class="breadcrumb-item"><a href="home/index.htm">Trang
								Chủ</a></li>
						<li class="breadcrumb-item active">${categoryNameNow}</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End All Title Box -->

	<!-- Start Shop Page  -->
	<div class="shop-box-inner">
		<div class="container">
			<div class="row">
				<div
					class="col-xl-9 col-lg-9 col-sm-12 col-xs-12 shop-content-right">
					<div class="right-product-box">
						<div class="product-item-filter row">
							<div class="col-12 col-sm-8 text-center text-sm-left">
								<!-- Hint: Toolbar sắp xếp -->
								<div class="toolbar-sorter-right">
									<span>Sắp xếp</span> <select id="basic"
										class="selectpicker show-tick form-control"
										data-placeholder="$ USD">
										<c:forEach var="sortType" items="${sortTypes}"
											varStatus="tagStatus">
											<c:choose>
												<c:when test="${tagStatus.index == 0} ">
													<option value="${tagStatus.index}" data-display="Select">${sortType}</option>
												</c:when>
												<c:otherwise>
													<option value="${tagStatus.index}">${sortType}</option>
												</c:otherwise>
											</c:choose>

										</c:forEach>
									</select>
								</div>
								<p>Showing all 4 results</p>
							</div>
							<div class="col-12 col-sm-4 text-center text-sm-right">
								<ul class="nav nav-tabs ml-auto">
									<li><a class="nav-link active" href="#grid-view"
										data-toggle="tab"> <i class="fa fa-th"></i>
									</a></li>
									<!-- <li>
                                        <a class="nav-link" href="#list-view" data-toggle="tab"> <i class="fa fa-list-ul"></i> </a>
                                    </li> -->
								</ul>
							</div>
						</div>
						<!-- Hint: load sản phẩm  -->
						<div class="product-categorie-box">
							<jsp:useBean id="pagedListHolder" scope="request"
								type="org.springframework.beans.support.PagedListHolder" />

							<c:url value="shop/redirect.htm" var="pagedLink">
								<c:param name="p" value="~${urlParam}" />
							</c:url>

							<div class="tab-content">
								<!-- Hint: xem danh sách dạng grid -->
								<div role="tabpanel" class="tab-pane fade show active"
									id="grid-view">
									<div class="row">
										<!-- Hint: Div 1 sản phẩm -->
										<c:forEach var="product" items="${pagedListHolder.pageList}">
											<div class="col-sm-6 col-md-6 col-lg-4 col-xl-3">
												<a id="productShop"
													href="shop-detail/showProduct.htm?idProduct=${product.idProduct}">
													<div class="products-single fix">
														<div class="box-img-hover">
															<img src="images/${product.productImgs[0].source}"
																class="img-fluid" alt="Image">
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

									<!--Hint: Phân Trang  -->
									<div>
										<tg:paging pagedListHolder="${pagedListHolder}"
											pagedLink="${pagedLink}" />
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- Hint: Thanh tìm kiếm + danh mục sản phẩm -->
				<div class="col-xl-3 col-lg-3 col-sm-12 col-xs-12 sidebar-shop-left">
					<div class="product-categori">
						<div class="search-product">
							<input class="form-control" placeholder="Tìm kiếm tên sản phẩm"
								type="text">
							<button type="submit">
								<i class="fa fa-search"></i>
							</button>
						</div>
						<div class="filter-sidebar-left">
							<div class="title-left">
								<h3>DANH MỤC SẢN PHẨM</h3>
							</div>
							<div
								class="list-group list-group-collapse list-group-sm list-group-tree"
								id="list-group-men" data-children=".sub-men">
								<a id="category-0" href="shop/all.htm"
									class="list-group-item list-group-item-action"> Tất Cả<small
									class="text-muted"></small>
								</a>
								<c:forEach var="category" items="${categories}">
									<a id="category-${category.id}"
										href="shop/${category.name}.htm"
										class="list-group-item list-group-item-action">
										${category.name } <small class="text-muted"> </small>
									</a>
								</c:forEach>
							</div>
						</div>
						<!-- Hint: Slider Chỉnh Giá -->
						<div class="filter-price-left">
							<div class="title-left">
								<h3>Lọc Theo Giá</h3>
							</div>
							<div class="price-box-slider">
								<!-- <div id="slider-range"></div> -->
								<!-- <div id="slider-range" class="ui-slider ui-slider-horizontal ui-widget ui-widget-content ui-corner-all">
                                    <div class="ui-slider-range ui-widget-header ui-corner-all" style="left: 50.675%; width: 0%;"></div>
                                    <span class="ui-slider-handle ui-state-default ui-corner-all" tabindex="0" style="left: 50.675%;"></span>
                                    <span class="ui-slider-handle ui-state-default ui-corner-all" tabindex="0" style="left: 50.675%;"></span>
                                </div> -->
								<div id="slider-range"
									class="ui-slider ui-slider-horizontal ui-widget ui-widget-content ui-corner-all">
									<span class="ui-slider-handle ui-state-default ui-corner-all"
										tabindex="0" style="left: 47.85%;"></span> <span
										class="ui-slider-handle ui-state-default ui-corner-all"
										tabindex="0" style="left: 47.85%;"></span>
								</div>
								<p>
									<!-- <input type="text" id="amount" readonly style="border:0; color:#fbb714; font-weight:bold;"> -->
									<input type="text" id="priceFilterVal" readonly
										style="border: 0; color: #fbb714; font-weight: bold;"
										value="1200-2000">
									<button class="btn hvr-hover">Lọc</button>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Shop Page -->

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
									<input class="" type="email" name="Email"
										placeholder="Email Address*" /> <i class="fa fa-envelope"></i>
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
								<li><a href="#"><i class="fab fa-facebook"
										aria-hidden="true"></i></a></li>
								<li><a href="#"><i class="fab fa-twitter"
										aria-hidden="true"></i></a></li>
								<li><a href="#"><i class="fab fa-linkedin"
										aria-hidden="true"></i></a></li>
								<li><a href="#"><i class="fab fa-google-plus"
										aria-hidden="true"></i></a></li>
								<li><a href="#"><i class="fa fa-rss" aria-hidden="true"></i></a></li>
								<li><a href="#"><i class="fab fa-pinterest-p"
										aria-hidden="true"></i></a></li>
								<li><a href="#"><i class="fab fa-whatsapp"
										aria-hidden="true"></i></a></li>
							</ul>
						</div>
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="col-lg-4 col-md-12 col-sm-12">
						<div class="footer-widget">
							<h4>About Freshshop</h4>
							<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit,
								sed do eiusmod tempor incididunt ut labore et dolore magna
								aliqua. Ut enim ad minim veniam, quis nostrud exercitation
								ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
							<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit,
								sed do eiusmod tempor incididunt ut labore et dolore magna
								aliqua.</p>
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
									<p>
										<i class="fas fa-map-marker-alt"></i>Address: Michael I. Days
										3756 <br>Preston Street Wichita,<br> KS 67213
									</p>
								</li>
								<li>
									<p>
										<i class="fas fa-phone-square"></i>Phone: <a
											href="tel:+1-888705770">+1-888 705 770</a>
									</p>
								</li>
								<li>
									<p>
										<i class="fas fa-envelope"></i>Email: <a
											href="mailto:contactinfo@gmail.com">contactinfo@gmail.com</a>
									</p>
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
		<p class="footer-company">
			All Rights Reserved. &copy; 2018 <a href="#">ThewayShop</a> Design By
			: <a href="https://html.design/">html design</a>
		</p>
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
	<script src="js/jquery-ui.js"></script>
	<script src="js/jquery.nicescroll.min.js"></script>
	<script src="js/form-validator.min.js"></script>
	<script src="js/contact-form-script.js"></script>
	<script src="js/custom.js"></script>


	<script type="text/javascript">
	
	var jsonData = ${jsonForShopViewBean}
	console.log(jsonData)
	
	var base_url = window.location.origin;
	//var host = window.location.host;
	var pathArray = window.location.pathname.split( '/' );	
	var path1 = pathArray[1]
	var path2 = pathArray[2]
	var path3 = pathArray[3]
	var parentUrl = base_url + '/' + path1 + '/' + path2 + '/' + path3
	
			
	// Sắp xếp sản phẩm (theo mặc định (a-z), mua nhiều, giá thấp-> cao, giá cao -> thấp, bonus mới nhất)

    var toolBarEle = document.querySelector('.toolbar-sorter-right select')
    
    
    
    
    //console.log(toolBarEle.querySelector('option[value="Gi� th?p ? cao"]'))
    
    
    toolBarEle.addEventListener('change', function(e) {
    	var selectedSortByVal = toolBarEle.options[toolBarEle.selectedIndex].value
        window.location.href = parentUrl + '?p=0&idCategory='+ jsonData.idCategory + 
        		'&indexSortType=' + selectedSortByVal
    })
    
    var str = 'option[value="' + jsonData.indexSortType + '"]'
    toolBarEle.querySelector(str).selected = 'selected'
    
   /*  switch(jsonData.sortType ){
    case 'Mặc định (a-z)':
    	break;
    case 'Giá thấp → cao':
    	break;
    case 'Giá cao → thấp':
    	break;
    case 'Mua nhiều':
    	break;
    case 'Mới nhất':
    	break;
    } */
    
    //toolBarEle.selectedIndex = "3"

    // Thanh tìm kiếm theo tên sản phẩm
    var searchProductBar = document.querySelector('.search-product')
    var inputSearchProduct = searchProductBar.querySelector('input')
    var btnSearchProduct = searchProductBar.querySelector('button')
    btnSearchProduct.addEventListener('click', function(e) {

    	var searchVal = inputSearchProduct.value.trim()
    	//var url =  base_url + '/' + path1 + '/' + path2 + '/all.htm'
       	window.location.href =  parentUrl + '?p=0&search='+ searchVal
    	
    })
    
    // set danh mục sản phẩm được chọn
    var categoryBar = document.querySelector('div.filter-sidebar-left')
   categoryBar.querySelector('#category-' + jsonData.idCategory).classList.add("active")
   
	
    
    // Filter theo giá tiền tự chọn
    var maxPrice = parseInt(jsonData.maxPrice)
    //showPriceFilterVal(0, maxPrice)
    
    var fromPrice = parseInt(jsonData.fromPrice);
    var toPrice = parseInt(jsonData.toPrice);
    var leftPriceSlider = document.querySelectorAll('#slider-range span')[0]
    var rightPriceSlider = document.querySelectorAll('#slider-range span')[1]

    var observer = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutationRecord) {
            var leftWitdhStr = mutationRecord.target.style.left.trim()
            leftWitdhStr = leftWitdhStr.slice(0, leftWitdhStr.length - 1)
            var priceChanged = Number(leftWitdhStr) * maxPrice / 100
            if (mutationRecord.target == leftPriceSlider) {
                fromPrice = priceChanged
            } else {
                toPrice = priceChanged
            }
            showPriceFilterVal(fromPrice, toPrice)
        });
    });

    observer.observe(leftPriceSlider, { attributes: true, attributeFilter: ['style'] });
    observer.observe(rightPriceSlider, { attributes: true, attributeFilter: ['style'] });

    var btnFilterPrice = document.querySelector('.price-box-slider button')
    btnFilterPrice.onclick = function(e) {
    	var selectedSortByVal = toolBarEle.options[toolBarEle.selectedIndex].value
        window.location.href = parentUrl + '?p=0&idCategory='+ jsonData.idCategory + 
		'&indexSortType=' + selectedSortByVal+
        		'&fromPrice=' + fromPrice.toFixed(0) +'&toPrice=' + toPrice.toFixed(0)
    }
    console.log(jsonData)
    console.log(fromPrice);
    console.log(toPrice);
    
    /* ..............................................
    Slider Range
    ................................................. */
	
    (function($) {
    	$(function() {
    	     $("#slider-range").slider({
    	         range: true,
    	         min: 0,
    	         max: maxPrice,
    	         values: [fromPrice, toPrice],
    	         slide: function(event, ui) {
    	             $("#amount").val("$" + ui.values[0] + " - $" + ui.values[1]);
    	         }
    	     });
    	     $("#amount").val("$" + $("#slider-range").slider("values", 0) +
    	         " - $" + $("#slider-range").slider("values", 1));
    	 });
    }(jQuery));
 

    
    // Hiển thị số lượng kết quả tìm thấy
    showNumberResultFound(parseInt(${jsonForShopViewBean}.totalResultFound))

    function showNumberResultFound(itemFound) {
        var showResultEle = document.querySelector('.product-item-filter p')
        showResultEle.innerText = itemFound  + `   sản phẩm được tìm thấy`
    }

    function showPriceFilterVal(fromPrice, toPrice) {
        var priceFilterValEl = document.querySelector('#priceFilterVal')
        var valStr = fromPrice.toFixed(0) + '₫  -  ' + toPrice.toFixed(0) +'₫'
        priceFilterValEl.value = valStr
    }
	</script>

</body>

</html>