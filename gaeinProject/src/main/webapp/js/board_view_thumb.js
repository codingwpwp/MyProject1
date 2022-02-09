function thumb(obj){
	var lidx = $("form[name='replyWrite']").find("input[name='lidx']").val();
	var bidx = $("form[name='replyWrite']").find("input[name='bidx']").val();
	var midx = $("form[name='replyWrite']").find("input[name='midx']").val();
	var thumbNum = parseInt($(obj).parent().find("span").text());
	$.ajax({
		url : "thumb_manager.jsp",
		type : "post",
		data : "lidx=" + lidx + "&bidx=" + bidx + "&midx=" + midx,
		success : function(data){
			
			var result = data.trim();
			if(result == "ok"){
				$(obj).attr("src", "/gaeinProject/image/thumbOk.jpg");
				$(obj).parent().find("span").html(thumbNum + 1);
			}else{
				alert("이미 추천 했습니다");
			}
		}
	});
	
}