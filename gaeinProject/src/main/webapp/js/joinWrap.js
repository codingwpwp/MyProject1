var idcheckSw = 0;
var checkedid = "";
var nicknamecheckSw = 0;
var checkednickname = "";

function idcheckFn(){
	var span = $("input:eq(0)").parent().children("span.checkspan");
	var idreg = /^[a-z0-9]{8,20}$/g;
	
	if($("input[name='id']").val() == ""){
		span.text(" *필수");
	} else if(!idreg.test($("input[name='id']").val())) {
		span.text(" *형식 오류");
	} else{
		$.ajax({
			url : "idcheck.jsp",
			type : "post",
			data : "id=" + $("input[name='id']").val(),
			success : function(data){
				var result = data.trim();
				if(result != "ok"){
					span.text(" *중복");
					idcheckSw = 0;
				}else{
					span.text(" *사용가능");
					idcheckSw = 1;
					checkedid = $("input[name='id']").val();
				}
			}
		});	
	}
}

function idcheckFn2(obj){
	var id = $(obj).val();
	if(id == "" || id != checkedid){
		idcheckSw = 0;
	}
}


function nicknamecheckFn(){
	var span = $("input:eq(4)").parent().children("span.checkspan");
	var nicknamereg = /^[0-9가-힣]{2,6}$/g;
	
	if($("input[name='nickname']").val() == ""){
		span.text(" *필수");
	} else if(!nicknamereg.test($("input[name='nickname']").val())) {
		span.text(" *형식 오류");
	} else{
		$.ajax({
			url : "nicknamecheck.jsp",
			type : "post",
			data : "nickname=" + $("input[name='nickname']").val(),
			success : function(data){
				var result = data.trim();
				if(result != "ok"){
					span.text(" *중복");
					nicknamecheckSw = 0;
				}else{
					span.text(" *사용가능");
					nicknamecheckSw = 1;
					checkednickname = $("input[name='nickname']").val();
				}
			}
		});	
	}
}

function nicknamecheckFn2(obj){
	var nickname = $(obj).val();
	if(nickname == "" || nickname != checkednickname){
		nicknamecheckSw = 0;
	}
}


function joincheck() {
	var flag = true;
	var input = document.getElementsByClassName('impor');
	var focusArray = [];

	for(var i = 0; i < input.length; i++){
		var span = $("input:eq(" + i + ")").parent().children("span.checkspan");
		var id = input[i].id;
		var check;

		if(id == "id"){
			check = /^[a-z0-9]{8,20}$/g;
		}else if(id == 'pw' || id == 'pwre'){
			check = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[~!@#$%^&*()+|=])[A-Za-z\d~!@#$%^&*()+|=]{8,20}$/;
		}else if(id == 'name'){
			check = /^[가-힣]{2,5}/g;
		}else if(id == 'nickname'){
			check = /^[0-9가-힣]{2,6}$/g;
		}

		var value = input[i].value;
		if(value == ""){
			span.text(" *필수");
			flag = false;
			focusArray[i] = input[i];
		}else if(!check.test(value)){
			span.text(" *형식오류");
			flag = false;
			focusArray[i] = input[i];
		}else if(id == "pwre"){
			if(value != document.getElementById('pw').value){
				span.text(" *비밀번호 불일치");
				flag = false;
				focusArray[i] = input[i];
			}else{
				span.text("");
			}
		}else{
			span.text("");
		}
	}

	for(i = 0; i < focusArray.length; i++){
		if(focusArray[i] != null){
			focusArray[i].focus();
			break;
		}
	}

	if(focusArray.length == 0){
		if(idcheckSw == 0){
			alert("아이디 중복확인하세요.");
			flag = false;
		}else if(nicknamecheckSw == 0){
			alert("닉네임 중복확인하세요.");
			flag = false;
		}
	}

	return flag;
}