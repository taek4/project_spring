<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<!-- //김영민
//金榮珉 -->
<style>
.button-container{
	display: flex;
	align-items: center;
	gap: 10px;
}
.button {
	width: 90px;
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
</style>
<div class="container-fluid px-4">
	<div class="button-container">
    	<h3 class="mt-4">決済履歴照会</h3>
        <button class="button">全体</button>
        <button class="button">未反映</button>
        <button class="button">会計反映</button>
        <button class="button">強制会計反映</button>
    </div>
    <div>
    	<table class="table table-bordered">
        <thead class="table-light">
    			<tr>
    				<th><input type="checkbox" id="selectAll" onclick="toggleAllCheckboxes(this)"></th>
                    <th>決済要請日時</th>
    				<th>決済要請者ID</th>
    				<th>取引先</th>
    				<th>品目</th>
    				<th>決済金額</th>
    				<th>決済方法</th>
    				<th>決済状態</th>
    				<th>承認番号</th>
    				<th>在庫伝票</th>
    				<th>状態別処理機能</th>
    				<th>会計伝票</th>
    				<th>内訳</th>
    				<th>領収書印刷</th>
    			</tr>
    		</thead>
    		<tbody>
	    		<c:forEach var="kessai" items="${saleList}">
			        <tr>
			            <td><input type="checkbox" class="row-checkbox"></td>
						<td>${kessai.kessaiyouseibi}</td>
			            <td>${kessai.kessaiyouseishaID}</td>
			            <td>${kessai.torihikisakimei}</td>
			            <td>${kessai.hinmokumei}</td>
			            <td>${kessai.kessaikingaku}</td>
			            <td>${kessai.kessaihouhou}</td>
			            <td>${kessai.kessaizyoutai}</td>
			            <td>${kessai.shouninbangou}</td>
			            <td>${kessai.zaikodenpyo}</td>
			            <td>${kessai.jyotaibetsushorikinou}</td>
			            <td>${kessai.kaikeidenpyo}</td>
			            <td>${kessai.uchiwake}</td>
			            <td><button>印刷</button></td>
			        </tr>
			    </c:forEach>
    		</tbody>
    	</table>
    </div>
</div>

<%@ include file="../includes/footer.jsp" %>
