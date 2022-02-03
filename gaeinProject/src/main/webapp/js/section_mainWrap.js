$(document).ready(function(){

	var main_section_mainWrap_aTags = $("#tables").find("a");
	main_section_mainWrap_aTags.mouseover(function () {
		$(this).parent().parent().css("backgroundColor","#e9e9e9");
	});
	main_section_mainWrap_aTags.mouseout(function () {
		$(this).parent().parent().css("backgroundColor","inherit");
	});

	var board_section_mainWrap_aTags = $("#board").find("a");
	board_section_mainWrap_aTags.mouseover(function () {
		$(this).parent().parent().css("backgroundColor","#e9e9e9");
	});
	board_section_mainWrap_aTags.mouseout(function () {
		$(this).parent().parent().css("backgroundColor","inherit");
	});
	
	// 각 게시판의 카테고리, 말머리가 공지인 경우
	var category = $(".board").find("td.col2");
	category.each(function (){
		if($(this).html() == "공지"){
			$(this).css("color","green").css("font-weight","bold");
		}
	});
	
});
