<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<!-- //김영민
//金榮珉 -->
<style>
label {
    margin-top: 10px;
}
.button-container{
	display: flex;
	align-items: center;
	gap: 10px;
}
.button {
	width: 60px;
	height: 40px;
	padding: 10px 0;
	text-align: center;
	border-radius: 15px;
	border: none;
	background-color: #d3daf7;
	color: #555;
	font-size: 14px;
	cursor: pointer;
	text-align: center;
	transition: all 0.3s ease;
}
.button:hover {
	background-color: #668FE7;
}
.button:focus, .button:active {
	background-color: #1B3DA1;
	color: white;
	border: none;
	outline: none;
}
#transactionGroupSearch {
    flex: 0 0 auto; /* 돋보기 아이콘 크기를 고정 */
    font-size: 16px; /* 아이콘 크기 */
    color: #007bff;
    cursor: pointer;
}
.additional-filters {
    display: flex; /* 플렉스 박스를 사용하여 자식 요소를 한 줄로 정렬 */
    align-hinmokus: center; /* 세로 방향 가운데 정렬 */
    gap: 10px; /* 요소 간 간격 설정 */
}
#warehouseGroupLabel {
    flex: 0 0 150px; /* 라벨의 고정 너비 설정 */
    font-weight: bold;
    text-align: left; /* 텍스트 왼쪽 정렬 */
}
#warehousebutton {
	width: 30px;
}
#warehouseGroupSearch {
    flex: 0 0 auto; /* 돋보기 아이콘 크기를 고정 */
    font-size: 16px; /* 아이콘 크기 */
    color: #007bff;
    cursor: pointer;
}
#warehouseGroupText {
    flex: 1; 
    border: 1px solid black;
    box-sizing: border-box;
}
.additional-filters {
    display: flex;
    align-hinmokus: center; /* 세로 정렬 중앙 */
    gap: 10px; /* 요소 간 간격 */
    margin-top: 5px;
}
/* 라벨 스타일 */
.additional-filters label {
    flex: 0 0 150px; /* 라벨 고정 너비 */
    font-weight: bold;
}
/* 입력 필드 스타일 */
.additional-filters input {
    flex: 1; /* 남은 공간 차지 */
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}
/* 돋보기 버튼 스타일 */
.additional-filters button {
    background: none;
    border: none;
    cursor: pointer;
    font-size: 16px;
    color: #007bff;
    padding: 10px;
    transition: transform 0.2s ease;
}
.additional-filters button:hover {
    transform: scale(1.1);
}
.checkbox-group {
    display: flex;
    align-hinmokus: center;
    gap: 5px;
    flex-wrap: wrap;
}
.checkbox-container {
    display: flex;
    align-hinmokus: center;
    gap: 5px;
    position: relative;
    font-size: 14px;
    cursor: pointer;
}
.checkbox-container input[type="checkbox"] {
    display: none;
}
.custom-checkbox {
    width: 16px;
    height: 16px;
    background-color: white;
    border: 2px solid #1B3DA1;
    border-radius: 5px;
    display: inline-block;
    position: relative;
}
.checkbox-container input[type="checkbox"]:checked + .custom-checkbox {
    background-color: #1B3DA1 !important; 
    border-color: #1B3DA1 !important;
}
.checkbox-container input[type="checkbox"]:checked + .custom-checkbox::after {
    content: '✔';
    color: white !important;
    font-size: 12px;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}
.checkbox-group span {
    margin: 0 5px;
    color: black;
}
.radio-group {
    display: flex;
    align-hinmokus: center;
    gap: 10px;
    margin-top: 10px;
    margin-bottom: 20px;
}
.radio-group label {
    font-size: 14px;
    display: flex;
    align-hinmokus: center;
    gap: 5px;
}
.radio-group input[type="radio"] {
    accent-color: #1B3DA1;
    cursor: pointer;
}
</style>

<div class="container-fluid px-4">
    <h3 class="mt-4">販売現状</h3>
    <divstyle="font-size: 16px;">
	    <div class="modal-content">
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
			            <label style="font-size: 16px;"><input type="radio" name="currency" value="전체" checked> 全体</label>
			            <label style="font-size: 16px;"><input type="radio" name="currency" value="내자"> 內資</label>
			            <label style="font-size: 16px;"><input type="radio" name="currency" value="외자"> 外資</label>
			        </div>
			    </div>
				<div id="warehouse-filter">
				    <label for="warehouse">出荷倉庫</label>
				    <button type="button" class="toggle-button" id="warehousebutton">▼</button>
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
				    <input type="text" id="torihikisakiGroupText" name="projectGroup" placeholder="取引先">
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
				                <span class="custom-checkbox"></span> 原材料
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
				<div>
			    	<label for="torihikikubun">取引区分</label>
	        		<label style="font-size: 16px;"><input type="radio" name="torihikikubun_category" value="전체" checked>全体</label>
	        		<label style="font-size: 16px;"><input type="radio" name="torihikikubun_category" value="일반"> 一般</label>
	        		<label style="font-size: 16px;"><input type="radio" name="torihikikubun_category" value="반품"> 返品</label>
			    </div>
			    <div id="order-filter">
				    <label for="order">オーダー管理番号</label>
				    <button id="orderGroupSearch" data-target="manager" style="cursor: pointer; padding: 10px; background: none; border: none;">
				        <i class="fas fa-search text-primary search-icon"></i>
				    </button>
				    <input type="text" id="orderGroupText" name="orderGroup" placeholder="オーダー管理番号">
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
				 <div id="tsuuka-filter">
				    <label for="tsuuka">通貨</label>
				    <button id="tsuukaGroupSearch" data-target="manager" style="cursor: pointer; padding: 10px; background: none; border: none;">
				        <i class="fas fa-search text-primary search-icon"></i>
				    </button>
				    <input type="text" id="tsuukaGroupText" name="tsuukaGroup" placeholder="通貨">
				</div>
				<div id="addnew">
			        <label>新項目追加</label>
			        <input type="text" id="addnewGroupText" name="addnewGroup" placeholder="新項目追加">
			    </div>
			    <div id="specification">
			        <label>規格</label>
			        <input type="text" id="specificationGroupText" name="specificationGroup" placeholder="規格">
			    </div>
			    <div id="suryuu">
			        <label>数量</label>
			        <input type="text" id="suryuuGroupText" name="suryuuGroup" placeholder="">
			    </div>
			    <div id="tanka">
			        <label>単価</label>
			        <input type="text" id="tankaGroupText" name="tankaGroup" placeholder="">
			    </div>
			    <div id="kyoukyuu">
			        <label>供給価額</label>
			        <input type="text" id="kyoukyuuGroupText" name="kyoukyuuGroup" placeholder="">
			    </div>
			    <div id="bugase">
			        <label>付加価値税</label>
			        <input type="text" id="bugaseGroupText" name="bugaseGroup" placeholder="">
			    </div>
			    <div id="addnew2">
			        <label>新項目追加</label>
			        <input type="text" id="addnew2GroupText" name="addnew2Group" placeholder="新項目追加">
			    </div>
			    <div id="sales-category">
			        <div class="radio-group">
			        	<label style="font-size: 16px;">販売区分</label>
			            <label style="font-size: 16px;"><input type="radio" name="sales_category" value="전체" checked> 全体</label>
			            <label style="font-size: 16px;"><input type="radio" name="sales_category" value="판매"> 販売</label>
			            <label style="font-size: 16px;"><input type="radio" name="sales_category" value="판매II"> 販売II</label>
			        </div>
			    </div>
			    <div id="shinkoujyoutai">
			        <div class="checkbox-group">
			        	<label style="font-size: 16px;">進行状態</label>
			            <label style="font-size: 16px;" class="checkbox-container">
			                <input type="checkbox" name="status" value="전체" checked>
			                <span class="custom-checkbox"></span> 全体
			            </label>
			            <span>|</span>
			            <label style="font-size: 16px;" class="checkbox-container">
			                <input type="checkbox" name="status" value="결제중" checked>
			                <span class="custom-checkbox"></span> 決済中
			            </label>
			            <label style="font-size: 16px;" class="checkbox-container">
			                <input type="checkbox" name="status" value="미확인" checked>
			                <span class="custom-checkbox"></span> 未確認
			            </label>
			            <label style="font-size: 16px;" class="checkbox-container">
			                <input type="checkbox" name="status" value="확인" checked>
			                <span class="custom-checkbox"></span> 確認
			            </label>
			        </div>
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
			    <div id="applied-format">
			        <label>適用様式</label>
			        <select id="addNew">
						<option value="" disabled selected>基本様式</option>
						<option value="transactionHistory">取引内訳見る</option>
						<option value="salesByRep">営業社員別販売状況</option>
						<option value="salesStatus">販売状況</option>
						<option value="tempSalesStatus">販売状況(臨時)</option>
						<option value="siteSalesStatus">現場別販売状況</option>
						<option value="status">状況</option>
					</select>
			    </div>
			    <div id="datasee">
			        <div class="checkbox-group">
			        	<label style="font-size: 16px;">データ表示形式</label>
			            <label style="font-size: 16px;" class="checkbox-container">
			                <input type="checkbox" name="status" value="그래프로 보기">
			                <span class="custom-checkbox"></span> グラフで見る
			            </label>
			        </div>
		    	</div>
			    <div id="search-button">
			       <button class="button">
			    		<a class="nav-link" href="/sale/genjou">検索</a>
			    	</button>
			    </div>
			</form>
	    </div>
	</div>
</div>

<<script>
document.querySelectorAll(".toggle-button").forEach(button => {
    button.addEventListener("click", function () {
        const parent = this.closest("div"); // 버튼이 포함된 가장 가까운 div 선택 // ボタンが含まれている最も近いdivを選択
        const additionalFilters = parent.querySelectorAll(".additional-filters"); // 하위의 additional-filters 선택 // 子要素のadditional-filtersを選択

        // 필터의 display 상태 토글 // フィルターのdisplay状態をトグル
        additionalFilters.forEach(filter => {
            if (filter.style.display === "none" || filter.style.display === "") {
                filter.style.display = "flex"; // 필터 표시 // フィルターを表示
                this.textContent = "▲"; // 버튼 텍스트 변경 // ボタンテキストを変更
            } else {
                filter.style.display = "none"; // 필터 숨기기 // フィルターを隠す
                this.textContent = "▼"; // 버튼 텍스트 변경 // ボタンテキストを変更
            }
        });
    });
});
</script>
<%@ include file="../includes/footer.jsp" %>
