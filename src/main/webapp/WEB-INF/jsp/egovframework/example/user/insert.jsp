<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0"/ -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<!-- Bootstrap -->
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요한) -->
<script src="http://code.jquery.com/jquery.js"></script>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<!-- 모든 합쳐진 플러그인을 포함하거나 (아래) 필요한 각각의 파일들을 포함하세요 -->
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<!-- Respond.js 으로 IE8 에서 반응형 기능을 활성화하세요 (https://github.com/scottjehl/Respond) -->
<script
	src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
</head>
<body>
	<div class="container">
		<form class="form-horizontal" role="form" action="/user/register.do" , method="POST">
			<div class="form-group" id="divId">
				<label for="inputId" class="col-lg-2 control-label">아이디</label>
				<div class="col-lg-10">
					<input type="text" class="form-control onlyAlphabetAndNumber" name="user_id" id="user_id" data-rule-required="true" placeholder="영문 숫자 조합 4~12자로 입력해주세요" maxlength="30">
				</div>
				<div id="id_check"></div>
			</div>
			<div class="form-group" id="divPassword">
				<label for="inputPassword" class="col-lg-2 control-label">패스워드</label>
				<div class="col-lg-10">
					<input type="password" class="form-control" id="user_pw" name="user_pw"  placeholder="영문 숫자 조합 4~12자로 입력해주세요" maxlength="30">
				</div>
			</div>
			<div class="form-group" id="divPasswordCheck">
				<label for="inputPasswordCheck" class="col-lg-2 control-label">패스워드 확인</label>
				<div class="col-lg-10">
					<input type="password" class="form-control" id="user_pw_check" name="user_pw_check" placeholder="영문 숫자 조합 4~12자로 입력해주세요" maxlength="30">
				</div>
			</div>
			<div class="form-group" id="divName">
				<label for="inputName" class="col-lg-2 control-label">이름</label>
				<div class="col-lg-10">
					<input type="text" class="form-control onlyHangul" id="user_name" name="user_name"  placeholder="한글만 입력 가능합니다." maxlength="15">
				</div>
			</div>
			<div class="form-group">
				<div class="col-lg-offset-2 col-lg-10">
					<button type="submit" id="registerbtn" class="btn btn-primary">회원가입</button>
					<button type="button" onclick="cancle()" class="btn btn-primary"">뒤로가기</button>
				</div>
			</div>
		</form>


		<script>
			//뒤로가기
			function cancle(){window.history.back();}
		
			//아이디 중복확인
			$('#user_id').blur(function(){
				var user_id = $('#user_id').val();
				if(user_id == ""){
					$("#id_check").text("아이디를 입력해주세요 ");
					$("#id_check").css("color", "red");
					$("#registerbtn").attr("disabled", true);
				}else{
					$.ajax({
						type : "POST",
						url : "<c:url value='/user/idCheck.do' />",
						data : {
							'user_id' : user_id
						},
						contentType : "application/x-www-form-urlencoded; charset=UTF-8",
						dataType : "json",
						success : function(data) {
							if (data.result == 1) {
								$("#id_check").text("사용중인 아이디입니다 ");
								$("#id_check").css("color", "red");
								$("#registerbtn").attr("disabled", true);
							} else {
								$("#id_check").text("사용가능한 아이디입니다 ");
								$("#id_check").css("color", "blue");
								$("#registerbtn").attr("disabled", false);
							}
						}
					});
				}
			})
		
			//회원정보 유효성 검사
			$('form').submit(function() {
				var getName = RegExp(/^[가-힣]+$/);
				var getCheck = RegExp(/^[a-zA-Z0-9]{4,12}$/);
				var user_id = $("#user_id").val();
				var user_pw = $("#user_pw").val();
				var user_name = $("#user_name").val();
				if ($("#user_id").val() == "") {
					alert("아이디를 입력해주세요.");
					$("#user_id").focus();
					return false;
				}
				if (!getCheck.test($("#user_id").val())) {
					alert("형식에 맞게 입력해주세요");
					$("#user_id").val("");
					$("#user_id").focus();
					return false;
				}
				if ($("#user_pw").val() == "") {
					alert("패스워드 입력바람");
					$("#user_pw").focus();
					return false;
				}
				if ($("#user_id").val() == $("#user_pw").val()) {
					alert("아이디와 비밀번호가 같습니다");
					$("#user_pw").val("");
					$("#user_pw").focus();
					return false;
				}
				if (!getCheck.test($("#user_pw").val())) {
					alert("형식에 맞게 입력해주세요");
					$("#user_pw").val("");
					$("#user_pw").focus();
					return false;
				}
				if ($("#user_pw_check").val() == "") {
					alert("패스워드 확인란을 입력해주세요");
					$("#user_pw_check").focus();
					return false;
				}
				if ($("#user_pw").val() != $("#user_pw_check").val()) {
					alert("비밀번호가 상이합니다");
					$("#user_pw").val("");
					$("#user_pw_check").val("");
					$("#user_pw").focus();
					return false;
				}
				if ($("#user_name").val() == "") {
					alert("이름을 입력해주세요");
					$("#user_name").focus();
					return false;
				}
				if (!getName.test($("#user_name").val())) {
					alert("이름형식에 맞게 입력해주세요")
					$("#user_name").val("");
					$("#user_name").focus();
					return false;
				}
				alert("가입완료");
			})
		</script>
		
		<hr />
	</div>
</body>
</html>