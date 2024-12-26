<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>

<div class="container-fluid px-4">
	<h1 class="mt-4">未販売現況</h1>

	<!-- 검색 폼 -->
	<form class="d-flex mb-4" method="get"
		action="<c:url value='/unsold/list' />">
		<input class="form-control me-2" type="text" name="search"
			placeholder="検索ワードを入力してください···" />
		<button class="btn btn-primary" type="submit">検索</button>
	</form>

	<!-- 테이블 -->
	<table class="table table-bordered">
		<thead class="table-light">
			<tr>
				<th>日付-No.</th>
				<th>品目名(規格)</th>
				<th>数量</th>
				<th>未販売数量</th>
				<th>未販売供給価格</th>
				<th>取引先名</th>
				<th>摘要</th>
				<th>品目別納期日</th>
				<th>未販売付加税</th>
			</tr>

		</thead>
		<tbody>
			<c:forEach var="item" items="${unsoldList}">
				<tr>
					<!-- 일자-No -->
					<td>${item.hitsukeNo}</td>

					<!-- 품목명(규격) -->
					<td>${item.hinmokuMei}[${item.kikaku}]</td>

					<!-- 수량 -->
					<td>${item.suuryou}</td>

					<!-- 미판매 수량 -->
					<td>${item.mihanbaisuuryou}</td>

					<!-- 미판매 공급가액 -->
					<td>${item.mihanbaikyoukyukingaku}</td>

					<!-- 거래처명 -->
					<td>${item.torihikisakiMei}</td>

					<!-- 적요 -->
					<td>${item.tekiyo}</td>

					<!-- 품목별납기일자 -->
					<td>${item.noukiIchija}</td>

					<!-- 미판매부가세 -->
					<td>${item.mihanbaibugase}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<!-- 하단 버튼 -->
	<div class="mt-4">
		<button class="btn btn-secondary"
			onclick="location.href='<c:url value='/unsold/exportExcel' />'">エクセル
			ダウンロード</button>
		<button class="btn btn-primary"
			onclick="location.href='<c:url value='/unsold/print' />'">印刷</button>
	</div>
</div>

<%@ include file="../includes/footer.jsp"%>
