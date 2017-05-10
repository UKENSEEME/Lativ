<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>公告</title>
	</head>
	<body>
	<jsp:useBean id="newsSvc" scope="page" class="com.news.model.NewsService" />
		<ul>
			<li>
			    <FORM METHOD="post">
			        <b>新增 :</b>
			        <input type="button" value="新增" name="new1" id='n1'>
			    </FORM>
			 </li>
 			<li>
 				<FORM >
			       <b>更改公告 :</b>
			       <select size="1" name="newsno1" >
				       <c:forEach var="newsVO" items="${newsSvc.all}" > 
				       		<option value="${newsVO.newsno}">${newsVO.newsno} : ${newsVO.title}
				       </c:forEach>   
			       </select>
			       <input type="button" value="送出" id='s1'>
			    </FORM>
			</li>
			<li>
 				<FORM >
			       <b>刪除公告 :</b>
			       <select size="1" name="deleteno" >
				       <c:forEach var="newsVO" items="${newsSvc.all}" > 
				       		<option value="${newsVO.newsno}">${newsVO.newsno} : ${newsVO.title}
				       </c:forEach>   
			       </select>
			       <input type="button" value="送出" id='d1'>
			    </FORM>
			</li>
		</ul>
		<div>
			<h1>修改公告</h1>
			<c:if test="${not empty errorMsgs}">
				<font color='red'>請修正以下錯誤:
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li>${message}</li>
					</c:forEach>
				</ul>
				</font>
			</c:if>
			<form method="post" action="news.do">
				<table border='1' >
					<tr><td width='80' style='text-align:center'>編  號</td>
						<td width='580' style='text-align:left' id='ta1'>
<!-- 							<input type='text'  name='newsno' size='80' readonly="readonly"> -->
						</td>
					</tr>
	
					<tr><td width='80' style='text-align:center'>主  題</td>
						<td width='580' id='ta2'>
<!-- 							<input type='text'  name='title' size='80' placeholder='標題'> -->
						</td>
					</tr> 

   					<tr><td width='80' style='text-align:center'>內  文</td>
   						<td width='580' id='ta3'>
<!--    							<textarea rows='10' cols='73'  name='content' placeholder='內文' overflow-y='visible'></textarea> -->
   						</td>
   					</tr>

   					<tr><td width='80' style='text-align:center'>日  期</td>
   						<td width='580' id='ta4'>
<!--    							<input type='text'  name='pubdate' size='80' placeholder='日期'> -->
   						</td>
   					</tr>

   					<tr><td colspan='2'style='text-align:center'>
   					<input type='submit' value='送出內容' id= 'go1'>&nbsp;&nbsp;&nbsp;
   					<input type='button' value='刪除內容' id= 's2'></td></tr>
			 		<input type="hidden" name="action" value="ins">
				</table>
			</form>
		</div>
		
		<script src="../js/jquery-1.12.3.min.js"></script>
		<script src="../js/bootstrap.min.js"></script>
		
		<script>
			
			
			$('#d1').click(function() {
				var deleteno = $('select[name="deleteno"]').val();
				
				console.log(deleteno);
				
				$.ajax({
					'type':'GET',
					'url':'news.do',
					'dataType':'xml',
					'data':{action:"del",'deleteno':deleteno},
					'complete':
						function(){
							alert('刪除成功');
							window.location.reload();
						},
				});
			});
			
			
			$('#n1').click(function() {
				now = new Date();
				var year = now.getFullYear();
				var mon = (now.getMonth()+1< 10 ? '0' : '')+(now.getMonth()+1);
				var day = (now.getDate()< 10 ? '0' : '')+now.getDate();
				var ta1 = $('#ta1');
				var ta2 = $('#ta2');
				var ta3 = $('#ta3');
				var ta4 = $('#ta4');
				var inp = $('<input/>');
				var inp2 = $('<input/>');
				inp.attr({type:'text',name:'newsno',size:'80',value:'new',color:'red',readonly:"readonly"});
				inp2.attr({type:'text',name:'pubdate',size:'80',value:year+'-'+mon+'-'+day});
				ta1.empty();
				ta2.empty();
				ta3.empty();
				ta4.empty();
				ta1.append($('<div></div>').append(inp));
				ta2.append($("<div></div>").html("<input type='text'  name='title' size='80' placeholder='標題'>"));
				ta3.append($("<div></div>").html("<textarea rows='10' cols='73'  name='content' placeholder='內文'></textarea>"));
				ta4.append($('<div></div>').append(inp2));
			});
			
			$('#s2').click(function() {
				var ta2 = $('#ta2');
				var ta3 = $('#ta3');

				ta2.empty();
				ta3.empty();

				ta2.append($("<div></div>").html("<input type='text'  name='title' size='80' placeholder='標題'>"));
				ta3.append($("<div></div>").html("<textarea rows='10' cols='73'  name='content' placeholder='內文'></textarea>"));

			});
			
			$('#s1').click(function() {
				var opValue = $('select[name="newsno1"]').val();
// 				console.log(opValue);
				$.getJSON('news.do',{action:"sel",'newsno':opValue},function(datas){
					
					   var ta1 = $('#ta1');
					   var ta2 = $('#ta2');
					   var ta3 = $('#ta3');
					   var ta4 = $('#ta4');
					   
					   var docFrag1 = $(document.createDocumentFragment());
					   var docFrag2 = $(document.createDocumentFragment());
					   var docFrag3 = $(document.createDocumentFragment());
					   var docFrag4 = $(document.createDocumentFragment());
					   
					   ta1.empty();
					   ta2.empty();
					   ta3.empty();
					   ta4.empty();
					  
					   $.each(datas,function(nox,news){
// 						   console.log(news.Content);
						   var inp = $('<input/>');
						   var inp2 = $('<input/>');
						   var inp33 = $('<textarea/>');
						   var inp4 = $('<input/>');
						   
						   inp.attr({type:'text',name:'newsno',size:'80',value:news.Newsno,readonly:"readonly"});
						   inp2.attr({type:'text',name:'title',size:'80',value:news.Title});
						   inp33.attr({name:'content',size:'80',rows:'10',cols:'73',value:news.Content});
						   var inp3 = inp33.val(news.Content);
						   inp4.attr({type:'text',name:'pubdate',size:'80',value:news.Pubdate});
						   
						   
						   var cell1 = $('<div></div>').append(inp);
						   var cell2 = $('<div></div>').append(inp2);
						   var cell3 = $('<div></div>').append(inp3);
						   var cell4 = $('<div></div>').append(inp4);
	
						   docFrag1.append(cell1);
						   docFrag2.append(cell2);
						   docFrag3.append(cell3);
						   docFrag4.append(cell4);
					   });
					   
					   ta1.append(docFrag1);
					   ta2.append(docFrag2);
					   ta3.append(docFrag3);
					   ta4.append(docFrag4);
				   })	  
				
			})
		</script>
	</body>
</html>