<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript">
	
	function workInsert() {
		var formData = new FormData($("#workFileForm")[0]);
		
		var pr_num = $("#work_pr_num").val();
		var pr_writer = "<c:out value="${user_id}"/>";
		
		var work_title = $("#work_title").val();
		if(work_title==null||"" == (work_title)){
			alert("제목을 입력해주세요");
			return false;
		}
		
		$.ajax({
			type : "POST",
			url : "<c:url value='/work/add.do' />",
			data: formData, 
			processData: false, 
			contentType: false, 
			success : function(data) {
					alert("등록되었습니다");
					projectDetail(pr_num, pr_writer);	
			}
		});
	}
	//일감 추가
	function workAdd(pr_num){
		var user = '';
		var work_writer = "<c:out value="${user_id}"/>";
		$("#worklist").empty();																    //일감 제목 NULL 값 검사
			user+='<form id="workFileForm" method="post" enctype="multipart/form-data">';
			user += '<input type="hidden" name="work_pr_num" id="work_pr_num" value="'+pr_num+'"/>';
			user += '<input type="hidden" name="work_writer" value="'+work_writer+'"/>';
			user += '<table>';
				user += '<tr>';
					user += '<td>제목</td>';
					user += '<td><input size"80" maxlength="255" type="text" name="work_title" id="work_title"/></td>';
				user += '</tr>';
				
				user += '<tr>';
					user += '<td>설명</td>';
					user += '<td><textarea cols="60" rows="10" name="work_content" id="work_content"/></td>';
				user += '</tr>';
				user += '<tr>';
					user += '<td>진행상태</td>';
					user += '<td>';
					user += 	'<select name="work_progress" id="work_progress">';
					user += 		'<option value="1">낮음</option>';
					user += 		'<option selected="selected" value="2">보통</option>';
					user += 		'<option value="3">높음</option>';
					user += 		'<option value="4">긴급</option>';
					user += 		'<option value="5">즉시</option></select>';
					user += '</td>';
				user += '</tr>';
				user += '<tr>';
					user+='<div id="file"></div>'
					user+='<td><input type="file" id="file" name="file" multiple /></td>';
					
				user += '</tr>';
				user += '<tr>';
				user += '<td><input type="button" value="등록" onclick="workInsert()"/></td>'
				user += '</tr>';
				
			user+='</table>'
		user+='</form>';
		$("#worklist").append(user);
	
	}

	//일감 제목 검사
	function workCheck(){
		  if($.trim($("#work_title").val())==""){
		   alert("제목을 입력해주세요");
		   $("#work_title").val("").focus();
		   return false;
		  } 
		}
	
	//일감 리스트 출력 (프로젝트 번호, 현재페이지)
	function workList(work_pr_num,nowPage){
		var user = '';
		//현재페이지가 NULL 값 일때 1을 기본 값으로 설정해준다
		if(nowPage==null){
			nowPage =1;
		}
		$.ajax({
			type : "POST",
			url : "<c:url value='/work/list.do' />",
			data : {
				'work_pr_num' : work_pr_num , 'nowPage':nowPage
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",
			success : function(data) {
				if(data.result ==1){
					//workList <div> 초기화
					$("#worklist").empty();
					user += '<table>';
						user += '<tr>';
							user += '<th>우선순위</th>';
							user += '<th>제목</th>';
							user += '<th>작성자</th>';
							user += '<th>변경</th>';
						user += '</tr>';
					if(data.workList.length>0){
						for(var i=0;i<data.workList.length;i++){
							if(data.workList[i].work_using ==1){
								user += '<tr>';	
								if(data.workList[i].work_progress == "1"){
									user+='<td>낮음</td>';
								}else if(data.workList[i].work_progress == "2"){
									user+='<td>보통</td>';
								}else if(data.workList[i].work_progress == "3"){
									user+='<td>높음</td>';
								}else if(data.workList[i].work_progress == "4"){
									user+='<td>긴급</td>';
								}else{
									user+='<td>즉시</td>';
								}
								user += '<td><a onclick="workDetail('+data.workList[i].work_num+')">'+data.workList[i].work_title+'</a></td>';
								user += '<td>'+data.workList[i].work_writer+'</td>';
								user += '<td>'+data.workList[i].work_modify_date+'</td>';
							user += '</tr>';
							}
							
						}
					}else{
						user+='<tr>';
						user+='<td colspan="4">일감을 등록해주세요</td>';
						user+='</tr>';
					}
					
					user+='</table>'
					//페이징 처리
					user+='<div>';
					if(data.paging.startPage!=1){
					user+='<a onclick="workList('+work_pr_num+','+(data.paging.startPage-1)+')">이전</a>';
					}
					for(var i =data.paging.startPage; i<data.paging.endPage+1; i++){
						if(i == data.paging.nowPage){
							user+='<b>'+i+'</b>';
						}else if(i != data.paging.nowPage){
							user+='<a onclick="workList('+work_pr_num+','+i+')">'+i+'</a>';
						}
					}
					if(data.paging.endPage != data.paging.lastPage){
						user+='<a onclick="workList('+work_pr_num+','+(data.paging.endPage+1)+')">다음</a>';
					}
					user+='</div>';
					
					//div에 추가
					$("#worklist").append(user);
				}else{
					alert(data.result);
					return false;
				}
				
			},
		     error:function(request,status,error){
		         alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
		     }
		});
	}
	
	//일감 상세 페이지
	function workDetail(work_num) {
		var user='';
		var user_id = "<c:out value="${user_id}"/>";
		$.ajax({
			type : "POST",
			url : "<c:url value='/work/detail.do' />",
			data : {
				'work_num' : work_num
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",
			success : function(data) {
				//work_num이 제대로 넘어갔을 때 동작
				if(data.result ==1){
					$("#worklist").empty();
					user += '<table>';
					
						user += '<tr>';
							user += '<td>제목 :</td>';
							user += '<td>'+data.work.work_title+'</td>';
						user += '</tr>';
						
						user += '<tr>';
							user += '<td>소개 :</td>';
							user += '<td>'+data.work.work_content+'</td>';
						user += '</tr>';
						
						user += '<tr>';
							user += '<td>우선순위 :</td>';
							if(data.work.work_progress == "1"){
								user+='<td>낮음</td>';
							}else if(data.work.work_progress == "2"){
								user+='<td>보통</td>';
							}else if(data.work.work_progress == "3"){
								user+='<td>높음</td>';
							}else if(data.work.work_progress == "4"){
								user+='<td>긴급</td>';
							}else{
								user+='<td>즉시</td>';
							}
						user += '</tr>';
						//첨부된 파일이 있을 때
						if(data.file.length>0){
							
							for(var i=0; i<data.file.length;i++){
								if(data.file[i].file_using==1){
									user+= '<tr>';
									user+='<td>'+data.file[i].file_original_name+'</td>';
									//다운로드
									user+='<td><input type="button" onclick="fileDown('+data.file[i].file_num+')" value="다운로드"/></td>';
									user+= '</tr>';	
								}
							}
							
						}
						//등록자 본인일 경우
						if(user_id == data.work.work_writer){
							user += '<tr>';
							user += '<td><input type="button" value="수정" onclick="workModify('+data.work.work_num+')"/></td>';
							user += '<td><input type="button" value="삭제" onclick="workDelete('+data.work.work_num+','+data.work.work_pr_num+')"/></td>';	
							user += '</tr>';
						}
						
						
					user+='</table>';
					user+='<hr>';
					////////////////////////댓글부분////////////////////////////////
					
					
					//댓글등록
					user+='<form id="writeCommentForm">';
					user+='<input type="hidden" name="user_id" value="'+user_id+'"/>';
					user+='<input type="hidden" name="cm_wnum" value="'+data.work.work_num+'"/>';
					user+=user_id+'|<textarea cols="30" rows="5" name="cm_content" id="cm_content"/>';
					user+='<input type="button" onclick="commentAdd()" value="댓글등록"/>';
					user+='</form>';
					user+='<hr>';
					
					//댓글리스트(스크롤)
					user+='<div id="commentList" style="overflow:auto; width:500px; height:150px;"></div>';
					$("#worklist").append(user);
					commentList(work_num);
				}else{
					alert(data.result);
					return false;
				}
				
			}
		});
	}
	//일감 삭제
	function workDelete(work_num,pr_num) {
		if (confirm("정말 삭제하시겠습니까??") == true) {
		$.ajax({
			type : "POST",
			url : "<c:url value='/work/delete.do' />",
			data : {
				'work_num' : work_num
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",
			success : function(data) {
				if(data.result == 1){
					alert("삭제 되었습니다");
					//일감 리스트로 이동
					workList(pr_num);
				}else{
					alert(data.result);
					return false;
				}
				
			}
		});
		}else{
			return false;
		}
	}
	//일감 수정 폼
	function workModify(work_num) {
		var user='';
		$.ajax({
			type : "POST",
			url : "<c:url value='/work/detail.do' />",
			data : {
				'work_num' : work_num
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",
			success : function(data) {
				$("#worklist").empty();
				user+='<form id="workModifyForm" method="post" enctype="multipart/form-data">';
					user += '<table id="">';
						user += '<tr>';
							user += '<td>제목</td>';
							user += '<td><input type="text" name="work_title" id="work_title" value="'+data.work.work_title+'"</td>';
						user += '</tr>';
						
						user += '<tr>';
							user += '<td>소개</td>';
							user += '<td><input type="text" name="work_content" id="work_content" value="'+data.work.work_content+'"</td>';
						user += '</tr>';
						
						user += '<tr>';
							user += '<td>진행상태</td>';
							user += '<td>';
							user += 	'<select name="work_progress" id="work_progress">';
							user += 		'<option value="1">낮음</option>';
							user += 		'<option selected="selected" value="2">보통</option>';
							user += 		'<option value="3">높음</option>';
							user += 		'<option value="4">긴급</option>';
							user += 		'<option value="5">즉시</option></select>';
							user += '</td>';
						user += '</tr>';
						
						if(data.file.length>0){
							for(var i=0; i<data.file.length;i++){
								if(data.file[i].file_using==1){
									user+= '<tr>';
									user+='<td>'+data.file[i].file_original_name+'</td>';
									user+='<td><input type="button" onclick="fileDelete(this,'+data.file[i].file_num+','+data.work.work_num+')" value="삭제"/></td>';
									user+= '</tr>';
								}
								
							}
						}
						user += '<tr>';
							user+='<td><input type="file" id="file"  name="file" multiple /></td>';
						user += '</tr>';
						
						user += '<tr>';
							user += '<input type="hidden" name="work_num" id="work_num" value="'+data.work.work_num+'"/>';
							user += '<td><input type="button" onclick="workModifyDo()" value="확인"/></td>'
							user += '<td><input type="button" value="취소" onclick="workDetail('+data.work.work_num+')"/></td>';
						user += '</tr>';
					user+='</table>'
				user+='</form>';
				$("#worklist").append(user);
			}
		});
		
	}
	
	//일감 수정
	function workModifyDo() {
		var formData = new FormData($("#workModifyForm")[0]);
				
		var work_num = $("#work_num").val();
		var work_title = $("#work_title").val();
		if(work_title==null||"" == (work_title)){
			alert("제목을 입력해주세요");
			return false;
		}
		
		$.ajax({
			type : "POST",
			url : "<c:url value='/work/modify.do' />",
			data: formData, 
			processData: false, 
			contentType: false, 
			success : function(data) {
					alert("수정되었습니다");
					workDetail(work_num);	
			}
		});
	}
	//파일 삭제
	function fileDelete(obj,file_num,work_num) {
		$(obj).parent().parent().remove(); // 해당 tr 삭제
		if (confirm("정말 삭제하시겠습니까??") == true) {
		$.ajax({
			type : "POST",
			url : "<c:url value='/work/fileDelete.do' />",
			data : {
				'file_num' : file_num
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",
			success : function(data) {
				if(data.result == 1){
					alert("삭제 되었습니다");
					workModify(work_num);	
				}else{
					alert(data.result);
					return false;
				}
				
			}
		});
		}else{
			return false;
		}
	}
	//파일 다운로드
	function fileDown(file_num) {
		/*  $.ajax({
			type : "POST",
			url : "<c:url value='/work/fileDown.do' />",
			data : {
				'file_num' : file_num
			},
			contentType : "application/octet-stream; charset=UTF-8",
			dataType : "json",
			success : function(data) {
				alert(data.result);
			}
		});  */
		 location.replace("/work/fileDown.do?file_num="+file_num); 
	}
	
	//댓글 등록
	function commentAdd() {
		var form = document.getElementById("writeCommentForm");
		//유저 아이디
		var user_id = form.user_id.value;
		//일감 번호
		var cm_wnum = form.cm_wnum.value;
		//댓글 내용
		var cm_content = form.cm_content.value;
		 if(!cm_content)
         {
             alert("내용을 입력하세요.");
             return false;
         }else{
        	 $.ajax({
     			type : "POST",
     			url : "<c:url value='/comment/add.do' />",
     			data : {
     				'user_id' : user_id, 'cm_content' : cm_content, 'cm_wnum' : cm_wnum
     			},
     			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
     			dataType : "json",
     			success : function(data) {
     				if(data.result==1){
     					alert("등록되었습니다");
     					form.cm_content.value ='';
     					commentList(cm_wnum);
     				}else{
     					alert(data.result);
     					return false;
     				}
     				
     			}
     		});
         }    
	}
	//댓글 리스트
	function commentList(work_num) {
		var user='';
		var user_id = "<c:out value="${user_id}"/>";
		$.ajax({
			type : "POST",
			url : "<c:url value='/comment/list.do' />",
			data : {
				'work_num' : work_num
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",
			success : function(data) {
					$("#commentList").empty();
					user+='<table>';
					for(var i=0; i<data.list.length;i++){
						if(data.list[i].cm_using ==1){
							user+='<tr>';
							user+='<td width="50">'+data.list[i].cm_writer+'</td>';
							user+='<td width="150">'+data.list[i].cm_content+'</td>';
							user+='<td width="150">'+data.list[i].cm_date+'</td>';
							//등록자 본인일 경우
							if(user_id==data.list[i].cm_writer){
								user+='<td><input type="button" value="수정" onclick="commentModify('+data.list[i].cm_num+')"/><td>';
								user+='<td><input type="button" value="삭제" onclick="commentDelete('+data.list[i].cm_num+')"/><td>';
							}
							user+='</tr>';
						}
					}
					user+='</table>';
					$("#commentList").append(user);
				
			}
		});
	}
	//댓글 삭제
	function commentDelete(cm_num) {
		$.ajax({
			type : "POST",
			url : "<c:url value='/comment/delete.do' />",
			data : {
				'cm_num' : cm_num
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",
			success : function(data) {
				if(data.result==1){
					alert("삭제 되었습니다");

					commentList(data.work_num);	
				}else{
					alert(data.result);
					return false;
				}
			}
		});
	}
	
	//댓글 수정폼
	function commentModify(cm_num) {
		var user='';
		$.ajax({
			type : "POST",
			url : "<c:url value='/comment/getComment.do' />",
			data : {
				'cm_num' : cm_num
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",
			success : function(data) {
					$("#commentList").empty();
					user+='<form id="modifyComment">';
					user+='<table>';
						user+='<tr>';
						user+='<td width="50">'+data.comment.cm_writer+'</td>';
						user+='<td width="150"><input type="text" name="cm_content" value="'+data.comment.cm_content+'"/></td>';
						user += '<td><input type="button" value="수정" onclick="modify('+data.comment.cm_num+')"></td>';
						user += '<td><input type="button" value="취소" onclick="commentList('+data.comment.cm_wnum+')"></td>';
						user+='</tr>';
						
					user+='</table>';
					user+='</form>';
					$("#commentList").append(user);
			}
		});
	}
	//댓글 수정
	function modify(cm_num) {

		var form = document.getElementById("modifyComment");
		var cm_content = form.cm_content.value;
		
		$.ajax({
			type : "POST",
			url : "<c:url value='/comment/modify.do' />",
			data : {
				'cm_num' : cm_num , 'cm_content':cm_content
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",
			success : function(data) {
				alert("수정완료");
				commentList(data.result.cm_wnum);
			}
		});
	}
	//프로젝트 추가
	function addProject(){
		var user_id = "<c:out value="${user_id}"/>";
		var user = '';
		$("#list").empty();
		user+='<form id="addProjectForm">';
		user+='<table class="table">';
		user+='<tr>';
			user+='<td class="col-md-1">작성자</td>';
			user+='<td><input type="text" name="pr_writer" id="pr_wrtier" value="'+user_id+'" readonly="readonly" /></td>';
		user+='</tr>';
		user+='<tr>';
			user+='<td class="col-md-1">제목</td>';
			user+='<td><input type="text" name="pr_title" id="pr_title"/></td>';
		user+='</tr>';
		user+='<tr>';
			user+='<td class="col-md-1">소개</td>';
			user+='<td><input type="text" name="pr_content" id="pr_content"/></td>';
		user+='</tr>';
		user+='</table>';
		user+='<input class="btn btn-default" onclick="addProjectDo()" type="button" value="등록"/>';
		user+='<input class="btn btn-default" onclick="cancle()" type="button" value="취소"/>';
		user+='</form>';
		
		
		
		$("#list").append(user);
	}
	function addProjectDo() {
		var form = document.getElementById("addProjectForm");
		var pr_writer = form.pr_writer.value;
		var pr_title = form.pr_title.value;
		var pr_content = form.pr_content.value;
		$.ajax({
			type : "POST",
			url : "<c:url value='/project/addProject.do' />",
			data : {
				'pr_writer' : pr_writer , 'pr_title':pr_title, 'pr_content':pr_content
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",
			success : function(data) {
				alert(data.result);
				projectList();
			}
		});
	}
	function searchList(nowPage) {
		var user = '';
		if(nowPage == null){
			nowPage = 1;
		}
		var con1 = $("#search_con1 option:selected").val();
		var con2 = $("#search_con2 option:selected").val();
		var con3 = $("#search_con").val();
		
		$.ajax({
			type : "POST",
			url : "<c:url value='/project/search.do' />",
			data : {
				'con1' : con1 , 'con2':con2, 'con3':con3, 'nowPage':nowPage
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",
			success : function(data) {
			
				$("#list").empty();
					
				
				user += '<select name="search_con1" id="search_con1">';
				user += '<option value="1"'; 
				if(data.searchVO.con1 == 1){
					user+='selected';
				}	 
				user += 	'>프로젝트</option>';
				user += 	'<option value="2"'; 
				if(data.searchVO.con1 == 2){
					user+='selected';
				}	 
				user += 	'>일감</option>';
				user +='</select>';
				
				user += '<select name="search_con2" id="search_con2">';
				user += '<option value="1"'; 
				if(data.searchVO.con2 == 1){
					user+='selected';
				}	 
				user += 	'>1개월</option>';
				user += '<option value="2"'; 
				if(data.searchVO.con2 == 2){
					user+='selected';
				}	 
				user += 	'>2개월</option>';
				user += '<option value="3"'; 
				if(data.searchVO.con2 == 3){
					user+='selected';
				}	 
				user += 	'>3개월</option>';
				user += '<option value="4"'; 
				if(data.searchVO.con2 == 4){
					user+='selected';
				}	 
				user += 	'>4개월</option>';
				user += '<option value="5"'; 
				if(data.searchVO.con2 == 5){
					user+='selected';
				}	 
				user += 	'>5개월</option>';
				user += '<option value="6"'; 
				if(data.searchVO.con2 == 6){
					user+='selected';
				}	 
				user += 	'>6개월</option>';
				user += '<option value="7"'; 
				if(data.searchVO.con2 == 7){
					user+='selected';
				}	 
				user += 	'>7개월</option>';
				user += '<option value="8"'; 
				if(data.searchVO.con2 == 8){
					user+='selected';
				}	 
				user += 	'>8개월</option>';
				user += '<option value="9"'; 
				if(data.searchVO.con2 == 9){
					user+='selected';
				}	 
				user += 	'>9개월</option>';
				user += '<option value="10"'; 
				if(data.searchVO.con2 == 10){
					user+='selected';
				}	 
				user += 	'>10개월</option>';
				user += '<option value="11"'; 
				if(data.searchVO.con2 == 11){
					user+='selected';
				}	 
				user += 	'>11개월</option>';
				user += '<option value="12"'; 
				if(data.searchVO.con2 == 12){
					user+='selected';
				}	 
				user += 	'>12개월</option>';
				user +='</select>';
				
				user +='<input type="text" id="search_con" value="'+data.searchVO.con3+'"/>';
				user +='<input type="button" onclick="searchList()" id="search" value="검색"/>'
				
				if(data.type == 1){
					user += '<table>';
					user += '<tr>';
					user += '<th>프로젝트명</th>';
					user += '<th>소개</th>';
					user += '<th>작성자</th>';
					user += '<th>작성일</th>';
					user +='<th>수정일</th>'
					user += '</tr>';
					if(data.projectList.length>0){
						for(var i=0;i<data.projectList.length;i++){
							if(data.projectList[i].pr_using == 1){
								user += '<tr>';
								user += '<td>'+'<a onclick="projectDetail('+data.projectList[i].pr_num+',\''+data.projectList[i].pr_writer+'\')">'+data.projectList[i].pr_title+'</a>'+'</td>';
								user += '<td>'+data.projectList[i].pr_content+'</td>';
								user += '<td>'+data.projectList[i].pr_writer+'</td>';
								user += '<td>'+data.projectList[i].reg_date+'</td>';
								user += '<td>'+data.projectList[i].pr_modify_date+'</td>';
								user += '</tr>';
							}
						}
					}else{
						user += '<tr>';
						user+='<td colspan="5">프로젝트를 등록해주세요</td>';
						user += '</tr>';
					}
					user+='</table>'
				}
				
				else{
					user += '<table>';
					user += '<tr>';
						user += '<th>우선순위</th>';
						user += '<th>제목</th>';
						user += '<th>작성자</th>';
						user += '<th>변경</th>';
					user += '</tr>';
				if(data.workList.length>0){
					for(var i=0;i<data.workList.length;i++){
						if(data.workList[i].work_using ==1){
							user += '<tr>';	
							if(data.workList[i].work_progress == "1"){
								user+='<td>낮음</td>';
							}else if(data.workList[i].work_progress == "2"){
								user+='<td>보통</td>';
							}else if(data.workList[i].work_progress == "3"){
								user+='<td>높음</td>';
							}else if(data.workList[i].work_progress == "4"){
								user+='<td>긴급</td>';
							}else{
								user+='<td>즉시</td>';
							}
							user += '<td><a onclick="workDetail('+data.workList[i].work_num+')">'+data.workList[i].work_title+'</a></td>';
							user += '<td>'+data.workList[i].work_writer+'</td>';
							user += '<td>'+data.workList[i].work_modify_date+'</td>';
						user += '</tr>';
						}
						
					}
				}else{
					user+='<tr>';
					user+='<td colspan="4">일감을 등록해주세요</td>';
					user+='</tr>';
				}
				
				user+='</table>'
					user+='<div>';
				if(data.paging.startPage!=1){
				user+='<a onclick="searchList('+(data.paging.startPage-1)+')">이전</a>';
				}
				for(var i =data.paging.startPage; i<data.paging.endPage+1; i++){
					if(i == data.paging.nowPage){
						user+='<b>'+i+'</b>';
					}else if(i != data.paging.nowPage){
						user+='<a onclick="searchList('+i+')">'+i+'</a>';
					}
				}
				if(data.paging.endPage != data.paging.lastPage){
					user+='<a onclick="searchList('+(data.paging.endPage+1)+')">다음</a>';
				}
				user+='</div>';
				user+='<hr>';
				user+='<div id="worklist"></div>';
				}
				//페이징
				
				$("#list").append(user);
			}
		});
	}
	
	
	//프로젝트 리스트 출력
	function projectList(nowPage){
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
				
				user += '<select name="search_con1" id="search_con1">';
				user += 	'<option value="1">프로젝트</option>';
				user += 	'<option value="2">일감</option></select>';
				user += '<select name="search_con2" id="search_con2">';
				user += 	'<option value="1">1개월</option>';
				user += 	'<option value="2">2개월</option>';
				user += 	'<option value="3">3개월</option>';
				user += 	'<option value="4">4개월</option>';
				user += 	'<option value="5">5개월</option>';
				user += 	'<option value="6">6개월</option>';
				user += 	'<option value="7">7개월</option>';
				user += 	'<option value="8">8개월</option>';
				user += 	'<option value="9">9개월</option>';
				user += 	'<option value="10">10개월</option>';
				user += 	'<option value="11">11개월</option>';
				user += 	'<option value="12">12개월</option></select>';
				user +='<input type="text" id="search_con"/>'
				user +='<input type="button" onclick="searchList()" id="search" value="검색"/>'
				
				user += '<table>';
				user += '<tr>';
				user += '<th>프로젝트명</th>';
				user += '<th>소개</th>';
				user += '<th>작성자</th>';
				user += '<th>작성일</th>';
				user +='<th>수정일</th>'
				user += '</tr>';
				if(data.projectList.length>0){
					for(var i=0;i<data.projectList.length;i++){
						if(data.projectList[i].pr_using == 1){
							user += '<tr>';
							user += '<td>'+'<a onclick="projectDetail('+data.projectList[i].pr_num+',\''+data.projectList[i].pr_writer+'\')">'+data.projectList[i].pr_title+'</a>'+'</td>';
							user += '<td>'+data.projectList[i].pr_content+'</td>';
							user += '<td>'+data.projectList[i].pr_writer+'</td>';
							user += '<td>'+data.projectList[i].reg_date+'</td>';
							user += '<td>'+data.projectList[i].pr_modify_date+'</td>';
							user += '</tr>';
						}
					}
				}else{
					user += '<tr>';
					user+='<td colspan="5">프로젝트를 등록해주세요</td>';
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

	//프로젝트 상세 페이지 폼
	function projectDetail(pr_num,pr_writer){
		var user = '';
		var user_id = "<c:out value="${user_id}"/>";
		
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
					//등록자 본인
					if(user_id == pr_writer){
						user += '<tr>';
						user += '<td><input type="button" value="일감 등록" onclick="workAdd('+pr_num+')"/></td>';
						user += '<td><input type="button" value="수정" onclick="projectModify('+pr_num+')"/></td>';
						user += '<td><input type="button" value="삭제" onclick="projectDelete('+pr_num+')"/></td>';
						
					}
					user += '<td><input type="button" value="일감 리스트" onclick="workList('+pr_num+')"/></td>';
					user += '</tr>';
				user+='</table>'
				user+='<hr>';
				user+='<div id="worklist"></div>'
				$("#list").append(user);
			}
		});
	}
	//프로젝트 수정 폼
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
							user += '<td><input type="button" onclick="pr_modify()"value="확인"/></td>';
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
		var pr_writer = form.pr_writer.value;
		$.ajax({
			type : "POST",
			url : "<c:url value='/project/pr_modify.do' />",
			data : {
				'pr_title' : pr_title, 'pr_content':pr_content, 'pr_num':pr_num, 'pr_writer':pr_writer
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",
			success : function(data) {
				alert(data.result);
				projectDetail(pr_num,pr_writer);
				
			}
		});
	}
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
	
	//뒤로가기
	function cancle(){
		var user_id = "<c:out value="${user_id}"/>";
		location.href="/user/loginOk.do?user_id="+user_id;
	}
	
	
	//내정보
	function userInfo() {
		var user = '';
		$("#list").empty();
		user+='<form id="userInfo">';
		user+='<label>비밀번호</label><input type="password" id="user_pw"/>'
		user+='<input class="btn btn-default" onclick="myInfo()" type="button" value="확인"/>';
		user+='</form>';
		$("#list").append(user);
	}
	function myInfo() {
		var user_id = "<c:out value="${user_id}"/>";
		var form = document.getElementById("userInfo");
		var user_pw = form.user_pw.value;
		$.ajax({
			type : "POST",
			url : "<c:url value='/user/loginCheck.do'/>",
			data : {
				'user_id' : user_id, 'user_pw':user_pw
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",
			success : function(data) {
				if(data.result ==1){
					 location.href="/user/myInfo.do"; 
				}else{
					alert("비밀번호를 확인해주세요");
					return false;
				}
				
			}
		});
		
	}
	
	
	//로그아웃
	function logOut(){
		location.href="/user/logOut.do";
	}
	
</script>
</head>
<body>
	<div>
		<h2>환영합니다 <c:out value="${user_id}"/>님</h2> &nbsp;&nbsp;&nbsp;&nbsp; 		
		<input type="button" value="내정보" onclick="userInfo()" />
		<input type="button" value="프로젝트 추가" onclick="addProject()" />
		<input type="button" value="프로젝트 리스트" onclick="projectList()" />
		<input type="button" value="로그아웃" onclick="logOut()" />
		
	</div>
	<hr>
	<div id="list"></div>
	
	
</body>
</html>