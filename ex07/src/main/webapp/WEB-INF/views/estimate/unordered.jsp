<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<!-- CSS 파일 적용 -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/status.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>未注文現況</title>

<script>
$(document).ready(function () {
    // 필터 보이기/숨기기 버튼 이벤트
    $(".toggle-button").click(function () {
        const parentGroup = $(this).closest(".form-group"); // 현재 그룹 선택
        let filters = parentGroup.next(".additional-filters"); // 바로 다음에 있는 추가 필터를 선택
        const isVisible = filters.length && filters.css("display") !== "none"; // 표시 여부 확인

        if (isVisible) {
            filters.slideUp(() => {
                filters.remove(); // 숨김 후 DOM에서 제거
            });
            $(this).text("▼"); // 버튼 텍스트 변경
        } else {
            // 추가 필터를 동적으로 생성해 추가
            filters = parentGroup.find(".additional-filters").clone(); // 기존 추가 필터 복제
            filters.insertAfter(parentGroup).slideDown(); // 입력 필드 아래에 추가
            $(this).text("▲"); // 버튼 텍스트 변경
        }
    });

						// 모달 열기
						$(".modal-button").click(function() {
							const modalId = $(this).data("modal-id");
							$("#" + modalId).show();
							$(".overlay").show();
						});

						// 모달 닫기
						$(".modal-close, .overlay").click(function() {
							$(".modal").hide();
							$(".overlay").hide();
						});
					});
</script>
</head>
<body>
	<div class="nav-bar"></div>
	<div class="container">

		<h1>未注文現況</h1>
		<form id="filterForm" action="/estimate/mijumun" method="get">
			<!-- 内外区分 -->
			<div class="form-group">
				<label>区分</label> <label><input type="radio"
					name="sourceType" value="全体" checked> 全体</label> <label><input
					type="radio" name="sourceType" value="品目別"> 品目別</label> <label><input
					type="radio" name="sourceType" value="ライン別"> ライン別</label>
			</div>
			<!-- 基準日フィルター -->
			<div class="form-group">
				<label for="startDate">基準日</label> <select>
					<option value="営業周期">営業周期</option>
					<option value="在庫周期">在庫周期</option>
				</select> <input type="date" id="startDate" name="startDate"
					value="2024-01-01"> ~ <input type="date" id="endDate"
					name="endDate" value="2024-12-31">
			</div>
			<div class="filter-container">
				<!-- 倉庫フィルター -->
				<div class="form-group">
					<label for="warehouse">倉庫</label> <input type="text" id="warehouse"
						name="warehouse" placeholder="倉庫">
					<button type="button" class="search-button"
						onclick="openWarehouseModal()">
						<i class="fas fa-search"></i>
					</button>
					<button type="button" class="toggle-button">▼</button>
					<div class="additional-filters" style="display: none;">
						<div class="form-group">
							<label for="warehouseGroup" id="warehouseGroup">倉庫階層グループ</label>
							<button type="button" id="warehouseGroupSearch"
								class="search-button">
								<i class="fas fa-search text-primary"></i>
							</button>
							<input type="text" id="warehouseGroupText" name="warehouseGroup"
								placeholder="倉庫階層グループ">
						</div>
					</div>
				</div>
				<!-- プロジェクトフィルター -->
				<div class="form-group">
					<label for="project">プロジェクト</label> <input type="text" id="project"
						name="project" placeholder="プロジェクト">
					<button type="button" class="search-button"
						onclick="openProjectModal()">
						<i class="fas fa-search"></i>
					</button>
					<button type="button" class="toggle-button">▼</button>
					<div class="additional-filters" style="display: none;">
						<!-- プロジェクトグループ1 -->
						<div class="form-group">
							<label for="projectGroup1" id="projectGroup1Label">プロジェクトグループ1</label>
							<button type="button" id="projectGroup1Search"
								class="search-button">
								<i class="fas fa-search text-primary"></i>
							</button>
							<input type="text" id="projectGroup1" name="projectGroup1"
								placeholder="プロジェクトグループ1">
						</div>
						<!-- プロジェクトグループ2 -->
						<div class="form-group">
							<label for="projectGroup2" id="projectGroup2Label">プロジェクトグループ2</label>
							<button type="button" id="projectGroup2Search"
								class="search-button">
								<i class="fas fa-search text-primary"></i>
							</button>
							<input type="text" id="projectGroup2" name="projectGroup2"
								placeholder="プロジェクトグループ2">
						</div>
					</div>
				</div>
				<!-- 取引先フィルター -->
				<div class="form-group">
					<label for="client">取引先</label> <input type="text" id="client"
						name="client" placeholder="取引先">
					<button type="button" class="search-button"
						onclick="openTraderModal()">
						<i class="fas fa-search"></i>
					</button>
					<button type="button" class="toggle-button">▼</button>
					<div class="additional-filters" style="display: none;">
						<!-- 取引先グループ1 -->
						<div class="form-group">
							<label for="clientGroup1" id="clientGroup1Label">取引先グループ1</label>
							<button type="button" id="clientGroup1Search"
								class="search-button">
								<i class="fas fa-search text-primary"></i>
							</button>
							<input type="text" id="clientGroup1" name="clientGroup1"
								placeholder="取引先グループ1">
						</div>
						<!-- 取引先グループ2 -->
						<div class="form-group">
							<label for="clientGroup2" id="clientGroup2Label">取引先グループ2</label>
							<button type="button" id="clientGroup2Search"
								class="search-button">
								<i class="fas fa-search text-primary"></i>
							</button>
							<input type="text" id="clientGroup2" name="clientGroup2"
								placeholder="取引先グループ2">
						</div>
						<!-- 取引先階層グループ -->
						<div class="form-group">
							<label for="clientHierarchy" id="clientHierarchyLabel">取引先階層グループ</label>
							<button type="button" id="clientHierarchySearch"
								class="search-button">
								<i class="fas fa-search text-primary"></i>
							</button>
							<input type="text" id="clientHierarchy" name="clientHierarchy"
								placeholder="取引先階層グループ">
						</div>
					</div>
				</div>
				<!-- 品目コードフィルター -->
				<div class="form-group">
					<label for="itemCategory">品目コード</label> <input type="text"
						id="itemCategory" name="itemCategory" placeholder="品目区分">
					<button type="button" id="itemCategorySearch" class="search-button">
						<i class="fas fa-search"></i>
					</button>
					<button type="button" class="toggle-button">▼</button>
					<div class="additional-filters" style="display: none;">
						<!-- 品目グループ1 -->
						<div class="form-group">
							<label for="itemGroup1" id="itemGroup1Label">品目グループ1</label>
							<button type="button" id="itemGroup1Search" class="search-button">
								<i class="fas fa-search text-primary"></i>
							</button>
							<input type="text" id="itemGroup1" name="itemGroup1"
								placeholder="品目グループ1">
						</div>
						<!-- 品目グループ2 -->
						<div class="form-group">
							<label for="itemGroup2" id="itemGroup2Label">品目グループ2</label>
							<button type="button" id="itemGroup2Search" class="search-button">
								<i class="fas fa-search text-primary"></i>
							</button>
							<input type="text" id="itemGroup2" name="itemGroup2"
								placeholder="品目グループ2">
						</div>
						<!-- 品目グループ3 -->
						<div class="form-group">
							<label for="itemGroup3" id="itemGroup3Label">品目グループ3</label>
							<button type="button" id="itemGroup3Search" class="search-button">
								<i class="fas fa-search text-primary"></i>
							</button>
							<input type="text" id="itemGroup3" name="itemGroup3"
								placeholder="品目グループ3">
						</div>
						<!-- 品目階層グループ -->
						<div class="form-group">
							<label for="itemHierarchy" id="itemHierarchyLabel">品目階層グループ</label>
							<button type="button" id="itemHierarchySearch"
								class="search-button">
								<i class="fas fa-search text-primary"></i>
							</button>
							<input type="text" id="itemHierarchy" name="itemHierarchy"
								placeholder="品目階層グループ">
						</div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<button onclick="location.href='/estimate/mijumun'"
					class="btn btn-primary">検索</button>
			</div>
		</form>

	</div>


	<!-- 倉庫検索モーダル -->
	<div id="warehouseModal" class="modal fade" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<!-- モーダルヘッダー -->
				<div class="modal-header">
					<h5 class="modal-title">倉庫検索</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="閉じる"></button>
				</div>
				<!-- モーダル本文 -->
				<div class="modal-body">
					<!-- 検索入力 -->
					<input type="text" id="warehouseSearchInput"
						class="form-control mb-3" placeholder="検索キーワードを入力してEnter">
					<!-- 倉庫データテーブル -->
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>倉庫ID</th>
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
				<!-- モーダルフッター -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">閉じる</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 取引先検索モーダル -->
	<div id="traderModal" class="modal fade" tabindex="-1" role="dialog"
		aria-labelledby="traderModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<!-- モーダルヘッダー -->
				<div class="modal-header">
					<h5 class="modal-title" id="traderModalLabel">取引先検索</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="閉じる"></button>
				</div>
				<!-- モーダル本文 -->
				<div class="modal-body">
					<input type="text" id="traderSearchInput" class="form-control mb-3"
						placeholder="取引先名を入力してください">
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
				<!-- モーダルフッター -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">閉じる</button>
				</div>
			</div>
		</div>
	</div>

	<!-- プロジェクト検索モーダル -->
	<div id="projectModal" class="modal fade" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<!-- モーダルヘッダー -->
				<div class="modal-header">
					<h5 class="modal-title">プロジェクト検索</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="閉じる"></button>
				</div>
				<!-- モーダル本文 -->
				<div class="modal-body">
					<!-- 検索入力 -->
					<input type="text" id="projectSearchInput"
						class="form-control mb-3" placeholder="プロジェクト名を入力してください">
					<!-- プロジェクトデータテーブル -->
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
				<!-- モーダルフッター -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">閉じる</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 品目コードモーダル -->
	<div id="hinmokuModal" class="modal fade" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<!-- モーダルヘッダー -->
				<div class="modal-header">
					<h5 class="modal-title">品目コード検索</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="閉じる"></button>
				</div>
				<!-- モーダル本文 -->
				<div class="modal-body">
					<!-- 検索入力 -->
					<input type="text" id="hinmokuSearchInput"
						class="form-control mb-3" placeholder="品目名を入力してください">
					<!-- 品目データテーブル -->
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>品目コード</th>
								<th>品目名</th>
							</tr>
						</thead>
						<tbody id="hinmokuTableBody">
							<c:forEach var="hinmoku" items="${hinmokuList}">
								<tr
									onclick="selectHinmoku('${hinmoku.hinmokuID}', '${hinmoku.hinmokumei}')">
									<td>${hinmoku.hinmokuID}</td>
									<td>${hinmoku.hinmokumei}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!-- モーダルフッター -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">閉じる</button>
				</div>
			</div>
		</div>
	</div>



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

    function selectProject(id, name) {
        alert("선택된 프로젝트: " + name);
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
	// 검색 필터링 함수
	document.getElementById("hinmokuSearchInput").addEventListener("keyup", function () {
	    const filter = this.value.toLowerCase();
	    const rows = document.querySelectorAll("#hinmokuTableBody tr");

	    rows.forEach(function (row) {
	        const hinmokuName = row.cells[1].textContent.toLowerCase();
	        if (hinmokuName.includes(filter)) {
	            row.style.display = "";
	        } else {
	            row.style.display = "none";
	        }
	    });
	});

	// 선택된 품목 데이터 처리 함수
	function selectHinmoku(id, name) {
	    document.getElementById("itemCategory").value = id + " - " + name;
	    closeModal("hinmokuModal");
	}

	// 모달 닫기 함수
	function closeModal(modalId) {
	    const modalElement = document.getElementById(modalId);
	    const modal = bootstrap.Modal.getInstance(modalElement);
	    modal.hide();
	}

	// 모달 열기 함수
	function openHinmokuModal() {
	    const modalElement = document.getElementById("hinmokuModal");
	    const modal = new bootstrap.Modal(modalElement, { backdrop: "static" });
	    modal.show();

	    // 검색 입력 초기화
	    const searchInput = document.getElementById("hinmokuSearchInput");
	    searchInput.value = "";
	    const rows = document.querySelectorAll("#hinmokuTableBody tr");
	    rows.forEach(function (row) {
	        row.style.display = "";
	    });
	}

	// "품목 코드 검색" 버튼 클릭 시 모달 열기
	document.getElementById("itemCategorySearch").addEventListener("click", function () {
	    openHinmokuModal();
	});


</script>

	<!-- JS 파일 적용 -->
	<script src="<%=request.getContextPath()%>/resources/js/status.js"></script>


</body>
</html>
<%@ include file="../includes/footer.jsp"%>
