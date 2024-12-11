<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>
<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
	text-align: center;
}

.uploadResult ul li img {
	width: 100px;
}

.uploadResult ul li span {
	color: white;
}

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255, 255, 255, 0.5);
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 600px;
}
</style>
<script>
$(document).ready(function(e) {
	// 폼 객체를 선택
	var formObj = $("form[role='form']");

	var cloneObj = $(".uploadDiv").clone();
	
	// 제출 버튼 클릭 이벤트 처리
	$("button[type='submit']").on("click", function(e) {
	    // 기본 동작(폼 제출)을 막음
	    e.preventDefault();

	    console.log("submit clicked");

	    // 숨겨진 입력 필드들을 담을 문자열 변수
	    var str = "";

	    // 업로드된 결과 리스트의 각 항목(li)을 순회
	    $(".uploadResult ul li").each(function(i, obj) {
	        // 현재 순회 중인 li 요소를 jQuery 객체로 변환
	        var jobj = $(obj);

	        // li 요소의 데이터 확인 (디버깅 용도)
	        console.dir(jobj);

	        // 파일 이름을 위한 hidden 필드 생성
	        str += "<input type='hidden' name='attachList[" + i + "].fileName' value='" + jobj.data("filename") + "'>";
	        // UUID를 위한 hidden 필드 생성
	        str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + jobj.data("uuid") + "'>";
	        // 파일 경로를 위한 hidden 필드 생성
	        str += "<input type='hidden' name='attachList[" + i + "].uploadPath' value='" + jobj.data("path") + "'>";
	        // 파일 타입을 위한 hidden 필드 생성
	        str += "<input type='hidden' name='attachList[" + i + "].fileType' value='" + jobj.data("type") + "'>";
	        
	        console.log(str);
	    });

	    // 폼 객체에 생성된 hidden 필드를 추가하고 폼 제출
	    formObj.append(str).submit();
	});

	// 파일 확장자 체크 정규식
    var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
    var maxSize = 5242880; // 5MB

   	// 파일 업로드 전에 파일의 사이즈와 확장자 검사
    function checkExtension(fileName, fileSize) {
    	// 파일 사이즈가 5MB 이상이라면 업로드 불가
    	if (fileSize >= maxSize) {
            alert("파일 사이즈 초과");
            return false;
        }
		
		// RegExp 클래스의 test 메서드
		// 특정 문자열이 정규식과 일치한다면 true를 반환
        if (regex.test(fileName)) {
            alert("해당 종류의 파일은 업로드할 수 없습니다.");
            return false;
        }

        return true;
    }

    // input 태그의 변화를 감지하는 이벤트 리스너.
    // input에 파일이 업로드되면 /uploadAjaxAction 경로에 POST 요청을 넣음
    $("input[type='file']").change(function(e) {
    	
    	// 가상 폼 생성
        var formData = new FormData();
    	
     	// name 속성이 'uploadFile'인 input 태그를 선택하여 변수 inputFile에 저장
        var inputFile = $("input[name='uploadFile']");
     	
    	// 선택한 input 태그(inputFile)에서 업로드된 파일 목록을 가져와 변수 files에 저장
     	// inputFile에 업로드된 파일들을 .files로 접근하여 배열과 유사한 FileList 객체를 가져온다.
        var files = inputFile[0].files;

    	// files를 반복문으로 순회하며 
        for (var i = 0; i < files.length; i++) {
        	// 현재 가리키는 파일의 확장자명과 사이즈를 검사한다.
            if (!checkExtension(files[i].name, files[i].size)) {
                return false;
            }
        	// 검사를 마치면 form에 파일을 추가한다.
            formData.append("uploadFile", files[i]);
        }

        $.ajax({
        	// /uploadAjaxAction 경로에 POST 요청을 넣는다.
            url: '/uploadAjaxAction',
            processData: false, // true : jQuery가 데이터를 자동으로 쿼리 스트링으로 만들어버린다.
            contentType: false, // true : 데이터가 key=value 형태일 때 사용한다.
            data: formData,		// 사용자가 업로드한 파일들이 들어있다.
            type: 'POST',
            dataType: 'json',	// 서버로부터의 응답 데이터를 JSON으로 요구한다.
            success: function(result) {
                console.log(result);
                showUploadResult(result); // 서버에 파일을 업로드하고 파일과 관련된 정보를 받아 showUploadResult에게 넘긴다.
            }
        }); // $.ajax
    });

    // x 아이콘을 눌렀을 때의 처리
    $(".uploadResult").on("click", "button", function(e) {
        console.log("delete file");

        // 클릭한 버튼의 data-file 속성 값 가져오기 (삭제할 파일 경로)
        var targetFile = $(this).data("file");

        // 클릭한 버튼의 data-type 속성 값 가져오기 (파일 타입)
        var type = $(this).data("type");

        // 클릭한 버튼의 가장 가까운 li 요소 선택
        var targetLi = $(this).closest("li");

        // AJAX 요청으로 파일 삭제 요청
        $.ajax({
            url: '/deleteFile', // 파일 삭제를 처리할 서버 엔드포인트
            data: { fileName: targetFile, type: type }, // 요청 데이터: 파일 경로와 타입
            dataType: 'text', // 서버 응답 데이터 형식
            type: 'POST', // 요청 방식: POST
            success: function(result) { // 서버 응답 성공 시 처리
                alert(result); // 서버로부터 받은 응답 메시지 출력
                targetLi.remove(); // 삭제된 파일의 li 요소 제거
            }
        }); // $.ajax
    });

});

// 파일을 업로드했을 때 그 파일의 정보를 출력하는 함수.
// 이미지 파일은 섬네일을, 일반 파일은 임의의 이미지를 출력하도록 한다.
function showUploadResult(uploadResultArr) {
	
	// 서버로부터 첨부 파일 리스트를 받지 못하거나
	// 게시물에 첨부 파일이 없다면 아무런 액션도 취하지 않는다.
	if(!uploadResultArr || uploadResultArr.length == 0) {return;}
	
	// uploadResult 클래스의 ul 요소를 가져옴
	var uploadResult = $(".uploadResult ul");
	
    var str = "";

    // 전달받은 uploadResultArr 배열을 순회
    $(uploadResultArr).each(function(i, obj) {

    	// 이미지 타입 여부 확인
    	if (obj.image) {
    	    // 이미지 파일 경로 생성
    	    var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);

    	    // 이미지 파일에 대한 HTML 구조 생성
    	    str += "<li data-path='" + obj.uploadPath + "'"; // 파일 경로
    	    str += " data-uuid='" + obj.uuid + "'"; // UUID
    	    str += " data-filename='" + obj.fileName + "'"; // 파일 이름
    	    str += " data-type='" + obj.image + "'>"; // 파일 타입
    	    str += "<div>"; // 파일 정보 표시용 div 시작
    	    str += "<span>" + obj.fileName + "</span>"; // 파일 이름 표시
    	    str += "<button type='button' data-file=\"" + fileCallPath + "\" "; // 파일 삭제 버튼
    	    str += "data-type='image' class='btn btn-warning btn-circle'>";
    	    str += "<i class='fa fa-times'></i></button><br>"; // 삭제 버튼의 아이콘. header.jsp에서 Font Awesome CSS를 import하여 사용 중 
    	    str += "<img src='/display?fileName=" + fileCallPath + "'>"; // 이미지 섬네일 표시
    	    str += "</div></li>"; // 닫기 태그
    	} else {
    	    // 이미지가 아닌 파일 경로 생성
    	    var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
    	    var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");

    	    // 일반 파일에 대한 HTML 구조 생성
    	    str += "<li data-path='" + obj.uploadPath + "'"; // 파일 경로
    	    str += " data-uuid='" + obj.uuid + "'"; // UUID
    	    str += " data-filename='" + obj.fileName + "'"; // 파일 이름
    	    str += " data-type='" + obj.image + "'>"; // 파일 타입
    	    str += "<div>"; // 파일 정보 표시용 div 시작
    	    str += "<span>" + obj.fileName + "</span>"; // 파일 이름 표시
    	    str += "<button type='button' data-file=\"" + fileCallPath + "\" data-type='file' "; // 파일 삭제 버튼
    	    str += "class='btn btn-warning btn-circle'>";
    	    str += "<i class='fa fa-times'></i></button><br>"; // 삭제 버튼의 아이콘. header.jsp에서 Font Awesome CSS를 import하여 사용 중
    	    str += "<img src='/resources/img/attach.png'></a>"; // 일반 파일의 아이콘 표시
    	    str += "</div></li>"; // 닫기 태그
    	}

    });

    // <ul> 태그 안에 생성한 <li> 태그를 추가
    uploadResult.append(str);
}
</script>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Register</h1>
	</div>
</div>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Register</div>
			<div class="panel-body">
				<form role="form" action="/board/register" method="post">
					<div class="form-group">
						<label>Title</label> <input class="form-control" name='title'>
					</div>

					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" rows="3" name='content'></textarea>
					</div>

					<div class="form-group">
						<label>Writer</label> <input class="form-control" name='writer'>
					</div>
					<button type="submit" class="btn btn-default">Submit
						Button</button>
					<button type="reset" class="btn btn-default">Reset Button</button>
				</form>
				<!-- end panel-body -->
			</div>
			<!-- end panel-body -->
		</div>
		<!-- end panel -->
	</div>
	<!-- /.row -->

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">File Attach</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<div class="form-group uploadDiv">
						<input type="file" name="uploadFile" multiple>
					</div>
					<div class="uploadResult">
						<ul>
						</ul>
					</div>
				</div>
				<!-- end panel-body -->
			</div>
			<!-- end panel -->
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->

</div>
<%@include file="../includes/footer.jsp"%>