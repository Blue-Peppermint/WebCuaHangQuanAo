<%@page import="ptithcm.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<!-- Basic -->

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<!-- Mobile Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Site Metas -->
<title>Trang Chủ</title>
<meta name="keywords" content="">
<meta name="description" content="">
<meta name="author" content="">

<base href="${pageContext.servletContext.contextPath}/">

<!-- Site Icons -->
<!-- <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
<link rel="apple-touch-icon" href="images/my-logo-mini.jpg"> -->

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

	<!-- Hint: Ảnh Nền nhằm Truyền tải năng lượng, thông tin đến User -->
	<!-- Start Slider -->
	<div id="slides-shop" class="cover-slides">
		<ul class="slides-container">
			<li class="text-center"><img src="images/home/Banner-football.jpg" alt="">
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<h1 class="m-b-20">
								<strong>Welcome To <br> Shop Sporter
								</strong>
							</h1>
							<p class="m-b-40">Quần áo thể thao nam nữ chính hãng. Cập
								nhật theo xu hướng mới nhất.</p>
							<p>
								<a class="btn hvr-hover" href="shop/all.htm">SHOP NOW</a>
							</p>
						</div>
					</div>
				</div></li>
			<li class="text-center"><img src="images/home/Banner-gym.jpeg" alt="">
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<h1 class="m-b-20">
								<strong>Welcome To <br> Shop Sporter
								</strong>
							</h1>
							<p class="m-b-40">Quần áo thể thao nam nữ chính hãng. Cập
								nhật theo xu hướng mới nhất.</p>
							<p>
								<a class="btn hvr-hover" href="shop/all.htm">Shop NOW</a>
							</p>
						</div>
					</div>
				</div></li>
			<li class="text-center"><img src="images/home/Banner-kid.jpg" alt="">
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<h1 class="m-b-20">
								<strong>Welcome To <br> Shop Sporter
								</strong>
							</h1>
							<p class="m-b-40">Quần áo thể thao nam nữ chính hãng. Cập
								nhật theo xu hướng mới nhất.</p>
							<p>
								<a class="btn hvr-hover" href="shop/all.htm">Shop NOW</a>
							</p>
						</div>
					</div>
				</div></li>
		</ul>
		<div class="slides-navigation">
			<a href="#" class="next"><i class="fa fa-angle-right"
				aria-hidden="true"></i></a> <a href="#" class="prev"><i
				class="fa fa-angle-left" aria-hidden="true"></i></a>
		</div>
	</div>
	<!-- End Slider -->

	<!-- Hint: Liệt Kê Các Categories -->
	<!-- Start Categories  -->
	<div class="categories-shop">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="title-all text-center">
						<h1>Danh Mục Sản Phẩm</h1>
						<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
							Sed sit amet lacus enim.</p>
					</div>
				</div>
			</div>

			<div class="row">
				<c:forEach var="category" items="${categories}">
					<div class="col-lg col-md col-sm-12 col-xs-12">
						<div class="shop-cat-box">
							<img class="img-fluid" src="images/${category.img }" alt="" /> <a
								class="btn hvr-hover" href="shop/${category.name}.htm">${category.name }</a>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<!-- End Categories -->

	<!-- Hint: Show 1 Vài Sản Phẩm Tiêu Biểu.  -->
	<!-- Start Products  -->
	<div class="products-box" style="background-color: #f4f4f4;">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="title-all text-center">
						<h1>Các Sản Phẩm Nổi Bật</h1>
						<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
							Sed sit amet lacus enim.</p>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="special-menu text-center">
						<div class="button-group filter-button-group">
							<button class="active" my-data-filter="discount">Giảm
								giá</button>
							<!-- button trigger action bằng data-filter = tên class đằng sau tag  <div class="col-lg-3 col-md-6 special-grid ...> dưới đây   -->
							<button my-data-filter="wishlist">Sản phẩm nhiều yêu
								thích</button>
							<button my-data-filter="best-seller">Bán chạy nhất</button>
						</div>
					</div>
				</div>
			</div>

			<!-- Hint: Các sản phẩm show lên lần đầu tiên ở đây -->
			<div class="special-li">

				<%
				//System.out.println(request.getAttribute("discountProducts[0].productImgs"));
				%>
				<div class="row-Grid">
					<c:forEach var="product" items="${discountProducts}" begin="0"
						end="3">

						<a
							href="shop-detail/showProduct.htm?idProduct=${product.idProduct}"
							id="productShop">
							<div class="col span_1_of_4 ">
								<div class="products-single fix">
									<div class="box-img-hover">
										<img src="images/${product.productImgs[0].source}"
											class="img-fluid" alt="Image">
										<div class="type-lb">
											<p class="sale">Sale ${product.discount} %</p>
										</div>
									</div>
									<div class="why-text">
										<h4>${product.name}</h4>
										<h5>
											<fmt:formatNumber type="currency" pattern="#₫"
												value="${product.price * (100 - product.discount)/100}" />
										</h5>
										<span> ${product.price}₫</span>
									</div>
								</div>
							</div>
						</a>

					</c:forEach>
				</div>
				<%-- </c:if> --%>


			</div>
		</div>

		<div class="special-menu text-center">
			<button id="loadMoreSpecialItems">Xem Thêm</button>
		</div>
	</div>
	</div>
	<!-- End Products  -->

	<!-- Hint: Mục latest blog. Có thể ko cần -->
	<!-- Start Blog  -->
	<div class="latest-blog" style="background-color: #ffffff;">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="title-all text-center">
						<h1>Bài Viết Gần Đây</h1>
						<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
							Sed sit amet lacus enim.</p>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6 col-lg-4 col-xl-4">
					<a
						href="https://www.sporter.vn/yoga/tre-lau-nho-bi-quyet-tap-yoga-buoi-sang-deu-dan/">
						<div class="blog-box">
							<div class="blog-img">
								<img class="img-fluid"
									src="https://www.sporter.vn/wp-content/uploads/2021/01/Tre-lau-nho-bi-quyet-tap-yoga-buoi-sang-deu-dan-1.jpg"
									alt="" />
							</div>
							<div class="blog-content">
								<div class="title-blog">
									<h3>Trẻ lâu nhờ bí quyết tập Yoga buổi sáng đều đặn</h3>
									<p>Nếu bạn có thể duy trì chế độ tập Yoga đều đặn vào buổi
										sáng thì bạn không cần phải lo ngại tuổi già kéo đến nữa rồi.
										Chỉ cần nghĩ đến buổi sáng sớm với không khí còn trong lành,
										mát mẻ, dạ dày còn rỗng và cơ thể bạn đã được nghỉ ngơi [...]</p>
								</div>
							</div>
						</div>
					</a>
				</div>
				<div class="col-md-6 col-lg-4 col-xl-4">
					<a
						href="https://www.sporter.vn/yoga/nhung-su-that-ve-yoga-ma-ban-nen-biet/">
						<div class="blog-box">
							<div class="blog-img">
								<img class="img-fluid"
									src="https://www.sporter.vn/wp-content/uploads/2020/09/Nhung-su-that-ve-yoga-ma-ban-nen-biet-4.jpg"
									alt="" />
							</div>
							<div class="blog-content">
								<div class="title-blog">
									<h3>Những sự thật về Yoga mà bạn nên biết</h3>
									<p>Bạn đang bắt đầu tìm hiểu về Yoga và đang muốn thực hành
										Yoga? Bạn đang tập luyện và luôn có những suy ngẫm về hành
										trình của mình, làm sao để tập luyện một cách đúng đắn và mang
										lại lợi ích tốt nhất cho tâm trí và cơ thể? [...]</p>
								</div>
							</div>
						</div>
					</a>
				</div>
				<div class="col-md-6 col-lg-4 col-xl-4">
					<a
						href="https://www.sporter.vn/cafe-sports/giai-ma-cau-hoi-tap-gym-buoi-sang-co-tot-khong/">
						<div class="blog-box">
							<div class="blog-img">
								<img class="img-fluid"
									src="https://www.sporter.vn/wp-content/uploads/2020/10/Tat-tan-tat-nhung-dieu-ban-nen-biet-khi-mua-tham-tap-gym-1.jpg"
									alt="" />
							</div>
							<div class="blog-content">
								<div class="title-blog">
									<h3>Giải mã câu hỏi tập gym buổi sáng có tốt không ?</h3>
									<p>Nhiều bạn khi mới bắt đầu tập gym đều có cùng thắc mắc
										rằng tập gym buổi sáng có tốt không ? Các chuyên gia sức khỏe
										và huấn luyện viên đưa ra quan điểm rằng “điều quan trọng nhất
										là tập luyện đều đặn”. Vì vậy [...]</p>
								</div>
							</div>
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>
	<!-- End Blog  -->

	<jsp:include page="../include/footer.jsp" />
	<!-- Hint: Không Thể Để Code này ra 1 file .js riêng đc Vì khi đó nó sẽ JSP sẽ hiểu file .js là 1 static file
	dẫn đến 1 số đặc tính liên kết giữa file .jsp và code javaScript sẽ bị mất đi == Không chạy code JS đc.
	Để Chung như vầy JS có 1 số đặc tính riêng cũng bị mất theo -->
	<script type="text/javascript">
	// Nút Xem thêm
	var btnLoadMore = document.querySelector('.products-box #loadMoreSpecialItems')
	//Set up nút xem thêm cho lần load page đầu tiền
	if(${jsonDiscountProducts}.length < 4){
		btnLoadMore.style.display = "none";
	}
	
	
	// Nut show special items đang đc active
	var btnActivatedSpecialMenu =
		document.querySelector('.products-box .container .row .col-lg-12 .special-menu.text-center .button-group.filter-button-group button.active');


	// Thẻ Div nơi show items
	var divSpecial_list = document.querySelector('.special-li')

	// kiem tra co chuyen sang click nut moi ko?
	var isClickedNewBtn = false;
	
	
	// Nút Chuyển tab
	var btnShowSpecialMenus =
		document.querySelectorAll('.products-box .container .row .col-lg-12 .special-menu.text-center .button-group.filter-button-group button')
	
	for (var btn of btnShowSpecialMenus) {
		btn.addEventListener('click', function(e) {
			// Kiểm tra xem có click sang nút khác ko (Để xác định có nên reset load sản phẩm?)
			if (e.target === btnActivatedSpecialMenu) {
				console.log('Vua moi nhan nut nay r ma')
				isClickedNewBtn = false;
			} else {
				console.log('Chuyen sang nut moi')
				isClickedNewBtn = true;
				btnActivatedSpecialMenu = e.target;
				// load sản phẩm tối đa 4 món
				divSpecial_list.innerHTML = ''
				divSpecial_list.innerHTML += `
                <div class="row-Grid "></div>
    `;
				var items;
				if (btnActivatedSpecialMenu.getAttribute('my-data-filter') === 'discount') {					
					//var jsonDis = '${myVarB}'					
					//var json = JSON.parse(jsonDis)
					//console.log(jsonDis[0].name)
					//console.log(jsonDis[1].name)
					items =  ${jsonDiscountProducts};
				} else if (btnActivatedSpecialMenu.getAttribute('my-data-filter') === 'wishlist') {
					//console.log("di vao wishlist")
					items = ${jsonWishlistProducts};
				}
				else if (btnActivatedSpecialMenu.getAttribute('my-data-filter') === 'best-seller') {
					items = ${jsonBestSellingProducts}
				}
				//console.log(items)
				for (var i = 0; i < 4 && i<items.length; i++) {
					//console.log(i)
					//var divRowGrid = divSpecial_list.querySelector('.row-Grid');
					//console.log(divSpecial_list)
					addItemToDiv(divSpecial_list.querySelector('.row-Grid'), items[i])
				}
				if(items.length > 4){
					btnLoadMore.style.display = "inline-block";
				}else{
					btnLoadMore.style.display = "none";
				}
			}
		})
	}
	
	// Nút Xem Thêm
	btnLoadMore.addEventListener('click', function(e) {
		for (var btn of btnShowSpecialMenus) {
			if (btn.classList.contains('active')) {
				loadMoreItems(btn.getAttribute('my-data-filter'))
			}
		}
	})


	function loadMoreItems(btnName) {
		// Cho biết đã load thêm được mấy item r. Nếu đã nhấn button khác thì reset itemIndexNow
		var itemLoaded = 0;

		var divRowGrids = divSpecial_list.querySelectorAll('.row-Grid');
		for (var divRowGrid of divRowGrids) {
			itemLoaded += divRowGrid.querySelectorAll('.col.span_1_of_4').length
		}

		// List sản phẩm đã và sẽ load
		var items;
		switch (btnName) {
			case 'discount':
				//itemLoaded += 4
				items =  ${jsonDiscountProducts};
				console.log('Thuc thi action load items btn discount')
				break;
			case 'wishlist':
				items =  ${jsonWishlistProducts};
				console.log('Thuc thi action load items btn wishlist');		
				break;
			case 'best-seller':
				items =  ${jsonBestSellingProducts};
				console.log('Thuc thi action load items btn best-seller');
				break;
		}

		// Đếm số lượng sản phẩm đã show trên 1 row. Max = 4
		var count = 0;
		for (itemLoaded; itemLoaded < items.length; itemLoaded++) {
			count++;
			if (count > 4) {
				break;
			}
			// Nếu như đã load hết 4 sản phẩm trên 1 row thì tạo row mới
			if (itemLoaded % 4 == 0) {
				divSpecial_list.innerHTML += `
        <div class="row-Grid "></div>
`;
			}

			divRowGrids = divSpecial_list.querySelectorAll('.row-Grid');
			var divLastRowGrid = divRowGrids[divRowGrids.length - 1]
			addItemToDiv(divLastRowGrid, items[itemLoaded])
		}
		if(itemLoaded == items.length){
			btnLoadMore.style.display = "none"
		}

	}

	// Thêm 1 sản phẩm vào thẻ div.special-li .row-Grid
	function addItemToDiv(div, item) {
		// Chỗ này get imgSources có vấn đề
		//console.log(item.imgSources)
		//console.log(`<img src= "` + item.imgSources[0] + `"`)
		// Đặt ký hiệu cho item đang xử lý với id = adding-item
		div.innerHTML += `
        <a href = "shop-detail/showProduct.htm?idProduct=` + item.idProduct +`" id="productShop" >
            <div id = "adding-item" class="col span_1_of_4 ">
                <div class="products-single fix">
                    <div class="box-img-hover">                                 
                    
                     </div>
                    <div class="why-text">
                     </div>
                </div>
             </div>
        </a>
           
            `;
		// get thẻ div vừa mới add
		var divItemAddingNow = document.querySelector('#adding-item');

		// Thêm tag Img
		var divItemAdding1 =
			divItemAddingNow.querySelector('.products-single.fix .box-img-hover')
		divItemAdding1.innerHTML += `
                <img src= "images/` + item.imgSources[0] + `" class="img-fluid" alt="Image">
                `;
		// Nếu có giảm giá. Tính giá tiền sản phẩm.
		if (item.discount != 0) {
			divItemAdding1 =
				divItemAddingNow.querySelector('.products-single.fix .box-img-hover')
			divItemAdding1.innerHTML += `
                <div class="type-lb">
                    <p class="sale">Sale `+ item.discount + `%</p>
                </div>
                `;

			var divItemAdding2 =
				divItemAddingNow.querySelector('.products-single.fix .why-text')
			divItemAdding2.innerHTML = `
                <h4>` + item.name +`</h4>
                <h5>` + item.price * (100 - item.discount) / 100 + `₫</h5>
                <span>` + item.price + `₫</span>              
                `;
		} else {
			var divItemAdding2 =
				divItemAddingNow.querySelector('.products-single.fix .why-text')
			divItemAdding2.innerHTML = `
            <h4>` + item.name + `</h4>
            <h5>` + item.price + `₫</h5>
            `;
		}
		// xóa id tự thêm lúc đầu
		divItemAddingNow.removeAttribute('id')
		//console.log(divItemAddingNow)
	};
	</script>
</body>

</html>