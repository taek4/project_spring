<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<!-- //김영민
//金榮珉 -->
<div class="container-fluid px-4">
	<div class="button-container">
    	<h3 class="mt-4">販売現状</h3>
    </div>
    <div>
    	<table class="table table-bordered" id="salesTable">
        <thead class="table-light">
    			<tr>
    				<th>日付</th>
    				<th>品目名</th>
    				<th>数量</th>
    				<th>単価</th>
    				<th>供給価額</th>
    				<th>付加価値税</th>
    				<th>合計</th>
    				<th>取引先名</th>
    			</tr>
    		</thead>
    		<tbody>
	    		<c:forEach var="hanbai" items="${saleList}">
			        <tr>
						<td>${hanbai.hitsuke}</td>
			            <td>${hanbai.hinmokumei}</td>
			            <td>${hanbai.suuryou}</td>
			            <td>${hanbai.tanka}</td>
			            <td>${hanbai.kyoukyuKingaku_sum}</td>
			            <td>${hanbai.bugase_sum}</td>
			            <td>${hanbai.kessaikingaku_sum}</td>
			            <td>${hanbai.torihikisakimei}</td>
			        </tr>
			    </c:forEach>
    		</tbody>
			<tfoot>
            	<tr class="total-row">
                	<td colspan="2" style="text-align: center;">総合計</td>
                	<td id="totalQuantity"></td>
                	<td id="totalUnitPrice"></td>
                	<td id="totalSupply"></td>
                	<td id="totalTax"></td>
                	<td id="totalSum"></td>
                	<td></td>
            	</tr>
        	</tfoot>
    	</table>
    </div>
</div>

<script>
function calculateTotals() {
    const table = document.getElementById('salesTable'); // 판매 테이블 가져오기 // 売上テーブルを取得
    const rows = table.querySelectorAll('tbody tr'); // 테이블의 모든 행 선택 // テーブルのすべての行を選択
    let totalQuantity = 0; // 총 수량 합계를 저장할 변수 // 総数量の合計を保存する変数
    let totalUnitPrice = 0; // 단가 합계를 위한 변수 // 単価の合計を保存する変数
    let totalSupply = 0; // 공급가액 합계를 저장할 변수 // 供給価額の合計を保存する変数
    let totalTax = 0; // 부가세 합계를 저장할 변수 // 付加価値税の合計を保存する変数
    let totalSum = 0; // 총합계를 저장할 변수 // 総合計を保存する変数

    rows.forEach(row => {
        const cells = row.querySelectorAll('td'); // 각 행의 모든 셀 선택 // 各行のすべてのセルを選択
        totalQuantity += parseFloat(cells[2].textContent) || 0; // 수량 합계 계산 // 数量の合計を計算

        // 단가 합계 계산 // 単価の合計を計算
        const unitPrice = parseFloat(cells[3].textContent) || 0;
        totalUnitPrice += unitPrice;

        totalSupply += parseFloat(cells[4].textContent) || 0; // 공급가액 합계 계산 // 供給価額の合計を計算
        totalTax += parseFloat(cells[5].textContent) || 0; // 부가세 합계 계산 // 付加価値税の合計を計算
        totalSum += parseFloat(cells[6].textContent) || 0; // 총합계 계산 // 総合計を計算
    });

    document.getElementById('totalQuantity').textContent = totalQuantity; // 총 수량 표시 // 総数量を表示
    document.getElementById('totalUnitPrice').textContent = totalUnitPrice; // 단가 합계를 표시 // 単価の合計を表示
    document.getElementById('totalSupply').textContent = totalSupply; // 공급가액 표시 // 供給価額を表示
    document.getElementById('totalTax').textContent = totalTax; // 부가세 표시 // 付加価値税を表示
    document.getElementById('totalSum').textContent = totalSum; // 총합계 표시 // 総合計を表示
}

// 총합계 계산 실행 // 総合計を計算して実行
window.onload = calculateTotals;
</script>

<%@ include file="../includes/footer.jsp" %>
