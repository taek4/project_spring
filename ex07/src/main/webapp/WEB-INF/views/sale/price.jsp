<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<!-- //김영민
//金榮珉 -->
<div class="container-fluid px-4">
    <h3 class="mt-4">販売単価一括変更</h3>
	<div  style="font-size: 16px;">
	    <div class="modal-content">
	        <form>
	        	<div>
	        		<label for="kubun">区分</label>
	        		<label style="font-size: 16px;"><input type="radio" name="kubun_category" value="단가변경" checked>単価変更</label>
	        		<label style="font-size: 16px;"><input type="radio" name="kubun_category" value="환율변경"> 換率変更</label>
	        	</div>
			    <div id="date-range">
			        <label for="startDate">基準日付</label>
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
			    <div>
			    	<label for="currency">內,外資区分</label>
			    	<label style="font-size: 16px;"><input type="radio" name="currency_category" value="내자" checked>內資</label>
			    	<label style="font-size: 16px;"><input type="radio" name="currency_category" value="외자" >外資</label>
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
				    <input type="text" id="hinmokuGroupText" name="hinmokuGroup" placeholder="取引先">
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
			    <div id="shinkoujyoutai">
			        <div class="checkbox-group">
			        	<label style="font-size: 16px;">進行状態</label>
			            <label style="font-size: 16px;" class="checkbox-container">
			                <input type="checkbox" name="status" value="전체" checked>
			                <span class="custom-checkbox"></span> 全体
			            </label>
			            <span>|</span>
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
			    <div id="search-button">
			    	<button class="button">
			    		<a class="nav-link" href="/sale/tanka">検索</a>
			    	</button>
			    </div>
			</form>
	    </div>
	</div>
</div>

<script>
document.querySelectorAll(".toggle-button").forEach(button => {
    button.addEventListener("click", function () {
        const parent = this.closest("div"); // 버튼이 포함된 가장 가까운 div 선택
        const additionalFilters = parent.querySelectorAll(".additional-filters"); // 하위의 additional-filters 선택

        // 필터의 display 상태 토글
        additionalFilters.forEach(filter => {
            if (filter.style.display === "none" || filter.style.display === "") {
                filter.style.display = "flex"; // 필터 표시
                this.textContent = "▲"; // 버튼 텍스트 변경
            } else {
                filter.style.display = "none"; // 필터 숨기기
                this.textContent = "▼"; // 버튼 텍스트 변경
            }
        });
    });
});

</script>
<%@ include file="../includes/footer.jsp" %>
