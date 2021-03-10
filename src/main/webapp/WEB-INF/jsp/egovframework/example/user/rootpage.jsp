<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->

<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script>
	//관리자 페이지 이동
	function rootPage(){
		location.href="/user/rootPage.do";
	}
	//회원 수정
	function userModify(user_id,nowPage) {
		var user_name = document.getElementById(user_id+"_name").value;
		var user_pw = document.getElementById(user_id+"_pw").value;
		
		if (confirm("정말 수정하시겠습니까??") == true) {
			var getName = RegExp(/^[가-힣]+$/);
			var getCheck = RegExp(/^[a-zA-Z0-9]{4,12}$/);
			if (user_name == "") {
				alert("이름을 입력해주세요");
				return false;
			}
			if (!getName.test(user_name)) {
				alert("이름형식에 맞게 입력해주세요")
				return false;
			}
			if (user_pw == "") {
				alert("패스워드 입력바람");
				return false;
			}
			if (user_id == user_pw) {
				alert("아이디와 비밀번호가 같습니다");
				return false;
			}
			if (!getCheck.test(user_pw)) {
				alert("형식에 맞게 입력해주세요");
				return false;
			}

			$.ajax({
				type : "POST",
				url : "<c:url value='/user/rootModifyUser.do'/>",
				data : {
					'user_id' : user_id,
					'user_pw' : user_pw,
					'user_name' : user_name
				},
				contentType : "application/x-www-form-urlencoded; charset=UTF-8",
				dataType : "json",
				success : function(data) {
					if(data.result == 1){
						alert("수정완료")	
						userList(nowPage);
					}else{
						alert(data.result);
					}
					
				}
			});
		} else {
			return false;
		}
	}
	//회원 삭제
	function userDelete(user_id,nowPage) {
		if (confirm("정말 삭제하시겠습니까??") == true) {
			$
					.ajax({
						type : "POST",
						url : "<c:url value='/user/doDelete.do'/>",
						data : {
							'user_id' : user_id
						},
						contentType : "application/x-www-form-urlencoded; charset=UTF-8",
						dataType : "json",
						success : function(data) {
							userList(nowPage);
							alert("삭제완료")
						}
					});

		} else {
			return false;
		}
	}
	//회원 권한 해제
	function userLock(user_id,nowPage) {
		$.ajax({
			type : "POST",
			url : "<c:url value='/user/lock.do'/>",
			data : {
				'user_id' : user_id
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",
			success : function(data) {
				if(data.result == 1){
					alert("해제 되었습니다.");
					userList(nowPage);
				}else{
					alert(data.result);
					return false;
				}
			}
		});
	}
	//회원 권한 승인
	function userUnLock(user_id,nowPage) {
		$.ajax({
			type : "POST",
			url : "<c:url value='/user/unlock.do'/>",
			data : {
				'user_id' : user_id
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",
			success : function(data) {
				if(data.result==1){
					alert("승인 되었습니다.");
					userList(nowPage);
				}else{
					alert(data.result);
					return false;
				}
				
				
			}
		});
	}
	//로그아웃
	function logOut(){
		location.href="/user/logOut.do";
	}
	
	function changeUserType(user_id,nowPage) {
		var user_type = $("#user_type option:selected").val();
		$.ajax({
			type : "POST",
			url : "<c:url value='/user/changeType.do' />",
			data : {
				'user_type' : user_type ,'uesr_id':user_id
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",
			success : function(data) {
				alert(data.result);
				userList(nowPage);
				
			}
		});
	}
	
	//회원 리스트 출력
	function userList(nowPage) {
		if(nowPage==null){
			nowPage = 1;
		}
		var user = '';
		$.ajax({
			type : "POST",
			url : "<c:url value='/user/userList.do'/>",
			data:{
				'nowPage':nowPage
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",
			success : function(data) {
				$("#list").empty();
				user += '<table class="table table-hover">';
				user += '<tr>';
				user += '<th>아이디</th>';
				user += '<th>이름</th>';
				user += '<th>비밀번호</th>';		
				user += '<th>타입</th>';
				user += '<th colspan="2">사용권한</th>';
				user += '<th>가입일</th>';
				user += '<th>수정일</th>';
				user += '<th>수정자</th>';
				user += '<th>설정</th>';
				user += '</tr>';
				for(var i=0;i<data.userList.length;i++){
					if(data.userList[i].user_type==2){
						user += '<tr>';
						user += '<td>'+data.userList[i].user_id+'</td>';
						user += '<td>'+data.userList[i].user_name+'</td>';
						user += '<td>'+'비밀'+'</td>';
						user += '<td>'+'관리자'+'</td>';
						user += '<td colspan="2">'+'Y'+'</td>';
						user += '<td>'+data.userList[i].user_reg_date+'</td>';
						user += '<td>'+data.userList[i].user_modify_date+'</td>';
						user += '<td>'+data.userList[i].user_modify_writer+'</td>';
						user += '</tr>';
					}else{
						user += '<tr>';
						user += '<td>'+data.userList[i].user_id+'</td>';
						user += '<td>'+'<input type="text" name="'+data.userList[i].user_id+'_name" id="'+data.userList[i].user_id+'_name" value="'+data.userList[i].user_name+'"/>'+'</td>';
						user += '<td>'+'<input type="password" name="'+data.userList[i].user_id+'_pw" id="'+data.userList[i].user_id+'_pw" value="'+data.userList[i].user_pw+'"/><input class="btn btn-default" type="button" onclick="userModify(\''+data.userList[i].user_id+'\','+data.paging.nowPage+')" value="수정"/>'+'</td>';
						
						user += '<td><select name="user_type" id="user_type">';
								user += '<option value="1"'; 
								if(data.userList[i].user_type == 1){
									user+='selected';
								} 
								user += 	'>일반사용자</option>';
								user += '<option value="3"'; 
								if(data.userList[i].user_type == 3){
									user+='selected';
								} 
								user += 	'>매니저</option>';
						
						
						user +='</select><input class="btn btn-default" type="button" value="변경" onclick="changeUserType(\''+data.userList[i].user_id+'\','+data.paging.nowPage+')"/></td>';
						
						if(data.userList[i].user_using == 1){
							user += '<td>'+'Y'+'</td>';
							user+='<td><input class="btn btn-default" type="button" onclick="userLock(\''+data.userList[i].user_id+'\','+data.paging.nowPage+')" value="회원해제"/></td>';
						}else{
							user += '<td>'+'N'+'</td>';
							user+='<td><input class="btn btn-default" type="button" onclick="userUnLock(\''+data.userList[i].user_id+'\','+data.paging.nowPage+')" value="회원승인"/></td>';
						}
						user += '<td>'+data.userList[i].user_reg_date+'</td>';
						user += '<td>'+data.userList[i].user_modify_date+'</td>';
						user += '<td>'+data.userList[i].user_modify_writer+'</td>';									
						user += '<td><input class="btn btn-default" type="button" onclick="userDelete(\''+data.userList[i].user_id+'\','+data.paging.nowPage+')" value="삭제"/></td>';
						user += '</tr>';
					}
					
				}
				user+='</table>'
				
				
				//페이징
				user+='<div class="text-center">';
				if(data.paging.startPage!=1){
				user+='<a onclick="userList('+(data.paging.startPage-1)+')">이전</a>';
				}
				for(var i =data.paging.startPage; i<data.paging.endPage+1; i++){
					if(i == data.paging.nowPage){
						user+='<b>'+i+'</b>';
					}else if(i != data.paging.nowPage){
						user+='<a onclick="userList('+i+')">'+i+'</a>';
					}
				}
				if(data.paging.endPage != data.paging.lastPage){
					user+='<a onclick="userList('+(data.paging.endPage+1)+')">다음</a>';
				}
				user+='</div>';
				$("#list").append(user);
			}
		});
	}
	function projectList(nowPage) {
		if(nowPage==null){
			nowPage =1;
		}
		var user = '';
		$.ajax({
			type : "POST",
			url : "<c:url value='/project/getProjectList.do'/>",
			data:{
				'nowPage':nowPage 
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",
			success : function(data) {
				
				$("#list").empty();
				user += '<table class="table table-hover">';
				user += '<tr>';
				user += '<th>프로젝트명</th>';
				user += '<th>소개</th>';
				user += '<th>사용권한</th>';
				user += '<th>작성자</th>';
				user += '<th>작성일</th>';
				user += '<th>수정일</th>';
				user += '</tr>';
				if(data.projectList.length>0){
					for(var i=0;i<data.projectList.length;i++){
						user += '<tr>';
						user += '<td>'+'<a onclick="projectDetail('+data.projectList[i].pr_num+','+nowPage+')">'+data.projectList[i].pr_title+'</a>'+'</td>';
						user += '<td>'+data.projectList[i].pr_content+'</td>';
						user += '<td>'+data.projectList[i].pr_using+'</td>';
						user += '<td>'+data.projectList[i].pr_writer+'</td>';
						user += '<td>'+data.projectList[i].pr_date+'</td>';
						user += '<td>'+data.projectList[i].pr_modify_date+'</td>';
						user += '</tr>';
					}
				}else{
					user += '<tr>';
					user+='<td colspan="5">등록된 프로젝트가 없습니다.</td>';
					user += '</tr>';
				}
				
				user+='</table>'
				
				//페이징
				user+='<div>';
				if(data.paging.startPage!=1){
				user+='<a onclick="projectList('+(data.paging.startPage-1)+')">이전</a>';
				}
				for(var i =data.paging.startPage; i<data.paging.endPage+1; i++){
					if(i == data.paging.nowPage){
						user+='<b>'+i+'</b>';
					}else if(i != data.paging.nowPage){
						user+='<a onclick="projectList('+i+')">'+i+'</a>';
					}
				}
				if(data.paging.endPage != data.paging.lastPage){
					user+='<a onclick="projectList('+(data.paging.endPage+1)+')">다음</a>';
				}
				user+='</div>';
				$("#list").append(user);
			}
		});
	}
	function projectDetail(pr_num,nowPage){
		var user = '';
		$.ajax({
			type : "POST",
			url : "<c:url value='/project/detail.do' />",
			data : {
				'pr_num' : pr_num 
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",
			success : function(data) {
				$("#list").empty();
				user += '<table>';
					user += '<tr>';
						user += '<th>프로젝트명 :</th>';
						user += '<th>'+data.project.pr_title+'</th>';
					user += '</tr>';
					user += '<tr>';
						user += '<th>소개 :</th>';
						user += '<th>'+data.project.pr_content+'</th>';
					user += '</tr>';
					user += '<tr>';
					user += '<td><input type="button" value="일감 등록" onclick="workAdd('+pr_num+')"/></td>';
					user += '<td><input type="button" value="수정" onclick="projectModify('+pr_num+')"/></td>';
					user += '<td><input type="button" value="삭제" onclick="projectDelete('+pr_num+','+nowPage+')"/></td>';
					user += '<td><input type="button" value="일감 리스트" onclick="workList('+pr_num+')"/></td>';
					user += '</tr>';
				user+='</table>'
				user+='<hr>';
				user+='<div id="worklist"></div>'
				$("#list").append(user);
			}
		});
	}
	function projectModify(pr_num){
		var user = '';
		$.ajax({
			type : "POST",
			url : "<c:url value='/project/detail.do' />",
			data : {
				'pr_num' : pr_num
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",
			success : function(data) {
				$("#list").empty();
				user+='<form id="projectModifyForm">';
					user += '<table>';
						user += '<tr>';
							user += '<td>프로젝트명 :</td>';
							user += '<td><input type="text" name="pr_title" id="pr_title" value="'+data.project.pr_title+'"</td>';
						user += '</tr>';
						
						user += '<tr>';
							user += '<td>소개 :</td>';
							user += '<td><input type="text" name="pr_content" id="pr_content" value="'+data.project.pr_content+'"</td>';
						user += '</tr>';
						
						user += '<tr>';
							user += '<input type="hidden" name="pr_writer" id="pr_writer" value="'+data.project.pr_writer+'"/>'
							user += '<input type="hidden" name="pr_num" id="pr_num" value="'+data.project.pr_num+'"/>'
							user += '<td><input type="button" onclick="pr_modify()" value="확인"/></td>';
							user += '<td><input type="button" value="취소" onclick="projectDetail('+data.project.pr_num+',\''+data.project.pr_writer+'\')"/></td>';
						user += '</tr>';
					user+='</table>'
				user+='</form>';
				$("#list").append(user);
			}
		});
	}
		function pr_modify() {
			
			var form = document.getElementById("projectModifyForm");
			var pr_title = form.pr_title.value;
			var pr_content = form.pr_content.value;
			var pr_num = form.pr_num.value;
			$.ajax({
				type : "POST",
				url : "<c:url value='/project/pr_modify.do' />",
				data : {
					'pr_title' : pr_title, 'pr_content':pr_content, 'pr_num':pr_num, 'pr_writer':'intern2'
				},
				contentType : "application/x-www-form-urlencoded; charset=UTF-8",
				dataType : "json",
				success : function(data) {
					alert(data.result);
					projectDetail(pr_num);
					
				}
			});
			
			
		}
		//프로젝트 삭제
		function projectDelete(pr_num,nowPage){
			
			if (confirm("정말 삭제하시겠습니까??") == true) {
				$.ajax({
					type : "POST",
					url : "<c:url value='/project/delete.do'/>",
					data : {
						'pr_num' : pr_num
					},
					contentType : "application/x-www-form-urlencoded; charset=UTF-8",
					dataType : "json",
					success : function(data) {
						alert(data.result);
						projectList(nowPage);
						
					}
				});
			} else {
				return false;
			}
		}	
		

	
</script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

</head>
<body>
	<div>
		<input class="btn btn-default" type="button" value="로그아웃" onclick="logOut()"/>&nbsp;
		<input class="btn btn-default" type="button" value="회원목록" onclick="userList()"/>&nbsp;
		<input class="btn btn-default" type="button" value="프로젝트관리" onclick="projectList()"/>
		
		
	</div>
	<hr>
	<div id="list">
	
	</div>
	
</body>
</html>