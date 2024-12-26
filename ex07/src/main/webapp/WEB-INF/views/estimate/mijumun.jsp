<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<!-- CSS 파일 적용 -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/list.css">
<meta charset="UTF-8">
<title>未注文現況</title>
</head>
<body>
	<h1>未注文現況</h1>

	<table border="1">
		<thead>
			<tr>
				<th>日付-No.</th>
				<th>品目名(規格)</th>
				<th>数量</th>
				<th>未注文数量</th>
				<th>未注文供給金額</th>
				<th>取引先名</th>
				<th>摘要</th>
				<th>未注文付加税</th>
			</tr>

		</thead>

		<tbody>
			<c:forEach var="item" items="${getMijumun}">
				<tr>
					<td><a href="#"
						onclick="showModal('${item.hitsukeNo}', '${item.hinmokuMei}', '${item.kikaku}', '${item.suuryou}', '${item.mijumunsuuryou}', '${item.mijumunkyokyukingaku}', '${item.torihikisakiMei}', '${item.tekiyo}', '${item.mijumunbugase}')">${item.hitsukeNo}</a></td>
					<td>${item.hinmokuMei}[${item.kikaku}]</td>
					<td>${item.suuryou}</td>
					<td>${item.mijumunsuuryou}</td>
					<td>${item.mijumunkyokyukingaku}</td>
					<td>${item.torihikisakiMei}</td>
					<td>${item.tekiyo}</td>
					<td>${item.mijumunbugase}</td>
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
		<h2 style="margin-bottom: 20px; font-weight: bold;">未注文修正</h2>

		<!-- 데이터 출력 및 입력 필드 -->
		<div
			style="display: flex; flex-wrap: wrap; gap: 20px; margin-bottom: 20px;">
			<div style="flex: 1;">
				<label for="modalHitsukeNo">日付-No。:</label> <input type="text"
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
				<label for="modalMijumunsuuryou">未注文水量:</label> <input type="text"
					id="modalMijumunsuuryou">
			</div>
		</div>

		<div
			style="display: flex; flex-wrap: wrap; gap: 20px; margin-bottom: 20px;">
			<div style="flex: 1;">
				<label for="modalMijumunkyokyukingaku">未注文供給価額:</label> <input
					type="text" id="modalMijumunkyokyukingaku">
			</div>
			<div style="flex: 1;">
				<label for="modalTorihikisakiMei">取引先名:</label> <input type="text"
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
				<label for="modalTekiyo">適用:</label> <input type="text"
					id="modalTekiyo">
			</div>
			<div style="flex: 1;">
				<label for="modalMijumunbugase">米州文付加税:</label> <input type="text"
					id="modalMijumunbugase">
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

					<!-- 서버에서 전달된 데이터 출력 -->
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

					<!-- 추가 행 및 동적 추가 버튼 -->
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

		<!-- 버튼 그룹 -->
		<div style="text-align: right; margin-top: 20px;">
			<button type="button" onclick="saveData()"
				style="padding: 10px 20px; border: none; background: #007bff; color: white; border-radius: 5px; margin-right: 5px;">保存</button>
			<button type="button" onclick="closeModal()"
				style="padding: 10px 20px; border: none; background: #6c757d; color: white; border-radius: 5px;">閉じる</button>
		</div>
	</div>

	<script>
	function showModal(hitsukeNo, hinmokuMei, suuryou, mijumunsuuryou, mijumunkyokyukingaku, torihikisakiMei, tekiyo, mijumunbugase) {
	    document.getElementById("modalBackground").style.display = "block";
	    document.getElementById("modal").style.display = "block";

	    // 데이터 채우기
	    document.getElementById("modalHitsukeNo").value = hitsukeNo;
	    document.getElementById("modalHinmokuMei").value = hinmokuMei;
	    document.getElementById("modalSuuryou").value = suuryou;
	    document.getElementById("modalMijumunsuuryou").value = mijumunsuuryou;
	    document.getElementById("modalMijumunkyokyukingaku").value = mijumunkyokyukingaku;
	    document.getElementById("modalTorihikisakiMei").value = torihikisakiMei;
	    document.getElementById("modalTekiyo").value = tekiyo;
	    document.getElementById("modalMijumunbugase").value = mijumunbugase;
	}

	function closeModal() {
	    document.getElementById("modalBackground").style.display = "none";
	    document.getElementById("modal").style.display = "none";
	}

	function saveData() {
	    // 저장 로직 추가 (필요 시 AJAX 사용)
	    alert("データが保存されました.");
	    closeModal();
	}

</script>

	<script>
// 행 추가 기능
document.getElementById("dynamicTable").addEventListener("click", function(e) {
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

// 전체 체크박스 기능
document.getElementById("selectAll").addEventListener("change", function() {
    const isChecked = this.checked;
    document.querySelectorAll(".row-checkbox").forEach(checkbox => {
        checkbox.checked = isChecked;
    });
});
</script>

</body>
</html>
<%@ include file="../includes/footer.jsp"%>
