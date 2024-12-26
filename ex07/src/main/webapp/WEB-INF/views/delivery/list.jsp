<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>
<style>
/* 가로 정렬 스타일 */
.form-row {
	display: flex;
	flex-wrap: nowrap; /* 한 줄에 고정 */
	gap: 20px; /* 항목 간 간격 */
	justify-content: space-between;
	width: 100%;
}

.form-group {
	display: flex; /* 내부 아이템 가로 배치 */
	align-items: center; /* 세로 가운데 정렬 */
	gap: 8px; /* 필드와 돋보기 간 간격 */
	flex: 1; /* 모든 필드가 동일한 너비 */
}

.form-group label {
	min-width: 100px; /* 라벨 너비 고정 */
	text-align: right; /* 라벨 정렬 */
	white-space: nowrap; /* 라벨이 여러 줄로 내려가지 않도록 */
}

#modal {
    display: none;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 900px;
    background: white;
    border-radius: 10px;
    padding: 20px;
    z-index: 1050;
}

/* 공통 모달 스타일 (.modal) */
.modal {
    display: none;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 700px; /* 다른 크기로 설정 */
    background: white;
    border-radius: 8px; /* 약간 작은 둥근 모서리 */
    padding: 15px;
    z-index: 1045; /* #modal보다 낮은 값 */
}

/* 공통 모달 배경 */
.modal-background {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    z-index: 1040;
}

/* 공통 테이블 스타일 */
table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #ccc;
	padding: 8px;
	text-align: center;
}

th {
	background-color: #f5f5f5;
	font-weight: bold;
}

td {
	background-color: #fff;
}

/* 입력 필드 스타일 */
input[type="text"] {
	padding: 5px 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
	outline: none;
}

input[type="text"]:focus {
	border-color: #007bff;
}

/* 버튼 스타일 수정 */
button {
	border: 1px solid #ccc;
	background-color: #f8f9fa;
	color: #333;
	padding: 6px 12px;
	margin: 2px;
	cursor: pointer;
	border-radius: 4px;
	outline: none;
}

button:hover {
	background-color: #e0e0e0;
	border-color: #bdbdbd;
}

@media print {
	body {
		visibility: visible;
		background: none;
	}
	.print-hidden {
		display: none !important;
	}
}
</style>



<legend>出荷紹介</legend>



<!-- 테이블 본문 // テーブルの本文 -->
<table>
	<thead>
		<tr>
			<th><input type="checkbox" id="selectAll"></th>
			<!-- 해당 체크박스를 선택할 경우 해당 페이지에서 보이는 tbody에 있는 체크박스 전체가 선택이 됨 
			     このチェックボックスを選択すると、このページのtbody内にあるチェックボックス全てが選択される -->
			<th>日付-No</th>
			<th>倉庫名</th>
			<th>品目名</th>
			<th>数量合計</th>
			<th>取引先名</th>
			<th>印刷</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="delivery" items="${deliveries}">
			<tr>
				<td><input type="checkbox" value="${delivery.shukkaID}" class="row-checkbox"></td>
				<td><a href="javascript:void(0);" class="modal-link"
					data-hitsukeNo="${delivery.hitsuke_No}"
					data-torihikisakiCode="${delivery.torihikisakiCode}"
					data-torihikisakiMei="${delivery.torihikisakiMei}"
					data-tantoushaCode="${delivery.tantoushaCode}"
					data-tantoushaMei="${delivery.tantoushaMei}"
					data-soukoCode="${delivery.soukoCode}"
					data-soukoMei="${delivery.soukoMei}"
					data-projectCode="${delivery.projectCode}"
					data-projectMeimei="${delivery.projectMeimei}"
					data-renrakusaki="${delivery.renrakusaki}"
					data-yuubinBangou="${delivery.yuubinBangou}"
					data-zyuusho="${delivery.zyuusho}"> ${delivery.hitsuke_No} </a></td>
				<td>${delivery.soukoMei}</td>
				<td><c:choose>
						<c:when test="${delivery.otherHinmokuCount == 0}">
                            ${delivery.hinmokuMei}
                        </c:when>
						<c:otherwise>
                            ${delivery.hinmokuMei} 以外 ${delivery.otherHinmokuCount}個
                            <!-- 품목명이 여러 개일 경우 '외 X개'를 추가 표시 // 品目名が複数ある場合は「外X個」を追加表示 -->
						</c:otherwise>
					</c:choose></td>
				<td>${delivery.suuryouGoukei}</td>
				<td>${delivery.torihikisakiMei}</td>
				<td><a href="javascript:void(0);" class="print-link" data-hitsukeNo="${delivery.hitsuke_No}">印刷</a></td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<div id="modal" class="modal">
	<div class="modal-content">
		<span class="close-modal">&times;</span>
		<h2>出荷修正</h2>
		<form id="updateForm" action="${pageContext.request.contextPath}/delivery/list" method="POST">
			<input type="hidden" id="shukkaID" name="shukkaID" value="${delivery.hitsuke_No_referType}">

			<!-- 첫 번째 행 // 最初の行 -->
			<div class="form-row">
				<div class="form-group">
					<label for="hitsukeNo">日付-No:</label> 
					<input type="text" id="hitsukeNo" name="hitsukeNo" value="${delivery.hitsuke_No}">
				</div>
			</div>

			<!-- 두 번째 행 // 2番目の行 -->
			<div class="form-row">
				<div class="form-group">
					<label for="torihikisakiCode">取引先:</label> 
					<input type="text" id="torihikisakiCode" name="torihikisakiCode" value="${delivery.torihikisakiCode}">
					<button type="button" class="search-button" data-modal="torihikisakiModal">
						<i class="fas fa-search"></i>
					</button>

					<div id="torihikisakiModal" class="modal">
						<div class="modal-content">
							<span class="close-modal">&times;</span>
							<h2>取引先選択</h2>
							<table>
								<thead>
									<tr>
										<th>取引先コード</th>
										<th>取引先名</th>
										<th>選択</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="torihikisaki" items="${torihikisakiList}">
										<tr>
											<td>${torihikisaki.torihikisakiCode}</td>
											<td>${torihikisaki.torihikisakimei}</td>
											<td>
												<button type="button" class="select-item"
													data-code="${torihikisaki.torihikisakiCode}"
													data-mei="${torihikisaki.torihikisakimei}">選択</button>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>

				</div>
				<div class="form-group">
					<label for="torihikisakiMei"></label> 
					<input type="text" id="torihikisakiMei" name="torihikisakiMei" value="${delivery.torihikisakiMei}">
				</div>
			</div>

			<!-- 세 번째 행 // 3番目の行 -->
			<div class="form-row">
				<div class="form-group">
					<label for="tantoushaCode">担当者:</label> 
					<input type="text" id="tantoushaCode" name="tantoushaCode" value="${delivery.tantoushaCode}">
					<button type="button" class="search-button" onclick="openTantoushaModal()">
						<i class="fas fa-search"></i>
					</button>

					<div id="tantoushaModal" class="modal">
						<div class="modal-content">
							<span class="close-modal">&times;</span>
							<h2>担当者選択</h2>
							<table>
								<thead>
									<tr>
										<th>担当者コード</th>
										<th>担当者名</th>
										<th>選択</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="tantousha" items="${tantoushaList}">
										<tr>
											<td>${tantousha.tantoushaCode}</td>
											<td>${tantousha.tantoushamei}</td>
											<td>
												<button type="button" class="select-item"
													data-code="${tantousha.tantoushaCode}"
													data-mei="${tantousha.tantoushamei}">選択</button>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="tantoushaMei"></label> 
					<input type="text" id="tantoushaMei" name="tantoushaMei" value="${delivery.tantoushaMei}">
				</div>
			</div>


<!-- 네 번째 행 // 4番目の行 -->
			<div class="form-row">
				<div class="form-group">
					<label for="soukoCode">出荷倉庫</label> <!-- 출하 창고 -->
					<input type="text" id="soukoCode" name="soukoCode" value="${delivery.soukoCode}">
					<button type="button" class="search-button" onclick="openSoukoModal()">
						<i class="fas fa-search"></i>
					</button>
					<div id="soukoModal" class="modal">
						<div class="modal-content">
							<span class="close-modal">&times;</span>
							<h2>倉庫選択</h2> <!-- 창고 선택 -->
							<table>
								<thead>
									<tr>
										<th>倉庫コード</th> <!-- 창고 코드 -->
										<th>倉庫名</th> <!-- 창고명 -->
										<th>選択</th> <!-- 선택 -->
									</tr>
								</thead>
								<tbody>
									<c:forEach var="souko" items="${soukoList}">
										<tr>
											<td>${souko.soukoCode}</td>
											<td>${souko.soukomei}</td>
											<td>
												<button type="button" class="select-item"
													data-code="${souko.soukoCode}" data-mei="${souko.soukomei}">選択</button> <!-- 선택 -->
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="soukoMei"></label> 
					<input type="text" id="soukoMei" name="soukoMei" value="${delivery.soukoMei}">
				</div>
			</div>

			<!-- 다섯 번째 행 // 5番目の行 -->
			<div class="form-row">
				<div class="form-group">
					<label for="projectCode">プロジェクト</label> <!-- 프로젝트 -->
					<input type="text" id="projectCode" name="projectCode" value="${delivery.projectCode}">
					<button type="button" class="search-button" onclick="openProjectModal()">
						<i class="fas fa-search"></i>
					</button>
					<div id="projectModal" class="modal">
						<div class="modal-content">
							<span class="close-modal">&times;</span>
							<h2>プロジェクト選択</h2> <!-- 프로젝트 선택 -->
							<table>
								<thead>
									<tr>
										<th>プロジェクトコード</th> <!-- 프로젝트 코드 -->
										<th>プロジェクト名</th> <!-- 프로젝트 이름 -->
										<th>選択</th> <!-- 선택 -->
									</tr>
								</thead>
								<tbody>
									<c:forEach var="project" items="${projectList}">
										<tr>
											<td>${project.projectCode}</td>
											<td>${project.projectMeimei}</td>
											<td>
												<button type="button" class="select-item"
													data-code="${project.projectCode}" data-mei="${project.projectMeimei}">選択</button> <!-- 선택 -->
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="projectMeimei"></label> 
					<input type="text" id="projectMeimei" name="projectMeimei" value="${delivery.projectMeimei}">
				</div>
			</div>

			<!-- 여섯 번째 행 // 6番目の行 -->
			<div class="form-row">
				<div class="form-group">
					<label for="renrakusaki">連絡先:</label> <!-- 연락처 -->
					<input type="text" id="renrakusaki" name="renrakusaki" value="${delivery.renrakusaki}">
				</div>
			</div>

			<!-- 일곱 번째 행 // 7番目の行 -->
			<div class="form-row">
				<div class="form-group">
					<label for="yuubinBangou">郵便番号:</label> <!-- 우편번호 -->
					<input type="text" id="yuubinBangou" name="yuubinBangou" value="${delivery.yuubinBangou}">
				</div>
			</div>

			<!-- 여덟 번째 행 // 8番目の行 -->
			<div class="form-row">
				<div class="form-group">
					<label for="zyuusho">住所:</label> <!-- 주소 -->
					<input type="text" id="zyuusho" name="zyuusho" value="${delivery.zyuusho}">
				</div>
			</div>

			<!-- 품목 정보 테이블 // 品目情報テーブル -->
			<table>
				<thead>
					<tr>
						<th><input type="checkbox" id="selectAllHinmoku"></th> <!-- 전체 선택 -->
						<th>品目名</th> <!-- 품목 이름 -->
						<th>数量</th> <!-- 수량 -->
						<th>規格</th> <!-- 규격 -->
						<th>数量</th> <!-- 수량 -->
					</tr>
				</thead>
				<tbody>
					<c:forEach var="deliveries" items="${shukkaWithHinmokuList}">
						<tr>
							<th><input type="checkbox" id="selectHinmoku"></th> <!-- 선택 -->
							<th>${deliveries.itemCode}</th> <!-- 품목 코드 -->
							<th>${deliveries.itemName}</th> <!-- 품목 이름 -->
							<th>${deliveries.kikaku}</th> <!-- 규격 -->
							<th>${deliveries.suuryou}</th> <!-- 수량 -->
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<button type="submit">修正保存</button> <!-- 수정 저장 -->
		</form>
	</div>
</div>


<table style="width: 800px">
	<tr>
		<td><button id="newShukka">新規(F2)</button></td>
		<td colspan="1" style="text-align: left;">
			<button class="modal-link">Email</button>
		</td>
		<td colspan="1" style="text-align: left;">進行状態変更</td>
		<td colspan="1" style="text-align: left;">送り出す</td>
		<td colspan="1" style="text-align: left;">印刷</td>
		<td colspan="1" style="text-align: left;">バーコード（品目）</td>
		<td colspan="1" style="text-align: left;">電子決済</td>
		<td><button id="deleteSelected">選択削除</button></td>
		<td colspan="1" style="text-align: left;">Excel</td>
		<td colspan="1" style="text-align: left;">履歴照会</td>
	</tr>
</table>


<script src="script.js"></script>




<script>

document.addEventListener("DOMContentLoaded", function () {
    // "selectAll" 체크박스 // "selectAll" チェックボックス
    const selectAllCheckbox = document.getElementById("selectAll");
    selectAllCheckbox.addEventListener("click", function () {
        const isChecked = selectAllCheckbox.checked;
        const rowCheckboxes = document.querySelectorAll(".row-checkbox");

        // row-checkbox의 상태를 selectAll과 동일하게 설정 // row-checkboxの状態をselectAllと同じに設定
        rowCheckboxes.forEach(function (checkbox) {
            checkbox.checked = isChecked;
        });
    });

    // 첫 번째 모달을 여는 링크 // 最初のモーダルを開くリンク
    document.querySelectorAll(".modal-link").forEach(function (link) {
        link.addEventListener("click", function (event) {
            const hitsukeNo = event.target.getAttribute("data-hitsukeNo");
            const torihikisakiCode = event.target.getAttribute("data-torihikisakiCode");
            const torihikisakiMei = event.target.getAttribute("data-torihikisakiMei");
            const tantoushaCode = event.target.getAttribute("data-tantoushaCode");
            const tantoushaMei = event.target.getAttribute("data-tantoushaMei");
            const soukoCode = event.target.getAttribute("data-soukoCode");
            const soukoMei = event.target.getAttribute("data-soukoMei");
            const projectCode = event.target.getAttribute("data-projectCode");
            const projectMeimei = event.target.getAttribute("data-projectMeimei");
            const renrakusaki = event.target.getAttribute("data-renrakusaki");
            const yuubinBangou = event.target.getAttribute("data-yuubinBangou");
            const zyuusho = event.target.getAttribute("data-zyuusho");

            // 첫 번째 모달에 값 설정 // 最初のモーダルに値を設定
            document.getElementById("shukkaID").value = hitsukeNo;
            document.getElementById("hitsukeNo").value = hitsukeNo;
            document.getElementById("torihikisakiCode").value = torihikisakiCode;
            document.getElementById("torihikisakiMei").value = torihikisakiMei;
            document.getElementById("tantoushaCode").value = tantoushaCode;
            document.getElementById("tantoushaMei").value = tantoushaMei;
            document.getElementById("soukoCode").value = soukoCode;
            document.getElementById("soukoMei").value = soukoMei;
            document.getElementById("projectCode").value = projectCode;
            document.getElementById("projectMeimei").value = projectMeimei;
            document.getElementById("renrakusaki").value = renrakusaki;
            document.getElementById("yuubinBangou").value = yuubinBangou;
            document.getElementById("zyuusho").value = zyuusho;

            // 첫 번째 모달 표시 // 最初のモーダルを表示
            document.getElementById("modal").style.display = "block";
        });
    });

    // 첫 번째 모달 닫기 // 最初のモーダルを閉じる
    document.querySelector(".close-modal").addEventListener("click", function () {
        document.getElementById("modal").style.display = "none";
    });

    // TorihikisakiModal 처리 // TorihikisakiModalの処理
    document.querySelector(".search-button[data-modal='torihikisakiModal']").addEventListener("click", function () {
        const torihikisakiModal = document.getElementById("torihikisakiModal");
        torihikisakiModal.style.display = "block";

        // 선택 이벤트 // 選択イベント
        torihikisakiModal.querySelectorAll(".select-item").forEach(function (item) {
            item.addEventListener("click", function () {
                const selectedCode = item.getAttribute("data-code");
                const selectedMei = item.getAttribute("data-mei");
                document.getElementById("torihikisakiCode").value = selectedCode;
                document.getElementById("torihikisakiMei").value = selectedMei;
                torihikisakiModal.style.display = "none";
            });
        });
    });

    // TantoushaModal 처리 // TantoushaModalの処理
    document.querySelector(".search-button[data-modal='tantoushaModal']").addEventListener("click", function () {
        const tantoushaModal = document.getElementById("tantoushaModal");
        tantoushaModal.style.display = "block";

        // 선택 이벤트 // 選択イベント
        tantoushaModal.querySelectorAll(".select-item").forEach(function (item) {
            item.addEventListener("click", function () {
                const selectedCode = item.getAttribute("data-code");
                const selectedMei = item.getAttribute("data-mei");
                document.getElementById("tantoushaCode").value = selectedCode;
                document.getElementById("tantoushaMei").value = selectedMei;
                tantoushaModal.style.display = "none";
            });
        });
    });

    // SoukoModal 처리 // SoukoModalの処理
    document.querySelector(".search-button[data-modal='soukoModal']").addEventListener("click", function () {
        const soukoModal = document.getElementById("soukoModal");
        soukoModal.style.display = "block";

        // 선택 이벤트 // 選択イベント
        soukoModal.querySelectorAll(".select-item").forEach(function (item) {
            item.addEventListener("click", function () {
                const selectedCode = item.getAttribute("data-code");
                const selectedMei = item.getAttribute("data-mei");
                document.getElementById("soukoCode").value = selectedCode;
                document.getElementById("soukoMei").value = selectedMei;
                soukoModal.style.display = "none";
            });
        });
    });

    // ProjectModal 처리 // ProjectModalの処理
    document.querySelector(".search-button[data-modal='projectModal']").addEventListener("click", function () {
        const projectModal = document.getElementById("projectModal");
        projectModal.style.display = "block";

        // 선택 이벤트 // 選択イベント
        projectModal.querySelectorAll(".select-item").forEach(function (item) {
            item.addEventListener("click", function () {
                const selectedCode = item.getAttribute("data-code");
                const selectedMei = item.getAttribute("data-mei");
                document.getElementById("projectCode").value = selectedCode;
                document.getElementById("projectMeimei").value = selectedMei;
                projectModal.style.display = "none";
            });
        });
    });

    // 모달 외부 클릭 시 닫기 // モーダルの外部をクリックして閉じる
    window.addEventListener("click", function (event) {
        const modals = document.querySelectorAll(".modal");
        modals.forEach(function (modal) {
            if (event.target === modal) {
                modal.style.display = "none";
            }
        });
    });

    // 모든 모달 닫기 버튼 // すべてのモーダルを閉じるボタン
    document.querySelectorAll(".close-modal").forEach(function (button) {
        button.addEventListener("click", function () {
            this.closest(".modal").style.display = "none";
        });
    });
});

</script>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const deleteButton = document.getElementById('deleteSelected');
    deleteButton.addEventListener('click', function() {
        // 선택된 체크박스 값 가져오기 // チェックされたボックスの値を取得する
        const selectedRows = Array.from(document.querySelectorAll('.row-checkbox:checked'))
            .map(checkbox => {
                return {
                    shukkaID: checkbox.value  // 예를 들어, value가 shukkaID라고 가정 // 例えば、valueがshukkaIDであると仮定
                };
            });

        if (selectedRows.length === 0) {
            alert('削除する項目を選んでください。'); // 삭제할 항목을 선택해주세요. // 削除する項目を選択してください。
            return;
        }

        // 서버로 데이터 전송 // サーバーにデータを送信する
        if (confirm('選択した項目を削除しますか。')) { // 선택한 항목을 삭제하시겠습니까? // 選択した項目を削除しますか？
            fetch('delevery/deleteDelivery', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ deliveries: selectedRows }) // DeliveryVO 형태로 배열을 전송 // DeliveryVO形式で配列を送信する
            })
            .then(response => {
                if (response.ok) {
                    alert('削除できました。'); // 삭제되었습니다. // 削除されました。
                    location.reload(); // 삭제 후 페이지 새로고침 // 削除後、ページをリロードする
                } else {
                    alert('削除に失敗しました。'); // 삭제에 실패했습니다. // 削除に失敗しました。
                }
            })
            .catch(error => {
                console.error('Error:', error); // 오류 로그 출력 // エラーログを表示する
                alert('削除中エラーが発生しました。'); // 삭제 중 오류가 발생했습니다. // 削除中にエラーが発生しました。
            });
        }
    });
});
</script>




<%@ include file="../includes/footer.jsp"%>