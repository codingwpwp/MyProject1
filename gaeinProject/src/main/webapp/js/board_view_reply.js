function insertReply(){
	if($("textarea[name='rcontent']").val() != ""){
		$.ajax({
			url : "board_reply_manager.jsp",
			type : "post",
			data : $('form[name=replyWrite]').serialize(),
			success : function(data){
				
				var json = JSON.parse(data.trim());
				var ridx = json[0].ridx;
				var midx = json[0].midx;
				var rcontent = json[0].rcontent;
				var rdate = json[0].rdate;
				var nickname = json[0].nickname;
				var position = json[0].position;
				
				var html = "";
				var div = document.createElement('div');
				$(div).addClass("reply");
				html = "<input type='hidden' value='" + ridx + "'> ";
				html += "<input type='hidden' value='" + midx + "'> ";
				
				html += "<div class='replyEdit'> ";
					html += "<img src='/gaeinProject/image/pencil.png' onclick='modifyReply(this)'> ";
					html += "<img src='/gaeinProject/image/x.png' onclick='deleteReply(this)'> ";
				html += "</div> ";
				
				html += "<div class='replyContent'> ";
				
					html += "<div>";
					if(position == "운영자"){
						html += "<img src='/gaeinProject/image/smilefrog.jpg'>";
					}
					
					html += "<span"
					if(position == "운영자"){
						html += " style='position: relative; bottom: 7px; color:red; font-weight: bold;'";
					}else if(position != "일반"){
						html += " style='color: blue;'";
					}
					html += ">" + nickname + "</span> ";
					
					html += "</div> ";
					html += "<div>" + rcontent + "</div> ";
					
				html += "</div> ";
				
				html += "<div class='replyDate'> " + rdate + "</div> ";
				div.innerHTML = html;
				$("#replylist").append(div);
				
				$("#replycnt").html(Number($("#replycnt").html()) + 1);
				$("textarea[name='rcontent']").val("");
			}
		});
	}else{
		alert("댓글을 입력하고 등록하세요");
	}
	
}

var rcontent = "";
var contentdiv;
function modifyReply(obj){
	var src = $(obj).attr("src");
	if(src == "/gaeinProject/image/pencil.png"){
		
		$(".replyEdit").each(function(){
			if($(this).find("img:eq(0)").attr("src") == "/gaeinProject/image/check.png"){
				$(this).find("img:eq(0)").attr("src", "/gaeinProject/image/pencil.png");
				$(this).next().find("textarea").remove();
				$(this).next().find("div:eq(1)").text(rcontent);
				return false;
			}
		});
		$(obj).attr("src", "/gaeinProject/image/check.png");
		contentdiv = $(obj).parent().next().find("div:eq(1)");
		rcontent = contentdiv.html();
		var textarea = document.createElement('textarea');
		$(textarea).attr("placeholder", "내용을 비우지 마세요");
		contentdiv.html("");
		textarea.innerHTML = rcontent;
		contentdiv.append(textarea);
	}else{
		if(contentdiv.find("textarea").val() == ""){
			alert("내용을 비우고 체크하지 마세요");
		}else if(rcontent != contentdiv.find("textarea").val()){
			rcontent = contentdiv.find("textarea").val();
			$.ajax({
				url : "board_reply_manager.jsp",
				type : "post",
				data : "ridx=" + $(obj).parent().prev().prev().val() + "&rcontent=" + rcontent,
				success : function(data){
					$(obj).parent().next().find("textarea").remove();
					$(obj).parent().next().find("div:eq(1)").text(rcontent);
					$(obj).attr("src", "/gaeinProject/image/pencil.png");
					var replyDate = $(obj).parent().next().next().text();
					if(replyDate.trim().length < 22){
						$(obj).parent().next().next().text(replyDate.trim() + " (수정됨)");
					};
				}
			});
		}else{
			alert("내용을 수정하고 체크 하세요");
		}
	}
}



function deleteReply(obj){
	
	if($(obj).prev().prop('tagName') != undefined && $(obj).prev().prop('tagName') == "IMG"){
		if($(obj).prev().attr("src") == "/gaeinProject/image/check.png"){
			$(obj).prev().attr("src", "/gaeinProject/image/pencil.png");
			$(obj).parent().next().find("textarea").remove();
			$(obj).parent().next().find("div:eq(1)").text(rcontent);
		}else{
			var ridx = $(obj).parent().prev().prev().val();
			$.ajax({
			url : "board_reply_manager.jsp",
			type : "post",
			data : "ridx=" + ridx,
			success : function(){
				$(obj).parent().parent().remove();
				$("#replycnt").html(Number($("#replycnt").html()) - 1);
				}
			});
		}
	}else{
		var ridx = $(obj).parent().prev().prev().val();
		$.ajax({
			url : "board_reply_manager.jsp",
			type : "post",
			data : "ridx=" + ridx,
			success : function(){
				$(obj).parent().parent().remove();
				$("#replycnt").html(Number($("#replycnt").html()) - 1);
			}
		});
	}
	
}