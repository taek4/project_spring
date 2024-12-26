
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>

<div id="app">
	<h1>出荷指示書照会</h1>
	<div id="status-filters" style="margin-bottom: 20px;">
    <button class="status-btn" onclick="filterShipments('全体')">全体</button>
	<button class="status-btn" onclick="filterShipments('進行中')">進行中</button>
	<button class="status-btn" onclick="filterShipments('完了')">完了</button>
</div>
	

	<table border="1">
		<thead>
			<tr>
				<th>日付-No</th>
				<!-- 일자-No -->
				<th>倉庫名</th>
				<!-- 창고명 -->
				<th>品目名</th>
				<!-- 품목명 -->
				<th>数量合計</th>
				<!-- 수량 합계 -->
				<th>進行状態</th>
				<!-- 진행 상태 -->
				<th>印刷</th>
				<!-- 인쇄 -->

			</tr>
		</thead>
		<tbody>
			<c:forEach var="shipment" items="${getList}">
				<tr>
					<td><a href="#"
						onclick="fetchDataAndShowModal('${shipment.hitsuke_No}')">
							${shipment.hitsuke_No} </a></td>
					<td>${shipment.soukoMei}</td>
					<td><c:choose>
							<c:when test="${shipment.otherHinmokuCount == 0}">
            ${shipment.itemName}
        </c:when>
							<c:otherwise>
            ${shipment.itemName}外${shipment.otherHinmokuCount}件
        </c:otherwise>
						</c:choose></td>

					<td>${shipment.suuryou}</td>
					<td>${shipment.shinkouZyoutai}<select
						onchange="taiupdate(this.value, ${shipment.shukkaShiziShoukaiID})">
							<option value="進行中"
								${shipment.shinkouZyoutai == '進行中' ? 'selected' : ''}>進行中</option>
							<option value="完了"
								${shipment.shinkouZyoutai == '完了' ? 'selected' : ''}>完了</option>
					</select>



					</td>
					<td><a
						href="print?shipmentId=${shipment.shukkaShiziShoukaiID}">印刷</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div id="modal"
		style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 800px; background: #fff; border: 1px solid #ccc; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); z-index: 1000; border-radius: 8px;">
		<div style="padding: 20px; font-family: Arial, sans-serif;">
			<h2 style="margin-bottom: 20px; text-align: left;">出荷指示書修正</h2>
			<form action="shipmentupdate" method="post">
				<!--  첫 번째 행 -->
				<div style="display: flex; margin-bottom: 10px;">
					<label for="hitsuke_No" style="width: 120px; margin-right: 10px;">日付:</label>
					<input type="text" id="hitsuke_No" name="hitsuke_No" readonly
						style="flex: 1; border: 1px solid #ccc; padding: 5px;"> <label
						for="torihikisakiID" style="width: 120px; margin-right: 10px;">取引先:</label>
					<input type="text" id="torihikisakiID" name="torihikisakiID"
						style="flex: 1; border: 1px solid #ccc; padding: 5px; width: 100px;">
					<p id="findTorihikisakiList" onclick="findTorihikisakiList()">
						<button type="button" id="findTorihikisaki" class="search-button">
							<i class="fas fa-search text-primary"></i>
						</button>
					</p>
					<input type="text" id="torihikisakiMei" name="torihikisakiMei"
						style="flex: 1; border: 1px solid #ccc; padding: 5px; width: 100px;">
				</div>

				<!--   두 번째 행 -->
				<div style="display: flex; margin-bottom: 10px;">
					<label for="tantoushaID" style="width: 120px; margin-right: 10px;">担当者:</label>
					<input type="text" id="tantoushaID" name="tantoushaID"
						style="flex: 1; border: 1px solid #ccc; padding: 5px; width: 100px;">
					<p id="findTtantoushaList" onclick="findTtantoushaList()">
						<button type="button" id="tantoushaID" class="search-button">
							<i class="fas fa-search text-primary"></i>
						</button>
					</p>
					<input type="text" id="tantoushaMei" name="tantoushaMei"
						style="flex: 1; border: 1px solid #ccc; padding: 5px; width: 100px;">

					<label for="soukoID" style="width: 120px; margin-right: 10px;">倉庫:</label>
					<input type="text" id="soukoID" name="soukoID"
						style="flex: 1; border: 1px solid #ccc; padding: 5px; width: 100px;">
					<p id="findSoukoList" onclick="findSoukoList()">
						<button type="button" id="soukoID" class="search-button">
							<i class="fas fa-search text-primary"></i>
						</button>
					</p>
					<input type="text" id="soukoMei" name="soukoMei"
						style="flex: 1; border: 1px solid #ccc; padding: 5px; width: 100px">
				</div>
				<!--  세 번째 행 -->
				<div style="display: flex; margin-bottom: 10px;">
					<label for="projectID" style="width: 120px; margin-right: 10px;">プロジェクト:</label>
					<input type="text" id="projectID" name="projectID"
						style="flex: 1; border: 1px solid #ccc; padding: 5px; width: 100px;">
					<p id="findProjectList" onclick="findProjectList()">
						<button type="button" id="projectID" class="search-button">
							<i class="fas fa-search text-primary"></i>
						</button>
					</p>
					<input type="text" id="projectMeimei" name="projectMeimei"
						style="flex: 1; border: 1px solid #ccc; padding: 5px; width: 100px;">

					<label for="renrakusaki" style="width: 120px; margin: 0 10px;">連絡先:</label>
					<input type="text" id="renrakusaki" name="renrakusaki"
						style="flex: 1; border: 1px solid #ccc; padding: 5px;">
				</div>

				<!--        네 번째 행 -->
				<div style="display: flex; margin-bottom: 10px;">
					<label for="shukkaYoteibi"
						style="width: 120px; margin-right: 10px;">出荷予定日:</label> <input
						type="date" id="shukkaYoteibi" name="shukkaYoteibi"
						style="flex: 1; border: 1px solid #ccc; padding: 5px;"> <label
						for="yuubinBangou" style="width: 120px; margin: 0 10px;">郵便番号:</label>
					<input type="text" id="yuubinBangou" name="yuubinBangou"
						style="flex: 1; border: 1px solid #ccc; padding: 5px;">
				</div>

				<div style="text-align: right;">
					<button type="button" onclick="closeModal()"
						style="padding: 5px 10px;">閉じる</button>
				</div>



				<div style="margin-bottom: 10px;">
					<!-- 検索ボタン (찾기 버튼) -->
					<button type="button" onclick="showSearchBox()"
						style="padding: 5px 10px; margin-right: 5px;">検索(F3)</button>
					<!-- ソートボタン (정렬 버튼) -->
					<button type="button" onclick="sortItems()"
						style="padding: 5px 10px; margin-right: 5px;">ソート</button>
					<!-- My 品目ボタン (My 품목 버튼) -->
					<button type="button" onclick="myProducts()"
						style="padding: 5px 10px; margin-right: 5px;">My 品目</button>
					<!-- 販売ボタン (판매 버튼) -->
					<button type="button" onclick="sales()"
						style="padding: 5px 10px; margin-right: 5px;">販売</button>
					<!-- 在庫取得ボタン (재고불러오기 버튼) -->
					<button type="button" onclick="reorderStock()"
						style="padding: 5px 10px; margin-right: 5px;">在庫取得</button>
					<!-- 伝票生成ボタン (생성한 전표 버튼) -->
					<button type="button" onclick="generateBarcode()"
						style="padding: 5px 10px; margin-right: 5px;">生成した伝票</button>
				</div>

				<div id="vue-table" style="margin-top: 20px;">
					<table border="1" style="width: 100%; text-align: center;">
						<thead>
							<tr style="background-color: #f1f1f1;">
								<!-- 番号 (번호) -->
								<th>番号</th>
								<!-- 空列 (빈 열) -->
								<th></th>
								<!-- 品目コード (품목코드) -->
								<th>品目コード</th>
								<!-- 品目名 (품목명) -->
								<th>品目名</th>
								<!-- 規格 (규격) -->
								<th>規格</th>
								<!-- 数量 (수량) -->
								<th>数量</th>
								<!-- 新しい項目 (새 항목) -->
								<th>新しい項目</th>
							</tr>
						</thead>
						<tbody>
						  
						

							<tr v-for="(item, index) in items" :key="index">
								<td>{{ index + 1 }}</td>
								<td>
									<button type="button" @click="addRow">↓</button>
								</td>
								<td><input type="text" class="itemCode" placeholder="コード"
									v-model="item.itemCode"
									@click="handleFieldClick('itemName', item)" readonly /></td>
								<td><input type="text" class="itemName" placeholder="品目名"
									v-model="item.itemName" readonly
									@click="handleFieldClick('itemName', item)" /> <input
									type="hidden" :value="item.hinmokuID" /></td>
								<td><input type="text" placeholder="規格を入力"
									v-model="item.kikaku" /></td>
								<td><input type="number" placeholder="数量を入力"
									v-model="item.suuryou" /></td>
								<td><input type="text" placeholder="新しい項目"
									v-model="item.extraField" /></td>
							</tr>
						</tbody>
					</table>
				</div>




				<!-- 저장 버튼 -->
				<table style="width: 100%; margin-top: 20px;">
					<tr>
						<td colspan="7" style="text-align: left;">
							<div style="margin-top: 1px; text-align: left;">
								<button type="button" onclick="saveData()"
									style="padding: 5px 10px;">保存(F8)</button>
								<button type="button" style="padding: 1px 1px;">保存/伝票(F7)</button>
								<button type="reset" style="padding: 1px 1px;">リセット</button>
								<button type="button" style="padding: 1px 1px;">リスト</button>
								<button type="button" style="padding: 1px 1px;">ウェブ資料アップロード</button>
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>



	<div class="detail_list_modal_back" style="display: none;"></div>
	<div class="detail_list_modal" style="display: none;">
		<div class="modal_header">
			<!-- <div class="header_top">
	    		<p>R</p>
	    		<p>M</p>
	    		<p>C</p>
	    	</div> -->

			<p class="title">검색</p>
			<p class="keyword">
				<input type="text" value="" placeholder="입력후 [Enter]">
			</p>
			<p class="searchBtn">Search(F3)</p>


		</div>
		<div class="modal_body">
			<table>
				<thead>
					<tr>
						<th>ID</th>
						<!-- ID列 -->
						<!-- ID 열 -->
						<th>名</th>
						<!-- 名前列 -->
						<!-- 이름 열 -->

					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	</div>

</div>

<style>
#app {
	display: contents;
}
/* 全体背景 (전체 배경) */
.detail_list_modal_back {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5); /* 半透明の黒背景 (반투명 검정 배경) */
	z-index: 999; /* 他の要素の上に表示 (다른 요소 위에 표시) */
}

/* モーダルウィンドウコンテナ (모달 창 컨테이너) */
.detail_list_modal {
	position: fixed;
	display: grid; /* グリッドレイアウトを使用 (Grid 레이아웃 사용) */
	grid-template-rows: auto 1fr;
	/* ヘッダーは固定高さ、ボディは可変 (헤더는 고정 높이, 바디는 유연) */
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 500px; /* モーダルの幅 (모달 너비) */
	height: 70vh; /* 画面高さの70% (전체 화면 높이의 70%) */
	background: #fff;
	border-radius: 8px;
	box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.3);
	z-index: 1002; /* 背景の上に表示 (배경 위에 표시) */
	overflow: hidden;
}

/* モーダルヘッダー (모달 헤더) */
.modal_header {
	background: #f5f5f5;
	padding: 15px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	border-bottom: 1px solid #ddd;
}

.modal_header .title {
	font-size: 18px;
	font-weight: bold;
	margin: 0;
}

.modal_header .keyword input {
	width: 70%;
	padding: 6px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.modal_header .searchBtn {
	background: #007bff;
	color: white;
	padding: 8px 12px;
	border-radius: 4px;
	cursor: pointer;
}

.modal_header .searchBtn:hover {
	background: #0056b3;
}

/* モーダルボディ (모달 바디) */
.modal_body {
	overflow-y: auto; /* 内容があふれた場合はスクロール (내용이 넘치면 스크롤) */
	padding: 15px;
	background: #fff;
}

/* テーブルスタイル (테이블 스타일) */
.modal_body table {
	width: 100%;
	border-collapse: collapse;
}

.modal_body table th, .modal_body table td {
	border: 1px solid #ddd;
	padding: 10px;
	text-align: center;
}

.modal_body table th {
	background: #f0f0f0;
	font-weight: bold;
}

.modal_body table tr:nth-child(even) {
	background: #f9f9f9; /* 偶数行の色 (짝수 행 색상) */
}

#vue-table input {
	width: 100%
}
</style>





<div id="modalBackground"
	style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); z-index: 999;"
	onclick="ComcloseModal()"></div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/vue@3/dist/vue.global.prod.js"></script>

<script>
//モーダルを表示する関数
function showModal(hitsuke_No) {
    $("#modal").show(); // モーダルを表示 (모달을 표시)
    $("#modalBackground").show(); // 背景を表示 (배경을 표시)
    $("#hitsuke_No").val(hitsuke_No); // モーダルに日付を設定 (모달에 날짜를 설정)
}

// モーダルを閉じる関数
function closeModal() {
    $("#modal").hide(); // モーダルを非表示 (모달을 숨김)
    $("#modalBackground").hide(); // 背景を非表示 (배경을 숨김)
}

// 検索ボックスを表示する関数
function showSearchBox() {
    alert("찾기(F3) 기능 실행됨"); // 검색(F3) 기능이 실행됨
}

// アイテムをソートする関数
function sortItems() {
    alert("정렬 기능 실행됨"); // 정렬 기능이 실행됨
}

// My 품목を表示する関数
function myProducts() {
    alert("My 품목 보기 실행됨"); // My 품목 보기 실행됨
}

// 販売機能を実行する関数
function sales() {
    alert("판매 기능 실행됨"); // 판매 기능 실행됨
}

// 在庫をリロードする関数
function reorderStock() {
    alert("재고 불러오기 실행됨"); // 재고 불러오기 실행됨
}

// 伝票を生成する関数
function generateBarcode() {
    alert("생성한 전표 보기 실행됨"); // 생성한 전표 보기 실행됨
}
	    
//状態を更新する関数
function taiupdate(newStatus, shukkaShiziShoukaiID) {
    $.ajax({
        url: '/shipment/taiupdate', // 更新URL (업데이트 URL)
        type: 'POST', // POSTリクエスト (POST 요청)
        data: {
            shukkaShiziShoukaiID: shukkaShiziShoukaiID, // 出荷指示書ID (출하지시서 ID)
            shinkouZyoutai: newStatus // 新しい状態 (새 상태)
        },
        success: function(response) {
            alert("상태가 성공적으로 업데이트되었습니다. " + newStatus); // 상태가 성공적으로 업데이트됨
            window.location.reload(); // ページをリロード (페이지를 새로고침)
        },
        error: function(xhr, status, error) {
            alert("업데이트 실패: " + error); // 업데이트 실패
        }
    });
}

// データを取得してモーダルを表示する関数
function fetchDataAndShowModal(hitsuke_No) {
    $.ajax({
        url: '/shipment/shipmentdetails', // サーバーのURL (서버 URL)
        type: 'GET', // GETリクエスト (GET 요청)
        data: { hitsuke_No: hitsuke_No }, // リクエストデータ (요청 데이터)
        success: function(data) {
            console.log(data); // デバッグ用ログ (디버그용 로그)

            // モーダルにデータを設定 (모달에 데이터를 설정)
            document.getElementById('hitsuke_No').value = data.hitsuke_No;
            document.getElementById('torihikisakiID').value = data.torihikisakiID;
            document.getElementById('torihikisakiMei').value = data.torihikisakiMei; // 取引先名 (거래처명)
            document.getElementById('tantoushaID').value = data.tantoushaID;
            document.getElementById('tantoushaMei').value = data.tantoushaMei; // 担当者名 (담당자명)
            document.getElementById('soukoID').value = data.soukoID;
            document.getElementById('soukoMei').value = data.soukoMei; // 倉庫名 (창고명)
            document.getElementById('projectID').value = data.projectID;
            document.getElementById('projectMeimei').value = data.projectMeimei; // プロジェクト名 (프로젝트명)
            document.getElementById('shukkaYoteibi').value = data.shukkaYoteibi;

            const firstRow = document.querySelector('#itemTable tbody tr'); // 初めの行を取得 (첫 번째 행을 가져옴)

            if (firstRow) {
                const itemCodeField = firstRow.querySelector('.itemCode');
                const itemNameField = firstRow.querySelector('.itemName');
                const hinmokuIDField = firstRow.querySelector('.hinmokuID');
                const kikakuField = firstRow.querySelector('.kikaku');
                const suuryouField = firstRow.querySelector('.suuryou');

                // 各フィールドにデータを設定 (각 필드에 데이터를 설정)
                if (itemCodeField) itemCodeField.value = data.itemCode || ''; // 品目コード 설정
                if (itemNameField) itemNameField.value = data.itemName || ''; // 品目名 설정
                if (hinmokuIDField) hinmokuIDField.value = data.hinmokuID || ''; // 품목ID 설정
                if (kikakuField) kikakuField.value = data.kikaku || ''; // 規格 설정
                if (suuryouField) suuryouField.value = data.suuryou || ''; // 数量 설정
            }

            document.getElementById('modal').style.display = 'block'; // モーダルを表示 (모달을 표시)
            document.getElementById('modalBackground').style.display = 'block'; // 背景を表示 (배경을 표시)
        },
        error: function(xhr, status, error) {
            console.error("データ取得失敗:", error); // データ取得失敗ログ (데이터 가져오기 실패 로그)
            alert("データ取得中にエラーが発生しました。"); // 데이터 가져오는 중 오류 발생
        }
    });
}
function saveShipmentData() {
    const data = {
        hitsuke_No: document.getElementById('hitsuke_No').value, // 日付-Noを取得 (일자-No 가져오기)
        torihikisakiID: document.getElementById('torihikisakiID').value, // 取引先IDを取得 (거래처 ID 가져오기)
        tantoushaID: document.getElementById('tantoushaID').value, // 担当者IDを取得 (담당자 ID 가져오기)
        soukoID: document.getElementById('soukoID').value, // 倉庫IDを取得 (창고 ID 가져오기)
        projectID: document.getElementById('projectID').value, // プロジェクトIDを取得 (프로젝트 ID 가져오기)
        shukkaYoteibi: document.getElementById('shukkaYoteibi').value, // 出荷予定日を取得 (출하 예정일 가져오기)
        yuubinBangou: document.getElementById('yuubinBangou').value, // 郵便番号を取得 (우편번호 가져오기)
        renrakusaki: document.getElementById('renrakusaki').value, // 連絡先を取得 (연락처 가져오기)
        commonHinmokuList: [] // 品目リストを初期化 (품목 리스트 초기화)
    };

    // テーブルデータを収集 (테이블 데이터 수집)
    const rows = document.querySelectorAll("#itemTable tbody tr");

    rows.forEach(function (row, index) {
        const hinmokuID = row.querySelector(".hinmokuID") ? row.querySelector(".hinmokuID").value.trim() : ''; // 品目IDを取得 (품목 ID 가져오기)
        const suuryou = row.querySelector(".suuryou") ? row.querySelector(".suuryou").value.trim() : ''; // 数量を取得 (수량 가져오기)
        const kikaku = row.querySelector(".kikaku") ? row.querySelector(".kikaku").value.trim() : ''; // 規格を取得 (규격 가져오기)
        const itemCode = row.querySelector(".itemCode") ? row.querySelector(".itemCode").value.trim() : ''; // 品目コードを取得 (품목 코드 가져오기)
        const itemName = row.querySelector(".itemName") ? row.querySelector(".itemName").value.trim() : ''; // 品目名を取得 (품목명 가져오기)
    });
    console.log(data); // デバッグ用ログ (디버그용 로그)
 // 데이터 전송
    $.ajax({
        url: '/shipment/shipmentcorrection',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function (response) {
             alert("保存成功！"); //저장 성공！
            window.location.reload(); 
        },
        error: function (xhr, status, error) {
            alert("保存失敗！ " + error); //저장 싪패 ！
        }
    });
}


// 担当者リストを取得する関数 (담당자 리스트 가져오기)
function findTtantoushaList() {
    $.ajax({
        url: '/common/tantoushaList', // 担当者リストAPIのURL (담당자 리스트 API URL)
        contentType: 'application/json',
        dataType: 'json',
        type: 'GET',
        headers: { "Accept": "application/json" },
        success: function(data) {
            let tableBody = $(".modal_body tbody");
            tableBody.empty(); // テーブルの内容をクリア (테이블 내용을 초기화)
            data.forEach(function(item) {
                let row = "<tr onclick=\"selectTantousha('" + item.tantoushaID + "', '" + item.tantoushamei + "')\">";
                row += "<td>" + item.tantoushaID + "</td>";
                row += "<td>" + item.tantoushamei + "</td>";
                row += "</tr>";
                tableBody.append(row); // 新しい行を追加 (새 행 추가)
            });
            $(".detail_list_modal_back").css("display", "block"); // モーダル背景を表示 (모달 배경 표시)
            $(".detail_list_modal").css("display", "grid"); // モーダルを表示 (모달 표시)
        },
        error: function(xhr, status, error) {
            console.error("AJAX Error:", error); // エラーをログ出力 (에러 로그 출력)
        }
    });
}

// 担当者を選択する関数 (담당자 선택하기)
function selectTantousha(tantoushaID, tantoushaMei) {
    document.getElementById('tantoushaID').value = tantoushaID; // 選択した担当者IDを設定 (선택한 담당자 ID 설정)
    document.getElementById('tantoushaMei').value = tantoushaMei; // 選択した担当者名を設定 (선택한 담당자명 설정)
    ComcloseModal(); // モーダルを閉じる (모달 닫기)
}

// 倉庫リストを取得する関数 (창고 리스트 가져오기)
function findSoukoList() {
    $.ajax({
        url: '/common/soukoList', // 倉庫リストAPIのURL (창고 리스트 API URL)
        contentType: 'application/json',
        dataType: 'json',
        type: 'GET',
        headers: { "Accept": "application/json" },
        success: function(data) {
            let tableBody = $(".modal_body tbody");
            tableBody.empty();
            data.forEach(function(item) {
                let row = "<tr onclick=\"selectSouko('" + item.soukoID + "', '" + item.soukomei + "')\">";
                row += "<td>" + item.soukoID + "</td>";
                row += "<td>" + item.soukomei + "</td>";
                row += "</tr>";
                tableBody.append(row);
            });
            $(".detail_list_modal_back").css("display", "block");
            $(".detail_list_modal").css("display", "grid");
        },
        error: function(xhr, status, error) {
            console.error("AJAX Error:", error);
        }
    });
}

// 倉庫を選択する関数 (창고 선택하기)
function selectSouko(soukoID, soukomei) {
    document.getElementById('soukoID').value = soukoID; // 選択した倉庫IDを設定 (선택한 창고 ID 설정)
    document.getElementById('soukoMei').value = soukomei; // 選択した倉庫名を設定 (선택한 창고명 설정)
    ComcloseModal();
}
	
//取引先リストを取得する関数 (거래처 리스트 가져오기)
function findTorihikisakiList() {
    $.ajax({
        url: '/common/torihikisakiList',
        contentType: 'application/json',
        dataType: 'json',
        type: 'GET',
        headers: { "Accept": "application/json" },
        success: function(data) {
            let tableBody = $(".modal_body tbody");
            tableBody.empty();
            data.forEach(function(item) {
                let row = "<tr onclick=\"selectTorihikisaki('" + item.torihikisakiID + "', '" + item.torihikisakimei + "')\">";
                row += "<td>" + item.torihikisakiID + "</td>";
                row += "<td>" + item.torihikisakimei + "</td>";
                row += "</tr>";
                tableBody.append(row);
            });
            $(".detail_list_modal_back").css("display", "block");
            $(".detail_list_modal").css("display", "grid");
        },
        error: function(xhr, status, error) {
            console.error("AJAX Error:", error);
        }
    });
}

// 取引先を選択する関数 (거래처 선택하기)
function selectTorihikisaki(torihikisakiID, torihikisakimei) {
    document.getElementById('torihikisakiID').value = torihikisakiID;
    document.getElementById('torihikisakiMei').value = torihikisakimei;
    ComcloseModal();
}
	
//プロジェクトリストを取得する関数 (프로젝트 리스트 가져오기)
function findProjectList() {
    $.ajax({
        url: '/common/projectList', // プロジェクトリストAPIのURL (프로젝트 리스트 API URL)
        contentType: 'application/json', // コンテンツタイプ設定 (컨텐츠 타입 설정)
        dataType: 'json', // レスポンスデータ形式をJSONに設定 (응답 데이터 형식을 JSON으로 설정)
        type: 'GET', // HTTPメソッドをGETに設定 (HTTP 메서드를 GET으로 설정)
        headers: { "Accept": "application/json" }, // ヘッダー情報を設定 (헤더 정보 설정)
        success: function(data) { // リクエスト成功時の処理 (요청 성공 시 처리)
            let tableBody = $(".modal_body tbody"); // モーダル内のテーブル本体取得 (모달 내 테이블 본체 가져오기)
            tableBody.empty(); // テーブルの内容をクリア (테이블 내용 초기화)
            data.forEach(function(item) { // 各プロジェクトデータを行として追加 (각 프로젝트 데이터를 행으로 추가)
                let row = "<tr onclick=\"selectProject('" + item.projectID + "', '" + item.projectMeimei + "')\">";
                row += "<td>" + item.projectID + "</td>"; // プロジェクトID列 (프로젝트 ID 열)
                row += "<td>" + item.projectMeimei + "</td>"; // プロジェクト名列 (프로젝트 이름 열)
                row += "</tr>";
                tableBody.append(row); // テーブルに行を追加 (테이블에 행 추가)
            });
            $(".detail_list_modal_back").css("display", "block"); // モーダル背景を表示 (모달 배경 표시)
            $(".detail_list_modal").css("display", "grid"); // モーダルを表示 (모달 표시)
        },
        error: function(xhr, status, error) { // リクエスト失敗時の処理 (요청 실패 시 처리)
            console.error("AJAX Error:", error); // エラーログ出力 (에러 로그 출력)
        }
    });
}

// プロジェクトを選択する関数 (프로젝트 선택하기)
function selectProject(projectID, projectMeimei) {
    document.getElementById('projectID').value = projectID; // 選択したプロジェクトIDを設定 (선택한 프로젝트 ID 설정)
    document.getElementById('projectMeimei').value = projectMeimei; // 選択したプロジェクト名を設定 (선택한 프로젝트 이름 설정)
    ComcloseModal(); // モーダルを閉じる (모달 닫기)
}

// グローバル変数でクリックされたフィールドを保存 (클릭된 필드를 저장할 전역 변수)
let selectedInputField = null;

// クリックされたフィールドを保存する関数 (클릭된 필드를 저장하는 함수)
function storeTargetField(inputField) {
    selectedInputField = inputField; // クリックされたフィールドを保存 (클릭된 필드 저장)
}

//品目リストを取得する関数 (품목 리스트를 가져오는 함수)
function findhimokuList() {
    $.ajax({
        url: '/shipment/hinmokuList', // 品目リスト取得APIのURL (품목 리스트 API URL)
        type: 'GET', // HTTPメソッドをGETに設定 (HTTP 메서드를 GET으로 설정)
        dataType: 'json', // レスポンスデータ形式をJSONに設定 (응답 데이터 형식을 JSON으로 설정)
        success: function(data) { // リクエスト成功時の処理 (요청 성공 시 처리)
            let tableBody = document.querySelector(".modal_body tbody"); // モーダルのテーブル本体を取得 (모달 테이블 본체 가져오기)
            tableBody.innerHTML = ""; // テーブル内容をクリア (테이블 내용 초기화)

            data.forEach(function(item) { // 各品目データを行として追加 (각 품목 데이터를 행으로 추가)
                const row = document.createElement("tr"); // 行要素を作成 (행 요소 생성)
                row.onclick = function () { 
                    selecthimoku(item.zaikoKoodo, item.hinmokumei, item.hinmokuID); // 行クリック時に選択処理実行 (행 클릭 시 선택 처리 실행)
                };

                const cell1 = document.createElement("td"); // 列1を作成 (열 1 생성)
                cell1.textContent = item.zaikoKoodo; // 在庫コードを設定 (재고 코드 설정)

                const cell2 = document.createElement("td"); // 列2を作成 (열 2 생성)
                cell2.textContent = item.hinmokumei; // 品目名を設定 (품목명 설정)

                row.appendChild(cell1); // 行に列1を追加 (행에 열 1 추가)
                row.appendChild(cell2); // 行に列2を追加 (행에 열 2 추가)
                tableBody.appendChild(row); // テーブル本体に行を追加 (테이블 본체에 행 추가)
            });

            document.querySelector(".detail_list_modal_back").style.display = "block"; // モーダル背景を表示 (모달 배경 표시)
            document.querySelector(".detail_list_modal").style.display = "grid"; // モーダルを表示 (모달 표시)
        },
        error: function() { // リクエスト失敗時の処理 (요청 실패 시 처리)
            alert("품목 데이터를 불러오는 중 오류가 발생했습니다。"); // エラーメッセージ表示 (에러 메시지 표시)
        }
    });
}

// 品目を選択する関数 (품목 선택하기)
function selecthimoku(itemCode, itemName, hinmokuID) {
    if (selectedInputField) { // 選択された入力フィールドが存在する場合 (선택된 입력 필드가 있는 경우)
        const row = selectedInputField.closest("tr"); // 選択されたフィールドの行を取得 (선택된 필드의 행 가져오기)

        const codeField = row.querySelector(".itemCode"); // 품목 코드 필드
        const nameField = row.querySelector(".itemName"); // 품목명 필드
        const idField = row.querySelector(".hinmokuID"); // 품목 ID 필드

        if (codeField) codeField.value = itemCode; // 品目コードを設定 (품목 코드 설정)
        if (nameField) nameField.value = itemName; // 品目名を設定 (품목명 설정)
        if (idField) idField.value = hinmokuID; // 品目IDを設定 (품목 ID 설정)

        ComcloseModal(); // モーダルを閉じる (모달 닫기)
    }
}

// 共通モーダルを閉じる関数 (공통 모달 닫기)
function ComcloseModal() {
    $(".detail_list_modal_back").css("display", "none"); // モーダル背景を非表示 (모달 배경 숨기기)
    $(".detail_list_modal").css("display", "none"); // モーダルを非表示 (모달 숨기기)
    $(".modal_body tbody").empty(); // テーブル内容をクリア (테이블 내용 초기화)
}
</script>
<script>
   
const { createApp } = Vue;  
//Vue 애플리케이션 생성 (Vue アプリケーションの作成)
createApp({
data() {
 return {
   items: [
     {
       itemCode: '', // 품목 코드
       itemName: '', // 품목명
       hinmokuID: '', // 품목 ID
       kikaku: '', // 규격
       suuryou: '', // 수량
       extraField: '' // 추가 필드
     }
   ],
   originalData: {} // 원본 데이터 스냅샷 (オリジナルデータスナップショット)
 };
},
mounted() {
 // 초기 데이터의 스냅샷 저장 (初期データのスナップショット保存)
 this.saveOriginalData();
},
methods: {
 addRow() {
   // 새로운 행 추가 (新しい行を追加)
   this.items.push({
     id: null, // 신규 데이터임을 나타냄 (新しいデータを示す)
     itemCode: '',
     itemName: '',
     hinmokuID: '',
     kikaku: '',
     suuryou: '',
     extraField: ''
   }); 
 },
 storeTargetField(item) {
   // 클릭된 필드를 저장하는 메서드 (クリックされたフィールドを保存するメソッド)
 },
 setItemsFromServer(itemList) {
   // 서버에서 받아온 데이터를 설정 (サーバーから受け取ったデータを設定)
   if (Array.isArray(itemList)) {
     this.items = itemList.map((obj) => ({
       itemCode: obj.itemCode || '',
       itemName: obj.itemName || '',
       hinmokuID: obj.hinmokuID || '',
       kikaku: obj.kikaku || '',
       suuryou: obj.suuryou || '',
       extraField: ''
     }));
   } else {
     this.items = [];
   }
 },
 handleFieldClick(fieldName, item) {
   // 특정 필드를 클릭했을 때 동작 (特定フィールドをクリックした時の動作)
   if (fieldName === 'itemCode') {
     this.findhimokuList(item); // itemCode 클릭 시 품목 리스트 호출 (itemCodeをクリックした際に品目リストを呼び出す)
   } else if (fieldName === 'itemName') {
     this.findhimokuList(item); // itemName 클릭 시 동일한 작업 (itemNameをクリックした際に同じ処理)
   } 	
 },
 handleFieldClick(fieldName, item) {
     // 특정 필드를 클릭했을 때 동작 (特定フィールドをクリックした時の動作)
     if (fieldName === 'itemCode') {
       this.findhimokuList(item); // itemCode 클릭 시 품목 리스트 호출 (itemCodeをクリックした際に品目リストを呼び出す)
     } else if (fieldName === 'itemName') {
       this.findhimokuList(item); // itemName 클릭 시 동일한 작업 (itemNameをクリックした際に同じ処理)
     }
   },
   findhimokuList(item) {
     // 품목 리스트 조회 (品目リスト取得)
     $.ajax({
       url: '/shipment/hinmokuList', // API URL
       type: 'GET',
       dataType: 'json',
       success: (data) => {
         const tableBody = document.querySelector(".modal_body tbody");
         tableBody.innerHTML = "";

         data.forEach((listItem) => {
           const row = document.createElement("tr");
           row.onclick = () => {
             this.selecthimoku(listItem.zaikoKoodo, listItem.hinmokumei, listItem.hinmokuID, item);
           };
           const cell1 = document.createElement("td");
           cell1.textContent = listItem.zaikoKoodo;
           const cell2 = document.createElement("td");
           cell2.textContent = listItem.hinmokumei;
           row.appendChild(cell1);
           row.appendChild(cell2);
           tableBody.appendChild(row);
         });

         document.querySelector(".detail_list_modal_back").style.display = "block";
         document.querySelector(".detail_list_modal").style.display = "block";
       },
       error: function () {
         alert("품목 데이터를 불러오는 중 오류가 발생했습니다."); // 品目データを取得中にエラーが発生しました
       }
     });
   },
   selecthimoku(zaikoKoodo, hinmokumei, hinmokuID, item) {
     // 품목 선택 시 클릭한 아이템에 대입 (品目選択時にクリックしたアイテムに代入)
     item.itemCode = zaikoKoodo;
     item.itemName = hinmokumei;
     item.hinmokuID = hinmokuID;
     document.querySelector(".detail_list_modal_back").style.display = "none";
     document.querySelector(".detail_list_modal").style.display = "none";
   },
   deleteRow(index) {
     // 특정 행 삭제 (特定の行を削除)
     this.items.splice(index, 1);
   },
   saveOriginalData() {
     // 원본 데이터 저장 (オリジナルデータを保存)
     this.originalData = JSON.parse(JSON.stringify(this.items));
   },
   saveData() {
     const insertData = [];
     const updateData = [];
     this.items.forEach((item) => {
       if (item.id === null) {
         insertData.push(item); // 신규 데이터 (新規データ)
       } else {
         const original = this.originalData.find((orig) => orig.id === item.id);
         if (JSON.stringify(original) !== JSON.stringify(item)) {
           updateData.push(item); // 변경된 데이터 (変更されたデータ)
         }
       }
     });
                console.log('Insert Data:', insertData);
                console.log('Update Data:', updateData);

                // API 호출
                if (insertData.length > 0) {
                  this.insertData(insertData);
                }
                if (updateData.length > 0) {
                  this.updateData(updateData);
                }

                // 저장 완료 후 원본 데이터 업데이트
                this.saveOriginalData();
              },
              insertData(data) {
                  console.log('Insert API 호출', data);

                  // Ajax 예시
                  $.ajax({
                    url: '/shipment/hinmokuinsert',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(data),
                    success: (response) => {
                      console.log('Insert 성공:', response);
                      alert('신규 데이터가 저장되었습니다.');
                    },
                    error: (error) => {
                      console.error('Insert 실패:', error);
                      alert('신규 데이터 저장 실패!');
                    }
                  });
                },  

                updateData(data) {
                    // 수정된 데이터 저장 (修正されたデータ保存)
                    $.ajax({
                      url: '/shipment/hinmokuupdate',
                      type: 'POST',
                      contentType: 'application/json',
                      data: JSON.stringify(data),
                      success: (response) => {
                        alert('변경된 데이터가 저장되었습니다。'); // 変更されたデータが保存されました。
                      },
                      error: (error) => {
                        alert('데이터 수정 실패!'); // データ修正失敗！
                      } 
                    });
                  }
                }  
              }).mount('#app'); // Vue 애플리케이션을 특정 요소에 마운트 (Vueアプリケーションを特定要素にマウント)
 </script>
<%@ include file="../includes/footer.jsp"%>