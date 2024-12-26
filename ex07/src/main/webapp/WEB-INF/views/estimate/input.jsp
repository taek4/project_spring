<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../includes/header.jsp"%>

<h1>見積書入力</h1>

<form id="estimateForm" method="post"
	action="<c:url value='/estimate/save'/>">
	<!-- 見積書基本情報 -->
	<fieldset>
		<legend>見積書基本情報</legend>

		<label>日付:</label> <input type="date" id="hitsuke" name="hitsuke"
			required value="<%=java.time.LocalDate.now().toString()%>"> <label>取引先:</label>
		<select name="torihikisakiID" required>
			<option value="">取引先を選択</option>
			<c:forEach var="torihikisaki" items="${torihikisakiList}">
				<option value="${torihikisaki.torihikisakiID}">${torihikisaki.torihikisakimei}</option>
			</c:forEach>
		</select> <label>担当者:</label> <select name="tantoushaID" required>
			<option value="">担当者を選択</option>
			<c:forEach var="tantousha" items="${tantoushaList}">
				<option value="${tantousha.tantoushaID}">${tantousha.tantoushamei}</option>
			</c:forEach>
		</select> <label>出荷倉庫:</label> <select name="soukoID">
			<option value="">出荷倉庫を選択</option>
			<c:forEach var="souko" items="${soukoList}">
				<option value="${souko.soukoID}">${souko.soukomei}</option>
			</c:forEach>
		</select> <label>取引区分:</label> <select name="zeikomikubun" required>
			<option value="Y" selected>税込み</option>
			<option value="N">税抜き</option>
		</select> <label>通貨:</label> <select name="tsukaID" required>
			<option value="">通貨を選択</option>
			<c:forEach var="tsuuka" items="${tsuukaList}">
				<option value="${tsuuka.tsukaID}">${tsuuka.tsuukaMeimei}</option>
			</c:forEach>
		</select> <label>備考:</label>
		<textarea name="memo" rows="1" cols="50"></textarea>
	</fieldset>


	<!-- 品目情報入力 -->
	<h3>品目情報入力</h3>
	<table id="itemTable" border="1">
		<thead>
			<tr>
				<th>品目選択</th>
				<th>品目コード</th>
				<th>品目名</th>
				<th>規格</th>
				<th>単価</th>
				<th>供給価額</th>
				<th>付加税</th>
				<th>数量</th>
				<th>備考</th>
				<th>削除</th>
			</tr>
		</thead>
		<tbody>

			<tr>
				<td><select class="hinmokuSelect"
					name="commonHinmokuList[0].hinmokuID" required>
						<option value="">選択</option>
						<c:forEach var="hinmoku" items="${hinmokuList}">
							<option value="${hinmoku.hinmokuID}"
								data-zaiko="${hinmoku.zaikoKoodo}"
								data-hinmokumei="${hinmoku.hinmokumei}"
								data-kikaku="${hinmoku.kikaku}" data-tanka="${hinmoku.tanka}"
								data-shouhizei="${hinmoku.shouhizei}">
								${hinmoku.zaikoKoodo}-${hinmoku.hinmokumei}</option>
						</c:forEach>
				</select></td>
				<td><input type="text" name="commonHinmokuList[0].itemCode"
					class="zaikoCode" readonly></td>
				<td><input type="text" name="commonHinmokuList[0].itemName"
					class="hinmokuName" readonly></td>
				<td><input type="text" name="commonHinmokuList[0].kikaku"
					class="kikaku" readonly></td>
				<td><input type="number" name="commonHinmokuList[0].tanka"
					class="tanka" readonly></td>
				<td><input type="number"
					name="commonHinmokuList[0].kyoukyuKingaku" class="kyoukyuuGaku"
					required></td>
				<td><input type="number" name="commonHinmokuList[0].bugase"
					class="shouhizei" readonly></td>
				<td><input type="number" name="commonHinmokuList[0].suuryou"
					class="suuryou" required></td>
				<td><input type="text" name="commonHinmokuList[0].tekiyo"
					class="tekiyo"></td>
				<td><button type="button" class="deleteRow">削除</button></td>
			</tr>
		</tbody>
	</table>

	<button type="button" id="addItemRow">品目追加</button>
	<button type="submit">保有</button>

</form>

<script>
document.addEventListener("DOMContentLoaded", function () {
    
	// 공급가액 계산 함수
    function calculateKyoukyuuGaku(row) {
        const tanka = parseFloat(row.querySelector('.tanka').value) || 0;
        const suuryou = parseFloat(row.querySelector('.suuryou').value) || 0;
        const kyoukyuuGaku = tanka * suuryou;
        row.querySelector('.kyoukyuuGaku').value = kyoukyuuGaku.toFixed(2); // 소수점 2자리로 고정
    }
	
	// 행 추가 이벤트
    document.getElementById('addItemRow').addEventListener('click', function () {
        const table = document.querySelector('#itemTable tbody');
        const rowCount = table.rows.length; // 현재 행 개수
        const newRow = table.rows[0].cloneNode(true); // 첫 번째 행 복제

        // 새 행 초기화
        newRow.querySelectorAll('input').forEach(input => input.value = '');
        newRow.querySelector('select').selectedIndex = 0;

        // 새 행 추가
        table.appendChild(newRow);

        // 새로 추가된 행에 이벤트 바인딩
        bindRowEvents(newRow);

        // 인덱스 재설정
        updateRowIndices();
    });

    // 테이블 내 삭제 버튼 클릭 이벤트
    document.getElementById('itemTable').addEventListener('click', function (e) {
        if (e.target.classList.contains('deleteRow')) {
            const row = e.target.closest('tr');
            row.remove();

            // 인덱스 재설정
            updateRowIndices();
        }
    });

    // 인덱스 재설정 함수
    function updateRowIndices() {
        const rows = document.querySelectorAll('#itemTable tbody tr');
        rows.forEach((row, index) => {
            row.querySelectorAll('input, select').forEach(input => {
                if (input.name) {
                    const baseName = input.name.split('[')[0]; // 'commonHinmokuList'
                    const fieldName = input.name.split(']')[1]; // '.itemCode', '.itemName' 등
                    // 문자열 연결 방식으로 name 속성 업데이트
                    input.name = baseName + '[' + index + ']' + fieldName;
                    console.log('Updated name: ' + input.name); // 디버깅용 출력
                }
            });
        });
    }

    // 기존 행 및 새로 추가된 행에 이벤트 바인딩
    function bindRowEvents(row) {
        // 품목 선택 이벤트
        row.querySelector('.hinmokuSelect').addEventListener('change', function () {
            const selectedOption = this.options[this.selectedIndex];
            row.querySelector('.zaikoCode').value = selectedOption.dataset.zaiko || '';
            row.querySelector('.hinmokuName').value = selectedOption.dataset.hinmokumei || '';
            row.querySelector('.kikaku').value = selectedOption.dataset.kikaku || '';
            row.querySelector('.tanka').value = selectedOption.dataset.tanka || '';
            row.querySelector('.shouhizei').value = selectedOption.dataset.shouhizei || '';
            calculateKyoukyuuGaku(row); // 공급가액 계산
        });
     // 수량 변경 시 공급가액 계산
        row.querySelector('.suuryou').addEventListener('input', function () {
            calculateKyoukyuuGaku(row);
        });
    }

    // 기존 행에 이벤트 핸들러 등록
    const rows = document.querySelectorAll('#itemTable tbody tr');
    rows.forEach((row) => {
        bindRowEvents(row);
    });

    // 폼 제출 전 데이터 확인
    document.getElementById('EstimateForm').addEventListener('submit', function (event) {
        const rows = document.querySelectorAll('#itemTable tbody tr');
        let isValid = true;

        rows.forEach((row, index) => {
            const hinmokuID = row.querySelector('.hinmokuSelect').value;
            const suuryou = row.querySelector('.suuryou').value;

            // 필수값 검증
            if (!hinmokuID || !suuryou) {
            	alert("行 " + (index + 1) + " に必須値が欠落しています。");
                isValid = false;
            }
        });

        if (!isValid) {
            event.preventDefault(); // 제출 중단
        }
    });
});

</script>

<%@ include file="../includes/footer.jsp"%>