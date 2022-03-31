<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Site Metas -->
<title>Cài Đặt Tài Khoản Của Tôi</title>
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



<style>
.avatar {
	width: 150px;
	height: 150px;
}

.title-setting {
	font-size: 150%;
	font-weight: 600;
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
					<h2>Cài đặt tài khoản</h2>
					<ul class="breadcrumb">
						<li class="breadcrumb-item"><a href="my-account/home.htm">Tài Khoản Của Tôi</a></li>
						<li class="breadcrumb-item active">Cài Đặt Tài Khoản</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End All Title Box -->

	<div class="container " style="margin-top: 20px; margin-bottom: 20px;">
		<h2 class="text-primary">Chỉnh Sửa Thông Tin Cá Nhân</h2>
		<hr>

		<div class="row">
			<!-- left column -->

			<div class="col-md-2 border-right ">
				<form:form action="my-account/settingAccount.htm"
					modelAttribute="userDetail" enctype="multipart/form-data"
					method="post">
					<input name="username" value="${user.username}" type="hidden" />
					<form:hidden path="id" />
					<form:hidden path="phone" />
					<form:hidden path="email" />
					<form:hidden path="name" />
					<form:hidden path="gender" />
					<form:hidden path="birthday" />
					<form:hidden path="address" />

					<form:hidden path="imgAvatar" />

					<div class="text-center">
						<img src="images/${userDetail.imgAvatar }"
							class="avatar img-circle img-thumbnail" alt="avatar">
						<h4 style="overflow-wrap: break-word;">
							Username: <b>${user.username }</b>
						</h4>
						<br>
						<form:errors path="imgAvatar" />
						<br>
						<h6>Đổi Avatar</h6>
						<input name="img" type="file" class="form-control">
					</div>
					<br>
					<div class="col d-flex justify-content-end">
						<button name="btnSaveAvatar" class="btn btn-primary" type="submit">Lưu
							Thay Đổi</button>
					</div>
				</form:form>
			</div>

			<!-- edit form column -->
			<div class="col-md-6 personal-info border-right">
				<c:if test="${not empty showInfo }">
					<div class="alert alert-info alert-dismissable">
						<a class="panel-close close" data-dismiss="alert">×</a> <i
							class="fad fa-info-circle"></i> ${showInfo}
					</div>
				</c:if>

				<p class="title-setting">Thông tin cá nhân</p>
				<form:form action="my-account/settingAccount.htm"
					modelAttribute="userDetail" class="form-horizontal" role="form"
					method="post">
					<input name="username" value="${user.username}" type="hidden" />
					<form:hidden path="id" />
					<form:hidden path="phone" />
					<form:hidden path="email" />
					<form:hidden path="imgAvatar" />
					<div class="form-group">
						<label class="col-lg-3 control-label">Họ & Tên</label>
						<div class="col-lg-10">
							<form:errors path="name" />
							<form:input path="name" class="form-control" type="text" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-3 control-label">Giới Tính</label>
						<div class="col-lg-6">
							<form:errors path="gender" />
							<div class="ui-select">
								<form:select path="gender" class="form-control">
									<form:option value="Nam">Nam</form:option>
									<form:option value="Nữ">Nữ</form:option>
									<form:option value="Khác">Khác</form:option>
								</form:select>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-3 control-label">Ngày Sinh</label>
						<div class="col-lg-6">
							<form:errors path="birthday" />
							<fmt:formatDate pattern='dd/MM/yyyy' type='date'
								value='${userDetail.birthday}' var="formattedDate" />
							<input name="birthdayStr" class="form-control"
								data-format="dd/MM/yyyy" type="text" value="${formattedDate}"
								placeholder="dd/MM/yyyy" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-6 control-label">Địa Chỉ Nhận Hàng</label>
						<div class="col-lg-12">
							<form:errors path="address" />
							<form:input path="address" class="form-control" type="text" />
						</div>
					</div>
					<div class="form-group">
						<div class="row">
							<div class="col d-flex justify-content-end">
								<button name="btnSaveInfo" class="btn btn-primary" type="submit">Lưu
									Thay Đổi</button>
							</div>
						</div>
					</div>
				</form:form>
			</div>

			<div class="col-md-4 ">
				<form:form action="my-account/settingAccount.htm"
					modelAttribute="userDetail">
					<input name="username" value="${user.username}" type="hidden"
						method="post" />
					<form:hidden path="id" />
					<form:hidden path="imgAvatar" />

					<form:hidden path="name" />
					<form:hidden path="gender" />
					<form:hidden path="birthday" />
					<form:hidden path="address" />
					<div
						class="d-flex justify-content-between align-items-center side-topic">
						<span class="title-setting">Số điện thoại và Email</span>
					</div>
					<br>
					<div class="form-group">
						<label class="col-lg-12 control-label">SĐT</label>
						<div class="col-lg-12">
							<form:errors path="phone" />
							<form:input path="phone" class="form-control" type="text" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-12 control-label">Email</label>
						<div class="col-lg-12">
							<form:errors path="email" />
							<form:input path="email" class="form-control" type="text" />
						</div>
					</div>
					<div class="row">
						<div class="col d-flex justify-content-end">
							<button name="btnSaveEmail" class="btn btn-primary" type="submit">Lưu
								Thay Đổi</button>
						</div>

					</div>
				</form:form>



				<hr>
				<div
					class="d-flex justify-content-between align-items-center side-topic">
					<span class="title-setting">Bảo mật</span>
				</div>
				<br>
				<form:form action="my-account/settingAccount.htm"
					modelAttribute="user" method="post">
					<form:hidden path="id" />
					<form:hidden path="username" />
					<div class="form-group">
						<div class="col-12 col-sm-6 mb-3">
							<div class="row">
								<div class="col">
									<div class="form-group">
										<label>Mật Khẩu Cũ</label> <br>
										<form:errors path="pass" />
										<form:input path="pass" class="form-control" type="password"
											placeholder="••••••" />
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col">
									<div class="form-group">
										<label>Mật Khẩu Mới</label> <input name="newPassword"
											class="form-control" type="password" placeholder="••••••" />
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col">
									<div class="form-group">
										<label>Xác Nhận Mật Khẩu</label> <input
											name="newPasswordRepeat" class="form-control" type="password"
											placeholder="••••••">
									</div>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col d-flex justify-content-end">
								<button name="btnSavePassword" class="btn btn-primary"
									type="submit">Lưu Thay Đổi</button>
							</div>
						</div>
					</div>
				</form:form>
			</div>
		</div>
		<hr>
	</div>

	<jsp:include page="../include/footer.jsp" />

	<!-- <input id="one"  type="date">
	<input id="two" type="date">
	<button id="btnSearchh" >Nhap vao day</button> -->
	<script>
		var btnSearch = document.querySelector('#btnSearchh');
		var dateOne = document.querySelector('#one')
		var dateTwo = document.querySelector('#two')

		console.log(dateOne)
		btnSearch.addEventListener('click', function(e) {
			var date1 = new Date(dateOne.value)
			var day = date1.getDate()
			var month = date1.getMonth() + 1;
			var year = date1.getFullYear();

			var time = [ day, month, year ].join('/')
			btnSearch.href = '?dateFrom=' + time + '&dateTo='
			console.log(time)
			//console.log(dateTwo.value)
		})
	</script>

</body>

</html>