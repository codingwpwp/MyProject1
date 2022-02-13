$(document).ready(function(){

	var main_section_mainWrap_aTags = $("#tables").find("a");
	main_section_mainWrap_aTags.mouseover(function () {
		$(this).parent().parent().css("backgroundColor","#f9ffec");
	});
	main_section_mainWrap_aTags.mouseout(function () {
		$(this).parent().parent().css("backgroundColor","inherit");
	});

	var board_section_mainWrap_aTags = $(".boardlist").find("a");
	board_section_mainWrap_aTags.mouseover(function () {
		$(this).parent().parent().css("backgroundColor","#e9e9e9");
	});
	board_section_mainWrap_aTags.mouseout(function () {
		$(this).parent().parent().css("backgroundColor","inherit");
	});
	
});
