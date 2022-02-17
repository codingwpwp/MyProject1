$(document).ready(function(){
	$("#gulgul").find("tbody").hide();
});


function showgul(obj){
	if($(obj).attr("src") == "/gaeinProject/image/plus2.png"){
		$("#gulgul").find("tbody").show();
		$(obj).attr("src", "/gaeinProject/image/minus2.png");
	}else{
		$("#gulgul").find("tbody").hide();
		$(obj).attr("src", "/gaeinProject/image/plus2.png");
	}
}


function changeInfo(){
	var changeSw = 1;
	
	var pwcheck = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[~!@#$%^&*()+|=])[A-Za-z\d~!@#$%^&*()+|=]{8,20}$/;
	var nickcheck = /^[0-9가-힣]{2,6}$/g;
	var emailcheck = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	var testpw = pwcheck.test($("input[name='pw']").val());
	var testnick = nickcheck.test($("input[name='nickname']").val());
	var testemail = emailcheck.test($("input[name='email']").val());
	
	if(!testpw){
		alert("비밀번호양식이 올바르지 않습니다");
		changeSw = 0;
	}else if(!testnick){
		alert("닉네임양식이 올바르지 않습니다");
		changeSw = 0;
	}else if($("input[name='email']").val() != ""){
		if(!testemail){
			alert("이메일양식이 올바르지 않습니다");
			changeSw = 0;
		}
	}
	
	if(changeSw == 1){
		$.ajax({
			url : "mypage_nicknamecheck.jsp",
			type : "post",
			data : "nickname=" + $("input[name='nickname']").val(),
			success : function(data){
				var result = data.trim();
				if(result != "ok"){
					alert('현재 사용중인 닉네임입니다');
				}else{
					$.ajax({
						url : "mypage_modify.jsp",
						type : "post",
						data : "pw=" + $("input[name='pw']").val() + "&nickname=" + $("input[name='nickname']").val()
							 + "&email=" + $("input[name='email']").val() + "&gender=" + $("input[name='gender']:checked").val(),
						success : function(){
							alert('변경되었습니다');
							location.href="/gaeinProject/manager/mypage.jsp";
						}
					});
				}
			}
		});
	}
}


function deleteInfo(){
	var flag = confirm("삭제하시겠습니까?\n(삭제시 등록한 광고는 내려집니다)");
	if(flag){
		if($("div[id='memberPosition']").text().includes("커뮤장")){
			alert('커뮤장은 탈퇴할 수 없습니다');
		}else{
			$.ajax({
				url : "mypage_delete.jsp",
				type : "post",
				success : function(){
					alert('삭제되었습니다');
					location.href="/gaeinProject/index.jsp";
				}
			});
		}
	}
}