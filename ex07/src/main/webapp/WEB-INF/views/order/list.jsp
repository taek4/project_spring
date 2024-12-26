<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>
<!-- CSS 파일 적용 -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/list.css">
<meta charset="UTF-8">
<!-- JS 파일 적용 -->
<script src="<%=request.getContextPath()%>/resources/js/list.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<div class="container-fluid px-4">
	<h1 class="mt-4">注文書照会</h1>

	<!-- 검색 폼 -->
	<form class="d-flex mb-4" method="get"
		action="<c:url value='/order/list' />">
		<input class="form-control me-2" type="text" name="search"
			placeholder="検索ワードを入力してください···" />
		<button class="btn btn-primary" type="submit">検索</button>
	</form>

	<!-- 테이블 -->
	<table class="table table-bordered">
		<thead class="table-light">
			<tr>
				<th>日付-No.</th>
				<!-- 일자-No. -->
				<th>取引先名</th>
				<!-- 거래처명 -->
				<th>担当者名</th>
				<!-- 담당자명 -->
				<th>品目名</th>
				<!-- 품목명 -->
				<th>納期日</th>
				<!-- 납기일자 -->
				<th>注文金額合計</th>
				<!-- 주문금액합계 -->
				<th>進行状況</th>
				<!-- 진행상태 -->
				<th>作成済み伝票</th>
				<!-- 생성한 전표 -->
				<th>印刷</th>
				<!-- 인쇄 -->
			</tr>

		</thead>
		<tbody>
			<c:forEach var="item" items="${orderList}">
				<tr>
					<!-- 일자-No (모달창 열리는 링크 추가) -->
					<td><a href="#"
						onclick="showModal(
                       '${item.hitsukeNo}',
                       '${item.torihikisakiMei}',
                       '${item.tantoushaMei}',
                       '${item.hinmokuMei}',
                       '${item.jumunKingakuGoukei}',
                       '${item.status}'
                   ); return false;">
							${item.hitsukeNo} </a></td>

					<!-- 거래처명 -->
					<td>${item.torihikisakiMei}</td>

					<!-- 담당자명 -->
					<td>${item.tantoushaMei}</td>

					<!-- 품목명 -->
					<td><c:choose>
							<c:when test="${item.otherHinmokuCount == 0}">
                        ${item.hinmokuMei}
                    </c:when>
							<c:otherwise>
                        ${item.hinmokuMei} 以外 ${item.otherHinmokuCount}個
                    </c:otherwise>
						</c:choose></td>

					<!-- 납기일자 -->
					<td>${item.noukiIchija}</td>

					<!-- 주문금액합계 -->
					<td>${item.jumunKingakuGoukei}</td>

					<!-- 진행상태 -->
					<td>${item.status}</td>

					<!-- 생성한 전표 (더미 링크) -->
					<td><a class="btn btn-link" href="#">照会</a></td>

					<!-- 인쇄 (더미 링크) -->
					<td><a class="btn btn-link" href="#">印刷</a></td>
				</tr>
			</c:forEach>
		</tbody>

	</table>

	<!-- 하단 버튼 -->
	<div class="mt-4">
		<button class="btn btn-success"
			onclick="location.href='<c:url value='/order/new' />'">신규</button>
		<button class="btn btn-danger">選択削除</button>
		<button class="btn btn-secondary">エクセルダウンロード</button>
	</div>
</div>

<!-- 모달 배경 -->
<div id="modalBackground"
	style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); z-index: 999;"
	onclick="closeModal()"></div>

<!-- 모달창 -->
<div id="modal"
	style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 900px; background: white; border-radius: 10px; padding: 20px; z-index: 1000;">
	<!-- 모달 제목 -->
	<h2 style="margin-bottom: 15px;">注文書修正</h2>

	<!-- 첫 번째 줄 -->
	<div
		style="display: flex; flex-wrap: wrap; gap: 10px; margin-bottom: 15px;">
		<div style="flex: 1;">
			<label>日付:</label>
			<div class="input-group">
				<input type="text" id="date" readonly placeholder="日付">
			</div>
		</div>
		<div style="flex: 1;">
			<label>取引先:</label>
			<div class="input-group">
				<input type="text" id="trader" placeholder="取引先 入力">
				<button type="button" class="search-button"
					onclick="openTraderModal()">
					<i class="fas fa-search"></i>
				</button>
			</div>
		</div>
	</div>

	<!-- 두 번째 줄 -->
	<div
		style="display: flex; flex-wrap: wrap; gap: 10px; margin-bottom: 15px;">
		<div style="flex: 1;">
			<label>担当者:</label>
			<div class="input-group">
				<input type="text" id="manager" placeholder="担当者 入力">
				<button type="button" class="search-button"
					onclick="openManagerModal()">
					<i class="fas fa-search"></i>
				</button>
			</div>
		</div>

		<div style="flex: 1;">
			<label>倉庫:</label>
			<div class="input-group">
				<input type="text" id="warehouse" placeholder="倉庫 入力">
				<button type="button" class="search-button"
					onclick="openWarehouseModal()">
					<i class="fas fa-search"></i>
				</button>
			</div>
		</div>

	</div>

	<!-- 세 번째 줄 -->
	<div
		style="display: flex; flex-wrap: wrap; gap: 10px; margin-bottom: 15px;">
		<div style="flex: 1;">
			<label>取引タイプ:</label>
			<div class="input-group">
				<input type="text" id="transactionType" placeholder="取引タイプ">
			</div>
		</div>
		<div style="flex: 1;">
			<label>通話:</label>
			<div class="input-group">
				<input type="text" id="currency" placeholder="通話">
			</div>
		</div>
	</div>

	<!-- 네 번째 줄 -->
	<div
		style="display: flex; flex-wrap: wrap; gap: 10px; margin-bottom: 15px;">
		<div style="flex: 1;">
			<label>プロジェクト:</label>
			<div class="input-group">
				<input type="text" id="project" placeholder="プロジェクト">
				<button type="button" class="search-button"
					onclick="openProjectModal()">
					<i class="fas fa-search"></i>
				</button>
			</div>
		</div>
		<div style="flex: 1;">
			<label>プロジェクト 入力:</label>
			<div class="input-group">
				<input type="text" id="newItem" placeholder="プロジェクト 入力">
			</div>
		</div>
	</div>

	<!-- 다섯 번째 줄 -->
	<div
		style="display: flex; flex-wrap: wrap; gap: 10px; margin-bottom: 15px;">
		<div style="flex: 1;">
			<label>添付:</label>
			<div class="input-group">
				<input type="file" id="attachment">
			</div>
		</div>
	</div>

	<!-- 버튼 그룹 -->
	<div style="margin-bottom: 15px;">
		<button onclick="searchItems()">検索(F3)</button>
		<!-- 찾기 -->
		<button onclick="sortItems()">並べ替え</button>
		<!-- 정렬 -->
		<button onclick="viewTransactionHistory()">取引履歴を見る(見積)</button>
		<!-- 거래내역보기(견적) -->
		<button onclick="loadMyItems()">My品目</button>
		<!-- My품목 -->
		<button onclick="applyDiscount()">割引</button>
		<!-- 할인 -->
		<button onclick="loadInventory()">在庫を読み込む</button>
		<!-- 재고 불러오기 -->
		<button onclick="generateInvoice()">生成された伝票</button>
		<!-- 생성한 전표 -->
		<button onclick="scanBarcode()">バーコード</button>
		<!-- 바코드 -->
		<button onclick="verifyData()">検証</button>
		<!-- 검증 -->
		<button onclick="calculateProfit()">利益計算</button>
		<!-- 이익계산 -->
		<button onclick="loadVoucher()">伝票を読み込む</button>
		<!-- 전표 불러오기 -->
	</div>


	<!-- 창고 검색 모달 -->
	<div id="warehouseModal" class="modal fade" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<!-- 모달 헤더 -->
				<div class="modal-header">
					<h5 class="modal-title">倉庫検索</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<!-- 모달 본문 -->
				<div class="modal-body">
					<!-- 검색 입력 -->
					<input type="text" id="warehouseSearchInput"
						class="form-control mb-3" placeholder="検索ワード入力">
					<!-- 창고 데이터 테이블 -->
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>倉庫 ID</th>
								<th>倉庫名</th>
							</tr>
						</thead>
						<c:forEach var="souko" items="${soukoList}">
							<tr>
								<td>${souko.soukoID}</td>
								<td>${souko.soukomei}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<!-- 모달 푸터 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">閉じる</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 거래처 검색 모달 -->
	<div id="traderModal" class="modal fade" tabindex="-1" role="dialog"
		aria-labelledby="traderModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<!-- 모달 헤더 -->
				<div class="modal-header">
					<h5 class="modal-title" id="traderModalLabel">取引先検索</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<!-- 모달 본문 -->
				<div class="modal-body">
					<input type="text" id="traderSearchInput" class="form-control mb-3"
						placeholder="取引先を入力してください">
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>取引先ID</th>
								<th>取引先名</th>
							</tr>
						</thead>
						<c:forEach var="torihikisaki" items="${torihikisakiList}">
							<tr>
								<td>${torihikisaki.torihikisakiID}</td>
								<td>${torihikisaki.torihikisakimei}</td>
							</tr>
						</c:forEach>

					</table>
				</div>
				<!-- 모달 푸터 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 담당자 검색 모달 -->
	<div id="managerModal" class="modal fade" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<!-- 모달 헤더 -->
				<div class="modal-header">
					<h5 class="modal-title">担当者検索</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<!-- 모달 본문 -->
				<div class="modal-body">
					<!-- 검색 입력 -->
					<input type="text" id="managerSearchInput"
						class="form-control mb-3" placeholder="担当者名を入力してください">
					<!-- 담당자 데이터 테이블 -->
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>担当者ID</th>
								<th>担当者名</th>
							</tr>
						</thead>
						<c:forEach var="tantousha" items="${tantoushaList}">
							<tr>
								<td>${tantousha.tantoushaID}</td>
								<td>${tantousha.tantoushamei}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<!-- 모달 푸터 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 프로젝트 검색 모달 -->
	<div id="projectModal" class="modal fade" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<!-- 모달 헤더 -->
				<div class="modal-header">
					<h5 class="modal-title">プロジェクト検索</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<!-- 모달 본문 -->
				<div class="modal-body">
					<!-- 검색 입력 -->
					<input type="text" id="projectSearchInput"
						class="form-control mb-3" placeholder="プロジェクト名を入力してください">
					<!-- 프로젝트 데이터 테이블 -->
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>プロジェクトID</th>
								<th>プロジェクト名</th>
							</tr>
						</thead>
						<c:forEach var="project" items="${projectList}">
							<tr>
								<td>${project.projectID}</td>
								<td>${project.projectMeimei}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<!-- 모달 푸터 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 테이블 견적, 주문, 판매 -->
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
					<th>供給額</th>
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
				<tr class="add-row-btn">
					<td colspan="8" style="text-align: center; cursor: pointer;">+</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- 하단 버튼 -->
	<div style="text-align: right;">
		<button id="saveButton">保有</button>
		<button onclick="closeModal()">閉じる</button>
	</div>

	<script>
document.addEventListener("DOMContentLoaded", function () {
    const tableBody = document.querySelector("#dynamicTable tbody");

    // 처음 10개까지만 표시
    const limitRows = () => {
        const rows = tableBody.querySelectorAll("tr:not(.add-row-btn)");
        rows.forEach((row, index) => {
            row.style.display = index < 10 ? "" : "none";
        });
    };

    // 동적 행 추가
    tableBody.addEventListener("click", function (e) {
        if (e.target && e.target.parentElement.classList.contains("add-row-btn")) {
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
            tableBody.insertBefore(newRow, e.target.parentElement);
            limitRows(); // 행 추가 후 다시 제한 적용
        }
    });

    // 전체 체크박스 선택
    document.getElementById("selectAll").addEventListener("change", function () {
        const isChecked = this.checked;
        document.querySelectorAll(".row-checkbox").forEach(checkbox => {
            checkbox.checked = isChecked;
        });
    });

    // 초기 행 제한 적용
    limitRows();
});
</script>


	<!-- jQuery (선택사항) -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	<!-- Bootstrap JS 및 JavaScript -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

	<script>
    // 창고 데이터 로드 함수
    function loadSoukoData() {
        fetch("/estimate/souko/list")
            .then(response => response.json())
            .then(function(data) {
                const tableBody = document.getElementById("warehouseTableBody");
                tableBody.innerHTML = ""; // 기존 데이터 초기화

                data.forEach(function(item) {
                    const row = '<tr onclick="selectWarehouse(\'' + item.soukoID + '\', \'' + item.soukomei + '\')">' +
                                '<td>' + item.soukoID + '</td>' +
                                '<td>' + item.soukomei + '</td>' +
                                '</tr>';
                    tableBody.innerHTML += row;
                });
            })
            .catch(function(error) {
                console.error("창고 데이터를 가져오는 중 오류:", error);
            });
    }

    // 거래처 데이터 로드 함수
    function loadTorihikisakiData() {
        fetch("/estimate/torihikisaki")
            .then(response => response.json())
            .then(function(data) {
                const tableBody = document.getElementById("traderTableBody");
                tableBody.innerHTML = ""; // 기존 데이터 초기화

                data.forEach(function(item) {
                    const row = '<tr onclick="selectTrader(\'' + item.torihikisakiID + '\', \'' + item.torihikisakimei + '\')">' +
                                '<td>' + item.torihikisakiID + '</td>' +
                                '<td>' + item.torihikisakimei + '</td>' +
                                '</tr>';
                    tableBody.innerHTML += row;
                });
            })
            .catch(function(error) {
                console.error("거래처 데이터를 가져오는 중 오류:", error);
            });
    }

    // 담당자 데이터 로드 함수
    function loadTantoushaData() {
        fetch("/estimate/tantousha/list")
            .then(response => response.json())
            .then(function(data) {
                const tableBody = document.getElementById("managerTableBody");
                tableBody.innerHTML = ""; // 기존 데이터 초기화

                data.forEach(function(item) {
                    const row = '<tr onclick="selectManager(\'' + item.tantoushaID + '\', \'' + item.tantoushamei + '\')">' +
                                '<td>' + item.tantoushaID + '</td>' +
                                '<td>' + item.tantoushamei + '</td>' +
                                '</tr>';
                    tableBody.innerHTML += row;
                });
            })
            .catch(function(error) {
                console.error("담당자 데이터를 가져오는 중 오류:", error);
            });
    }

    // 프로젝트 데이터 로드 함수
    function loadProjectData() {
        fetch("/estimate/project/list")
            .then(response => response.json())
            .then(function(data) {
                const tableBody = document.getElementById("projectTableBody");
                tableBody.innerHTML = ""; // 기존 데이터 초기화

                data.forEach(function(item) {
                    const row = '<tr onclick="selectProject(\'' + item.projectID + '\', \'' + item.projectMeimei + '\')">' +
                                '<td>' + item.projectID + '</td>' +
                                '<td>' + item.projectMeimei + '</td>' +
                                '</tr>';
                    tableBody.innerHTML += row;
                });
            })
            .catch(function(error) {
                console.error("프로젝트 데이터를 가져오는 중 오류:", error);
            });
    }

    // 선택된 값 처리 함수들
    function selectWarehouse(id, name) {
        document.getElementById("warehouse").value = id + " - " + name;
    }

    function selectTrader(id, name) {
        document.getElementById("trader").value = id + " - " + name;
    }

    function selectManager(id, name) {
        document.getElementById("manager").value = id + " - " + name;
    }

    function selectProject(id, name) {
        alert("選択されたプロジェクト: " + name);
        document.getElementById("project").value = id + " - " + name;
        closeModal("projectModal");
    }

    // 모달 열기 함수
    function openTraderModal() {
        const modalElement = document.getElementById("traderModal");
        const modal = new bootstrap.Modal(modalElement, { backdrop: "static" });
        modal.show();
        loadTorihikisakiData();
    }

    function openManagerModal() {
        const modalElement = document.getElementById("managerModal");
        const modal = new bootstrap.Modal(modalElement, { backdrop: "static" });
        modal.show();
        loadTantoushaData();
    }

    function openWarehouseModal() {
        const modalElement = document.getElementById("warehouseModal");
        const modal = new bootstrap.Modal(modalElement, { backdrop: "static" });
        modal.show();
        loadSoukoData();
    }

    function openProjectModal() {
        const modalElement = document.getElementById("projectModal");
        const modal = new bootstrap.Modal(modalElement, { backdrop: "static" });
        modal.show();
        loadProjectData();
    }

    // 모달 닫기 함수
    function closeModal(modalId) {
        const modalElement = document.getElementById(modalId);
        const modal = bootstrap.Modal.getInstance(modalElement);
        modal.hide();
    }
</script>

	<script>
	function showModal(hitsukeNo, trader, manager, hinmokuMei, gokeiKingaku, zeikomikubun) {
	    // 모달 표시
	    document.getElementById("modalBackground").style.display = "block";
	    document.getElementById("modal").style.display = "block";

	    // 필드 데이터 설정
	    document.getElementById("date").value = hitsukeNo;
	    document.getElementById("trader").value = trader;
	    document.getElementById("manager").value = manager;
	    document.getElementById("transactionType").value = gokeiKingaku;
	    document.getElementById("currency").value = zeikomikubun;

	    // 테이블 데이터를 로드하고 삽입
	    loadCommonHinmokuData(hinmokuMei);
	}

	// 공통 품목 데이터 로드 및 테이블 삽입
	var commonHinmokuData = []; // 데이터를 저장할 배열

	// "+" 버튼 행 추가
	function addPlusRow() {
	    var tableBody = document.querySelector("#dynamicTable tbody");

	    // "+" 버튼 행이 중복으로 추가되지 않도록 기존 "+" 버튼 삭제
	    var existingPlusRow = tableBody.querySelector(".add-row-btn");
	    if (existingPlusRow) {
	        existingPlusRow.remove();
	    }

	    var addRowButtonRow = document.createElement("tr");
	    addRowButtonRow.innerHTML = "<td class='add-row-btn' colspan='8' style='text-align: center; cursor: pointer;' onclick='addNewRow()'>+</td>";
	    tableBody.appendChild(addRowButtonRow);
	}

	// 데이터 로드 및 "+" 버튼 추가
	function loadCommonHinmokuData(hinmokuID) {
	    fetch("/estimate/commonHinmoku?hinmokuID=" + hinmokuID)
	        .then(function(response) {
	            return response.json();
	        })
	        .then(function(data) {
	            commonHinmokuData = data; // 데이터를 전역 변수에 저장
	            var tableBody = document.querySelector("#dynamicTable tbody");
	            tableBody.innerHTML = ""; // 기존 테이블 데이터 초기화

	            // 서버에서 받은 데이터를 기반으로 테이블 행 생성
	            for (var i = 0; i < data.length && i < 10; i++) {
	                addNewRow(data[i]); // 기존 데이터를 기반으로 행 추가
	            }

	            // "+" 버튼 행 추가
	            addPlusRow();
	        })
	        .catch(function(error) {
	            console.error("데이터 로드 오류:", error);
	            alert("데이터를 불러오는 중 오류가 발생했습니다.");
	        });
	}

	// 행 추가 함수
	function addNewRow(item) {
	    var tableBody = document.querySelector("#dynamicTable tbody");
	    var row = document.createElement("tr");

	    var rowContent = "<td><input type='checkbox' class='row-checkbox' onchange='toggleDropdown(this)' />" +
	        "<select class='item-dropdown' style='display: none;' onchange='selectItem(this, this.value)'>" +
	        "<option value=''>選択</option>";

	    // 공통 품목 데이터 옵션 생성
	    for (var j = 0; j < commonHinmokuData.length; j++) {
	        var optionItem = commonHinmokuData[j];
	        rowContent += "<option value='" + JSON.stringify(optionItem) + "'>" +
	            (optionItem.itemCode || '') + " - " + (optionItem.itemName || '') + "</option>";
	    }

	    rowContent += "</select></td>" +
	        "<td class='item-code'>" + (item ? item.itemCode : '') + "</td>" +
	        "<td class='item-name'>" + (item ? item.itemName : '') + "</td>" +
	        "<td class='item-kikaku'>" + (item ? item.kikaku : '') + "</td>" +
	        "<td class='item-suuryou'>" + (item ? item.suuryou : '') + "</td>" +
	        "<td class='item-tanka'>" + (item ? item.tanka : '') + "</td>" +
	        "<td class='item-kyoukyuKingaku'>" + (item ? item.kyoukyuKingaku : '') + "</td>" +
	        "<td class='item-bugase'>" + (item ? item.bugase : '') + "</td>";

	    row.innerHTML = rowContent;
	    tableBody.appendChild(row);

	    // "+" 버튼 행을 항상 맨 마지막에 유지
	    addPlusRow();
	}

	// "+" 버튼 추가 및 클릭 이벤트 연결
	document.querySelector(".add-row-btn").addEventListener("click", function() {
	    addNewRow(); // 빈 행 추가
	});


	// 체크박스 선택 시 드롭다운 표시/숨기기
	function toggleDropdown(checkbox) {
	    var dropdown = checkbox.nextElementSibling;
	    if (checkbox.checked) {
	        dropdown.style.display = "inline-block";
	    } else {
	        dropdown.style.display = "none";
	    }
	}

	// 드롭다운에서 항목 선택 시 입력 필드 채우기
	function selectItem(select, value) {
	    if (value) {
	        var data = JSON.parse(value);
	        var row = select.closest("tr");

	        row.querySelector(".item-code").innerText = data.itemCode || '';
	        row.querySelector(".item-name").innerText = data.itemName || '';
	        row.querySelector(".item-kikaku").innerText = data.kikaku || '';
	        row.querySelector(".item-suuryou").innerText = data.suuryou || '';
	        row.querySelector(".item-tanka").innerText = data.tanka || '';
	        row.querySelector(".item-kyoukyuKingaku").innerText = data.kyoukyuKingaku || '';
	        row.querySelector(".item-bugase").innerText = data.bugase || '';
	    }
	}

	// 모달 닫기 함수
	function closeModal() {
	    document.getElementById("modal").style.display = "none";
	    document.getElementById("modalBackground").style.display = "none";
	};
	</script>

	<%@ include file="../includes/footer.jsp"%>