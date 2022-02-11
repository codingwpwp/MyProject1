$(document).ready(function(){
	$("#delyntable").find("tbody").hide();
});


var titleval = "";
function titlechange(obj){
	var check = /^[가-힇]{2,4}(커뮤)$/;
	if($(obj).val() == "변경하기"){
		titleval = "" + $(obj).prev().val();
		$(obj).val("변경완료");
		$(obj).prev().removeAttr("disabled");
	}else{
		var testcommutitle = check.test($(obj).prev().val());
		if(!testcommutitle){
			alert('~~~~커뮤로 입력하세요');
		}else if(titleval == $("input[name='commutitle']").val()){
			alert('원래이름과 동일합니다');
		}else{
			if(confirm('' + $(obj).prev().val() + '로 변경하시겠습니까?')){
				
				$.ajax({
					url : "commu_manager_commu_title_update.jsp",
					type : "post",
					data : "commutitle=" + $(obj).prev().val() + "&lidx=" + $("input[name='lidx']").val() + "&midx=" + $("input[name='midx']").val(),
					success : function(data){
						var result = data.trim();
						if(result == "존재한다"){
							alert('이미 존재하는 커뮤니티 입니다');
						}else{
							alert('변경되었습니다');
							location.href="/gaeinProject/manager/commu_manager.jsp?lidx=" + $("input[name='lidx']").val();
						}
						
						
					}
				});
			}
			
		}
		
	}
}


var introval = "";
function introchange(obj){
	if($(obj).val() == "변경하기"){
		introval = "" + $(obj).prev().val();
		$(obj).val("변경완료");
		$(obj).prev().removeAttr("disabled");
	}else{
		var intro = $(obj).prev().val();
		if(intro == ""){
			alert('내용을 입력하고 완료하세요');
		}else{
			if(introval == intro){
				alert('기존의 내용과 동일합니다');
			}else{
				if(confirm('내용을 변경하시겠습니까?')){
					$.ajax({
						url : "commu_manager_commu_intro_update.jsp",
						type : "post",
						data : "intro=" + $(obj).prev().val() + "&lidx=" + $("input[name='lidx']").val(),
						success : function(){
							alert('변경되었습니다');
							location.href="/gaeinProject/manager/commu_manager.jsp?lidx=" + $("input[name='lidx']").val();
						}
					});
				}
			}
		}
	}
}

function malheadchange(obj){
	if($(obj).val() == "변경"){
		$(obj).val("완료");
		$(obj).parent().prev().find("input[name='writesort']").removeAttr("disabled");
	}else{
		if(confirm('변경하시겠습니까?')){
			var malval = $(obj).parent().prev().find("input[name='writesort']").val();
			$.ajax({
				url : "commu_manager_commu_mal_update.jsp",
				type : "post",
				data : "writesort=" + malval + "&lidx=" + $("input[name='lidx']").val() + "&num=" + $(obj).parent().prev().find("input[name='num']").val()
					 + "&",
				success : function(data){
					var result = data.trim();
					if(result == "성공"){
						alert('변경되었습니다');
						location.href="/gaeinProject/manager/commu_manager.jsp?lidx=" + $("input[name='lidx']").val();
					}else{
						alert("이미 존재하거나 변경하지 않은 카테고리입니다");
					}
					
				}
			});
		}
	}
}




function showhide(obj){
	var src = $(obj).attr("src");
	if(src == "/gaeinProject/image/plus2.png"){
		$("#delyntable").find("tbody").show();
		$(obj).attr("src", "/gaeinProject/image/minus2.png");
		$("#delyisn").removeAttr("disabled");
	}else{
		$("#delyntable").find("tbody").hide();
		$(obj).attr("src", "/gaeinProject/image/plus2.png");
		$("#delyisn").attr("disabled", true);
	}
}



function changedelyn(){
	
}
























