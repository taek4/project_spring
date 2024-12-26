<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- CSS 파일 적용 -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/list.css">
<meta charset="UTF-8">
<title>출하현황</title>
</head>
<body>
	<h1>출하현황</h1>
	<table border="1">
		<thead>
			<tr>
				<th>日付-No</th>
				<th>品目名(規格)</th>
				<th>数量</th>
				<th>倉庫名</th>
				<th>取引先名</th>
				<th>連絡先</th>
				<th>摘要</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="item" items="${getDelivery}">
				<tr>
					<td><a href="#"
						onclick="showModal(
                    '${item.hitsuke_No}', 
                    '${item.torihikisakiMei}', 
                    '${item.hinmokuMei}', 
                    '${item.suuryou}', 
                    '${item.tekiyo}'
                )">${item.hitsuke_No}</a>
					</td>
					<td>${item.hinmokuMei}${item.kikaku}</td>
					<td>${item.suuryou}</td>
					<td>${item.soukoMei}</td>
					<td>${item.torihikisakiMei}</td>
					<td>${item.yuubinBangou}</td>
					<td>${item.tekiyo}</td>
				</tr>
			</c:forEach>
		</tbody>

	</table>

	<!-- 모달 배경 -->
	<div id="modalBackground"
		style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); z-index: 999;"
		onclick="closeModal()"></div>

	<!-- 모달창 -->
	<div id="modal"
		style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 900px; background: white; border-radius: 10px; padding: 20px; z-index: 1000; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);">
		<!-- 모달 제목 -->
		<h2 style="margin-bottom: 20px; font-weight: bold;">出荷修正</h2>

		<!-- データ出力および入力フィールド -->
		<div
			style="display: flex; flex-wrap: wrap; gap: 20px; margin-bottom: 20px;">
			<div style="flex: 1;">
				<label for="modalHitsukeNo">日付-No.:</label> <input type="text"
					id="modalHitsukeNo" readonly>
			</div>
			<div style="flex: 1;">
				<label for="modalHinmokuMei">品目名(規格):</label> <input type="text"
					id="modalHinmokuMei" readonly>
				<button type="button" class="search-button"
					onclick="openTraderModal()">
					<i class="fas fa-search"></i>
				</button>
			</div>
		</div>

		<div
			style="display: flex; flex-wrap: wrap; gap: 20px; margin-bottom: 20px;">
			<div style="flex: 1;">
				<label for="modalSuuryou">数量:</label> <input type="text"
					id="modalSuuryou">
			</div>
			<div style="flex: 1;">
				<label for="modalMijumunsuuryou">単価:</label> <input type="text"
					id="modalTanka">
			</div>
		</div>

		<div
			style="display: flex; flex-wrap: wrap; gap: 20px; margin-bottom: 20px;">
			<div style="flex: 1;">
				<label for="modalMijumunkyokyukingaku">供給金額:</label> <input
					type="text" id="modalKyokyukingaku">
			</div>
			<div style="flex: 1;">
				<label for="modalTorihikisakiMei">取引先:</label> <input type="text"
					id="modalTorihikisakiMei">
				<button type="button" class="search-button"
					onclick="openTraderModal()">
					<i class="fas fa-search"></i>
				</button>
			</div>
		</div>

		<div
			style="display: flex; flex-wrap: wrap; gap: 20px; margin-bottom: 20px;">
			<div style="flex: 1;">
				<label for="modalTekiyo">摘要:</label> <input type="text"
					id="modalTekiyo">
			</div>
		</div>

		<!-- ボタングループ -->
		<div style="margin-bottom: 15px;">
			<button onclick="searchItems()">検索(F3)</button>
			<button onclick="sortItems()">並び替え</button>
			<button onclick="viewTransactionHistory()">取引履歴を見る(見積)</button>
			<button onclick="loadMyItems()">My品目</button>
			<button onclick="applyDiscount()">割引</button>
			<button onclick="loadInventory()">未注文在庫を読み込む</button>
			<button onclick="generateInvoice()">生成した伝票</button>
			<button onclick="scanBarcode()">バーコード</button>
			<button onclick="verifyData()">検証</button>
			<button onclick="calculateProfit()">利益計算</button>
			<button onclick="loadVoucher()">伝票を読み込む</button>
		</div>

		<!-- テーブル 見積、注文、販売 -->
		<div class="table-container">
			<table id="dynamicTable">
				<thead>
					<tr>
						<th><input type="checkbox" id="selectAll" /></th>
						<th>品目コード</th>
						<th>品目名</th>
						<th>規格</th>
						<th>数量</th>
						<th>単価</th>
						<th>供給金額</th>
						<th>付加税</th>
					</tr>
				</thead>
				<tbody>
					<!-- サーバーから提供されたデータ出力 -->
					<c:forEach var="item" items="${commonHinmokuList}">
						<tr>
							<td><input type="checkbox" class="row-checkbox" /></td>
							<td contenteditable="true">${item.itemCode}</td>
							<td contenteditable="true">${item.itemName}</td>
							<td contenteditable="true">${item.kikaku}</td>
							<td contenteditable="true">${item.suuryou}</td>
							<td contenteditable="true">${item.tanka}</td>
							<td contenteditable="true">${item.kyoukyuKingaku}</td>
							<td contenteditable="true">${item.bugase}</td>
						</tr>
					</c:forEach>

					<!-- 追加行および動的追加ボタン -->
					<tr class="editable-row">
						<td><input type="checkbox" class="row-checkbox" /></td>
						<td contenteditable="true"></td>
						<td contenteditable="true"></td>
						<td contenteditable="true"></td>
						<td contenteditable="true"></td>
						<td contenteditable="true"></td>
						<td contenteditable="true"></td>
						<td contenteditable="true"></td>
					</tr>
					<tr>
						<td class="add-row-btn" colspan="8"
							style="text-align: center; cursor: pointer;">+</td>
					</tr>
				</tbody>
			</table>
		</div>

		<!-- ボタングループ -->
		<div style="text-align: right; margin-top: 20px;">
			<button type="button" onclick="saveData()"
				style="padding: 10px 20px; border: none; background: #007bff; color: white; border-radius: 5px; margin-right: 5px;">保存</button>
			<button type="button" onclick="closeModal()"
				style="padding: 10px 20px; border: none; background: #6c757d; color: white; border-radius: 5px;">閉じる</button>
		</div>


<script>
    function showModal(hitsukeNo, torihikisakiMei, hinmokuMei, suuryou, tanka, kyoukyuKingaku, tekiyo) {
        // DOM要素の取得及び存在確認
        const hitsukeNoField = document.getElementById("modalHitsukeNo");
        const traderField = document.getElementById("modalTorihikisakiMei");
        const itemField = document.getElementById("modalHinmokuMei");
        const quantityField = document.getElementById("modalSuuryou");
        const unitPriceField = document.getElementById("modalTanka");
        const supplyAmountField = document.getElementById("modalKyokyukingaku");
        const summaryField = document.getElementById("modalTekiyo");

        if (!hitsukeNoField || !traderField || !itemField || !quantityField || ！unitPriceField || !supplyAmountField || !summaryField) {
            console.error("モーダルウィンドウ フィールドが存在しません.");
            return;
        }

        // データ設定
        hitsukeNoField.value = hitsukeNo || ""; // 빈값 방지
        traderField.value = torihikisakiMei || "";
        itemField.value = hinmokuMei || "";
        quantityField.value = suuryou || "";
        unitPriceField.value = tanka || "";
        supplyAmountField.value = kyoukyuKingaku || "";
        summaryField.value = tekiyo || "";

        // モーダルウィンドウ表示
        document.getElementById("modalBackground")。style.display = "block";
        document.getElementById("modal")。style.display = "block";
    }

    function closeModal() {
        // モダルチャンかくし
        document.getElementById("modalBackground")。style.display = "none";
        document.getElementById("modal")。style.display = "none";
    }
</script>

		<script>
// 行追加機能
document.getElementById("dynamicTable")。addEventListener("click", function(e) {
    if (e.target && e.target.classList.contains("add-row-btn")) {
        const newRow = document.createElement("tr");
        newRow.innerHTML = `
            <td><input type="checkbox" class="row-checkbox" /></td>
            <td contenteditable="true"></td>
            <td contenteditable="true"></td>
            <td contenteditable="true"></td>
            <td contenteditable="true"></td>
            <td contenteditable="true"></td>
            <td contenteditable="true"></td>
            <td contenteditable="true"></td>
        `;
        const addButtonRow = e.target.parentElement; // 현재 '+ 버튼' 행
        e.target.parentElement.parentElement.insertBefore(newRow, addButtonRow);
    }
});

// 全体 チェックボックス 機能
document.getElementById("selectAll")。addEventListener("change", function() {
    const isChecked = this.checked;
    document.querySelectorAll(".row-checkbox")。forEach(checkbox => {
        checkbox.checked = isChecked;
    });
});
</script>

	</div>

</body>
</html>
<%@ include file="../includes/footer.jsp"%>