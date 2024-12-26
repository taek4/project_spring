<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>


<style>
/* 공통 스타일 */
.page-title {
	text-align: center;
	margin: 20px 0;
	font-size: 28px;
	color: #555;
}

.filter-form {
	margin: 20px auto;
	background: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	width: 900px; /* 폼의 전체 너비 */
}

.form-row {
	display: flex;
	justify-content: space-between; /* 양옆 정렬 */
	align-items: center;
	margin-bottom: 15px;
	gap: 20px;
}

.form-group {
	display: flex;
	align-items: center; /* 라벨과 입력 필드를 수직 정렬 */
	gap: 10px;
	flex: 1; /* 양옆 그룹의 너비 균등 분배 */
}

.form-group label {
	font-weight: bold;
	width: 120px; /* 고정된 라벨 너비 */
	text-align: right; /* 텍스트 오른쪽 정렬 */
}

.form-input, .form-input-top {
	padding: 6px 10px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
	flex: 1; /* 입력 필드가 남은 공간을 채움 */
}

.form-input-top {
	max-width: 150px; /* 기준일자 필드 크기 */
}

.form-button {
	width: 100%;
	padding: 10px;
	font-size: 16px;
	background-color: #007BFF;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.form-button:hover {
	background-color: #0056b3;
}

/* 기준일자와 납기일자 라벨 간격 조정 */
.form-group.date-range {
	display: flex;
	align-items: center;
	gap: 5px; /* 라벨(~)과 입력 필드 사이 간격을 최소화 */
}

.form-group.date-range label {
	margin: 0; /* 라벨의 기본 margin 제거 */
	width: auto; /* 라벨의 너비를 내용에 맞춤 */
}

.form-group.date-range input {
	margin-right: 10px; /* 오른쪽 여백 추가로 통일감 유지 */
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
</style>
<h1 class="page-title">出荷指示書現況</h1>

<c:choose>
	<c:when test="${empty statusList}">
		<form class="filter-form" id="statusForm" method="post"
			action="<c:url value='/shipment/status'/>">
			<!-- 기준일자와 통화 필드 -->
			<div class="form-row">
				<div class="form-group date-range">
					<label for="nyuuryokuBiKaishi">基準日付:</label> <input
						class="form-input-top" type="date" id="nyuuryokuBiKaishi"
						name="nyuuryokuBiKaishi" value="${param.nyuuryokuBiKaishi}"
						pattern="\\d{4}/\\d{2}/\\d{2}" placeholder="yyyy/mm/dd" /> <label
						for="nyuuryokuBiShuuryou">~</label> <input class="form-input-top"
						type="date" id="nyuuryokuBiShuuryou" name="nyuuryokuBiShuuryou"
						value="${param.nyuuryokuBiShuuryou}"
						pattern="\\d{4}/\\d{2}/\\d{2}" placeholder="yyyy/mm/dd" />
				</div>
				<div class="form-group">
					<label>出荷倉庫:</label> <select class="form-input" name="soukoID">
						<option value="">出荷倉庫選択</option>
						<c:forEach var="souko" items="${soukoList}">
							<option value="${souko.soukoID}">${souko.soukomei}</option>
						</c:forEach>
					</select>
				</div>
			</div>

			<!-- 나머지 입력 필드 -->
			<div class="form-row">
				<div class="form-group">
					<label>プロジェクト:</label> <select class="form-input" name="projectID">
						<option value="">プロジェクト選択</option>
						<c:forEach var="project" items="${projectList}">
							<option value="${project.projectID}">${project.projectMeimei}</option>
						</c:forEach>
					</select>
				</div>
				<div class="form-group">
					<label>取引先:</label> <select class="form-input"
						name="torihikisakiID">
						<option value="">取引先選択</option>
						<c:forEach var="torihikisaki" items="${torihikisakiList}">
							<option value="${torihikisaki.torihikisakiID}">${torihikisaki.torihikisakimei}</option>
						</c:forEach>
					</select>
				</div>
			</div>

			<div class="form-row">
				<div class="form-group">
					<label>項目名:</label> <select class="form-input" name="hinmokuID">
						<option value="">品目選択</option>
						<c:forEach var="hinmoku" items="${hinmokuList}">
							<option value="${hinmoku.hinmokuID}">${hinmoku.hinmokumei}</option>
						</c:forEach>
					</select>
				</div>
				<div class="form-group">
					<label>規格:</label> <select class="form-input" name="hinmokuID">
						<option value="">規格選択</option>
						<c:forEach var="hinmoku" items="${hinmokuList}">
							<option value="${hinmoku.hinmokuID}">${hinmoku.kikaku}</option>
						</c:forEach>
					</select>
				</div>
			</div>

			<div class="form-row">
				<div class="form-group">
					<label>担当者:</label> <select class="form-input" name="tantoushaID">
						<option value="">担当者選択</option>
						<c:forEach var="tantousha" items="${tantoushaList}">
							<option value="${tantousha.tantoushaID}">${tantousha.tantoushamei}</option>
						</c:forEach>
					</select>
				</div>
				<div class="form-group">
					<label>取引先担当者:</label> <select class="form-input"
						name="torihikisakiID">
						<option value="">取引先選択</option>
						<c:forEach var="torihikisaki" items="${torihikisakiList}">
							<option value="${torihikisaki.torihikisakiID}">${torihikisaki.toriTantousha}</option>
						</c:forEach>
					</select>
				</div>
			</div>


			<button class="form-button" type="submit">検索</button>
		</form>



	</c:when>
	<c:otherwise>
		<table class="summary-table">
			<thead>
				<tr>
					<th>日付</th>
					<th>品目名</th>
					<th>数量</th>
					<th>単価</th>
					<th>供給価格</th>
					<th>取引先名</th>
					<th>備考</th>
					<th>付加税</th>
					<th>合計額</th>
					<th>倉庫名</th>
				</tr>

			</thead>
			<tbody>
				<c:forEach var="row" items="${statusList}">
					<tr>
						<td>${row.hitsukeNo}</td>
						<td>${row.hinmokuMei}</td>
						<td>${row.suuryou}</td>
						<td>${row.tanka}</td>
						<td>${row.kyoukyuKingaku}</td>
						<td>${row.torihikisakiMei}</td>
						<td>${row.tekiyo}</td>
						<td>${row.bugase}</td>
						<td>${row.goukei}</td>
						<td>${row.soukoMei}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:otherwise>
</c:choose>

<script>
	document.getElementById("statusForm")
			.addEventListener(
					"submit",
					function(event) {
						const startDate = document
								.getElementById("nyuuryokuBiKaishi").value;
						const endDate = document
								.getElementById("nyuuryokuBiShuuryou").value;

						if (startDate && endDate
								&& new Date(startDate) > new Date(endDate)) {
							alert("基準日付の開始日は終了日より大きくすることはできません。");
							event.preventDefault();
						}

					});
</script>

<%@ include file="../includes/footer.jsp"%>
