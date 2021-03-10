<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메인</title>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
	//회외가입 폼으로 이동
	function insert_btn() {
		location.href = "/user/insert.do"
	}
	
	//1.아이디가 있는지 검사
	function id_check() {
		var user_id = $('#user_id').val();
		var user_pw = $('#user_pw').val();
		if(""==user_id||null==user_id){
			alert("아이디를 입력해주세요.");
			return false;
		}if(""==user_pw||null==user_pw){
			alert("비밀번호를 입력해주세요.");
			return false;
		}
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
					allowLogin();	
				}else if(data.result==0){
					alert("가입되지 않은 사용자입니다.");
					return false;
				}else{
					alert(data.result);
					return false;
				}
			}
		});
	}
	//2. 회원 승인 확인
	function allowLogin() {
		var user_id = $('#user_id').val();
		$.ajax({
			type : "POST",
			url : "<c:url value='/user/allowLogin.do' />",
			data : {
				'user_id' : user_id
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",
			success : function(data) {
				if (data.user_using == 1) {
					password_check();	
				}else{
					alert('승인이 완료되지 않은 사용자입니다.');
					return false;					
				}
			}
		});
	}
	//3.비밀번호 확인
	function password_check() {
		var user_id = $('#user_id').val();
		var user_pw = $('#user_pw').val();
		$.ajax({
			type : "POST",
			url : "<c:url value='/user/loginCheck.do' />",
			data : {
				'user_id' : user_id, 'user_pw' : user_pw
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",
			success : function(data) {
				if (data.result == 1) {
					checkUserType();
				} else if(data.result == 0){
					alert("비밀번호를 확인해주세요.");
					return false;
				}else{
					alert(data.result);
					return false;
				}
			}
		});
	}
	
	//유저타입 확인
	function checkUserType(){
		var user_id = $('#user_id').val();
		$.ajax({
			type : "POST",
			url : "<c:url value='/user/checkUserType.do' />",
			data : {
				'user_id' : user_id
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",
			success : function(data) {
				if(data.result == 1 ){
					location.href="/user/loginOk.do?user_id="+user_id;
				}else if(data.result ==2){
					location.href="/user/rootPage.do";
				}else{
					alert(data.result);
					return false;
				}
			}
		});
	}

	
	
</script>
</head>
<body>
		<table class="table">
			<tr>
				<th class="col-md-1">ID</th>
				<td><input type="text" name="user_id" id="user_id" /></td>
			</tr>
			<tr>
				<th class="col-md-1">PW</th>
				<td><input type="password" name="user_pw" id="user_pw" /></td>
			</tr>

			<tr>
				<th><input class="btn btn-default" type="button" value="로그인" onclick="id_check()"></th>
				<td><input class="btn btn-default" type="button" value="회원가입" onclick="insert_btn()" /></td>
			</tr>
		</table>
</body>
</html>