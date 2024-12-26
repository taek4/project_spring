<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<!-- //김영민
//金榮珉 -->
<div class="container-fluid px-4">
    <h3 class="mt-4">決済履歴資料比較</h3>
    <divstyle="font-size: 16px;">
	    <div class="modal-content">
	        <h4>基本</h4>
	        <form>
			    <div id="date-range">
			        <label for="startDate">基準日</label>
			        <input type="date" id="startDate">
			        <label for="endDate">~</label>
			        <input type="date" id="endDate">
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
			    	<label for="siryoukijun">資料基準</label>
	        		<label style="font-size: 16px;"><input type="radio" name="siryoukijun_category" value="전체" checked>全体</label>
	        		<label style="font-size: 16px;"><input type="radio" name="siryoukijun_category" value="일치"> 一致</label>
	        		<label style="font-size: 16px;"><input type="radio" name="siryoukijun_category" value="불일치"> 不一致</label>
			    </div>
			     <div id="applied-format">
			        <label>適用様式</label>
			        <select id="addNew">
						<option value="" disabled selected>基本様式</option>
						<option value="transactionHistory">決済履歴資料比較</option>
					</select>
			    </div>
			    <div id="search-button">
			        <button type="submit" style="padding: 10px 20px; margin-top: 10px;">検索</button>
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
