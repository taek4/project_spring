<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>

<form id="deliveryForm" method="post" action="<c:url value='/delivery/save'/>">

<!-- ReferenceType 値を固定に設定  / ReferenceType 값을 고정으로 설정  -->
    <input type="hidden" name="referenceType" value="5">

    <!-- 出荷基本情報 / 출하 기본 정보 -->
<fieldset>
    <legend>出荷入力</legend>

    <label>日付:</label>
    <input type="date" id="hitsuke" name="hitsuke" required value="<%= java.time.LocalDate.now().toString() %>">

    <label>取引先:</label>
    <select name="torihikisakiID" required>
        <option value="">取引先選択</option>
        <c:forEach var="torihikisaki" items="${torihikisakiList}">
            <option value="${torihikisaki.torihikisakiID}">${torihikisaki.torihikisakimei}</option>
        </c:forEach>
    </select>

    <label>担当者:</label>
    <select name="tantoushaID" required>
        <option value="">担当者選択</option>
        <c:forEach var="tantousha" items="${tantoushaList}">
            <option value="${tantousha.tantoushaID}">${tantousha.tantoushamei}</option>
        </c:forEach>
    </select>

    <label>出荷倉庫:</label>
    <select name="soukoID">
        <option value="">出荷倉庫選択</option>
        <c:forEach var="souko" items="${soukoList}">
            <option value="${souko.soukoID}">${souko.soukomei}</option>
        </c:forEach>
    </select>

    <label>プロジェクト:</label>
    <select name="projectID" required>
        <option value="">プロジェクト選択</option>
        <c:forEach var="project" items="${projectList}">
            <option value="${project.projectID}">${project.projectMeimei}</option>
        </c:forEach>
    </select>

    <label>連絡先:</label>
    <select name="renrakusaki" required>
        <option value="">連絡先選択</option>
        <c:forEach var="torihikisaki" items="${torihikisakiList}">
            <option value="${torihikisaki.torihikisakiID}">${torihikisaki.renrakusaki}</option>
        </c:forEach>
    </select>

    <label>郵便番号:</label>
    <select name="yuubinBangou" required>
        <option value="">郵便番号選択</option>
        <c:forEach var="torihikisaki" items="${torihikisakiList}">
            <option value="${torihikisaki.torihikisakiID}">${torihikisaki.yuubinBangou}</option>
        </c:forEach>
    </select>

    <label>住所:</label>
    <select name="zyuusho" required>
        <option value="">住所選択</option>
        <c:forEach var="torihikisaki" items="${torihikisakiList}">
            <option value="${torihikisaki.torihikisakiID}">${torihikisaki.zyuusho}</option>
        </c:forEach>
    </select>

    <label>新項目追加:</label>
    <textarea name="ShinKoumokuTsuika" rows="2" cols="50"></textarea>
</fieldset>


      <!-- 品目情報入力 / 품목 정보 입력 -->
    <h3>品目情報入力</h3>
    <table id="itemTable" border="1">
    <thead>
        <tr>
            <th>品目選択</th>
            <th>品目コード</th>
            <th>品目名</th>
            <th>規格</th>
            <th>数量</th>
            <th>備考</th>
            <th>削除</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>
                <select class="hinmokuSelect" name="commonHinmokuList[0].hinmokuID" required>
                    <option value="">品目選択</option>
                    <c:forEach var="hinmoku" items="${hinmokuList}">
                        <option value="${hinmoku.hinmokuID}" 
                                data-zaiko="${hinmoku.zaikoKoodo}" 
                                data-hinmokumei="${hinmoku.hinmokumei}" 
                                data-kikaku="${hinmoku.kikaku}">
                            ${hinmoku.zaikoKoodo}-${hinmoku.hinmokumei}
                        </option>
                    </c:forEach>
                </select>
            </td>
    <td><input type="text" name="commonHinmokuList[0].itemCode" class="zaikoCode" readonly></td>
    <td><input type="text" name="commonHinmokuList[0].itemName" class="hinmokuName" readonly></td>
    <td><input type="text" name="commonHinmokuList[0].kikaku" class="kikaku" readonly></td>
    <td><input type="number" name="commonHinmokuList[0].suuryou" class="suuryou" required></td>
    <td><input type="text" name="commonHinmokuList[0].tekiyo" class="tekiyo"></td>
    <td><button type="button" class="deleteRow">削除</button></td>
        </tr>
    </tbody>
</table>

<button type="button" id="addItemRow">品目追加</button>
<button type="submit">保存</button>

</form>

<script>


document.addEventListener("DOMContentLoaded", function () {
    // 行追加イベント  / 행 추가 이벤트
    document.getElementById('addItemRow').addEventListener('click', function () {
        const table = document.querySelector('#itemTable tbody');
        const rowCount = table.rows.length; // 現在の行数 / 현재 행 수
        const newRow = table.rows[0].cloneNode(true); // 最初の行を複製 / 첫 번째 행 복제

        // 新しい行を初期化  / 새로운 행 초기화
        newRow.querySelectorAll('input').forEach(input => input.value = '');
        newRow.querySelector('select').selectedIndex = 0;

        // 新しい行を追加  / 새로운 행 추가
        table.appendChild(newRow);

        // 新しく追加された行にイベントバインディング  / 새롭게 추가된 행에 이벤트 바인딩
        bindRowEvents(newRow);

        // インデックスを再設定  / 인덱스 재설정
        updateRowIndices();
    });

    // テーブル内の削除ボタンクリックイベント  / 테이블 내 삭제 버튼 클릭 이벤트
    document.getElementById('itemTable').addEventListener('click', function (e) {
        if (e.target.classList.contains('deleteRow')) {
            const row = e.target.closest('tr');
            row.remove();

            // インデックスを再設定  / 인덱스 재설정
            updateRowIndices();
        }
    });

    // インデックスを再設定する関数  / 인덱스를 재설정하는 함수
    function updateRowIndices() {
        const rows = document.querySelectorAll('#itemTable tbody tr');
        rows.forEach((row, index) => {
            row.querySelectorAll('input, select').forEach(input => {
                if (input.name) {
                    const baseName = input.name.split('[')[0]; // 'commonHinmokuList'
                    const fieldName = input.name.split(']')[1]; // '.itemCode', '.itemName'など 
                    // 文字列結合方式でname属性をアップデート  / 문자열 결합 방식으로 name 속성 업데이트
                    input.name = baseName + '[' + index + ']' + fieldName;
                    console.log('Updated name: ' + input.name); // デバッグ用出力  / 디버그용 출력
                }
            });
        });
    }

    // 既存の行および新しく追加された行にイベントをバインディング  / 기존 행 및 새로 추가된 행에 이벤트 바인딩
    function bindRowEvents(row) {
        // 品目選択イベント  / 품목 선택 이벤트
        row.querySelector('.hinmokuSelect').addEventListener('change', function () {
            const selectedOption = this.options[this.selectedIndex];
            row.querySelector('.zaikoCode').value = selectedOption.dataset.zaiko || '';
            row.querySelector('.hinmokuName').value = selectedOption.dataset.hinmokumei || '';
            row.querySelector('.kikaku').value = selectedOption.dataset.kikaku || '';
            row.querySelector('.suuryou').value = selectedOption.dataset.suuryou || '';
            row.querySelector('.tekiyo').value = selectedOption.dataset.tekiyo || '';
        });
    }

    // 既存の行にイベントハンドラを登録  / 기존 행에 이벤트 핸들러 등록
    const rows = document.querySelectorAll('#itemTable tbody tr');
    rows.forEach((row) => {
        bindRowEvents(row);
    });

    // フォーム送信前のデータ確認  / 폼 전송 전 데이터 확인
    document.getElementById('deliveryForm').addEventListener('submit', function (event) {
        const rows = document.querySelectorAll('#itemTable tbody tr');
        let isValid = true;

        rows.forEach((row, index) => {
            const hinmokuID = row.querySelector('.hinmokuSelect').value;
            const suuryou = row.querySelector('.suuryou').value;

            // 必須値の検証  / 필수 값 검증
            if (!hinmokuID || !suuryou) {
                alert(`行 ${index + 1} に必須値が欠落しています。 / ${index + 1}必須値が欠落しています。`);
                isValid = false;
            }
        });

        if (!isValid) {
            event.preventDefault(); // 提出中止  / 제출 중지
        }
    });
});
</script>


<%@ include file="../includes/footer.jsp"%>
