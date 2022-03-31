<%@page import="ptithcm.entity.Bill"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@ include file="/WEB-INF/views/include/taglib.jsp"%> --%>
<%@ taglib prefix="tg" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<%@page pageEncoding="utf-8"%>
<html lang="en">

<head>
<base href="${pageContext.servletContext.contextPath}/">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Quản Lý Đơn Hàng Của Tôi</title>


<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

<style type="text/css">
.table-responsive {
	margin: 30px 0;
}
/* Hint: background color của body table */
.table-wrapper {
	min-width: 1000px;
	background: #b0b435;
	padding: 20px 25px;
	border-radius: 3px;
	box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
}

.table-wrapper .btn {
	float: right;
	color: #333;
	background-color: #fff;
	border-radius: 3px;
	border: none;
	outline: none !important;
	margin-left: 10px;
}

.table-wrapper .btn:hover {
	color: #333;
	background: #f2f2f2;
}

.table-wrapper .btn.btn-primary {
	color: #fff;
	background: #03A9F4;
}

.table-wrapper .btn.btn-primary:hover {
	background: #03a3e7;
}

.table-title .btn {
	font-size: 13px;
	border: none;
}

.table-title .btn i {
	float: left;
	font-size: 21px;
	margin-right: 5px;
}

.table-title .btn span {
	float: left;
	margin-top: 2px;
}
/* Hint: background color của title table */
.table-title {
	color: #0000;
	background: #fff;
	padding: 16px 25px;
	margin: -20px -25px 10px;
	border-radius: 3px 3px 0 0;
}

.table-title h2 {
	margin: 5px 0 0;
	font-size: 24px;
}

.show-entries select.form-control {
	width: 60px;
	margin: 0 5px;
}

.table-filter .filter-group {
	float: right;
	margin-left: 15px;
}

.table-filter input, .table-filter select {
	height: 34px;
	border-radius: 3px;
	border-color: #ddd;
	box-shadow: none;
}

.table-filter {
	padding: 5px 0 15px;
	border-bottom: 1px solid #e9e9e9;
	margin-bottom: 5px;
}

.table-filter .btn {
	height: 34px;
}

.table-filter label {
	font-weight: normal;
	margin-left: 10px;
}

.table-filter select, .table-filter input {
	display: inline-block;
	margin-left: 5px;
}

.table-filter input {
	width: 200px;
	display: inline-block;
}

.filter-group select.form-control {
	width: 110px;
}

.filter-icon {
	float: right;
	margin-top: 7px;
}

.filter-icon i {
	font-size: 18px;
	opacity: 0.7;
}

table.table tr th, table.table tr td {
	border-color: #e9e9e9;
	padding: 12px 15px;
	vertical-align: middle;
}

table.table tr th:first-child {
	width: 60px;
}

table.table tr th:last-child {
	width: 80px;
}
/* màu background bình thường của element <tr> lẻ  */
table.table-striped tbody tr:nth-of-type(odd) {
	background-color: #fcfcfc;
}
/* màu background hover của element <tr> */
table.table-striped.table-hover tbody tr:hover {
	background: #f5f5f5;
}

table.table th i {
	font-size: 13px;
	margin: 0 5px;
	cursor: pointer;
}

table.table td a {
	font-weight: bold;
	color: #566787;
	display: inline-block;
	text-decoration: none;
}

table.table td a:hover {
	color: #2196F3;
}

table.table td a.view {
	width: 30px;
	height: 30px;
	color: #2196F3;
	border: 2px solid;
	border-radius: 30px;
	text-align: center;
}

table.table td a.view i {
	font-size: 22px;
	margin: 2px 0 0 1px;
}

table.table .avatar {
	border-radius: 50%;
	vertical-align: middle;
	margin-right: 10px;
}

.status {
	font-size: 30px;
	margin: 2px 2px 0 0;
	display: inline-block;
	vertical-align: middle;
	line-height: 10px;
}

.text-success {
	color: #10c469;
}

.text-info {
	color: #62c9e8;
}

.text-warning {
	color: #FFC107;
}

.text-danger {
	color: #ff5b5b;
}

.pagination {
	float: right;
	margin: 0 0 5px;
}

.pagination li a {
	border: none;
	font-size: 13px;
	min-width: 30px;
	min-height: 30px;
	color: #999;
	margin: 0 2px;
	line-height: 30px;
	border-radius: 2px !important;
	text-align: center;
	padding: 0 6px;
}

.pagination li a:hover {
	color: #666;
}

.pagination li.active a {
	background: #03A9F4;
}

.pagination li.active a:hover {
	background: #0397d6;
}

.pagination li.disabled i {
	color: #ccc;
}

.pagination li i {
	font-size: 16px;
	padding-top: 6px
}

.hint-text {
	float: left;
	margin-top: 10px;
	font-size: 13px;
}
</style>


<script>
	$(document).ready(function() {
		$('[data-toggle="tooltip"]').tooltip();
	});
</script>
<!-- begin css header + footer -->
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
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
	integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p"
	crossorigin="anonymous" />
<!-- end css header + footer -->
<link
	href="https://fonts.googleapis.com/css?family=PT+Serif:400,400i,700,700ii%7CRoboto:300,300i,400,400i,500,500i,700,700i,900,900i&amp;subset=cyrillic"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.3.0/css/flag-icon.min.css"
	rel="stylesheet">


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
					<h2>Quản lý đơn hàng</h2>
					<ul class="breadcrumb">
						<li class="breadcrumb-item"><a href="my-account/home.htm">Tài
								Khoản Của Tôi</a></li>
						<li class="breadcrumb-item active">Quản Lý Đơn Hàng</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End All Title Box -->

	<!-- orders -->
	<div class="container">
		<div class="table-responsive">
			<div class="table-wrapper">
				<!-- <div class="table-title">
					<div class="row">
						<div class="col-sm-4">
							<h2>
								Order <b>Details</b>
							</h2>
						</div>
					</div>
				</div> -->
				<div class="table-filter">
					<div class="row">
						<div class="col-sm-3">
							<div class="show-entries">
								<span style="color: #fff; font-size: 130%">Bạn đã đặt ${number} đơn hàng</span>
							</div>
						</div>
					</div>
				</div>
				<div class="bg-light p-5 rounded">
					<jsp:useBean id="pagedListHolder" scope="request"
						type="org.springframework.beans.support.PagedListHolder" />
					<c:url value="my-account/bill/page" var="pagedLink">
						<c:param name="p" value="~" />
					</c:url>
					<div class="d-flex flex-row justify-content-between">
						<div>
							<tg:paging pagedListHolder="${pagedListHolder}"
								pagedLink="${pagedLink}" />
						</div>
					</div>
					<table class="table table-hover">
						<thead>
							<tr style="font-weight: bold">
								<th style="text-align: center">ID Bill</th>
								<th style="text-align: center">Ngày mua</th>
								<th>Sản phẩm</th>
								<th>Tổng tiền</th>
								<th style="text-align: center">Chi tiết</th>
								<!-- <th style="text-align: center">Số lượng</th>
                <th style="text-align: center"><i class="fa fa-edit" style="font-size: 25px;color: #e9c563" ></i></th> -->
							</tr>
						</thead>
						<tbody>
							<c:forEach var="item" items="${pagedListHolder.pageList}">
								<%-- <c:forEach items="${listProduct}" var="item"> --%>
								<tr>
									<td class="hidden-xs">${item.idBill}</td>
									<td style="text-align: center">${item.timeCreated}</td>
									<td>${item.namePD()}</td>
									<td>${item.totalBill()}đ</td>
									<td><a href="my-account/bill/detail.htm?id=${item.idBill}"
										class="view" title="View Details" data-toggle="tooltip"><i
											class="material-icons">&#xE5C8;</i></a></td>
									<%-- <td style="text-align: center"><img src="${item.productImgs[0].source}" alt="img" style="height: 50px;width: 50px">  </td>
                    <td style="text-align: center">${item.inStock}</td> --%>
									<%-- <td align="center"><!-- sửa--><a class="btn btn-default" href="edit.htm?id=${item.idProduct}"><em class="fa fa-pencil"></em></a> <!-- xóa--> <a class="btn btn-danger" href="#" id="btn-del-prod-${item.idProduct}" onclick="confirmDel(${item.idProduct})"><em class="fa fa-trash"></em></a></td> --%>
								</tr>

							</c:forEach>
						</tbody>
					</table>
					<!-- Phân trang -->
					<tg:paging pagedListHolder="${pagedListHolder}"
						pagedLink="${pagedLink}" />
				</div>
			</div>
		</div>
	</div>


	<jsp:include page="../include/footer.jsp" />

	<script type="text/javascript">
		var btnSearch = document.querySelector('#btnSearch')
		var dateFrom = document.querySelector('#dateFrom')
		var dateTo = document.querySelector('#dateTo')
		btnSearch.addEventListener('click', function(e) {
			var date1 = new Date(dateFrom.value)
			var day1 = date1.getDate()
			var month1 = date1.getMonth() + 1;
			var year1 = date1.getFullYear();

			var date2 = new Date(dateTo.value)
			var day2 = date2.getDate()
			var month2 = date2.getMonth() + 1;
			var year2 = date2.getFullYear();

			var timeFrom = [ day1, month1, year1 ].join('-')
			var timeTo = [ day2, month2, year2 ].join('-')

			btnSearch.href = '/WEB_CuoiKy/bill/search.htm?p=0' + '&dateFrom='
					+ timeFrom + '&dateTo=' + timeTo
			//console.log(time)
			//console.log(dateTwo.value)
		})
	</script>
</body>

</html>