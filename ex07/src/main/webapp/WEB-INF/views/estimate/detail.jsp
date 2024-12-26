<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>견적서 상세</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="container mt-5">
		<!-- 메인 컨텐츠 -->
		<h1 class="mb-4">견적서 상세</h1>
		<hr>
		<!-- 버튼 -->
		<div class="d-flex justify-content-between">
			<button class="btn btn-primary" onclick="openModal();">모달 열기</button>
			<button class="btn btn-secondary" onclick="printContent();">인쇄</button>
		</div>

		<!-- 모달 -->
		<div class="modal fade" id="listModal" tabindex="-1"
			aria-labelledby="listModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<!-- 모달 헤더 -->
					<div class="modal-header">
						<h5 class="modal-title" id="listModalLabel">생성한 전표 조회</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<!-- 모달 본문 -->
					<div class="modal-body">
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>품목명</th>
									<th>규격</th>
									<th>수량</th>
									<th>잔량</th>
									<th>총 금액</th>
								</tr>
							</thead>
							<tbody id="listModalTableBody">
								<!-- AJAX를 통해 데이터 로드 -->
							</tbody>
						</table>
					</div>
					<!-- 모달 푸터 -->
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>