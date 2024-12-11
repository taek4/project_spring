<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>


<script type="text/javascript" src="/resources/js/reply.js"></script>

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

		var operForm = $("#operForm");

		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/board/modify").submit();
		});

		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#bno").remove();
			operForm.attr("action", "/board/list");
			operForm.submit();
		});

	});

	$(document).ready(function() {
		// 현재 출력중인 게시물의 bno 값을 가져온다.
		var bnoValue = "<c:out value='${board.bno}'/>";

		var replyUL = $(".chat");

		showList(1);

		function showList(page) {
			console.log("show list " + page);

			replyService.getList({
				bno : bnoValue,
				page : page || 1
			}, function(replyCnt, list) {
				console.log("replyCnt: " + replyCnt);
				console.log("list: " + list);
				console.log(list);

				if (page == -1) {
					pageNum = Math.ceil(replyCnt / 10.0);
					showList(pageNum);
					return;
				}

				var str = "";

				if (list == null || list.length == 0) {
					return;
				}

				for (var i = 0, len = list.length || 0; i < len; i++) {
					str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
					str += "<div class='header'><strong class='primary-font'>[" + list[i].rno + "] " + list[i].replyer + "</strong>";
					str += "<small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small></div>";
					str += "<p>" + list[i].reply + "</p></div></li>";
				}

				replyUL.html(str);

				showReplyPage(replyCnt);
			}); // end function
		}

		// 모달 창 속성 가져오기
		var modal = $(".modal");
		// 모달 창에서 이름이 reply인 input 요소를 가져오기
		var modalInputReply = modal.find("input[name='reply']");
		// 모달 창에서 이름이 replyer인 input 요소를 가져오기
		var modalInputReplyer = modal.find("input[name='replyer']");
		// 모달 창에서 이름이 replyDate인 input 요소를 가져오기
		var modalInputReplyDate = modal.find("input[name='replyDate']");

		// id가 modalModBtn인 버튼을 가져오기
		var modalModBtn = $("#modalModBtn");
		// id가 modalRemoveBtn인 버튼을 가져오기
		var modalRemoveBtn = $("#modalRemoveBtn");
		// id가 modalRegisterBtn인 버튼을 가져오기
		var modalRegisterBtn = $("#modalRegisterBtn");
		// id가 modalCloseBtn인 버튼을 가져오기
		var modalCloseBtn = $("#modalCloseBtn");

		// New Reply 버튼 클릭 시 모달 창 열기
		/*
		 * 
		 $("#addReplyBtn").on("click", function(e){
		
		 // 모달 창에서 모든 input 태그들을 찾아서 jQuery 객체로 반환 후 빈 문자열로 설정
		 modal.find("input").val("");
		
		 // ReplyDate 입력 필드를 안보이게 처리
		 modalInputReplyDate.closest("div").hide();
		
		 // Modify 버튼과 Remove 버튼을 안보이게 처리
		 modal.find("button[id='modalModBtn']").hide();
		 modal.find("button[id='modalRemoveBtn']").hide();
		 modalInputReplyer.removeAttr("readonly");


		 // 모달 창을 보이도록 설정
		 $(".modal").modal("show");
		 });
		
		 */

		$("#addReplyBtn").on("click", function(e) {

			modal.find("input").val("");
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id!='modalCloseBtn']").hide();

			modalRegisterBtn.show();

			$(".modal").modal("show");

		});

		// 모달 창에서 댓글 추가하기
		modalRegisterBtn.on("click", function(e) {
			// 모달 창의 입력 필드의 값들을 reply 객체에 담는다.
			var reply = {
				reply : modalInputReply.val(),
				replyer : modalInputReplyer.val(),
				bno : bnoValue
			};

			// reply 객체를 add 메서드에게 넘기면서 ajax 요청
			// 서버의 응답을 출력하고 모달 창을 숨기는 메서드를 선언과 동시에 넘긴다.
			replyService.add(reply, function(result) {
				alert(result);

				modal.find("input").val("");
				modal.modal("hide");

				// 새 댓글을 읽어오기
				showList(-1);
			});
		});

		// 댓글 클릭 이벤트 처리
		$(".chat").on("click", "li", function(e) {

			// 클릭한 댓글의 기본키를 가져옴
			var rno = $(this).data("rno");

			// get 메서드에게 댓글의 기본키와 callback 함수를 만들어서 전달
			replyService.get(rno, function(reply) {

				// 모달 창의 reply 필드 값을 reply 객체의 reply 필드 값으로 변경
				modalInputReply.val(reply.reply);

				// 모달 창의 replyer 필드 값을 replyer 객체의 replyer 필드 값으로 변경 
				modalInputReplyer.val(reply.replyer);

				// replyer 부분을 읽기 전용으로 변경
				//modalInputReplyer.attr("readonly", "readonly");

				// displayTime 부분을 읽기 전용으로 변경
				modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");

				// modal 요소에게 reply 객체의 rno 값을 부여
				modal.data("rno", reply.rno);

				// Register 버튼을 숨김
				modal.find("button[id='modalRegisterBtn']").hide();

				modalModBtn.show();
				modalRemoveBtn.show();
				modalInputReplyDate.closest("div").show();

				// 모달 창을 보이도록 설정
				$(".modal").modal("show");
			});
		});

		// Modify 버튼 클릭 이벤트 처리
		modalModBtn.on("click", function(e) {
			// reply 객체의 값을 설정
			var reply = {
				// 댓글을 클릭했을 때 모달 창에게 부여된 그 댓글의 기본키를 가져와서 rno 필드에 담는다.
				rno : modal.data("rno"),
				// 모달 창의 reply 입력 필드 값을 가져와서 reply 필드에 담는다.
				reply : modalInputReply.val()
			};
			// reply 객체를 update 메서드에게 넘기면서 ajax 요청
			// 서버의 응답을 출력하고 모달 창을 숨기는 메서드를 선언과 동시에 넘긴다.
			replyService.update(reply, function(result) {
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});
		});
		// Remove 버튼 클릭 이벤트 처리
		modalRemoveBtn.on("click", function(e) {
			// 댓글을 클릭했을 때 모달 창에게 부여된 그 댓글의 기본키를 가져옴
			var rno = modal.data("rno");
			// rno 값을 remove 메서드에게 넘기면서 ajax 요청
			// 서버의 응답을 출력하고 모달 창을 숨기는 메서드를 선언과 동시에 넘긴다.
			replyService.remove(rno, function(result) {
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});
		});

		var pageNum = 1;
		var replyPageFooter = $(".panel-footer");

		function showReplyPage(replyCnt) {
			var endNum = Math.ceil(pageNum / 10.0) * 10;
			var startNum = endNum - 9;

			var prev = startNum != 1;
			var next = false;

			if (endNum * 10 >= replyCnt) {
				endNum = Math.ceil(replyCnt / 10.0);
			}
			if (endNum * 10 < replyCnt) {
				next = true;
			}

			var str = "<ul class='pagination pull-right'>";

			if (prev) {
				str += "<li class='page-item'><a class='page-link' href='" + (startNum - 1) + "'>Previous</a></li>";
			}

			for (var i = startNum; i <= endNum; i++) {
				var active = pageNum == i ? "active" : "";

				str += "<li class='page-item " + active + "'><a class='page-link' href='" + i + "'>" + i + "</a></li>";
			}

			if (next) {
				str += "<li class='page-item'><a class='page-link' href='" + (endNum + 1) + "'>Next</a></li>";
			}

			str += "</ul></div>";

			console.log(str);

			replyPageFooter.html(str);
		}

		replyPageFooter.on("click", "li a", function(e) {
			e.preventDefault();
			console.log("page click");

			var targetPageNum = $(this).attr("href");
			console.log("targetPageNum: " + targetPageNum);

			pageNum = targetPageNum;
			showList(pageNum);
		});

		// 게시물이 클릭되었을 때 클릭한 게시물에 게재된 첨부 파일 리스트를 JSON 형태로 받아온다.
		(function() {
			// 클릭한 게시물의 bno 값을 가져온다.
			var bno = '<c:out value="${board.bno}"/>';

			// jQuery의 AJAX 메서드 중 하나
			// Get 요청을 보내고 JSON 형식의 응답을 받는다.
			$.getJSON("/board/getAttachList", {
				// bno를 쿼리 스트링 형태로 보낸다.
				// key=value
				bno : bno
			}, function(arr) {

				console.log(arr);
				var str = "";
				// 컨트롤러에게 받은 JSON 형식의 데이터를 반복문으로 순회
				$(arr).each(function(i, attach) {

					// 이미지 파일인지 확인
					if (attach.fileType) {
						var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);

						str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
						str += "<img src='/display?fileName=" + fileCallPath + "'></div></li>";
					} else {
						str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
						str += "<span>" + attach.fileName + "</span><br/>";
						str += "<img src='/resources/img/attach.png'></div></li>";
					}
				});
				$(".uploadResult ul").html(str);
			});
		})();

		// 첨부파일이 클릭되었을 때의 처리
		// 이미지 파일이면 원본 이미지를 출력, 일반 파일이라면 다운로드
		$(".uploadResult").on("click", "li", function(e) {
			console.log("view image");
			// 이벤트가 발생한 요소를 가져와 저장
			var liObj = $(this);
			// 파일의 경로 + UUID + 파일 이름으로 다운로드 경로를 구성
			var path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename"));
			// 클릭한 파일이 이미지인 경우
			if (liObj.data("type")) {
				// 화면에 클릭한 섬네일의 원본 이미지를 출력
				showImage(path.replace(new RegExp(/\\/g), "/"));
			} else {
				// 일반 파일인 경우 다운로드 처리
				self.location = "/download?fileName=" + path;
			}
		});

		// 원본 이미지를 출력하는 애니메이션
		function showImage(fileCallPath) {
			alert(fileCallPath);
			$(".bigPictureWrapper").css("display", "flex").show();
			$(".bigPicture").html("<img src='/display?fileName=" + fileCallPath + "'>").animate({
				width : '100%',
				height : '100%'
			}, 1000);
		}

		// 원본 이미지를 닫는 애니메이션
		$(".bigPictureWrapper").on("click", function(e) {
			$(".bigPicture").animate({
				width : '0%',
				height : '0%'
			}, 1000);
			setTimeout(function() {
				$('.bigPictureWrapper').hide();
			}, 1000);
		});
	});
</script>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">Board Read Page</div>
			<!-- /.panel-heading -->
			<div class="panel-body">

				<div class="form-group">
					<label>Bno</label> <input class="form-control" name="bno" value='<c:out value="${board.bno }"/>' readonly="readonly">
				</div>

				<div class="form-group">
					<label>Title</label> <input class="form-control" name="title" value='<c:out value="${board.title }"/>' readonly="readonly">
				</div>

				<div class="form-group">
					<label>Text area</label>
					<textarea class="form-control" rows="3" name="content" readonly="readonly">
            <c:out value="${board.content}" />
          </textarea>
				</div>

				<div class="form-group">
					<label>Writer</label> <input class="form-control" name="writer" value='<c:out value="${board.writer }"/>' readonly="readonly">
				</div>

				<button data-oper='modify' class="btn btn-default" onclick="location.href='/board/modify?bno=<c:out value="${board.bno }"/>'">Modify</button>

				<button data-oper='list' class="btn btn-info" onclick="location.href='/board/list'">List</button>

				<form id='operForm' action="/board/modify" method="get">
					<input type="hidden" id='bno' name='bno' value='<c:out value="${board.bno }"/>'> <input type="hidden" name='pageNum' value='<c:out value="${cri.pageNum }"/>'> <input type="hidden" name='amount' value='<c:out value="${cri.amount }"/>'> <input type="hidden" name='keyword' value='<c:out value="${cri.keyword }"/>'> <input type="hidden" name='type' value='<c:out value="${cri.type }"/>'>
				</form>
			</div>
			<!-- end panel-body -->
			<!-- .panel -->
			<div class="panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-comments fa-fw"></i> Reply
					<button id='addReplyBtn' class="btn btn-primary btn-xs pull-right">New Reply</button>
				</div>
				<!-- .panel-heading -->
				<div class="panel-body">
					<ul class="chat">
						<!-- start reply -->
						<li class="left clearfix" data-rno="12">
							<div>
								<div class="header">
									<strong class="primary-font">user00</strong> <small class="pull-right text-muted">2018-01-01 13:13</small>
								</div>
								<p>Good job!</p>
							</div>
						</li>
						<!-- end reply -->
					</ul>
					<!-- end ul -->
				</div>
				<div class="uploadResult">
					<ul>
					</ul>
				</div>
				<div class="panel-footer"></div>
				<!-- .panel-body -->
			</div>
			<!-- .panel .chat-panel -->

		</div>
		<!-- end panel-body -->
	</div>
	<!-- end panel -->
</div>
<!-- /.row -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label> <input class="form-control" name="reply" value="New Reply!!!!">
				</div>
				<div class="form-group">
					<label>Replyer</label> <input class="form-control" name="replyer" value="replyer">
				</div>
				<div class="form-group">
					<label>Reply Date</label> <input class="form-control" name="replyDate" value="">
				</div>
			</div>
			<div class="modal-footer">
				<button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
				<button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
				<button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
				<button id="modalCloseBtn" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<%@include file="../includes/footer.jsp"%>