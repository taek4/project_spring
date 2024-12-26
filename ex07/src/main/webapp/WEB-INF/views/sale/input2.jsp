<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<!-- //김영민
//金榮珉 -->
<style>
ul {
	list-style: none;
	padding: 0;
	margin: 0;
}
li {
	display: flex;
	align-items: center;
	gap: 10px; /* 요소 간의 간격 */
}
label {
	font-size: 14px;
	font-weight: bold;
}
select, input[type="date"] {
	padding: 5px;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 14px;
}
.button {
	width: 90px;
	height: 40px;
	padding: 10px 0;
	text-align: center;
	border-radius: 15px;
	border: none;
	background-color: #d3daf7;
	color: #555;
	font-size: 14px;
	cursor: pointer;
	text-align: center;
	transition: all 0.3s ease;
}
.button:hover {
	background-color: #668FE7;
}
.button:focus, .button:active {
	background-color: #1B3DA1;
	color: white;
	border: none;
	outline: none;
}
#itemTable {
	width: 100%;
	border-collapse: collapse;
	margin: 20px 0;
}
#itemTable th, #itemTable td {
	border: 1px solid #ccc; 
	padding: 8px;
	text-align: center;
}
#itemTable thead {
	background-color: #F7F8F9;
}
</style>
<div class="container-fluid px-4">
	<div class="button-container">
		<h3 class="mt-4">販売入力2</h3>
		<button id="searchButton" class="button">販売入力2</button>
	</div>
	<form id="saleForm" method="post" action="<c:url value='/sale/save2'/>">
	<fieldset>
		<div>
			<ul>
				<li>
					<label for="year">日付</label>
					<select id="year"></select> / 
					<select id="month"></select> /
					<select id="day"></select>  
					<input type="date" id="hitsuke">
				</li>
				<li>
					<div id="torihikisaki-filter">
		    			<label for="torihikisaki">取引先</label>
						<select name="torihikisakiID" required>
						    <option value="">取引先選択</option>
						    <c:forEach var="torihikisaki" items="${torihikisakiList}">
						        <option value="${torihikisaki.torihikisakiID}">${torihikisaki.torihikisakimei}</option>
						    </c:forEach>
						</select>
					</div>
				</li>
				<li>
					<div id="tantousha-filter">
		    			<label for="tantousha">担当者</label>	    				
						<select name="tantoushaID" required>
					        <option value="">担当者選択</option>
					        <c:forEach var="tantousha" items="${tantoushaList}">
					            <option value="${tantousha.tantoushaID}">${tantousha.tantoushamei}</option>
					        </c:forEach>
					    </select>
					</div>
				</li>
				<li>
					<div id="souko-filter">
		    			<label for="souko">出荷倉庫</label>	    				
					    <select name="soukoID">
					        <option value="">出荷倉庫選択</option>
					        <c:forEach var="souko" items="${soukoList}">
					            <option value="${souko.soukoID}">${souko.soukomei}</option>
					        </c:forEach>
					    </select>
					</div>
				</li>
				<li>
					<div id="transaction-filter">
		    			<label for="transaction">取引タイプ</label>	    				
					    <select name="zeikomikubun" required>
					        <option value="Y" selected>付加価値税率適用</option>
					        <option value="N">付加価値税率未適用</option>
					    </select>
					</div>
				</li>
			</ul>
			<button class="button">さがし(F3)</button>
			<button class="button">整列</button>
			<button class="button">My品目</button>
			<button class="button">所要</button>
			<button class="button">保留</button>
			<button class="button">在庫ロード</button>
			<button class="button">バーコード</button>
			<button class="button">検証</button>
			<button class="button">調整</button>
			<table id="itemTable">
				<thead>
					<tr>
						<th>品目選択</th>
						<th>品目コード</th>
						<th>品目名</th>
						<th>規格</th>
						<th>数量</th>
						<th>単価</th>
						<th>供給価額(合計)</th>
						<th>付加価値税</th>
						<th>新項目追加</th>
					</tr>
				</thead>
				<tbody>
	        		<tr>
	            		<td>
	                		<select class="hinmokuSelect" name="commonHinmokuList[0].hinmokuID" required>
	                    		<option value="">選択</option>
	                    		<c:forEach var="hinmoku" items="${hinmokuList}">
	                        	<option value="${hinmoku.hinmokuID}" 
		                                data-zaiko="${hinmoku.zaikoKoodo}" 
		                                data-hinmokumei="${hinmoku.hinmokumei}" 
		                                data-kikaku="${hinmoku.kikaku}"
		                                data-tanka="${hinmoku.tanka}" 
		                                data-shouhizei="${hinmoku.shouhizei}">
	                            	${hinmoku.zaikoKoodo}-${hinmoku.hinmokumei}
	                        	</option>
	                    		</c:forEach>
	                		</select>
	            		</td>
	            		<td><input type="text" name="commonHinmokuList[0].itemCode" class="zaikoCode" readonly></td>
	    				<td><input type="text" name="commonHinmokuList[0].itemName" class="hinmokuName" readonly></td>
	    				<td><input type="text" name="commonHinmokuList[0].kikaku" class="kikaku" readonly></td>
	    				<td><input type="number" name="commonHinmokuList[0].suuryou" class="suuryou" required></td> 	
	    				<td><input type="number" name="commonHinmokuList[0].tanka" class="tanka" readonly></td>
	    				<td><input type="number" name="commonHinmokuList[0].kyoukyuKingaku" class="kyoukyuuGaku" required></td>
	    				<td><input type="number" name="commonHinmokuList[0].bugase" class="shouhizei" readonly></td>
	    				<td><button type="button" class="deleteRow" style="width: 180px;">削除</button></td>
	        		</tr>
	    		</tbody>
			</table>
		</div>
	</fieldset>
	<button type="button" id="addItemRow" class="button">品目追加</button>
	<button type="submit" class="button">保存</button>
	</form>
	</div>

<script>
//연도, 월, 일 옵션 채우기 // 年、月、日オプションを設定
const yearSelect = document.getElementById("year");
const monthSelect = document.getElementById("month");
const daySelect = document.getElementById("day");
const dateInput = document.getElementById("hitsuke");

// 연도 옵션 (2020 ~ 2030) // 年オプション (2020 ~ 2030)
for (let year = 2020; year <= 2030; year++) {
    const option = document.createElement("option");
    option.value = year;
    option.textContent = year;
    yearSelect.appendChild(option);
}

// 월 옵션 (1 ~ 12) // 月オプション (1 ~ 12)
for (let month = 1; month <= 12; month++) {
    const option = document.createElement("option");
    option.value = month;
    option.textContent = month;
    monthSelect.appendChild(option);
}

// 일 옵션 (1 ~ 31) // 日オプション (1 ~ 31)
for (let day = 1; day <= 31; day++) {
    const option = document.createElement("option");
    option.value = day;
    option.textContent = day;
    daySelect.appendChild(option);
}

// 날짜 선택 시 드롭다운 업데이트 // 日付選択時にドロップダウンを更新
dateInput.addEventListener("input", () => {
    const selectedDate = new Date(dateInput.value);
    if (!isNaN(selectedDate)) {
        yearSelect.value = selectedDate.getFullYear();
        monthSelect.value = selectedDate.getMonth() + 1; // 월은 0부터 시작 // 月は0から始まる
        daySelect.value = selectedDate.getDate();
    }
});

document.addEventListener("DOMContentLoaded", function () {
    
    // 공급가액 계산 함수 // 供給価額計算関数
    function calculateKyoukyuuGaku(row) {
        const tanka = parseFloat(row.querySelector('.tanka').value) || 0;
        const suuryou = parseFloat(row.querySelector('.suuryou').value) || 0;
        const kyoukyuuGaku = tanka * suuryou;
        row.querySelector('.kyoukyuuGaku').value = kyoukyuuGaku.toFixed(2); // 소수점 2자리로 고정 // 小数点を2桁に固定
    }

    // 행 추가 이벤트 // 行追加イベント
    document.getElementById('addItemRow').addEventListener('click', function () {
        const table = document.querySelector('#itemTable tbody');
        const rowCount = table.rows.length; // 현재 행 개수 // 現在の行数
        const newRow = table.rows[0].cloneNode(true); // 첫 번째 행 복제 // 最初の行を複製

        // 새 행 초기화 // 新しい行を初期化
        newRow.querySelectorAll('input').forEach(input => input.value = '');
        newRow.querySelector('select').selectedIndex = 0;

        // 새 행 추가 // 新しい行を追加
        table.appendChild(newRow);

        // 새로 추가된 행에 이벤트 바인딩 // 新しく追加された行にイベントをバインド
        bindRowEvents(newRow);

        // 인덱스 재설정 // インデックスを再設定
        updateRowIndices();
    });

    // 테이블 내 삭제 버튼 클릭 이벤트 // テーブル内削除ボタンのクリックイベント
    document.getElementById('itemTable').addEventListener('click', function (e) {
        if (e.target.classList.contains('deleteRow')) {
            const row = e.target.closest('tr');
            row.remove();

            // 인덱스 재설정 // インデックスを再設定
            updateRowIndices();
        }
    });

    // 인덱스 재설정 함수 // インデックス再設定関数
    function updateRowIndices() {
        const rows = document.querySelectorAll('#itemTable tbody tr');
        rows.forEach((row, index) => {
            row.querySelectorAll('input, select').forEach(input => {
                if (input.name) {
                    const baseName = input.name.split('[')[0]; // 'commonHinmokuList'
                    const fieldName = input.name.split(']')[1]; // '.itemCode', '.itemName' 등
                    // 문자열 연결 방식으로 name 속성 업데이트 // 文字列結合でname属性を更新
                    input.name = baseName + '[' + index + ']' + fieldName;
                    console.log('Updated name: ' + input.name); // 디버깅용 출력 // デバッグ用出力
                }
            });
        });
    }

    // 기존 행 및 새로 추가된 행에 이벤트 바인딩 // 既存行と新しく追加された行にイベントをバインド
    function bindRowEvents(row) {
        // 품목 선택 이벤트 // 品目選択イベント
        row.querySelector('.hinmokuSelect').addEventListener('change', function () {
            const selectedOption = this.options[this.selectedIndex];
            row.querySelector('.zaikoCode').value = selectedOption.dataset.zaiko || '';
            row.querySelector('.hinmokuName').value = selectedOption.dataset.hinmokumei || '';
            row.querySelector('.kikaku').value = selectedOption.dataset.kikaku || '';
            row.querySelector('.tanka').value = selectedOption.dataset.tanka || '';
            row.querySelector('.shouhizei').value = selectedOption.dataset.shouhizei || '';
            calculateKyoukyuuGaku(row); // 공급가액 계산 // 供給価額を計算
        });
     // 수량 변경 시 공급가액 계산 // 数量変更時に供給価額を計算
        row.querySelector('.suuryou').addEventListener('input', function () {
            calculateKyoukyuuGaku(row);
        });
    }

    // 기존 행에 이벤트 핸들러 등록 // 既存行にイベントハンドラを登録
    const rows = document.querySelectorAll('#itemTable tbody tr');
    rows.forEach((row) => {
        bindRowEvents(row);
    });

    // 폼 제출 전 데이터 확인 // フォーム提出前にデータを確認
    document.getElementById('saleForm').addEventListener('submit', function (event) {
        const rows = document.querySelectorAll('#itemTable tbody tr');
        let isValid = true;

        rows.forEach((row, index) => {
            const hinmokuID = row.querySelector('.hinmokuSelect').value;
            const suuryou = row.querySelector('.suuryou').value;

            // 필수값 검증 // 必須値検証
            if (!hinmokuID || !suuryou) {
                alert(`행 ${index + 1}에 필수값이 누락되었습니다。`);
                // 行${index + 1}に必須値が欠落しています。
                isValid = false;
            }
        });

        if (!isValid) {
            event.preventDefault(); // 제출 중단 // 提出を中止
        }
    });
});
</script>

<%@ include file="../includes/footer.jsp"%>