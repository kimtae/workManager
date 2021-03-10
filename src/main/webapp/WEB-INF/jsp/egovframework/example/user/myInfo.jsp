<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		
		<!-- 모달창 -->
		<div class="modal fade" id="defaultModal">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">알림</h4>
					</div>
					<div class="modal-body">
						<p class="modal-contents"></p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
		<!--// 모달창 -->
		<hr />
		<!-- 본문 들어가는 부분 -->


		<form class="form-horizontal" role="form" action="/user/modify.do" onsubmit="return userModify()" method="post">
			<div class="form-group" id="divId">
				<label for="inputId" class="col-lg-2 control-label">아이디</label>
				<div class="col-lg-10">
					<input type="text" readonly="readonly"
						class="form-control onlyAlphabetAndNumber" name="user_id"
						id="user_id" data-rule-required="true" value="${user_id}"
						maxlength="30">
				</div>
			</div>
			<div class="form-group" id="divPassword">
				<label for="inputPassword" class="col-lg-2 control-label">패스워드</label>
				<div class="col-lg-10">
					<input type="password" class="form-control" id="user_pw"
						name="user_pw" data-rule-required="true"
						placeholder="영문 숫자 조합 4~12자로 입력해주세요" maxlength="30">
				</div>
			</div>
			<div class="form-group" id="divPasswordCheck">
				<label for="inputPasswordCheck" class="col-lg-2 control-label">패스워드
					확인</label>
				<div class="col-lg-10">
					<input type="password" class="form-control" id="user_pw_check"
						name="user_pw_check" data-rule-required="true"
						placeholder="영문 숫자 조합 4~12자로 입력해주세요" maxlength="30">
				</div>
			</div>
			<div class="form-group" id="divName">
				<label for="inputName" class="col-lg-2 control-label">이름</label>
				<div class="col-lg-10">
					<input type="text" class="form-control onlyHangul" id="user_name"
						name="user_name" data-rule-required="true"
						placeholder="한글만 입력 가능합니다." maxlength="15">
				</div>
			</div>
			<div class="form-group">
				<div class="col-lg-offset-2 col-lg-10">
					<button type="submit" class="btn btn-primary">수정하기</button>
					<button type="button" onclick="doDelete()" class="btn btn-primary"">탈퇴하기</button>
					<button type="button" onclick="cancle()" class="btn btn-primary"">뒤로가기</button>
				</div>
			</div>
		</form>
		

		<script>
		function cancle(){window.history.back();}
		
		function doDelete(){
			var user_id = $("#user_id").val();
			if (confirm("정말 삭제하시겠습니까??") == true) {
				$.ajax({
					type : "POST",
					url : "<c:url value='/user/doDelete.do'/>",
					data : {
						'user_id' : user_id
					},
					contentType : "application/x-www-form-urlencoded; charset=UTF-8",
					dataType : "json",
					success : function(data) {
						alert(data.result);
						location.href="/user/main.do";
					}, error: function(jqXHR, textStatus, errorThrown) {
		                alert("ERROR : " + textStatus + " : " + errorThrown);
		            }        
				}); 
			}
			else {
				return false;
			}
		}
		
		function userModify() {
			var getName = RegExp(/^[가-힣]+$/);
			var getCheck = RegExp(/^[a-zA-Z0-9]{4,12}$/);
			var user_id = $("#user_id").val();
			var user_pw = $("#user_pw").val();
			var user_name = $("#user_name").val();

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
			alert("수정완료")
		}
		
		</script>
		<hr />

	</div>
</body>
</html>