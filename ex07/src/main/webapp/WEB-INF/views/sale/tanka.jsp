<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>

<!-- //김영민
//金榮珉 -->
<div class="container-fluid px-4">
	<div class="button-container">
    	<h3 class="mt-4">販売単価一括変更</h3>
    </div>
    <div>
    	<table class="table table-bordered">
        <thead class="table-light">
    			<tr>
    				<th><input type="checkbox" id="selectAll" onclick="toggleAllCheckboxes(this)"></th>
                    <th>日付-No</th>
    				<th>取引先名</th>
    				<th>担当者名</th>
    				<th>出荷倉庫名</th>
    				<th>取引タイプ名</th>
    				<th>通貨名</th>
    				<th>プロジェクト名</th>
    				<th>品目コード</th>
    				<th>品目名</th>
    				<th>規格</th>
    				<th>数量</th>
    				<th>単価</th>
    				<th>変更単価</th>
    				<th>供給価額</th>
    				<th>付加価値税</th>
    				<th>変更</th>
    			</tr>
    		</thead>
    		<tbody>
	    		<c:forEach var="hanbai" items="${saleList}">
			        <tr>
			            <td><input type="checkbox" class="row-checkbox"></td>
						<td>${hanbai.hitsuke_no}</td>
			            <td>${hanbai.torihikisakimei}</td>
			            <td>${hanbai.tantoushamei}</td>
			            <td>${hanbai.soukomei}</td>
			            <td>${hanbai.zeikomikubun}</td>
			            <td>${hanbai.tsuukamei}</td>
			            <td>${hanbai.projectmei}</td>
			            <td>${hanbai.hinmokuID}</td>
			            <td>${hanbai.hinmokumei}</td>
			            <td>${hanbai.kikaku}</td>
			            <td>${hanbai.suuryou}</td>
			            <td>${hanbai.tanka}</td>
			            <td>
                    		<input type="number" name="release" min="1" max="${hanbai.tanka}" />
                		</td>
			            <td>${hanbai.kyoukyuKingaku}</td>
			            <td>${hanbai.bugase}</td>
			            <td>
                    		<button type="button" onclick="processRelease('${hanbai.hinmokumei}', '${hanbai.hitsukeNoRefertype}', this)">変更</button>
                		</td>
			        </tr>
			    </c:forEach>
    		</tbody>
    	</table>
    </div>
</div>

<script>
function processRelease(hinmokumei, hitsukeNoRefertype, button) {
    const row = button.closest('tr'); // 버튼이 포함된 가장 가까운 행(tr)을 선택 // ボタンが含まれている最も近い行(tr)を選択
    const release = row.querySelector('input[name="release"]').value; // 입력된 단가 값 가져오기 // 入力された単価値を取得

    if (!release || release <= 0) {
        alert("단가를 입력하세요."); // 단가 입력 요청 메시지 // 単価を入力してください。
        return;
    }

    const requestData = {
        hinmokumei: hinmokumei, // 품목명 // 品目名
        hitsukeNoRefertype: hitsukeNoRefertype, // 날짜-No 참조 유형 // 日付-No参照タイプ
        release: parseInt(release) // 입력된 단가를 정수로 변환 // 入力された単価を整数に変換
    };

    fetch('/sale/tanka', {
        method: 'POST', // POST 요청 // POSTリクエスト
        headers: { 'Content-Type': 'application/json; charset=UTF-8' }, // JSON 형식으로 전송 // JSON形式で送信
        body: JSON.stringify(requestData) // 데이터를 JSON 문자열로 변환 // データをJSON文字列に変換
    })
    .then(function(response) {
        if (!response.ok) throw new Error("단가 변경 실패"); // 응답이 실패할 경우 에러 발생 // 応答が失敗した場合、エラーを発生
        return response.text(); // 응답 텍스트 반환 // 応答テキストを返す
    })
    .then(function(result) {
        alert(result); // 성공 메시지 알림 // 成功メッセージを通知
        location.reload(); // 데이터 갱신을 위해 페이지 새로고침 // データ更新のためにページをリロード
    })
    .catch(function(error) {
        alert(error.message); // 에러 메시지 알림 // エラーメッセージを通知
    });
}
</script>

<%@ include file="../includes/footer.jsp" %>
