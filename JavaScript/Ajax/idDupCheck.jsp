<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** ID 중복확인 **</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src = "resources/myLib/jquery-3.2.1.min.js"></script>
<script src = "resources/myLib/inCheck.js"></script>
<script>
// $.ajax({
// 	url:"joinck",
// 	type:"post",
// 	data :{id:id},
// 	success: (result)=>{
// 		if(result != 'fall'){
			
// 		}else {
			
// 		}		
// 	};

//** 사용자가 입력한 id 를 사용가능하도록 해주고, 현재(this)창은 close
// 1=> this 창의 id 를 부모창의 id 로
// 2=> 부모창의 ID중복확인 버튼은 disable & submit 은 enable
// 3=> 부모창의 id 는 수정불가 (readonly) , password 에 focus
// 4=> 현재(this)창은 close
function idOK(){
	
	// ** JQ 방식으로 속성 접근
	// => attr, prop 비교
	// => attr()는 HTML의 속성(Attribute), 기능, 입력된 값을 취급 
	// => prop()는 JavaScript DOM 객체의 프로퍼티(Property), 실제값, property가 가지는 본연의 값
	
	//1
	// 	opener.document.getElementById("id").value="${newId}";
	//	=> <script> 에서 EL은 문자열Type 내부에서 사용 가능함.
	//	opener.$('#id').val('${newId}');
	opener.$('#id').val(`${'${newId}'}`) 
	
	//2
	//opener.$('#iddup').attr('disabled','disabled'); //in JQ attr
	// in JS opener.document.getElementById('iddup').disabled='disabled';
	opener.$('#iddup').prop(`disabled`,true); //in JQ prop
	//opener.$('#submit').attr('disabled',""); // in JQ attr
	// in JS opener.document.getElementById('submit').disabled='';
	opener.$('#submit').prop('disabled',false);//in JQ prop
	
	//3
	opener.$('#id').prop('readonly',true); // in JQ prop
	// in JS opener.document.getElementById('id').readonly='readonly';
	// in JQ attr => opener.$('#id').attr('readonly','readonly');
	
	//4
	self.close(); // window.close(), this.close();
	
	
	}; // idOK
</script>
<style>
	body{
		background-color: beige;
		font-family: 맑은고딕;
	}
	#container {
		margin-left:0;
		text-align: center;
	}
	h3{
		color : navy;
	}
</style>
</head>
<body>
<div id = 'container'>
	<h3> ID 중복확인</h3>
	<form action ="idDupCheck" method = "get">
		User_ID :
		<input type="text" id="id" name="id"> &nbsp;
		<input type="submit" value="중복확인" onclick = "return id">
		<!-- inCheck.js 의  idCheck() 의 결과에 따라 sumit 결정-->
		<br>
		<span id='iMessage' class='eMessage'></span>
	</form>
	<br><br><hr><br>
<!-- 	서버의 확인 결과에 따른 처리 영역 
	=> idUse : 'T' 가능 // 'F' 불가능
	-->
	<div id = "msgBlock">
		<c:if test ="${idUse=='T'}">
			${newId}는 사용가능한 아이디 입니다.<br>
			<input type = "button" value = "idOK" onclick = "idOK()">
<!-- 			사용자가 입력한 id를 사용가능하도록 해주고, 현재(this)창은 close -->
		</c:if>
		<c:if test="${idUse=='F' }">
			${newId}는 이미 사용중인 아이디입니다.<br>
			다시 입력해주세요.
<!-- 			부모창(Join Form = opener)에 남아있는 사용자가 입력한 아이디를 지워주고,
				현재 창(this) 에서는 id 에 포커스를 준다. ==> 재입력 유도.(script)  -->
		 	<script>
		 		$('#id').focus();
		 		opener.document.getElementById("id").value='';
		 	</script>
		</c:if>
	</div>
</div>
</body>
</html>