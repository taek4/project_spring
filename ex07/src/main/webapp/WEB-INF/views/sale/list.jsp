<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<!-- //김영민
//金榮珉 -->
<style>
/* 라벨 스타일 // ラベルスタイル */
label {
    margin-top: 10px; /* 상단 여백 설정 // 上余白設定 */
}
/* 버튼 컨테이너 스타일 // ボタンコンテナスタイル */
.button-container {
    display: flex; /* 플렉스 박스를 사용하여 버튼 정렬 // Flexboxを使用してボタンを整列 */
    align-items: center; /* 수직 방향 가운데 정렬 // 垂直方向の中央揃え */
    gap: 10px; /* 버튼 간 간격 설정 // ボタン間の間隔を設定 */
}
/* 버튼 기본 스타일 // ボタンの基本スタイル */
.button {
    width: 60px; /* 버튼 너비 // ボタンの幅 */
    height: 40px; /* 버튼 높이 // ボタンの高さ */
    padding: 10px 0; /* 버튼 내부 여백 // ボタンの内部余白 */
    text-align: center; /* 텍스트 가운데 정렬 // テキストの中央揃え */
    border-radius: 15px; /* 둥근 테두리 // 丸い境界線 */
    border: none; /* 테두리 제거 // 境界線を削除 */
    background-color: #d3daf7; /* 버튼 배경색 // ボタン背景色 */
    color: #555; /* 텍스트 색상 // テキストの色 */
    font-size: 14px; /* 텍스트 크기 // テキストサイズ */
    cursor: pointer; /* 클릭 가능한 포인터 커서 // クリック可能なカーソル */
    transition: all 0.3s ease; /* 부드러운 전환 효과 // なめらかなトランジション効果 */
}
/* 버튼 호버 스타일 // ボタンのホバースタイル */
.button:hover {
    background-color: #668FE7; /* 호버 시 배경색 변경 // ホバー時の背景色変更 */
}
/* 버튼 포커스 및 활성화 스타일 // ボタンのフォーカスおよびアクティブスタイル */
.button:focus, .button:active {
    background-color: #1B3DA1; /* 활성화 시 배경색 변경 // アクティブ時の背景色変更 */
    color: white; /* 활성화 시 텍스트 색상 변경 // アクティブ時のテキスト色変更 */
    border: none; /* 테두리 제거 // 境界線を削除 */
    outline: none; /* 외곽선 제거 // アウトラインを削除 */
}
/* 검색 필드 스타일 // 検索フィールドスタイル */
#searchField {
    width: 200px; /* 검색 필드 너비 // 検索フィールドの幅 */
    height: 40px; /* 검색 필드 높이 // 検索フィールドの高さ */
    padding: 10px; /* 내부 여백 // 内部余白 */
    border-radius: 15px; /* 둥근 테두리 // 丸い境界線 */
    border: 1px solid #ccc; /* 테두리 스타일 // 境界線スタイル */
    font-size: 14px; /* 텍스트 크기 // テキストサイズ */
    margin-left: 10px; /* 왼쪽 여백 // 左余白 */
}
/* 검색 버튼 스타일 // 検索ボタンスタイル */
#searchbutton {
    width: 90px; /* 버튼 너비 // ボタンの幅 */
    height: 40px; /* 버튼 높이 // ボタンの高さ */
    padding: 10px 0; /* 버튼 내부 여백 // ボタンの内部余白 */
    text-align: center; /* 텍스트 가운데 정렬 // テキストの中央揃え */
    border-radius: 15px; /* 둥근 테두리 // 丸い境界線 */
    border: none; /* 테두리 제거 // 境界線を削除 */
    background-color: #1B3DA1; /* 버튼 배경색 // ボタン背景色 */
    color: white; /* 텍스트 색상 // テキスト色 */
    font-size: 14px; /* 텍스트 크기 // テキストサイズ */
    cursor: pointer; /* 클릭 가능한 포인터 커서 // クリック可能なカーソル */
    transition: all 0.3s ease; /* 부드러운 전환 효과 // なめらかなトランジション効果 */
}
/* 테이블 스타일 // テーブルスタイル */
#hanbailistTable {
    width: 100%; /* 테이블 너비 // テーブルの幅 */
    border-collapse: collapse; /* 경계선 병합 // 境界線の結合 */
}
#hanbailistTable th, #hanbailistTable td {
    border: 1px solid #ccc; /* 셀 경계선 // セルの境界線 */
    padding: 8px; /* 셀 내부 여백 // セル内部の余白 */
    text-align: center; /* 텍스트 가운데 정렬 // テキストの中央揃え */
}
#hanbailistTable thead {
    background-color: #F7F8F9; /* 테이블 헤더 배경색 // テーブルヘッダーの背景色 */
}
/* 모달 스타일 // モーダルスタイル */
.modal {
    display: none; /* 기본적으로 숨김 // デフォルトでは非表示 */
    position: fixed; /* 화면 고정 // 画面に固定 */
    top: 0; /* 상단에서 0 위치 // 上端から0位置 */
    left: 0; /* 좌측에서 0 위치 // 左端から0位置 */
    width: 100%; /* 모달 너비 // モーダルの幅 */
    height: 100%; /* 모달 높이 // モーダルの高さ */
    background-color: rgba(0, 0, 0, 0.5); /* 반투명 검은 배경 // 半透明の黒背景 */
    z-index: 1050; /* z-index 설정 // z-indexの設定 */
    opacity: 0; /* 초기 투명도 // 初期の透明度 */
    transition: opacity 0.3s ease; /* 부드러운 투명도 전환 효과 // スムーズな透明度トランジション効果 */
}
.modal.active {
    display: block; /* 활성화 시 표시 // アクティブ時に表示 */
    opacity: 1; /* 활성화 시 불투명도 변경 // アクティブ時に不透明度を変更 */
}
/* 모달 내용 스타일 // モーダル内容のスタイル */
.modal-content {
    position: relative; /* 상대 위치 // 相対位置 */
    margin: 10% auto; /* 중앙 정렬 // 中央揃え */
    background-color: white; /* 배경색 // 背景色 */
    width: 80%; /* 모달 너비 // モーダルの幅 */
    padding: 20px; /* 내부 여백 // 内部余白 */
    border-radius: 10px; /* 둥근 테두리 // 丸い境界線 */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 효과 // シャドウ効果 */
}
.modal-content button {
    margin-right: 10px; /* 버튼 오른쪽 간격 // ボタン右側の間隔 */
    background-color: #1B3DA1; /* 버튼 배경색 // ボタン背景色 */
    color: white; /* 버튼 텍스트 색상 // ボタンテキスト色 */
    border: none; /* 버튼 테두리 제거 // ボタン境界線を削除 */
    border-radius: 5px; /* 버튼 둥근 모서리 // ボタンの丸い角 */
    cursor: pointer; /* 클릭 가능한 커서 // クリック可能なカーソル */
}
.modal-content button:hover {
    background-color: #003DA1; /* 호버 시 배경색 변경 // ホバー時の背景色変更 */
}
#transactionGroupSearch {
    flex: 0 0 auto; /* 돋보기 아이콘 크기를 고정 // 拡大鏡アイコンのサイズを固定 */
    font-size: 16px; /* 아이콘 크기 // アイコンのサイズ */
    color: #007bff; /* 아이콘 색상 // アイコンの色 */
    cursor: pointer; /* 클릭 가능한 커서 스타일 // クリック可能なカーソルスタイル */
}

.additional-filters {
    display: flex; /* 플렉스 박스를 사용하여 자식 요소를 한 줄로 정렬 // Flexboxを使用して子要素を一列に整列 */
    align-hinmokus: center; /* 세로 방향 가운데 정렬 // 縦方向の中央揃え */
    gap: 10px; /* 요소 간 간격 설정 // 要素間の間隔を設定 */
}

#warehouseGroupLabel {
    flex: 0 0 150px; /* 라벨의 고정 너비 설정 // ラベルの固定幅を設定 */
    font-weight: bold; /* 텍스트 굵게 // テキストを太字に */
    text-align: left; /* 텍스트 왼쪽 정렬 // テキストを左揃え */
}

#warehousebutton {
    width: 30px; /* 버튼 너비 // ボタンの幅 */
}

#warehouseGroupSearch {
    flex: 0 0 auto; /* 돋보기 아이콘 크기를 고정 // 拡大鏡アイコンのサイズを固定 */
    font-size: 16px; /* 아이콘 크기 // アイコンのサイズ */
    color: #007bff; /* 아이콘 색상 // アイコンの色 */
    cursor: pointer; /* 클릭 가능한 커서 스타일 // クリック可能なカーソルスタイル */
}

#warehouseGroupText {
    flex: 1; /* 남은 공간을 모두 차지 // 残りのスペースを全て使用 */
    border: 1px solid black; /* 검정색 테두리 // 黒の境界線 */
    box-sizing: border-box; /* 테두리와 패딩을 포함하여 크기 계산 // 境界線とパディングを含めてサイズを計算 */
}

.additional-filters {
    display: flex; /* 플렉스 박스를 사용하여 자식 요소를 한 줄로 정렬 // Flexboxを使用して子要素を一列に整列 */
    align-hinmokus: center; /* 세로 방향 가운데 정렬 // 縦方向の中央揃え */
    gap: 10px; /* 요소 간 간격 설정 // 要素間の間隔を設定 */
    margin-top: 5px; /* 상단 여백 설정 // 上余白を設定 */
}

/* 라벨 스타일 // ラベルスタイル */
.additional-filters label {
    flex: 0 0 150px; /* 라벨 고정 너비 설정 // ラベルの固定幅を設定 */
    font-weight: bold; /* 텍스트 굵게 // テキストを太字に */
}

/* 입력 필드 스타일 // 入力フィールドスタイル */
.additional-filters input {
    flex: 1; /* 남은 공간을 모두 차지 // 残りのスペースを全て使用 */
    padding: 8px; /* 내부 여백 설정 // 内部余白を設定 */
    border: 1px solid #ccc; /* 회색 테두리 // グレーの境界線 */
    border-radius: 4px; /* 둥근 테두리 // 丸い境界線 */
    box-sizing: border-box; /* 테두리와 패딩을 포함하여 크기 계산 // 境界線とパディングを含めてサイズを計算 */
}

/* 돋보기 버튼 스타일 // 拡大鏡ボタンスタイル */
.additional-filters button {
    background: none; /* 배경 제거 // 背景を削除 */
    border: none; /* 테두리 제거 // 境界線を削除 */
    cursor: pointer; /* 클릭 가능한 커서 스타일 // クリック可能なカーソルスタイル */
    font-size: 16px; /* 버튼 텍스트 크기 // ボタンテキストのサイズ */
    color: #007bff; /* 텍스트 색상 // テキストの色 */
    padding: 10px; /* 버튼 내부 여백 // ボタン内部余白 */
    transition: transform 0.2s ease; /* 전환 효과 // トランジション効果 */
}

.additional-filters button:hover {
    transform: scale(1.1); /* 버튼을 확대하여 시각적 피드백 제공 // ボタンを拡大して視覚的フィードバックを提供 */
}

/* 체크박스 그룹 스타일 // チェックボックスグループスタイル */
.checkbox-group {
    display: flex; /* 플렉스 박스를 사용하여 정렬 // Flexboxを使用して整列 */
    align-hinmokus: center; /* 세로 방향 가운데 정렬 // 縦方向の中央揃え */
    gap: 5px; /* 체크박스 간 간격 설정 // チェックボックス間の間隔を設定 */
    flex-wrap: wrap; /* 여러 줄로 감싸기 허용 // 複数行で包むことを許可 */
}

/* 체크박스 컨테이너 스타일 // チェックボックスコンテナスタイル */
.checkbox-container {
    display: flex; /* 플렉스 박스를 사용하여 정렬 // Flexboxを使用して整列 */
    align-hinmokus: center; /* 세로 방향 가운데 정렬 // 縦方向の中央揃え */
    gap: 5px; /* 요소 간 간격 설정 // 要素間の間隔を設定 */
    position: relative; /* 상대 위치 설정 // 相対位置を設定 */
    font-size: 14px; /* 텍스트 크기 설정 // テキストのサイズを設定 */
    cursor: pointer; /* 클릭 가능한 커서 스타일 // クリック可能なカーソルスタイル */
}

/* 체크박스 숨기기 // チェックボックスを非表示 */
.checkbox-container input[type="checkbox"] {
    display: none; /* 기본 체크박스를 숨김 // デフォルトのチェックボックスを非表示 */
}

/* 사용자 지정 체크박스 스타일 // カスタムチェックボックススタイル */
.custom-checkbox {
    width: 16px; /* 체크박스 너비 // チェックボックスの幅 */
    height: 16px; /* 체크박스 높이 // チェックボックスの高さ */
    background-color: white; /* 배경색 설정 // 背景色を設定 */
    border: 2px solid #1B3DA1; /* 파란색 테두리 설정 // 青の境界線を設定 */
    border-radius: 5px; /* 둥근 테두리 // 丸い境界線 */
    display: inline-block; /* 인라인 블록 요소로 설정 // インラインブロック要素として設定 */
    position: relative; /* 상대 위치 설정 // 相対位置を設定 */
}

/* 체크된 사용자 지정 체크박스 스타일 // チェック済みカスタムチェックボックススタイル */
.checkbox-container input[type="checkbox"]:checked + .custom-checkbox {
    background-color: #1B3DA1 !important; /* 선택 시 배경색 변경 // 選択時に背景色を変更 */
    border-color: #1B3DA1 !important; /* 선택 시 테두리 색상 변경 // 選択時に境界線の色を変更 */
}

/* 체크된 체크박스의 체크 마크 스타일 // チェック済みチェックボックスのチェックマークスタイル */
.checkbox-container input[type="checkbox"]:checked + .custom-checkbox::after {
    content: '✔'; /* 체크 표시 추가 // チェックマークを追加 */
    color: white !important; /* 체크 마크 색상 변경 // チェックマークの色を変更 */
    font-size: 12px; /* 체크 마크 크기 설정 // チェックマークのサイズを設定 */
    position: absolute; /* 절대 위치 설정 // 絶対位置を設定 */
    top: 50%; /* 세로 방향 중앙 정렬 // 縦方向の中央揃え */
    left: 50%; /* 가로 방향 중앙 정렬 // 横方向の中央揃え */
    transform: translate(-50%, -50%); /* 가운데로 위치 조정 // 中央に位置調整 */
}

.checkbox-group span {
    margin: 0 5px;
    color: black;
}
/* 라디오 그룹 스타일 // ラジオグループスタイル */
.radio-group {
    display: flex; /* 플렉스 박스를 사용하여 정렬 // Flexboxを使用して整列 */
    align-hinmokus: center; /* 세로 방향 가운데 정렬 // 縦方向の中央揃え */
    gap: 10px; /* 라디오 버튼 간 간격 설정 // ラジオボタン間の間隔を設定 */
    margin-top: 10px; /* 상단 여백 설정 // 上余白を設定 */
    margin-bottom: 20px; /* 하단 여백 설정 // 下余白を設定 */
}

/* 라디오 버튼 라벨 스타일 // ラジオボタンラベルスタイル */
.radio-group label {
    font-size: 14px; /* 텍스트 크기 설정 // テキストのサイズを設定 */
    display: flex; /* 플렉스 박스를 사용하여 정렬 // Flexboxを使用して整列 */
    align-hinmokus: center; /* 세로 방향 가운데 정렬 // 縦方向の中央揃え */
    gap: 5px; /* 텍스트와 라디오 버튼 간 간격 설정 // テキストとラジオボタン間の間隔を設定 */
}

/* 라디오 버튼 스타일 // ラジオボタンスタイル */
.radio-group input[type="radio"] {
    accent-color: #1B3DA1; /* 라디오 버튼 강조 색상 // ラジオボタンの強調色 */
    cursor: pointer; /* 클릭 가능한 커서 스타일 // クリック可能なカーソルスタイル */
}
</style>
<div class="container-fluid px-4">
    <!-- 버튼 및 검색 필드 컨테이너 // ボタンおよび検索フィールドのコンテナ -->
    <div class="button-container">
        <h3 class="mt-4">販売照会</h3> <!-- 판매 조회 제목 // 販売照会タイトル -->
        <button class="button">全体</button> <!-- 전체 버튼 // 全体ボタン -->
        <button class="button">決済中</button> <!-- 결제 진행 중 버튼 // 決済中ボタン -->
        <button class="button">未確認</button> <!-- 미확인 버튼 // 未確認ボタン -->
        <button class="button">確認</button> <!-- 확인 버튼 // 確認ボタン -->
        <input type="text" id="searchField" placeholder="検索語入力"> <!-- 검색어 입력 필드 // 検索語入力フィールド -->
        <button id="searchButton">Search(F3)</button> <!-- 검색 버튼 // 検索ボタン -->
    </div>

    <!-- 테이블 컨테이너 // テーブルコンテナ -->
    <div>
        <table class="table table-bordered">
            <thead class="table-light">
                <tr>
                    <th>
                        <input type="checkbox" id="selectAll" onclick="toggleAllCheckboxes(this)">
                        <!-- 전체 선택 체크박스 // 全選択チェックボックス -->
                    </th>
                    <th>日付-No</th> <!-- 날짜-번호 // 日付-No -->
                    <th>取引先名</th> <!-- 거래처명 // 取引先名 -->
                    <th>品目名</th> <!-- 품목명 // 品目名 -->
                    <th>金額合計</th> <!-- 금액 합계 // 金額合計 -->
                    <th>取引タイプ名</th> <!-- 거래 타입명 // 取引タイプ名 -->
                    <th>出荷倉庫名</th> <!-- 출하 창고명 // 出荷倉庫名 -->
                    <th>会計反映可否</th> <!-- 회계 반영 여부 // 会計反映可否 -->
                    <th>印刷</th> <!-- 인쇄 버튼 // 印刷ボタン -->
                    <th>伝票</th> <!-- 전표 버튼 // 伝票ボタン -->
                </tr>
            </thead>
            <tbody>
                <!-- 판매 데이터 반복 출력 // 販売データの繰り返し出力 -->
                <c:forEach var="sale" items="${saleList}">
                    <tr>
                        <td>
                            <input type="checkbox" class="row-checkbox">
                            <!-- 개별 선택 체크박스 // 個別選択チェックボックス -->
                        </td>
                        <td>
                            <a href="#" onclick="fetchDataAndShowModal('${sale.hitsuke_no}')">
                                ${sale.hitsuke_no}
                            </a>
                            <!-- 클릭 시 모달 표시 // クリック時にモーダルを表示 -->
                        </td>
                        <td>${sale.torihikisakimei}</td> <!-- 거래처명 출력 // 取引先名を出力 -->
                        <td>
                            <c:choose>
                                <c:when test="${sale.otherHinmokuCount == 0}">
                                    ${sale.hinmokumei} <!-- 품목명 출력 // 品目名を出力 -->
                                </c:when>
                                <c:otherwise>
                                    ${sale.hinmokumei} 外 ${sale.otherHinmokuCount}か
                                    <!-- 추가 품목 개수 출력 // 追加品目数を出力 -->
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${sale.hanbaiKingakuGoukei}</td> <!-- 판매 금액 합계 출력 // 販売金額合計を出力 -->
                        <td>${sale.zeikomikubun}</td> <!-- 세금 포함 여부 출력 // 税込み区分を出力 -->
                        <td>${sale.soukomei}</td> <!-- 창고명 출력 // 倉庫名を出力 -->
                        <td></td> <!-- 회계 반영 여부 // 会計反映可否 -->
                        <td>
                            <button>印刷</button> <!-- 인쇄 버튼 // 印刷ボタン -->
                        </td>
                        <td>
                            <button>朝会</button> <!-- 전표 버튼 // 伝票ボタン -->
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div id="modal1" class="modal"  style="font-size: 16px;">
    <div class="modal-content">
        <h4>基本</h4>
        <form>
		    <div id="date-range">
		        <label for="startDate">基準日</label>
		        <input type="date" id="startDate">
		        <label for="endDate">~</label>
		        <input type="date" id="endDate">
		    </div>
		    <div id="transaction-type">
		        <label for="transaction">取引タイプ</label>
				<button id="transactionGroupSearch" type="button" data-bs-toggle="modal" data-bs-target="#modalTransaction" style="cursor: pointer; padding: 10px; background: none; border: none;">
				    <i class="fas fa-search text-primary search-icon"></i>
				</button>
		        <input type="text" id="transactionGroupText" name="warehouseGroup" placeholder="取引タイプ">
		    </div>
		    <div id="currency">
		        <div class="radio-group">
		        	<label style="font-size: 16px;">通貨</label>
		            <label style="font-size: 16px;"><input type="radio" name="currency" value="전체" checked>全体</label>
		            <label style="font-size: 16px;"><input type="radio" name="currency" value="내자">內資</label>
		            <label style="font-size: 16px;"><input type="radio" name="currency" value="외자"> 外資</label>
		        </div>
		    </div>
			<div id="warehouse-filter">
			    <label for="warehouse">出荷倉庫</label>
			    <button type="button" class="toggle-button" id="warehosebutton">▼</button>
			    <button id="warehouseGroupSearch" data-target="manager" style="cursor: pointer; padding: 10px; background: none; border: none;">
			        <i class="fas fa-search text-primary search-icon"></i>
			    </button>
			    <input type="text" id="warehouseGroupText" name="warehouseGroup" placeholder="出荷倉庫">
			    <div class="additional-filters" style="display: none;">
			        <label for="warehouseGroup" id="warehousekaisoGroup">出荷倉庫階層グループ</label>
			        <button id="warehouseGroupSearch" data-target="manager" style="cursor: pointer; padding: 10px; background: none; border: none;">
			            <i class="fas fa-search text-primary search-icon"></i>
			        </button>
			        <input type="text" id="warehouseGroupText" name="warehouseGroup" placeholder="出荷倉庫階層グループ">
			    </div>
			</div>
			<div id="project-filter">
			    <label for="project">プロジェクト</label>
			    <button type="button" class="toggle-button" id="projectbutton">▼</button>
			    <button id="projectGroupSearch" data-target="manager" style="cursor: pointer; padding: 10px; background: none; border: none;">
			        <i class="fas fa-search text-primary search-icon"></i>
			    </button>
			    <input type="text" id="projectGroupText" name="projectGroup" placeholder="プロジェクト">
			    <div class="additional-filters" style="display: none;">
			        <label for="projectGroup1">プロジェクトグループ1</label>
			        <button id="projectGroupSearch1" data-target="manager" style="cursor: pointer; background: none; border: none;">
			            <i class="fas fa-search text-primary search-icon"></i>
			        </button>
			        <input type="text" id="projectGroupText1" name="projectGroup1" placeholder="プロジェクトグループ1">
			    </div>
			    <div class="additional-filters" style="display: none;">
			        <label for="projectGroup2">プロジェクトグループ2</label>
			        <button id="projectGroupSearch2" data-target="manager" style="cursor: pointer; background: none; border: none;">
			            <i class="fas fa-search text-primary search-icon"></i>
			        </button>
			        <input type="text" id="projectGroupText2" name="projectGroup2" placeholder="プロジェクトグループ2">
			    </div>
			</div>
		    <div id="torihikisaki-filter">
			    <label for="torihikisaki">取引先</label>
			    <button type="button" class="toggle-button" id="torihikisakibutton">▼</button>
			    <button id="torihikisakiGroupSearch" data-target="manager" style="cursor: pointer; padding: 10px; background: none; border: none;">
			        <i class="fas fa-search text-primary search-icon"></i>
			    </button>
			    <input type="text" id="torihikisakiGroupText" name="projectGroup" placeholder="取引先名">
			    <div class="additional-filters" style="display: none;">
			        <label for="torihikisakiGroup1">取引先グループ1</label>
			        <button id="torihikisakiGroupSearch1" data-target="manager" style="cursor: pointer; background: none; border: none;">
			            <i class="fas fa-search text-primary search-icon"></i>
			        </button>
			        <input type="text" id="torihikisakiGroupText1" name="torihikisakiGroup1" placeholder="取引先グループ1">
			    </div>
			    <div class="additional-filters" style="display: none;">
			        <label for="torihikisakiGroup2">取引先グループ2</label>
			        <button id="torihikisakiGroupSearch2" data-target="manager" style="cursor: pointer; background: none; border: none;">
			            <i class="fas fa-search text-primary search-icon"></i>
			        </button>
			        <input type="text" id="torihikisakiGroupText2" name="torihikisakiGroup2" placeholder="取引先グループ2">
			    </div>
			    <div class="additional-filters" style="display: none;">
			        <label for="torihikisakikaisoGroup">取引先階層グループ</label>
			        <button id="torihikisakikaisoGroup" data-target="manager" style="cursor: pointer; background: none; border: none;">
			            <i class="fas fa-search text-primary search-icon"></i>
			        </button>
			        <input type="text" id="torihikisakikaisoGroup" name="torihikisakikaisoGroup" placeholder="取引先階層グループ">
			    </div>
			</div>
		    <div id="hinmoku-filter">
			    <label for="hinmoku">品目コード</label>
			    <button type="button" class="toggle-button" id="hinmokubutton">▼</button>
			    <button id="hinmokuGroupSearch" data-target="manager" style="cursor: pointer; padding: 10px; background: none; border: none;">
			        <i class="fas fa-search text-primary search-icon"></i>
			    </button>
			    <input type="text" id="hinmokuGroupText" name="hinmokuGroup" placeholder="品目コード">
			    <div class="checkbox-group">
			    	<div class="additional-filters" style="display: none;">
			        	<label style="font-size: 16px;">品目区分</label>
			            <span style="font-size: 16px;" class="checkbox-container">
			                <input type="checkbox" name="status" value="전체" checked>
			                <span class="custom-checkbox"></span> 全体
			            </span>
			            <span>|</span>
			            <span style="font-size: 16px;" class="checkbox-container">
			                <input type="checkbox" name="status" value="원재료" checked>
			                <span class="custom-checkbox"></span>原材料
			            </span>
			            <span style="font-size: 16px;" class="checkbox-container">
			                <input type="checkbox" name="status" value="부재료" checked>
			                <span class="custom-checkbox"></span> 副材料
			            </span>
			            <span style="font-size: 16px;" class="checkbox-container">
			                <input type="checkbox" name="status" value="제품" checked>
			                <span class="custom-checkbox"></span> 製品
			            </span>
			            <span style="font-size: 16px;" class="checkbox-container">
			                <input type="checkbox" name="status" value="반제품" checked>
			                <span class="custom-checkbox"></span> 半製品
			            </span>
			            <span style="font-size: 16px;" class="checkbox-container">
			                <input type="checkbox" name="status" value="상품" checked>
			                <span class="custom-checkbox"></span> 商品
			            </span>
			            <span style="font-size: 16px;" class="checkbox-container">
			                <input type="checkbox" name="status" value="무형상품" checked>
			                <span class="custom-checkbox"></span> 無形商品
			            </span>
		            </div>
		        </div>
			    <div class="additional-filters" style="display: none;">
			        <label for="hinmokuGroup1">品目グループ1</label>
			        <button id="hinmokuGroupSearch1" data-target="manager" style="cursor: pointer; background: none; border: none;">
			            <i class="fas fa-search text-primary search-icon"></i>
			        </button>
			        <input type="text" id="hinmokuGroupText1" name="hinmokuGroup1" placeholder="品目グループ1">
			    </div>
			    <div class="additional-filters" style="display: none;">
			        <label for="hinmokuGroup2">品目グループ2</label>
			        <button id="hinmokuGroupSearch2" data-target="manager" style="cursor: pointer; background: none; border: none;">
			            <i class="fas fa-search text-primary search-icon"></i>
			        </button>
			        <input type="text" id="hinmokuGroupText2" name="hinmokuGroup2" placeholder="品目グループ2">
			    </div>
			    <div class="additional-filters" style="display: none;">
			        <label for="hinmokuGroup3">品目グループ3</label>
			        <button id="hinmokuGroupSearch3" data-target="manager" style="cursor: pointer; background: none; border: none;">
			            <i class="fas fa-search text-primary search-icon"></i>
			        </button>
			        <input type="text" id="hinmokuGroupText3" name="hinmokuGroup3" placeholder="品目グループ3">
			    </div>
			    <div class="additional-filters" style="display: none;">
			        <label for="hinmokukaisoGroup">品目階層グループ</label>
			        <button id="hinmokukaisoGroup" data-target="manager" style="cursor: pointer; background: none; border: none;">
			            <i class="fas fa-search text-primary search-icon"></i>
			        </button>
			        <input type="text" id="hinmokukaisoGroup" name="hinmokukaisoGroup" placeholder="品目階層グループ">
			    </div>
			</div>
		    <div id="misc">
		        <div class="checkbox-group">
		        	<label style="font-size: 16px;">その外</label>
		            <label class="checkbox-container" style="font-size: 16px;">
		            <input type="checkbox" name="etc" value="기타">
		            <span class="custom-checkbox"></span>修正日付順(整列)
		            </label>
		        </div>
		    </div>
		    <div id="shipment-status">
		        <div class="radio-group">
		        	<label style="font-size: 16px;">発送可否</label>
		            <label style="font-size: 16px;"><input type="radio" name="shipment_status" value="전체" checked > 全体</label>
		            <label style="font-size: 16px;"><input type="radio" name="shipment_status" value="미발송"> 未発送</label>
		            <label style="font-size: 16px;"><input type="radio" name="shipment_status" value="발송"> 発送</label>
		        </div>
		    </div>
		    <div id="order-filter">
			    <label for="order">オーダー管理番号</label>
			    <button id="orderGroupSearch" data-target="manager" style="cursor: pointer; padding: 10px; background: none; border: none;">
			        <i class="fas fa-search text-primary search-icon"></i>
			    </button>
			    <input type="text" id="orderGroupText" name="orderGroup" placeholder="オーダー管理番号">
			</div>
		    <div id="specification">
		        <label>規格</label>
		        <input type="text" id="specificationGroupText" name="specificationGroup" placeholder="規格">
		    </div>
		    <div id="tantousha-filter">
			    <label for="tantousha">担当者</label>
			    <button id="tantoushaGroupSearch" data-target="manager" style="cursor: pointer; padding: 10px; background: none; border: none;">
			        <i class="fas fa-search text-primary search-icon"></i>
			    </button>
			    <input type="text" id="tantoushaGroupText" name="tantoushaGroup" placeholder="担当者">
			</div>
		    <div id="torihikisakitantousha-filter">
			    <label for="torihikisakitantousha">取引先管理担当者</label>
			    <button id="torihikisakitantoushaGroupSearch" data-target="manager" style="cursor: pointer; padding: 10px; background: none; border: none;">
			        <i class="fas fa-search text-primary search-icon"></i>
			    </button>
			    <input type="text" id="torihikisakitantoushaGroupText" name="torihikisakitantoushaGroup" placeholder="取引先管理担当者">
			</div>
		    <div id="accounting-status">
		        <div class="checkbox-group">
		        	<label style="font-size: 16px;">会計反映可否</label>
		            <label style="font-size: 16px;" class="checkbox-container">
		                <input type="checkbox" name="status" value="전체" checked>
		                <span class="custom-checkbox"></span> 全体
		            </label>
		            <span>|</span>
		            <label style="font-size: 16px;" class="checkbox-container">
		                <input type="checkbox" name="status" value="미청구" checked>
		                <span class="custom-checkbox"></span> 未請求
		            </label>
		            <label style="font-size: 16px;" class="checkbox-container">
		                <input type="checkbox" name="status" value="청구" checked>
		                <span class="custom-checkbox"></span> 請求
		            </label>
		        </div>
		    </div>   
		    <div id="sales-category">
		        <div class="radio-group">
		        	<label style="font-size: 16px;">販売区分</label>
		            <label style="font-size: 16px;"><input type="radio" name="sales_category" value="전체" checked> 全体</label>
		            <label style="font-size: 16px;"><input type="radio" name="sales_category" value="판매"> 販売</label>
		            <label style="font-size: 16px;"><input type="radio" name="sales_category" value="판매II"> 販売II</label>
		        </div>
		    </div>
		    <div id="add-new-hinmoku">
		        <label>新項目追加</label>
		        <input type="text" id="addNew" placeholder="新項目追加">
		    </div>
		    <div id="bond-number">
		        <label>債券番号</label>
		        <input type="text" id="addNew" placeholder="債券番号">
		    </div>
		    <div id="initial-filter">
			    <label for="initial">最初作成者</label>
			    <button id="initialGroupSearch" data-target="manager" style="cursor: pointer; padding: 10px; background: none; border: none;">
			        <i class="fas fa-search text-primary search-icon"></i>
			    </button>
			    <input type="text" id="initialGroupText" name="initialGroup" placeholder="最初作成者">
			</div>
		    <div id="final-filter">
			    <label for="final">最終修正者</label>
			    <button id="finalGroupSearch" data-target="manager" style="cursor: pointer; padding: 10px; background: none; border: none;">
			        <i class="fas fa-search text-primary search-icon"></i>
			    </button>
			    <input type="text" id="finalGroupText" name="finalGroup" placeholder="最終修正者">
			</div>
		    <div id="initial-date">
		        <label>最初作成日</label>
		        <input type="date" id="startDate">
		        <label for="endDate">~</label>
		        <input type="date" id="endDate">
		    </div>
		    <div id="final-date">
		        <label>最終作業日</label>
		        <input type="date" id="startDate">
		        <label for="endDate">~</label>
		        <input type="date" id="endDate">
		    </div>
		    <div id="input-method">
		        <div class="checkbox-group">
		        	<label style="font-size: 16px;">入力経路</label>
		            <label style="font-size: 16px;" class="checkbox-container">
		                <input type="checkbox" name="status" value="전체" checked>
		                <span class="custom-checkbox"></span> 全体
		            </label>
		            <span>|</span>
		            <label style="font-size: 16px;" class="checkbox-container">
		                <input type="checkbox" name="status" value="웹(ERP)" checked>
		                <span class="custom-checkbox"></span> ウェブ(ERP)
		            </label>
		            <label style="font-size: 16px;" class="checkbox-container">
		                <input type="checkbox" name="status" value="자료올리기" checked>
		                <span class="custom-checkbox"></span> データアップロード
		            </label>
		            <label style="font-size: 16px;" class="checkbox-container">
		                <input type="checkbox" name="status" value="기타" checked>
		                <span class="custom-checkbox"></span> その外
		            </label>
		        </div>
		    </div>
		    <div id="delete-status">
		        <div class="radio-group">
		        	<label style="font-size: 16px;">削除区分</label>
		            <label style="font-size: 16px;"><input type="radio" name="delete_status" value="전체"> 全体</label>
		            <label style="font-size: 16px;"><input type="radio" name="delete_status" value="미삭제" checked> 削除</label>
		            <label style="font-size: 16px;"><input type="radio" name="delete_status" value="삭제"> 未削除</label>
		        </div>
		    </div>
		    <div id="applied-format">
		        <label>適用様式</label>
		        <input type="text" id="addNew" placeholder="基本様式">
		    </div>
		    <div id="search-button">
		        <button type="submit" style="padding: 10px 20px;">検索</button>
		    </div>
		</form>
    </div>
</div>

<!-- 판매수정 모달  -->
<div id="modal" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 800px; background: #fff; border: 1px solid #ccc; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); z-index: 1000; border-radius: 8px;">
	<div style="padding: 20px; font-family: Arial, sans-serif;">
		<h2 style="margin-bottom: 20px; text-align: left;">販売修正</h2>
		<form action="shipmentcorrection" method="post">
			<!--  첫 번째 행 -->
			<div style="display: flex; margin-bottom: 10px;">
				<label for="hitsuke_no" style="width: 120px; margin-right: 10px;">日付:</label>
				<input type="text" id="hitsuke_no" name="hitsuke_no" readonly style="flex: 1; border: 1px solid #ccc; padding: 5px;"> 
				<label for="torihikisakiID" style="width: 120px; margin-right: 10px;">取引先:</label>
				<input type="text" id="torihikisakiID" name="torihikisakiID" style="flex: 1; border: 1px solid #ccc; padding: 5px; width: 100px;">
				<p id="findTorihikisakiList" onclick="findTorihikisakiList()">
					<button type="button" id="findTorihikisaki" class="search-button">
						<i class="fas fa-search text-primary"></i>
					</button>
				</p>
				<input type="text" id="torihikisakimei" name="torihikisakimei" style="flex: 1; border: 1px solid #ccc; padding: 5px; width: 100px;">
			</div>

			<!--   두 번째 행 -->
			<div style="display: flex; margin-bottom: 10px;">
				<label for="tantoushaID" style="width: 120px; margin-right: 10px;">担当者:</label>
				<input type="text" id="tantoushaID" name="tantoushaID" style="flex: 1; border: 1px solid #ccc; padding: 5px; width: 100px;">
				<p id="findTtantoushaList" onclick="findTtantoushaList()">
					<button type="button" id="tantoushaID" class="search-button">
						<i class="fas fa-search text-primary"></i>
					</button>
				</p>
				<input type="text" id="tantoushaMai" name="tantoushaMai" style="flex: 1; border: 1px solid #ccc; padding: 5px; width: 100px;">
				<label for="soukoID" style="width: 120px; margin-right: 10px;">出荷倉庫:</label>
				<input type="text" id="soukoID" name="soukoID" style="flex: 1; border: 1px solid #ccc; padding: 5px; width: 100px;">
				<p id="findSoukoList" onclick="findSoukoList()">
					<button type="button" id="soukoID" class="search-button">
						<i class="fas fa-search text-primary"></i>
					</button>
				</p>
				<input type="text" id="soukoMai" name="soukoMai" style="flex: 1; border: 1px solid #ccc; padding: 5px; width: 100px">
			</div>
			<!--  세 번째 행 -->
			<div style="display: flex; margin-bottom: 10px;">
				<select onchange="update(this.value, ${hanbai.zeikomikubun})">
					<option value="進行中" ${hanbai.zeikomikubuni == 'Y' ? 'selected' : ''}>付加価値税率適用</option>
					<option value="完了" ${hanbai.zeikomikubuni == 'N' ? 'selected' : ''}>付加価値税率未適用</option>
				</select>
				<label for="purojekutoID" style="width: 120px; margin-right: 10px;">プロジェクト:</label>
				<input type="text" id="purojekutoID" name="purojekutoID" style="flex: 1; border: 1px solid #ccc; padding: 5px; width: 100px;">
				<p id="findProjectList" onclick="findProjectList()">
					<button type="button" id="purojekutoID" class="search-button">
						<i class="fas fa-search text-primary"></i>
					</button>
				</p>
				<input type="text" id="purojekutoMai" name="purojekutoMai" style="flex: 1; border: 1px solid #ccc; padding: 5px; width: 100px;">
			</div>
			
			<!--        네 번째 행 -->
			<div style="display: flex; margin-bottom: 10px;">
				<label for="shukkaYoteibi" style="width: 120px; margin-right: 10px;">出荷予定日:</label>
				<input type="date" id="shukkaYoteibi" name="shukkaYoteibi" style="flex: 1; border: 1px solid #ccc; padding: 5px;"> 
				<label for="yuubinBangou" style="width: 120px; margin: 0 10px;">郵便番号:</label>
				<input type="text" id="yuubinBangou" name="yuubinBangou" style="flex: 1; border: 1px solid #ccc; padding: 5px;">
			</div>

			<div style="margin-bottom: 10px;">
				<button type="button" onclick="showSearchBox()"
					style="padding: 5px 10px; margin-right: 5px;">さがし(F3)</button>
				<button type="button" onclick="sortItems()"
					style="padding: 5px 10px; margin-right: 5px;">整列</button>
				<button type="button" onclick="showList()"
					style="padding: 5px 10px; margin-right: 5px;">取引内訳見る</button>
				<button type="button" onclick="myProducts()"
					style="padding: 5px 10px; margin-right: 5px;">My品目</button>
				<button type="button" onclick="order()"
					style="padding: 5px 10px; margin-right: 5px;">主文</button>
				<button type="button" onclick="purchase()"
					style="padding: 5px 10px; margin-right: 5px;">購買</button>
				<button type="button" onclick="discount()"
					style="padding: 5px 10px; margin-right: 5px;">割引</button>
				<button type="button" onclick="reorderStock()"
					style="padding: 5px 10px; margin-right: 5px;">在庫ロード</button>
				<button type="button" onclick="loadedBarcode()"
					style="padding: 5px 10px; margin-right: 5px;">呼び寄せた伝票</button>
				<button type="button" onclick="barcode()"
					style="padding: 5px 10px; margin-right: 5px;">バーコード</button>
				<button type="button" onclick="seikyuBarcode()"
					style="padding: 5px 10px; margin-right: 5px;">伝票バーコード</button>
				<button type="button" onclick="verification()"
					style="padding: 5px 10px; margin-right: 5px;">検証</button>
				<button type="button" onclick="earnCal()"
					style="padding: 5px 10px; margin-right: 5px;">利益計算</button>
				<button type="button" onclick="loadBarcode()"
					style="padding: 5px 10px; margin-right: 5px;">伝票ロード</button>
			</div>

			<div style="margin-top: 20px;">
				<table id="itemTable"
					style="width: 100%; border: 1px solid #ccc; border-collapse: collapse; text-align: center;">
					<thead>
						<tr style="background-color: #f1f1f1;">
							<th style="border: 1px solid #ccc; padding: 5px; width: 5%;">番号</th>
							<th style="border: 1px solid #ccc; padding: 5px; width: 5%;"></th>
							<th style="border: 1px solid #ccc; padding: 5px;">品目コード</th>
							<th style="border: 1px solid #ccc; padding: 5px;">品目名</th>
							<th style="border: 1px solid #ccc; padding: 5px;">規格</th>
							<th style="border: 1px solid #ccc; padding: 5px;">数量</th>
							<th style="border: 1px solid #ccc; padding: 5px;">単価</th>
							<th style="border: 1px solid #ccc; padding: 5px;">供給価額</th>
							<th style="border: 1px solid #ccc; padding: 5px;">付加価値税</th>
							<th style="border: 1px solid #ccc; padding: 5px;">新項目追加</th>
						</tr>
					</thead>
					<tbody>
						<!-- 첫 번째 항목 -->
						<tr>
							<td
								style="border: 1px solid #ccc; padding: 5px; text-align: center; vertical-align: middle;">1</td>
							<td style="border: 1px solid #ccc; padding: 5px; text-align: center; vertical-align: middle;">
								<button type="button" onclick="addRowInModal()">↓</button>
							</td>
							<td style="border: 1px solid #ccc; padding: 5px;">
							<input type="text" id="zaikoKoodo" placeholder="コード 入力" style="width: 100%;" onclick="storeTargetField(this); findhimokuList()" readonly>
							</td>
							<td style="border: 1px solid #ccc; padding: 5px;">
							<input type="text" id="hinmokuMei" placeholder="名前入力" style="width: 100%;" onclick="storeTargetField(this); findhimokuList()" readonly>
							</td>
							<td style="border: 1px solid #ccc; padding: 5px;">
							<input type="text" placeholder="規格入力" style="width: 100%;">
							</td>
							<td style="border: 1px solid #ccc; padding: 5px;">
							<input type="number" placeholder="数量入力" style="width: 100%;">
							</td>
							<td style="border: 1px solid #ccc; padding: 5px;">
							<input type="number" placeholder="単価入力" style="width: 100%;">
							</td>
							<td style="border: 1px solid #ccc; padding: 5px;">
							<input type="number" placeholder="供給価額入力" style="width: 100%;">
							</td>
							<td style="border: 1px solid #ccc; padding: 5px;">
							<input type="number" placeholder="付加価値税入力" style="width: 100%;">
							</td>
							<td style="border: 1px solid #ccc; padding: 5px;">
							<input type="text" placeholder="新項目追加" style="width: 100%;">
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<!-- 저장 버튼 -->
			<table style="width: 100%; margin-top: 20px;">
				<tr>
					<td colspan="7" style="text-align: left;">
						<div style="margin-top: 1px; text-align: left;">
							<button type="button" onclick="saveShipmentData()"
								style="padding: 5px 10px;">저장(F8)</button>
							<button type="button" style="padding: 1px 1px;">保存(F7)</button>
							<button type="reset" style="padding: 1px 1px;">会計伝票接続</button>
							<button type="button" style="padding: 1px 1px;">コピー</button>
							<button type="button" style="padding: 1px 1px;">返品処理</button>
							<button type="button" style="padding: 1px 1px;">現金集金</button>
							<button type="button" style="padding: 1px 1px;">以前</button>
							<button type="button" style="padding: 1px 1px;">次</button>
							<button type="button" style="padding: 1px 1px;">閉じる</button>
							<button type="button" style="padding: 1px 1px;">削除</button>
							<button type="button" style="padding: 1px 1px;">送</button>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</div>
<script>
//토글 버튼 공통 이벤트 // トグルボタン共通イベント
document.querySelectorAll(".toggle-button").forEach(button => {
    button.addEventListener("click", function () {
        const parent = this.closest("div"); 
        // 버튼이 포함된 가장 가까운 div 선택 // ボタンが含まれる最も近いdivを選択
        
        const additionalFilters = parent.querySelectorAll(".additional-filters");
        // 하위의 additional-filters 선택 // 子要素のadditional-filtersを選択

        // 필터의 display 상태 토글 // フィルターのdisplay状態をトグル
        additionalFilters.forEach(filter => {
            if (filter.style.display === "none" || filter.style.display === "") {
                filter.style.display = "flex"; 
                // 필터 표시 // フィルターを表示
                this.textContent = "▲"; 
                // 버튼 텍스트 변경 // ボタンテキストを変更
            } else {
                filter.style.display = "none"; 
                // 필터 숨기기 // フィルターを非表示
                this.textContent = "▼"; 
                // 버튼 텍스트 변경 // ボタンテキストを変更
            }
        });
    });
});

// 모든 체크박스 선택/해제 // すべてのチェックボックス選択/解除
function toggleAllCheckboxes(selectAllCheckbox) {
    const checkboxes = document.querySelectorAll('.row-checkbox');
    // 모든 행의 체크박스 선택 // すべての行のチェックボックスを選択
    checkboxes.forEach((checkbox) => {
        checkbox.checked = selectAllCheckbox.checked; 
        // 선택된 상태를 전체 선택 체크박스의 상태로 설정 // 選択された状態を全選択チェックボックスの状態に設定
    });
}

// 모달 열기 // モーダルを開く
document.getElementById("searchButton").addEventListener("click", function () {
    const modal = document.getElementById("modal1"); 
    // 모달 요소 가져오기 // モーダル要素を取得
    modal.classList.add("active"); 
    // 모달 활성화 // モーダルをアクティブ化
});

// 모달 닫기 // モーダルを閉じる
window.addEventListener("click", function (event) {
    const modal = document.getElementById("modal1"); 
    // 모달 요소 가져오기 // モーダル要素を取得
    if (event.target === modal) {
        modal.classList.remove("active"); 
        // 클릭한 대상이 모달일 경우 모달 비활성화 // クリックした対象がモーダルの場合、モーダルを非アクティブ化
    }
});

function showModal(hitsuke_No) {
    $("#modal").show();
    $("#modalBackground").show();
    $("#hitsuke_No").val(hitsuke_No);
    console.log(HanbaiID);
}
function closeModal() {
    $("#modal").hide();
    $("#modalBackground").hide();
}
function showSearchBox() {
    alert("찾기(F3) 기능 실행됨");
}
function sortItems() {
    alert("정렬 기능 실행됨");
}
function showList() {
    alert("거래내역보기 기능 실행됨");
}
function myProducts() {
    alert("My 품목 보기 실행됨");
}
function order() {
    alert("주문 기능 실행됨");
}
function purchase() {
    alert("구매 기능 실행됨");
}
function discount() {
    alert("할인 기능 실행됨");
}
function recondStock() {
    alert("재고불러오기 기능 실행됨");
}
function loadedBarcode() {
    alert("불러온전표 기능 실행됨");
}
function barcode() {
    alert("바코드 기능 실행됨");
}
function seikyuBarcode() {
    alert("전표 바코드 기능 실행됨");
}
function verification() {
    alert("검증 기능 실행됨");
}
function earnCal() {
    alert("이익계산 기능 실행됨");
}
function loadBarcode() {
    alert("전표불러오기 기능 실행됨");
}
function update(newStatus, shukkaShiziShoukaiID) {
    $.ajax({
        url: '/sale/update', // 업데이트 요청을 보낼 URL // 更新リクエストを送るURL
        type: 'POST', // 요청 방식: POST // リクエスト方法: POST
        data: {
            saleID: saleID, // 판매 ID 데이터 // 販売IDデータ
            // shinkouZyoutai: newStatus // 진행 상태 (현재 주석 처리됨) // 進行状態 (現在コメントアウトされている)
        },
        success: function(response) {
            alert("상태가 성공적으로 업데이트되었습니다. " + newStatus);
            // 상태 업데이트 성공 알림 // 状態更新成功のアラート

            window.location.reload(); 
            // 알림창 확인 후 페이지 새로고침 // アラート確認後にページをリロード
        },
        error: function(xhr, status, error) {
            alert("업데이트 실패: " + error); 
            // 업데이트 실패 알림 // 更新失敗のアラート

            console.log(saleID, newStatus); 
            // 콘솔에 디버그 정보 출력 // コンソールにデバッグ情報を出力
        }
    });
}

let rowCount = 2; // 행 번호 카운터 초기값 // 行番号カウンターの初期値

function addRowInModal() {
    const table = document.getElementById('itemTable').getElementsByTagName('tbody')[0];
    // 테이블의 tbody 요소 가져오기 // テーブルのtbody要素を取得

    const newRow = table.insertRow(); 
    // 새로운 행 추가 // 新しい行を追加

    // 각 셀 생성 및 추가 // 各セルを生成して追加
    const cell1 = newRow.insertCell(0);
    const cell2 = newRow.insertCell(1);
    const cell3 = newRow.insertCell(2);
    const cell4 = newRow.insertCell(3);
    const cell5 = newRow.insertCell(4);
    const cell6 = newRow.insertCell(5);
    const cell7 = newRow.insertCell(6);
    const cell8 = newRow.insertCell(7);
    const cell9 = newRow.insertCell(8);
    const cell10 = newRow.insertCell(9);

    // 셀 내용 설정 // セル内容の設定
    cell1.style.textAlign = "center"; 
    cell1.innerHTML = rowCount++; 
    // 행 번호 자동 증가 // 行番号の自動増加

    cell2.style.textAlign = "center"; 
    cell2.innerHTML = '<button type="button" onclick="addRowInModal()">↓</button>';
    // 행 추가 버튼 // 行追加ボタン

    cell3.innerHTML = '<input type="text" placeholder="코드 입력" style="width: 95%;" onclick="findhimokuList()" readonly>';
    // 코드 입력 필드 // コード入力フィールド

    cell4.innerHTML = '<input type="text" placeholder="이름 입력" style="width: 100%;" onclick="findhimokuList()" readonly>';
    // 이름 입력 필드 // 名前入力フィールド

    cell5.innerHTML = '<input type="text" placeholder="규격 입력" style="width: 100%;">';
    // 규격 입력 필드 // 規格入力フィールド

    cell6.innerHTML = '<input type="number" placeholder="수량 입력" style="width: 100%;">';
    // 수량 입력 필드 // 数量入力フィールド

    cell7.innerHTML = '<input type="number" placeholder="단가 입력" style="width: 100%;">';
    // 단가 입력 필드 // 単価入力フィールド

    cell8.innerHTML = '<input type="number" placeholder="공급가액 입력" style="width: 100%;">';
    // 공급가액 입력 필드 // 供給価格入力フィールド

    cell9.innerHTML = '<input type="number" placeholder="부가세 입력" style="width: 100%;">';
    // 부가세 입력 필드 // 付加価値税入力フィールド

    cell10.innerHTML = '<input type="text" placeholder="새로운 항목 추가" style="width: 100%;">';
    // 새로운 항목 추가 필드 // 新しい項目追加フィールド
}
// 담당자 리스트 불러오기 //担当者リストの読み込み
function findTtantoushaList() {
    $.ajax({
        url: '/common/tantoushaList',
        contentType: 'application/json',
        dataType: 'json',
        type: 'GET',
        headers: { "Accept": "application/json" },
        success: function(data) {
            let tableBody = $(".modal_body tbody");
            tableBody.empty();
            data.forEach(function(item) {
                let row = "<tr onclick=\"selectTantousha('" + sale.tantoushaID + "', '" + sale.tantoushamei + "')\">";
                row += "<td>" + sale.tantoushaID + "</td>";
                row += "<td>" + sale.tantoushamei + "</td>";
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

function selectTantousha(tantoushaID, tantoushaMai) {
    document.getElementById('tantoushaID').value = tantoushaID;
    document.getElementById('tantoushamei').value = tantoushamei;
    ComcloseModal();
}

// 창고 리스트 불러오기 //倉庫リスト読み込み
function findSoukoList() {
    $.ajax({
        url: '/common/soukoList',
        contentType: 'application/json',
        dataType: 'json',
        type: 'GET',
        headers: { "Accept": "application/json" },
        success: function(data) {
            let tableBody = $(".modal_body tbody");
            tableBody.empty();
            data.forEach(function(item) {
                let row = "<tr onclick=\"selectSouko('" + sale.soukoID + "', '" + sale.soukomei + "')\">";
                row += "<td>" + sale.soukoID + "</td>";
                row += "<td>" + sale.soukomei + "</td>";
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

function selectSouko(soukoID, soukomei) {
    document.getElementById('soukoID').value = soukoID;
    document.getElementById('soukomei').value = soukomei;
    ComcloseModal();
}

// 거래처 리스트 불러오기 //取引先リストの読み込み
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
                let row = "<tr onclick=\"selectTorihikisaki('" + sale.torihikisakiID + "', '" + sale.torihikisakimei + "')\">";
                row += "<td>" + sale.torihikisakiID + "</td>";
                row += "<td>" + sale.torihikisakimei + "</td>";
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

function selectTorihikisaki(torihikisakiID, torihikisakimei) {
    document.getElementById('torihikisakiID').value = torihikisakiID;
    document.getElementById('torihikisakimei').value = torihikisakimei;
    ComcloseModal();
}

// 프로젝트 리스트 불러오기 //プロジェクトリストの読み込み
function findProjectList() {
    $.ajax({
        url: '/common/projectList',
        contentType: 'application/json',
        dataType: 'json',
        type: 'GET',
        headers: { "Accept": "application/json" },
        success: function(data) {
            let tableBody = $(".modal_body tbody");
            tableBody.empty();
            data.forEach(function(item) {
                let row = "<tr onclick=\"selectProject('" + sale.projectID + "', '" + sale.projectmeimei + "')\">";
                row += "<td>" + sale.projectID + "</td>";
                row += "<td>" + sale.projectmeimei + "</td>";
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

function selectProject(projectID, projectMeimei) {
    document.getElementById('projectID').value = projectID;
    document.getElementById('projectmei').value = projectMeimei;
    ComcloseModal();
}

let selectedInputField = null; // 押されたフィールドを保存する全域変数

function storeTargetField(inputField) {
    selectedInputField = inputField; // 눌린 필드를 저장  //押されたフィールドを保存
}
//품목 불러오기  品目読み込み
function findhimokuList() {
    $.ajax({
        url: '/common/hinmokuList',
        contentType: 'application/json',
        dataType: 'json',
        type: 'GET',
        headers: { "Accept": "application/json" },
        success: function(data) {
            let tableBody = $(".modal_body tbody");
            tableBody.empty();
            data.forEach(function(item) {
                let row = "<tr onclick=\"selectAllHinmoku('" + sale.zaikoKoodo + "', '" + sale.hinmokuMei + "')\">";
                row += "<td>" + sale.zaikoKoodo + "</td>";
                row += "<td>" + sale.hinmokuMei + "</td>";
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

function selectAllHinmoku(zaikoKoodo, hinmokuMei) {
    if (selectedInputField) {
        const row = selectedInputField.closest('tr'); // 클릭된 필드의 부모 행(tr)을 찾음

        // 품목코드 입력 필드에 값 설정  //品目コード入力フィールドに値設定
        const codeField = row.querySelector('.zaikoKoodo');
        if (codeField) codeField.value = zaikoKoodo;

        // 품목명 입력 필드에 값 설정  //品目名入力フィールドに値設定
        const nameField = row.querySelector('.hinmokuMei');
        if (nameField) nameField.value = hinmokuMei;
    }
    ComcloseModal();
}
function ComcloseModal() {
    $(".detail_list_modal_back").css("display", "none");
    $(".detail_list_modal").css("display", "none");
    $(".modal_body tbody").empty();
}
</script>

<%@ include file="../includes/footer.jsp" %>