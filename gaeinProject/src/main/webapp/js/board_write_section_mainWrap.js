$(document).ready(function(){
	$('#summernote').summernote({
		toolbar: [
			['fontname', ['fontname']],
			['fontsize', ['fontsize']],
			['style', ['bold', 'italic', 'underline','strikethrough']],
			['color', ['color']],
			['table', ['table']],
			['insert',['picture']]
		],
		fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', 'sans-serif', '맑은 고딕', '궁서', '굴림체', '굴림', '돋움체', '바탕체'],
		fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50'],
		minHeight: 300,
		maxHeight: 800,
		lang: 'ko-KR'
	});
	$('#summernote').summernote('reset');
	$('#commuform').hide();
});

var commumalheadSwitch = 2;
var commuSwitch = 0;
var html = "";

function changeGul(obj) {
	if($(obj).val() == 'commuapply'){
		$('#summernote').summernote('reset');
		$('#summernote').summernote('destroy');
		$('#commuform').show();
		$('#summernote').hide();
		commuSwitch = 1;
	} else if(commuSwitch == 1){
		$('#summernote').summernote({
			toolbar: [
				['fontname', ['fontname']],
				['fontsize', ['fontsize']],
				['style', ['bold', 'italic', 'underline','strikethrough']],
				['color', ['color']],
				['table', ['table']],
				['insert',['picture']]
			],
			fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', 'sans-serif', '맑은 고딕', '궁서', '굴림체', '굴림', '돋움체', '바탕체'],
			fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50'],
			minHeight: 300,
			maxHeight: 800,
			lang: 'ko-KR'
		});
		$('#summernote').summernote('reset');
		$('#commuform').find("textarea").val("");
		$('#commuform').find("input").not("input[name='commuNotice']").val("");
		for(var i = 3; i <= commumalheadSwitch; i++){
			$("input[name='commumalhead" + i + "']").next().remove();
			$("input[name='commumalhead" + i + "']").remove();
		}
		$('#commuform').hide();
		commumalheadSwitch = 2;
		$("input[name='commumalheadCnt']").val(commumalheadSwitch);
		commuSwitch = 0;
	}
}

function commumalPlus() {
	if(commumalheadSwitch >= 2 && commumalheadSwitch <= 4){
		++commumalheadSwitch;
		html = "<input type='text' name='commumalhead" + commumalheadSwitch + "' placeholder='4자이내' maxlength='4'><br>";
		$("#commumalhead").append(html);
		$("input[name='commumalheadCnt']").val(commumalheadSwitch);
	}else if(commumalheadSwitch >= 5){
		alert('추가할 수 있는 말머리의 갯수는 최대 3개입니다.');
	}
}

function commumalMinus() {
	if(commumalheadSwitch > 2 && commumalheadSwitch <= 5){
		$("input[name='commumalhead" + commumalheadSwitch + "']").next().remove();
		$("input[name='commumalhead" + commumalheadSwitch + "']").remove();
		--commumalheadSwitch;
		$("input[name='commumalheadCnt']").val(commumalheadSwitch);
	}else if(commumalheadSwitch == 2){
		alert('최소 2개이상의 말머리는 있어야 합니다.');
	}
}

function gulWrite() {
	var flag = true;
	var reg = /^(\s+)$/;
	var subject = document.getElementById('gulSubject');
	var cTitle = document.getElementById('cTitle');

	if(reg.test(subject.value) || subject.value == ""){
		alert('제목을 비우지 마세요');
		flag = false;
	}else{

		if($("input[name='malhead']:checked").val() != 'commuapply'){	// 커뮤신청이 아닌경우
			var gulData = $('#summernote').summernote('code');
			if(gulData == "<p><br></p>"){	// 글이 비어있을 때
				alert('내용을 작성하고 완료하세요');
				flag = false;
			}else{	// 글이 안 비어있을 때
				flag = true;
			}
		}else if($("input[name='malhead']:checked").val() == 'commuapply'){	// 커뮤신청인 경우
			var reg2 = /^[가-힇]{2,4}(커뮤)$/;

			for(var i = 2; i <= commumalheadSwitch; i++){
				var commuheadval = $("input[name='commumalhead" + commumalheadSwitch + "']").val();
				if(reg.test(cTitle.value) || !reg2.test(cTitle.value)){
					alert('커뮤이름을 정확히 입력하세요');
					flag = false;
					break;
				}else if($("textarea[name='commuIntroduce']").val() == ""){
					alert('소개글을 정확히 입력하세요');
					flag = false;
					break;
				}else if(reg.test(commuheadval) || commuheadval == ""){
					alert('말머리를 정확히 입력하세요');
					flag = false;
					break;
				}
			}
			
		}

	}
	return flag;
}