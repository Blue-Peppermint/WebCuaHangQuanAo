<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@ include file="/WEB-INF/views/include/dashboard.jsp"%> --%>
<%@ taglib prefix="tg" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<%@page pageEncoding="utf-8"%>
<head>
	<style type="text/css">
		.text-logo{
			font-size: 35px; 
			font-family: 'Brush Script MT';
			color: #b0b435;
		}
	</style>


<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="format-detection" content="telephone=no">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<!-- Mobile Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Site Metas -->
<title>Quản lý sản phẩm - Admin</title>
<base href="${pageContext.servletContext.contextPath}/">
<meta name="keywords" content="">
<meta name="description" content="">
<meta name="author" content="">

<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css"
	rel="stylesheet" />
<link href="cssForAdmin/1/css/styles.css" rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"
	crossorigin="anonymous"></script>

<!-- Site Icons -->
<link rel="icon" href="images/my-logo-mini.png">


<link rel="canonical"
	href="https://getbootstrap.com/docs/5.0/examples/starter-template/">
<link
	href="<c:url value='/resources/assets/dist/css/bootstrap.min.css' />"
	rel="stylesheet">

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

<link
	href="https://fonts.googleapis.com/css?family=PT+Serif:400,400i,700,700ii%7CRoboto:300,300i,400,400i,500,500i,700,700i,900,900i&amp;subset=cyrillic"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.3.0/css/flag-icon.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="cssForAdmin/2/css/font-awesome.min.css">
<link rel="stylesheet" href="cssForAdmin/2/css/ion.rangeSlider.css">
<link rel="stylesheet" href="cssForAdmin/2/css/ion.rangeSlider.skinFlat.css">
<link rel="stylesheet" href="cssForAdmin/2/css/jquery.bxslider.css">
<link rel="stylesheet" href="cssForAdmin/2/css/jquery.fancybox.css">
<link rel="stylesheet" href="cssForAdmin/2/css/flexslider.css">
<link rel="stylesheet" href="cssForAdmin/2/css/swiper.css">
<link rel="stylesheet" href="cssForAdmin/2/css/swiper.css">
<link rel="stylesheet" href="cssForAdmin/2/css/media.css">

<!-- CSS for group button -->
<style>
.btn-group button {
  background-color: #04AA6D; /* Green background */
  border: 1px solid green; /* Green border */
  color: white; /* White text */
  padding: 5px 25px; /* Some padding */
  cursor: pointer; /* Pointer/hand icon */
  float: left; /* Float the buttons side by side */
}

/* Clear floats (clearfix hack) */
.btn-group:after {
  content: "";
  clear: both;
  display: table;
}

.btn-group button:not(:last-child) {
  border-right: none; /* Prevent double borders */
}

/* Add a background color on hover */
.btn-group button:hover {
  background-color: #3e8e41;
}
</style>

</head>
<body class="sb-nav-fixed">
	<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
		<!-- Navbar Brand-->
		<a class="text-logo" href="home/index.htm">Shop Sporter</a>
		<!-- Sidebar Toggle-->
		<button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0"
			id="sidebarToggle" href="#!">
			<i class="fas fa-bars"></i>
		</button>
		<!-- Navbar Search-->
		<form
			class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
			<div class="input-group">
				<p style="font-size: 20px; color: white; font-family: Arial"
					class="nav-link">${sessionScope.user.username}</p>
				<input style="display: none" class="form-control" type="text"
					placeholder="Search for..." aria-label="Search for..."
					aria-describedby="btnNavbarSearch" />
				<button style="display: none" class="btn btn-primary"
					id="btnNavbarSearch" type="button">
					<i class="fas fa-search"></i>
				</button>
			</div>
		</form>
		<!-- Navbar-->
		<ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
				role="button" data-bs-toggle="dropdown" aria-expanded="false"><i
					class="fas fa-user fa-fw"></i></a>
				<ul class="dropdown-menu dropdown-menu-end"
					aria-labelledby="navbarDropdown">
					<li><a class="dropdown-item" href="my-account/settingAccount.htm">Cài Đặt Tài Khoản</a></li>
					<li><hr class="dropdown-divider" /></li>
					<li><a class="dropdown-item" href="admin/logout.htm">Đăng Xuất</a></li>
				</ul></li>
		</ul>
	</nav>
	<div id="layoutSidenav">
		<div id="layoutSidenav_nav">
			<nav class="sb-sidenav accordion sb-sidenav-dark"
				id="sidenavAccordion">
				<div class="sb-sidenav-menu">
					<div class="nav">
						<div class="sb-sidenav-menu-heading">Quản lý</div>
						<a class="nav-link" href="admin/editProduct.htm">
							<div class="sb-nav-link-icon">
								<i class="fas fa-tachometer-alt"></i>
							</div>
							<font size="4" style="font-weight: bold"> Quản lý sản phẩm
						</font>
						</a> <a class="nav-link" href="admin/bills.htm">
							<div class="sb-nav-link-icon">
								<i class="fas fa-tachometer-alt"></i>
							</div> <font size="4" style="font-weight: bold"> Quản lý đơn
								hàng </font>
						</a>
					</div>
				</div>
			</nav>
		</div>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<div class="list-admin-top">
						<h1></h1>
						<h1></h1>
					</div>
					<div class="bg-light p-5 rounded">
						<p>${message}</p>
						<p style="text-align: center; font-size: 30px">
							<b><font color="black">Thông tin sản phẩm</font></b>
						</p>
						<form:form class="row g-3" modelAttribute="product"
							enctype="multipart/form-data" action="admin/editProduct.htm"
							method="post">
							<%-- <spring:hasBindErrors name="product">
								<c:forEach var="error" items="${errors.allErrors}">
									<b><spring:message message="${error}" /></b>
									<br />
								</c:forEach>
							</spring:hasBindErrors> --%>
							<form:hidden path="dateAdd"/>
							<form:hidden path="idProduct" class="form-control"
								id="exampleFormControlInput1" />
							<div class="col-md-4">
								<label for="exampleFormControlInput1" class="form-label">Tên
									sản phầm</label>
								<form:input path="name" type="text" class="form-control"
									id="exampleFormControlInput1"
									placeholder="Vui lòng nhập tên sản phẩm" />
							</div>
							
							<div class="col-md-4">
								<label for="exampleFormControlInput1" class="form-label">Giá</label>
								<form:input path="price" type="text" class="form-control"
									id="exampleFormControlInput1"
									placeholder="Vui lòng nhập giá của sản phẩm" />
							</div>
							
							<!-- <div class="col-md-4">
								<label for="exampleFormControlInput1" class="form-label"> Size</label>
								<br>
									<div class="container">
									    <div class="btn-group col-xs-12" data-toggle="buttons">
									        <label class="btn btn-default">
									            <input type="checkbox" >L
									        </label>
									        <label class="btn btn-default">
									            <input type="checkbox" >XL
									        </label>
									        <label class="btn btn-default">
									            <input type="checkbox" >XXL
									        </label>
									    </div>
									</div>
							</div> -->
							
							<div class="col-md-4">
								<label for="exampleFormControlInput1" class="form-label">Giảm
									giá(%)</label>
								<form:input path="discount" type="text" class="form-control"
									id="exampleFormControlInput1"
									placeholder="Vui lòng nhập giảm giá của sản phẩm" />
							</div>	
								
							<div class="col-md-4">
								<label for="exampleFormControlInput1" class="form-label">Thể
									loại</label>
								<form:select path="category.id" items="${categories }"
									itemValue="id" itemLabel="name"
									class="form-select form-select-lg mb-4"
									aria-label=".form-select-lg example">
								</form:select>
							</div>
							
							
							<div class="col-md-8">
								<label for="exampleFormControlInput1" class="form-label">Size - Số lượng</label>
								<br>
								<div>
									L : &ensp;
									<input type="text" size=7 name="inStockL" value="${inStockL}">
									&emsp;&emsp;XL : &ensp;
									<input type="text" size=7 name="inStockXL" value="${inStockXL}">
									&emsp;&emsp;XXL : &ensp;
									<input type="text" size=7 name="inStockXXL" value="${inStockXXL}">
								</div>				
								<div>
									
								</div>								
								<div>
									
								</div>								
							</div>


							<div class="col-md-12">
								<form:textarea type="textarea" rows="4" cols="100"
									name="decription" placeholder="Mô tả sản phẩm"
									path="decription" />
							</div>
							<p></p>
							<%-- <c:when test="${!empty images}"> --%>
							<div class="row" id="listImg">
								<c:forEach var="image" varStatus="loop" items="${images}">
									<div class="col-sm" style="text-align: center"
										id="pic-${loop.index}">
										<img id="${loop.index}" src="images/${image.source}" width="250"
											height="250" />
									</div>
								</c:forEach>
							</div>
							<div class="col-md-12">
								<div id="preview"></div>
								<input type="file" id="fileImg" name="file" accept="image/*"
									multiple formenctype="multipart/form-data">
							</div>
							<div class="col-12">
								<button name="${btnStatus}" class="btn btn-primary">Save</button>
							</div>


						</form:form>
					</div>
					<div>
						<p style="text-align: center; font-size: 30px">
							<b><font color="black">Tất cả sản phẩm</font></b>
						</p>
					</div>

					<!-- Phân trang -->
					<div class="bg-light p-5 rounded">
						<jsp:useBean id="pagedListHolder" scope="request"
							type="org.springframework.beans.support.PagedListHolder" />
						<c:url value="admin/page.htm" var="pagedLink">
							<c:param name="p" value="~" />
						</c:url>
						<table class="table table-hover">
							<thead>
								<tr style="font-weight: bold">
									<th style="text-align: center">ID</th>
									<th style="text-align: center">
										<form action="admin?type=">
											<select name="type" onchange="clickButtonSubmit()">
												<option value="0">Category...</option>
												<option value="1">Đồ đá banh</option>
												<option value="2">Đồ tập gym</option>
												<option value="3">Đồ trẻ em</option>											
											</select>
											<button style="display: none" type="submit" id="submit"
												style="float: right">
												<i class="fa fa-filter"></i>
											</button>
										</form> <%--                    Category--%> <%--                    <a href="admin?type=" style="float: left"><i class="fa fa-filter"></i></a>--%>
									</th>



									<th style="text-align: center">Tên</th>
									<th style="text-align: center">Giá</th>
									<th style="text-align: center">Giảm giá(%)</th>
									<th style="text-align: center">Hình ảnh</th>
									<!-- <th style="text-align: center">Số lượng</th> -->
									<th style="text-align: center"><i class="fa fa-edit"
										style="font-size: 25px; color: #e9c563"></i></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${pagedListHolder.pageList}">
									<%-- <c:forEach items="${listProduct}" var="item"> --%>
									<tr>
										<td class="hidden-xs">${item.idProduct}</td>
										<td style="text-align: center">${item.category.name}</td>
										<td style="text-align: center">${item.name}</td>
										<td style="text-align: center">${item.price}₫</td>
										<td style="text-align: center">${item.discount}</td>
										<td style="text-align: center"><img
											src="images/${item.productImgs[0].source}" alt="img"
											style="height: 50px; width: 50px"></td>
										<%-- <td style="text-align: center">${item.inStock}</td> --%>
										<td align="center">
											<!-- sửa--> <a class="btn btn-default"
											href="admin/edit.htm?id=${item.idProduct}"><em
												class="fa fa-pen" title="Edit"></em></a> <!-- xóa--> <a
											class="btn btn-danger" href="#" title="Delete"
											id="btn-del-prod-${item.idProduct}"
											onclick="confirmDel(${item.idProduct})"><em
												class="fa fa-trash"></em></a>
										</td>
									</tr>

								</c:forEach>
							</tbody>
						</table>
						<!-- Phân trang -->
						<tg:paging pagedListHolder="${pagedListHolder}"
							pagedLink="${pagedLink}" />
					</div>
				</div>
			</main>
		</div>
	</div>
	<!-- End copyright  -->
	<script type="text/javascript">
	function confirmDel(id){
		var option =confirm('Bạn có muốn xóa sản phẩm này không???')
		if(option == true){
			$("#btn-del-prod-"+id).attr("href","admin/del.htm?id="+id);
		}
		else{
			$("#btn-del-prod-"+id).attr("href","admin/editProduct.htm");
		}
	}
</script>

	<script type="text/javascript">
	function getFilePathFromDialog() {
	    document.getElementById('fileBrowser').click();
	    document.getElementById('filePath').value = document.getElementById('fileBrowser').value;
	}
</script>

	<script>
  var loadFile = function(event) {
    var output = document.getElementById('output');
    output.src = URL.createObjectURL(event.target.files[0]);
    output.onload = function() {
      URL.revokeObjectURL(output.src) // free memory
    }
  };
</script>

	<script type="text/javascript">
	
	
	function previewImages() {
	
	  var listImg= document.querySelector('#listImg')
	  listImg.innerHTML=""
	  var preview = document.querySelector('#preview');
	  
	  
	  
	  if (this.files) {
	    [].forEach.call(this.files, readAndPreview);
	  }
	
	  function readAndPreview(file) {
	
	    // Make sure `file.name` matches our extensions criteria
	    if (!/\.(jpe?g|png|gif)$/i.test(file.name)) {
	      return alert(file.name + " is not an image");
	    } // else...
	    
	    var reader = new FileReader();
	    
	    reader.addEventListener("load", function() {
	      var image = new Image();
	      image.height = 250;
	      image.title  = file.name;
	      image.src    = this.result;
	      preview.appendChild(image);
	    });
	    reader.readAsDataURL(file);    
	  }
	}
	document.querySelector('#fileImg').addEventListener("change", previewImages);	
</script>

	<script type="text/javascript">
	$(document).ready( function() {
	    var now = new Date();
	    var month = (now.getMonth() + 1);               
	    var day = now.getDate();
	    if (month < 10) 
	        month = "0" + month;
	    if (day < 10) 
	        day = "0" + day;
	    var today = now.getFullYear() + '-' + month + '-' + day;
	    $('#theDate').val(today);
	});
</script>

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
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="cssForAdmin/1/js/scripts.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>
	<script src="cssForAdmin/1/assets/demo/chart-area-demo.js"></script>
	<script src="cssForAdmin/1/assets/demo/chart-bar-demo.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest"
		crossorigin="anonymous"></script>
	<script src="cssForAdmin/1/js/datatables-simple-demo.js"></script>
</body>
</html>
