<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
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
<body>
	<h1>Upload with Ajax</h1>

	<div class='uploadDiv'>
		<input type='file' name='uploadFile' multiple>
	</div>

	<div class="uploadResult">
		<ul>
			<!-- 서버로부터 받은 섬네일들을 출력할 위치 -->
		</ul>
	</div>

	<button id='uploadBtn'>Upload</button>


	<div class="bigPictureWrapper">
		<div class="bigPicture"></div>
	</div>

	<script src="https://code.jquery.com/jquery-3.3.1.js" integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60=" crossorigin="anonymous"></script>

	<script>
		// 파일 확장자 체크 정규식
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; // 5MB

		function checkExtension(fileName, fileSize) {
			if (fileSize >= maxSize) {
				alert("파일 사이즈 초과.");
				return false;
			}

			// RegExp 클래스의 test 메서드
			// 특정 문자열이 정규식과 일치한다면 true를 반환
			if (regex.test(fileName)) {
				alert("허용하지 않는 파일은 업로드할 수 없습니다.");
				return false;
			}
			
			return true;
		}

		// 업로드 창을 새로고침하지 않고 다시 업로드할 수 있는 상태로 만들기 위해
		// 아무 내용도 들어있지 않은 업로드 창을 복사해서 가져옴
		var cloneObj = $(".uploadDiv").clone();

		$("#uploadBtn").on("click", function(e) {

			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;

			console.log(files);

			for (var i = 0; i < files.length; i++) {
				if (!checkExtension(files[i].name, files[i].size)) {
					return false;
				}

				formData.append("uploadFile", files[i]);
			}

			$.ajax({
				url : '/uploadAjaxAction',
	            processData: false, // true : jQuery가 데이터를 자동으로 쿼리 스트링으로 만들어버린다.
	            contentType: false, // true : 데이터가 key=value 형태일 때 사용한다.
				data : formData,
				type : 'POST',
				dataType : 'json',
				success : function(result) {
					console.log(result);

					showUploadedFile(result);

					// 비어있는 업로드 창으로 갈아치움
					$(".uploadDiv").html(cloneObj.html());
				}
			});
		});

		// uploadResult 클래스의 ul 요소를 가져옴
		var uploadResult = $(".uploadResult ul");

		function showUploadedFile(uploadResultArr) {
			var str = "";

			// 전달받은 uploadResultArr 배열을 순회
			$(uploadResultArr).each(function(i, obj) {

				// 이미지 파일이 아닌 경우 처리
				if (!obj.image) {
					// 파일 경로 생성
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");

					// 다운로드 링크와 삭제 버튼 추가
					str += "<li><div><a href='/download?fileName=" + fileCallPath + "'>" + "<img src='/resources/img/attach.png'>" + obj.fileName + "</a>" + "<span data-file=\'" + fileCallPath + "\' data-type='file'> x </span>" + "</div></li>";
				} else {
					// 이미지 파일인 경우 처리
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);

					// 원본 이미지 경로 생성
					var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
					originPath = originPath.replace(new RegExp(/\\/g), "/");

					// 이미지 링크와 삭제 버튼 추가
					str += "<li><a href=\"javascript:showImage(\'" + originPath + "\')\">" + "<img src='/display?fileName=" + fileCallPath + "'></a>" + "<span data-file=\'" + fileCallPath + "\' data-type='image'> x </span>" + "</li>";
				}
			});

			// <ul> 태그 안에 생성한 <li> 태그를 추가
			uploadResult.append(str);
		}

		function showImage(fileCallPath) {
			// 파일 경로를 확인하는 디버깅용 alert
			// alert(fileCallPath);

			// .bigPictureWrapper 요소를 flex로 표시하고 보이도록 설정
			$(".bigPictureWrapper").css("display", "flex").show();

			// .bigPicture 요소에 img 태그를 동적으로 추가하고, 파일 경로를 지정
			$(".bigPicture").html("<img src='/display?fileName=" + encodeURI(fileCallPath) + "'>").animate({
				width : '100%',
				height : '100%'
			}, 1000); // 애니메이션 효과: 크기를 점진적으로 키움
		}

		$(".bigPictureWrapper").on("click", function(e) {
			// .bigPicture 요소를 애니메이션으로 점진적으로 축소
			$(".bigPicture").animate({
				width : '0%',
				height : '0%'
			}, 1000);

			// 애니메이션 종료 후 .bigPictureWrapper 요소를 숨김
			setTimeout(function() {
				$('.bigPictureWrapper').hide();
			}, 1000); // 1초 후에 실행
		});

		$(".uploadResult").on("click", "span", function(e) {
			// 클릭한 span 요소의 data-file 속성 값 가져오기
			var targetFile = $(this).data("file");

			// 클릭한 span 요소의 data-type 속성 값 가져오기
			var type = $(this).data("type");

			console.log(targetFile); // 삭제할 파일의 경로 로그 출력

			// AJAX 요청으로 서버에 파일 삭제 요청
			$.ajax({
				url : '/deleteFile', // 파일 삭제를 처리할 서버 엔드포인트
				data : {
					fileName : targetFile,
					type : type
				}, // 요청 데이터: 파일 이름과 타입
				dataType : 'text', // 서버 응답 데이터 형식
				type : 'POST', // 요청 방식: POST
				success : function(result) { // 서버 응답 처리
					alert(result); // 서버로부터 받은 응답 메시지 출력
				}
			}); // $.ajax
		});
	</script>



</body>
</html>
