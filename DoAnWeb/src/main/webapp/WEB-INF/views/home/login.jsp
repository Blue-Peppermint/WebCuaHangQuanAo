<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>

<head>
<title>Đăng Nhập</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
	integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p"
	crossorigin="anonymous" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<base href="${pageContext.servletContext.contextPath}/">

<link rel="icon" href="images/my-logo-mini.png">
<style>
body {
	margin: 0;
	color: #6a6f8c;
	background: #c8c8c8;
	background-image: linear-gradient(45deg, rgba(86, 95, 143, 0.8) 55%,
		rgba(89, 108, 231, 0.8)),
		url("images/ropa-deporte-2512231.jpg");
	background-attachment: fixed;
	 background-size: cover;
	font: 600 16px/18px 'Open Sans', sans-serif;
}

*, :after, :before {
	box-sizing: border-box
}

.clearfix:after, .clearfix:before {
	content: '';
	display: table
}

.clearfix:after {
	clear: both;
	display: block
}

a {
	color: inherit;
	text-decoration: none
}

.login-wrap {
	width: 100%;
	margin: auto;
	max-width: 525px;
	min-height: 900px;
	position: relative;
 	background:
		url("images/ropa-deporte-2512231.jpg")
		no-repeat center;
	box-shadow: 0 12px 15px 0 rgba(0, 0, 0, .24), 0 17px 50px 0
		rgba(0, 0, 0, .19);
}

.login-html {
	width: 100%;
	height: 100%;
	position: absolute;
	padding: 90px 70px 50px 70px;
	background: rgba(40, 57, 101, .9);
}

.login-html .sign-in-htm, .login-html .sign-up-htm {
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	position: absolute;
	transform: rotateY(180deg);
	backface-visibility: hidden;
	transition: all .4s linear;
}

.login-html .sign-in, .login-html .sign-up, .login-form .group .check {
	display: none;
}

.login-html .tab, .login-form .group .label, .login-form .group .button
	{
	/* text-transform: uppercase; */
	
}

.login-html .tab {
	font-size: 22px;
	margin-right: 15px;
	padding-bottom: 5px;
	margin: 0 15px 10px 0;
	display: inline-block;
	border-bottom: 2px solid transparent;
}

.login-html .sign-in:checked+.tab, .login-html .sign-up:checked+.tab {
	color: #fff;
	border-color: #1161ee;
}

.login-form {
	min-height: 345px;
	position: relative;
	perspective: 1000px;
	transform-style: preserve-3d;
}

.login-form .group {
	margin-bottom: 15px;
}

.login-form .group .label, .login-form .group .input, .login-form .group .button
	{
	width: 100%;
	color: #fff;
	display: block;
}

.login-form .group .input, .login-form .group .button {
	border: none;
	padding: 15px 20px;
	border-radius: 25px;
	background: rgba(255, 255, 255, .1);
}

.login-form .group input[data-type="password"] {
	text-security: circle;
	-webkit-text-security: circle;
}

.login-form .group .label {
	color: #aaa;
	font-size: 12px;
}

.login-form .group i, .login-form .group p {
	/* 	margin-top: 5px;
	margin-bottom: 5px; */
	
}

.login-form .group i {
	color: rgba(245, 10, 10, 0.7);
	font-size: 18px;
}

*[id$=errors] {
	color: rgba(245, 10, 10, 0.9);
}

.login-form .group p {
	color: rgba(245, 10, 10, 1);
}

.login-form .group .button {
	background: #1161ee;
	border: 1px solid #1161ee;
}

.login-form .group .button:hover, .login-form .group .button:active {
	cursor: pointer;
	background: rgba(17, 97, 238, 0.8);
	border: 1px solid #a8c0eb;
}

.login-form .group label .icon {
	width: 15px;
	height: 15px;
	border-radius: 2px;
	position: relative;
	display: inline-block;
	background: rgba(255, 255, 255, .1);
}

.login-form .group label .icon:before, .login-form .group label .icon:after
	{
	content: '';
	width: 10px;
	height: 2px;
	background: #fff;
	position: absolute;
	transition: all .2s ease-in-out 0s;
}

.login-form .group label .icon:before {
	left: 3px;
	width: 5px;
	bottom: 6px;
	transform: scale(0) rotate(0);
}

.login-form .group label .icon:after {
	top: 6px;
	right: 0;
	transform: scale(0) rotate(0);
}

.login-form .group .check:checked+label {
	color: #fff;
}

.login-form .group .check:checked+label .icon {
	background: #1161ee;
}

.login-form .group .check:checked+label .icon:before {
	transform: scale(1) rotate(45deg);
}

.login-form .group .check:checked+label .icon:after {
	transform: scale(1) rotate(-45deg);
}

.login-html .sign-in:checked+.tab+.sign-up+.tab+.login-form .sign-in-htm
	{
	transform: rotate(0);
}

.login-html .sign-up:checked+.tab+.login-form .sign-up-htm {
	transform: rotate(0);
}

.hr {
	height: 2px;
	margin: 60px 0 50px 0;
	background: rgba(255, 255, 255, .2);
}

.foot-lnk {
	text-align: center;
}

.login-html .tab:hover, .login-html .tab:active {
	cursor: pointer;
}

.foot-lnk #alreadyMember:hover, .foot-lnk #alreadyMember:active {
	cursor: pointer;
}
</style>
</head>

<body>
	<div class="login-wrap">
		<div class="login-html">

			<input id="tab-1" type="radio" name="tab" class="sign-in"> <a
				href="home/login.htm" for="tab-1" class="tab"> <!-- <label
				for="tab-1" class="tab">Đăng Nhập</label>  --> Đăng Nhập
			</a> <input id="tab-2" type="radio" name="tab" class="sign-up"> <a
				href="home/register.htm" for="tab-2" class="tab"> Đăng Ký </a>


			<div class="login-form">
				<div class="sign-in-htm">
					<c:if test="${ not empty message}">
						<div class="group">
							<div class="row">
								<div class="col-1">
									<i class="fad fa-info-circle"></i>
								</div>
								<div class="col">
									<p>${message}
									<p>
								</div>
							</div>
						</div>
					</c:if>
					<form:form action="home/login.htm" modelAttribute="userLog"
						method="POST">
						<div class="group">
							<label for="user" class="label">Tên Đăng Nhập</label>
							<div class="row">
								<div class="col-1">
									<i class="fad fa-info-circle"></i>
								</div>
								<div class="col">
									<form:errors path="username" />
								</div>
							</div>
							<form:input id="user" type="text" path="username" class="input" />
						</div>
						<div class="group">
							<label for="pass" class="label">Mật Khẩu</label>
							<div class="row">
								<div class="col-1">
									<i class="fad fa-info-circle"></i>
								</div>
								<div class="col">
									<form:errors path="pass" />
								</div>
							</div>
							<form:input id="pass" type="password" path="pass" class="input"
								data-type="password" />
						</div>
						<div class="group">
							<input id="check" type="checkbox" class="check" checked>
							<label for="check"><span class="icon"></span> Ghi Nhớ Lần
								Sau</label>
						</div>
						<div class="group">
							<!-- <input type="submit" class="button" value="Sign In"> -->
							<button class="button">Đăng Nhập</button>
						</div>
						<div class="hr"></div>
						<div class="foot-lnk">
							<a href="#forgot">Quên Mật Khẩu?</a>
						</div>
					</form:form>


				</div>
			</div>
		</div>
	</div>

	<script>
		if (window.location.href.includes('login.htm')) {
			var tab1Ele = document.querySelector('.login-html input#tab-1')
			tab1Ele.checked = true
			console.log("login.htm")
		} else {
			var tab2Ele = document.querySelector('.login-html input#tab-2')
			tab2Ele.checked = true
			console.log("register.htm")
		}
	</script>
</body>

</html>