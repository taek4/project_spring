<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>

<h1>出荷指示書入力</h1>
<form id="shipmentForm" method="post" action="<c:url value='/shipment/save'/>">
    <!-- 注文書基本情報 -->
<fieldset>
    <legend>出荷指示書基本情報</legend>

    <label>日付:</label>
    <input type="date" id="hitsuke" name="hitsuke" required value="<%= java.time.LocalDate.now().toString() %>">

    <label>受付先:</label>
    <select name="torihikisakiID" required>
        <option value="">受付先選択</option>
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
    <select name="soukoID" required>
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
    
    <label>出荷予定日:</label>
    <input type="date" name="shukkaYoteibi" required>
	<label>郵便番号:</label>
    <input type="text" name="yuubinBangou" required>
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
            <th>数量</th>
            <th>削除</th>

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
        data-suuryou="${hinmoku.suuryou}">
    	${hinmoku.hinmokumei}
</option>

    </c:forEach>
</select>

            </td>
            <td><input type="text" name="commonHinmokuList[0].itemCode" class="zaikoCode" readonly></td>
    <td><input type="text" name="commonHinmokuList[0].itemName" class="hinmokuName" readonly></td>
    <td><input type="text" name="commonHinmokuList[0].kikaku" class="kikaku" readonly></td>
    <td><input type="number" name="commonHinmokuList[0].suuryou" class="suuryou" required></td>
    <td><button type="button" class="deleteRow">削除</button></td>
   <!--  <td><input type="hidden" name="shinkouZyoutai" value="進行中"></td> -->
    </tbody>
</table>

<button type="button" id="addItemRow">品目追加</button>
<button type="submit">保存</button>

</form>

<script>
document.addEventListener("DOMContentLoaded", function () {
    // 行追加イベント
    document.getElementById('addItemRow').addEventListener('click', function () {
        const table = document.querySelector('#itemTable tbody');
        const rowCount = table.rows.length; // 現在行数
        const newRow = table.rows[0].cloneNode(true); // 最初行複製

        // 新行初期化
        newRow.querySelectorAll('input').forEach(function (input) {
            input.value = '';
        });
        newRow.querySelector('select').selectedIndex = 0;

        // 新行追加
        table.appendChild(newRow);

        // 新しく追加された行にイベントバインド
        bindRowEvents(newRow);

        // インデックス再設定
        updateRowIndices();
    });

    // テーブル内削除ボタンクリックイベント
    document.getElementById('itemTable').addEventListener('click', function (e) {
        if (e.target.classList.contains('deleteRow')) {
            const row = e.target.closest('tr');
            row.remove();

            // インデックス再設定
            updateRowIndices();
        }
    });

    // インデックス再設定関数
    function updateRowIndices() {
        const rows = document.querySelectorAll('#itemTable tbody tr');
        rows.forEach(function (row, index) {
            row.querySelectorAll('input, select').forEach(function (input) {
                if (input.name) {
                    const baseName = input.name.split('[')[0]; // 'commonHinmokuList'
                    const fieldName = input.name.split(']')[1]; // '.itemCode', '.itemName' など
                    // 文字列接続方式でname属性アップデート
                    input.name = baseName + '[' + index + ']' + fieldName;
                    console.log('Updated name: ' + input.name); // ディバッグ用出力
                }
            });
        });
    }

    // 既存行および新しく追加された行にイベントバインド
    function bindRowEvents(row) {
        // 品目選択イベント
        row.querySelector('.hinmokuSelect').addEventListener('change', function () {
            const selectedOption = this.options[this.selectedIndex];
            row.querySelector('.zaikoCode').value = selectedOption.dataset.zaiko || '';
            row.querySelector('.hinmokuName').value = selectedOption.dataset.hinmokumei || '';
            row.querySelector('.kikaku').value = selectedOption.dataset.kikaku || '';
            row.querySelector('.suuryou').value = selectedOption.dataset.suuryou || '';
        });
    }

    // 既存行にイベントハンドラー登録
    const rows = document.querySelectorAll('#itemTable tbody tr');
    rows.forEach(function (row) {
        bindRowEvents(row);
    });

    // フォーム提出前データ確認
    document.getElementById('shipmentForm').addEventListener('submit', function (event) {
        const rows = document.querySelectorAll('#itemTable tbody tr');
        let isValid = true;

        // 保存されたデータ出力
        console.log('保存されたデータ:');
        rows.forEach(function (row, index) {
            const hinmokuID = row.querySelector('.hinmokuSelect').value;
            const itemCode = row.querySelector('.zaikoCode').value;
            const itemName = row.querySelector('.hinmokuName').value;
            const kikaku = row.querySelector('.kikaku').value;
            const suuryou = row.querySelector('.suuryou').value;

            // コンソールに行データ出力
            console.log(`行 ${index + 1}:`, {
                hinmokuID: hinmokuID,
                itemCode: itemCode,
                itemName: itemName,
                kikaku: kikaku,
                suuryou: suuryou,
            });

            // 必須値検証
            if (!hinmokuID || !suuryou) {
                alert('行 ' + (index + 1) + 'に必須値が不足しています。');
                isValid = false;
            }
        });

        if (!isValid) {
            event.preventDefault(); // 提出中断
        }
    });
});
</script>

<%@ include file="../includes/footer.jsp"%>
