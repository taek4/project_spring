<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<div class="bigPictureWrapper">
	<div class="bigPicture"></div>
</div>
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
	align-content: center;
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
<script type="text/javascript">

	$(document).ready(function() {

		var formObj = $("form");

		$("button").on("click", function(e) {
		    e.preventDefault();

		    var operation = $(this).data("oper");
		    console.log(operation);

		    if (operation === "remove") {
		        formObj.attr("action", "/board/remove");
		    } else if (operation === "list") {
		    	// form의 action을 /board/list로 설정
				// form의 method를 get으로 설정
				formObj.attr("action", "/board/list").attr("method", "get");
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				var typeTag = $("input[name='type']").clone();

				// form 내부의 내용을 비워버림
				formObj.empty();

				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
		    } else if (operation === "modify") {
		        console.log("submit clicked.");

		        var str = "";

		        $(".uploadResult ul li").each(function(i, obj) {
		            var jobj = $(obj);
		            console.dir(jobj);

		            str += "<input type='hidden' name='attachList[" + i + "].fileName' value='" + jobj.data("filename") + "'>";
		            str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + jobj.data("uuid") + "'>";
		            str += "<input type='hidden' name='attachList[" + i + "].uploadPath' value='" + jobj.data("path") + "'>";
		            str += "<input type='hidden' name='attachList[" + i + "].fileType' value='" + jobj.data("type") + "'>";
		        });

		        formObj.append(str).submit();
		    }

		    formObj.submit();
		});


		// 게시물 수정 모달창에서 첨부파일의 x 버튼 클릭 시 화면상에서만 사라지도록 수정
		$(".uploadResult").on("click", "button", function(e) {
			console.log("delete file");

			if (confirm("Remove this file?")) {
				var targetLi = $(this).closest("li");
				targetLi.remove();
			}
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
				url : '/uploadAjaxAction',
				processData : false, // true : jQuery가 데이터를 자동으로 쿼리 스트링으로 만들어버린다.
				contentType : false, // true : 데이터가 key=value 형태일 때 사용한다.
				data : formData, // 사용자가 업로드한 파일들이 들어있다.
				type : 'POST',
				dataType : 'json', // 서버로부터의 응답 데이터를 JSON으로 요구한다.
				success : function(result) {
					console.log(result);
					showUploadResult(result); // 서버에 파일을 업로드하고 파일과 관련된 정보를 받아 showUploadResult에게 넘긴다.
				}
			}); // $.ajax
		});
	});

	$(document).ready(function() {
		(function() {
			var bno = '<c:out value="${board.bno}" />';

			$.getJSON("/board/getAttachList", {
				bno : bno
			}, function(arr) {
				console.log(arr);

				var str = "";

				$(arr).each(function(i, attach) {
					// image type
					if (attach.fileType) {
						var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);

						str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType + "'>";
						str += "<div>";
						str += "<span>" + attach.fileName + "</span>";
						str += "<button type='button' data-file='" + fileCallPath + "' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/display?fileName=" + fileCallPath + "'>";
						str += "</div>";
						str += "</li>";
					} else {
						str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType + "'>";
						str += "<div>";
						str += "<span>" + attach.fileName + "</span><br>";
						str += "<button type='button' data-file='" + attach.uploadPath + "' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/resources/img/attach.png'>";
						str += "</div>";
						str += "</li>";
					}
				});

				$(".uploadResult ul").html(str);
			});
		})();
	});

	// 파일을 업로드했을 때 그 파일의 정보를 출력하는 함수.
	// 이미지 파일은 섬네일을, 일반 파일은 임의의 이미지를 출력하도록 한다.
	function showUploadResult(uploadResultArr) {

		// 서버로부터 첨부 파일 리스트를 받지 못하거나
		// 게시물에 첨부 파일이 없다면 아무런 액션도 취하지 않는다.
		if (!uploadResultArr || uploadResultArr.length == 0) {
			return;
		}

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

<form role="form" action="/board/modify" method="post">
	<input type="hidden" name='pageNum' value='<c:out value="${cri.pageNum}"/>'> <input type="hidden" name='amount' value='<c:out value="${cri.amount}"/>'> <input type="hidden" name='type' value='<c:out value="${cri.type}"/>'> <input type="hidden" name='keyword' value='<c:out value="${cri.keyword}"/>'>

	<div class="form-group">
		<label>Bno</label> <input class="form-control" name="bno" value='<c:out value="${board.bno }"/>' readonly="readonly">
	</div>

	<div class="form-group">
		<label>Title</label> <input class="form-control" name="title" value='<c:out value="${board.title }"/>' readonly="readonly">
	</div>

	<div class="form-group">
		<label>Text area</label>
		<textarea class="form-control" rows="3" name="content"><c:out value="${board.content}" /></textarea>
	</div>

	<div class="form-group">
		<label>Writer</label> <input class="form-control" name="writer" value='<c:out value="${board.writer }"/>' readonly="readonly">
	</div>

	<div class="form-group">
		<label>RegDate</label> <input class="form-control" name="regDate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regDate}"/>' readonly="readonly">
	</div>

	<div class="form-group">
		<label>Update Date</label> <input class="form-control" name="updateDate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate}"/>' readonly="readonly">
	</div>

	<button type="submit" data-oper="modify" class="btn btn-default">Modify</button>
	<button type="submit" data-oper="remove" class="btn btn-danger">Remove</button>
	<button type="submit" data-oper="list" class="btn btn-info">List</button>

</form>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Files</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<div class="form-group uploadDiv">
					<input type="file" name="uploadFile" multiple="multiple">
				</div>
				<div class="uploadResult">
					<ul>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<%@include file="../includes/footer.jsp"%>