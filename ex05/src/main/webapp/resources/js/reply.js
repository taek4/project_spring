console.log("Reply Module..........");

var replyService = (function() {
	// callback은 add를 호출하면서
	// add 함수가 끝날 때 호출할 함수를 뜻한다.
	function add(reply, callback, error) {
		console.log("add reply...............");
		console.log(reply);
		$.ajax({
			type : 'post', // 요청 유형
			url : '/replies/new', // 요청 경로
			data : JSON.stringify(reply), // 보낼 데이터
			contentType : "application/json; charset=utf-8", // MIME 설정
			success : function(result, status, xhr) { // 성공 시
				// add를 호출할 때 callback 함수를 호출하면
				// 그 callback 함수에게 서버로부터 받은 result를 전달
				// ReplyController에게 "success"를 받았음.
				if (callback) {
					callback(result); // 콜백 함수 호출
				}
			},
			error : function(xhr, status, er) { // 실패 시
				if (error) {
					error(er); // 에러 함수 호출
				}
			}
		});
	}
	
	function getList(param, callback, error) {
	    var bno = param.bno;
	    var page = param.page || 1;

	    $.getJSON("/replies/pages/" + bno + "/" + page + ".json",
	        function(data) {
	            if (callback) {
	                // callback(data); // 댓글 목록만 가져오는 경우
	                callback(data.replyCnt, data.list); // 댓글 숫자와 목록을 가져오는 경우
	            }
	        }).fail(function(xhr, status, err) {
	            if (error) {
	                error();
	            }
	        });
	}


	function remove(rno, callback, error) {
		$.ajax({
			type : 'delete', // 요청 유형: Delete
			url : '/replies/' + rno, // 요청 경로
			success : function(deleteResult, status, xhr) { // 성공 시
				if (callback) {
					callback(deleteResult); // 콜백 함수 호출
				}
			},
			error : function(xhr, status, er) { // 실패 시
				if (error) {
					error(er); // 에러 함수 호출
				}
			}
		});
	}
	
	// replyService update 메서드
	function update(reply, callback, error) {
		console.log("RNO: " + reply.rno);
		console.log(reply);
		$.ajax({
			type : 'put', // 요청 유형: PUT
			url : '/replies/' + reply.rno, // 요청 경로
			data : JSON.stringify(reply), // JSON 데이터로 변환하여 전송
			contentType : "application/json; charset=utf-8", // 데이터 타입
			success : function(result, status, xhr) { // 성공 시
				if (callback) {
					callback(result); // 콜백 함수 호출
				}
			},
			error : function(xhr, status, er) { // 실패 시
				if (error) {
					error(er); // 에러 함수 호출
				}
			}
		});
	}

	function get(rno, callback, error) {
		$.get("/replies/" + rno + ".json", function(result) {
			if (callback) {
				callback(result); // 성공 시 콜백 함수 호출
			}
		}).fail(function(xhr, status, err) {
			if (error) {
				error(err); // 실패 시 에러 함수 호출
			}
		});
	}

	function displayTime(timeValue) {
		var today = new Date(); // 현재 날짜와 시간을 가져옴
		var gap = today.getTime() - timeValue; // 현재 시간과 전달된 시간의 차이를 계산
		var dateObj = new Date(timeValue); // 전달된 시간을 Date 객체로 변환
		var str = "";

		// 24시간 이내일 경우 시간으로 표시
		if (gap < 1000 * 60 * 60 * 24) {
			var hh = dateObj.getHours(); // 시
			var mi = dateObj.getMinutes(); // 분
			var ss = dateObj.getSeconds(); // 초

			return [ (hh > 9 ? "" : "0") + hh, ":", (mi > 9 ? "" : "0") + mi,
					":", (ss > 9 ? "" : "0") + ss, ].join("");
		} else {
			// 24시간 이상일 경우 날짜로 표시
			var yy = dateObj.getFullYear(); // 년
			var mm = dateObj.getMonth() + 1; // 월 (0부터 시작하므로 +1)
			var dd = dateObj.getDate(); // 일

			return [ yy, "/", (mm > 9 ? "" : "0") + mm, "/",
					(dd > 9 ? "" : "0") + dd, ].join("");
		}
	}
	return {
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		get : get,
		displayTime : displayTime
	};

})();
