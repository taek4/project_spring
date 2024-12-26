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
<!-- JS 파일 적용 -->
<script src="<%=request.getContextPath()%>/resources/js/list.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>見積書照会</title>
<script>
const variableName = "value"; // 초기화
</script>
</head>
<body>
	<div class="container">
		<header>
			<h1>見積書照会</h1>
		</header>

		<!-- 견적서 목록 테이블 -->
		<table class="table">
			<thead>
				<tr>
					<th>日付-No。</th>
					<th>取引先名</th>
					<th>担当者名</th>
					<th>品目名</th>
					<th>有効期間</th>
					<th>見積金額合計</th>
					<th>進行状態</th>
					<th>生成した伝票</th>
					<th>印刷</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="item" items="${getlist}">
					<tr>
						<td><a value=${item.hitsukeNoRefertype } href="#"
							onclick="showModal(
                       '${item.hitsukeNo}',
                       '${item.torihikisakiMei}',
                       '${item.tantoushaMei}',
                       '${item.hinmokuMei}',
                       '${item.gokeiKingaku}',
                       '${item.zeikomikubun}' )
                       ">
								${item.hitsukeNo} </a></td>
						<td>${item.torihikisakiMei}</td>
						<td>${item.tantoushaMei}</td>
						<td><c:choose>
								<c:when test="${item.otherHinmokuCount == 0}">
            ${item.hinmokuMei}
        </c:when>
								<c:otherwise>
            ${item.hinmokuMei} 以外 ${item.otherHinmokuCount}個
        </c:otherwise>
							</c:choose></td>

						<td>${item.sakuseibi}</td>
						<!-- sakuseibi 바로 출력 -->
						<td>${item.gokeiGaku}</td>
						<td><select
							onchange="updateStatus(this.value, '${item.mitsumorishoID}')">
								<option value="未確認" ${item.status == '未確認' ? 'selected' : ''}>未確認</option>
								<option value="確認" ${item.status == '確認' ? 'selected' : ''}>確認</option>
								<option value="進行中" ${item.status == '進行中' ? 'selected' : ''}>進行中
								</option>
								<option value="完了" ${item.status == '完了' ? 'selected' : ''}>完了</option>
						</select></td>

						<td><a href="#"
							onclick="openModal(${item.mitsumorishoID}); return false;">照会</a>
						<td>
							<!-- 인쇄 버튼 --> <a href="#"
							onclick="printContent(${item.mitsumorishoID}); return false;">印刷</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<!-- 하단 버튼 -->
		<div class="footer-buttons">
			<button class="btn">新規(F2)</button>
			<button class="btn">履歴照会</button>
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
		<h2 style="margin-bottom: 15px;">見積書修正</h2>

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
						<input type="text" id="traderSearchInput"
							class="form-control mb-3" placeholder="거래처명을 입력하세요">
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
						<!-- 품목코드 -->
						<th>品目名</th>
						<!-- 품목명 -->
						<th>規格</th>
						<!-- 규격 -->
						<th>数量</th>
						<!-- 수량 -->
						<th>単価</th>
						<!-- 단가 -->
						<th>供給額</th>
						<!-- 공급가액 -->
						<th>付加税</th>
						<!-- 부가세 -->
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
		<!-- 하단 버튼 -->
		<div style="text-align: right;">
			<button id="saveButton">保有</button>
			<button onclick="closeModal()">閉じる</button>
		</div>
	</div>

	<!-- 생성한 전표 조회 모달 -->
	<div id="listModal" class="modal fade" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<!-- 모달 헤더 -->
				<div class="modal-header">
					<h5 class="modal-title">生成した伝票照会</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<!-- 모달 본문 -->
				<div class="modal-body">
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>品目コード</th>
								<!-- 품목코드 -->
								<th>品目名</th>
								<!-- 품목명 -->
								<th>規格</th>
								<!-- 규격 -->
								<th>数量</th>
								<!-- 수량 -->
								<th>残量</th>
								<!-- 잔량 -->
								<th>生成した伝票</th>
								<!-- 생성한 전표 -->
							</tr>

						</thead>
						<tbody id="listModalTableBody">
							<!-- AJAX를 통해 데이터 로드 -->
						</tbody>
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
	// 견적서 수정 모달 열기 및 데이터 로드
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
	            for (var i = 0; i < 10; i++) {
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
	}
	// 저장 버튼 이벤트 바인딩
	document.addEventListener("DOMContentLoaded", function () {
    var saveButton = document.getElementById("saveButton");
    if (saveButton) {
        saveButton.addEventListener("click", saveModalData);
    } else {
        console.error("saveButton 요소를 찾을 수 없습니다.");
    }
});


	function saveModalData() {
	    var mitsumorishoVO = {
	        commonHinmokuList: []
	    };

	    // 모든 행 데이터 수집
	    var rows = document.querySelectorAll("#dynamicTable tbody tr");
	    for (var i = 0; i < rows.length; i++) {
	        var row = rows[i];
	        
	        // 각 행의 데이터 추출
	        var hinmokuID = row.querySelector(".item-code") ? row.querySelector(".item-code").innerText.trim() : null;
	        if (!hinmokuID) {
	            // 필수값이 없으면 무시
	            continue;
	        }

	        var hinmoku = {
	            commonHinmokuID: row.getAttribute("data-common-hinmoku-id") || null,
	            hinmokuID: hinmokuID,
	            hitsukeNo: document.getElementById("date").value,
	            suuryou: row.querySelector(".item-suuryou") ? row.querySelector(".item-suuryou").innerText.trim() : "0",
	            tanka: row.querySelector(".item-tanka") ? row.querySelector(".item-tanka").innerText.trim() : "0",
	            kyoukyuKingaku: row.querySelector(".item-kyoukyuKingaku") ? row.querySelector(".item-kyoukyuKingaku").innerText.trim() : "0",
	            bugase: row.querySelector(".item-bugase") ? row.querySelector(".item-bugase").innerText.trim() : "0",
	            itemCode: hinmokuID,
	            itemName: row.querySelector(".item-name") ? row.querySelector(".item-name").innerText.trim() : null,
	            kikaku: row.querySelector(".item-kikaku") ? row.querySelector(".item-kikaku").innerText.trim() : null
	        };

	        mitsumorishoVO.commonHinmokuList.push(hinmoku);
	    }


	    // 서버로 데이터 전송
	    fetch("/estimate/modalsave", {
	        method: "POST",
	        headers: {
	            "Content-Type": "application/json"
	        },
	        body: JSON.stringify(mitsumorishoVO)
	    })
	    .then(function(response) {
	        if (response.ok) {
	            alert("保有しました！");
	            location.reload(); // 페이지 새로고침
	        } else {
	            response.text().then(function(message) {
	                alert("貯蔵 失敗: " + message);
	            });
	        }
	    })
	    .catch(function(error) {
	        console.error("저장 중 오류 발생:", error);
	        alert("저장 중 오류가 발생했습니다.");
	    });
	}

</script>

	<script>
	function updateStatus(newStatus, mitsumorishoId) {
	    if (!mitsumorishoId) {
	        console.error("mitsumorishoId가 정의되지 않았습니다.");
	        alert("mitsumorishoId 값이 올바르지 않습니다.");
	        return;
	    }

	    $.ajax({
	        url: '/estimate/update',
	        type: 'POST',
	        data: {
	            mitsumorishoId: mitsumorishoId,
	            status: newStatus,
	            limit: 10
	        },
	        success: function(response) {
	            alert("ステータスが正常に更新されました: " + newStatus);
	            window.location.reload(); // 페이지 새로고침
	        },
	        error: function(xhr, status, error) {
	            alert("アップデート失敗: " + error);
	            console.log("mitsumorishoId:", mitsumorishoId, "status:", newStatus);
	        }
	    });
	}


	</script>

	<script>
    // ボタン機能関数
    function searchItems() {
        alert("検索(F3)機能を実行します。");
        // 検索ロジックを追加
    }

    function sortItems() {
        alert("並べ替え機能を実行します。");
        // 並べ替えロジックを追加
    }

    function viewTransactionHistory() {
        alert("取引履歴(見積)を表示します。");
        // 取引履歴表示ロジックを追加
    }

    function loadMyItems() {
        alert("My品目を読み込みます。");
        // My品目読み込みロジックを追加
    }

    function applyDiscount() {
        alert("割引機能を適用します。");
        // 割引適用ロジックを追加
    }

    function loadInventory() {
        alert("在庫を読み込みます。");
        // 在庫読み込みロジックを追加
    }

    function generateInvoice() {
        alert("生成した伝票を確認します。");
        // 生成した伝票確認ロジックを追加
    }

    function scanBarcode() {
        alert("バーコードスキャン機能を実行します。");
        // バーコードロジックを追加
    }

    function verifyData() {
        alert("データを検証します。");
        // データ検証ロジックを追加
    }

    function calculateProfit() {
        alert("利益を計算します。");
        // 利益計算ロジックを追加
    }

    function loadVoucher() {
        alert("伝票を読み込みます。");
        // 伝票読み込みロジックを追加
    }
</script>


	<script>
    // 모달 열기 및 데이터 로드
function openModal(mitsumorishoID) {
    const modalElement = document.getElementById("listModal");
    const modal = new bootstrap.Modal(modalElement);

    // 모달 표시
    modal.show();

   
    // 생성한 전표 데이터 로드
    fetch("/estimate/getDetail?limit=10")
    .then(function(response) {
        if (!response.ok) {
            throw new Error("HTTP Error! Status: " + response.status);
        }
        return response.json();
    })
    .then(function(data) {
        console.log("서버에서 받은 데이터:", data); // 응답 데이터 확인

        var tableBody = document.getElementById("listModalTableBody");
        tableBody.innerHTML = ""; // 기존 데이터 초기화

        if (!data || data.length === 0) {
            tableBody.innerHTML = "<tr><td colspan='6' class='text-center'>데이터가 없습니다.</td></tr>";
            return;
        }

        data.forEach(function(item) {
            var row = document.createElement("tr");
            var rowContent = "" +
                "<td>" + (item.hinmokumei || "-") + "</td>" +
                "<td>" + (item.kikaku || "-") + "</td>" +
                "<td>" + (item.suryou || "-") + "</td>" +
                "<td>" + (item.zanryou || "-") + "</td>" +
                "<td>" + (item.gokeiGaku || "-") + "</td>" +
                "<td>" + (item.sakuseisha || "-") + "</td>";
            row.innerHTML = rowContent;
            tableBody.appendChild(row);
        });
    })
    .catch(function(error) {
        console.error("데이터 로드 오류:", error);
        alert("데이터를 불러오는 중 오류가 발생했습니다.");
    });
}
    // 버튼 클릭 시 모달 열기
    document.addEventListener("DOMContentLoaded", function () {
        const testButton = document.getElementById("testOpenModal");
        if (testButton) {
            testButton.addEventListener("click", function () {
                openModal(1); // 테스트용 ID (실제로는 동적 값 사용)
            });
        }
    });
    </script>

	<!-- JavaScript -->
	<script>
    function printContent(mitsumorishoID) {
        fetch(`/estimate/getDetail?id=${mitsumorishoID}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error('HTTP Error! Status: ' + response.status);
                }
                return response.json();
            })
            .then(data => {
                // 데이터 처리 로직
            })
            .catch(error => {
                console.error('데이터 로드 오류:', error);
                alert('데이터를 불러오는 중 오류가 발생했습니다.');
            });
    }

        // 인쇄 기능
        function printContent() {
            const printWindow = window.open('', '_blank');
            printWindow.document.write('<html><head><title>인쇄</title></head><body>');
            printWindow.document.write(document.body.innerHTML); // 현재 페이지 내용을 복사
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            printWindow.print();
        }
    </script>

	<%@ include file="../includes/footer.jsp"%>
</body>
</html>
