<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>


<div class="container-fluid px-4">
	<h1 class="mt-4">出庫処理</h1>

	<!-- 테이블 -->
	<table class="table table-bordered">
		<thead class="table-light">
			<tr>
				<th>日付-No.</th>
				<th>取引先名</th>
				<th>品目名</th>
				<th>残量</th>
				<th>納期日</th>
				<th>備考</th>
				<th>出庫数量</th>
				<th>出庫処理</th>
			</tr>

		</thead>
		<tbody>
			<c:forEach var="item" items="${releaseList}">
				<tr>
					<td>${item.hitsukeNo}</td>
					<td>${item.torihikisakiMei}</td>
					<td>${item.hinmokuMei}[${item.kikaku}]</td>
					<td>${item.mihanbaisuuryou}</td>
					<td>${item.noukiIchija}</td>
					<td>${item.tekiyo}</td>
					<td><input type="number" name="release" min="1"
						max="${item.mihanbaisuuryou}" required /></td>
					<td>
						<button type="button"
							onclick="processRelease('${item.hinmokuMei}', '${item.hitsukeNoRefertype}', this)">出庫</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<script>
function processRelease(hinmokuMei, hitsukeNoRefertype, button) {
    const row = button.closest('tr');
    const release = row.querySelector('input[name="release"]').value;

    if (!release || release <= 0) {
        alert("出荷数量を入力してください。");
        return;
    }

    const requestData = {
        hinmokuMei: hinmokuMei,
        hitsukeNoRefertype: hitsukeNoRefertype,
        release: parseInt(release)
    };

    fetch('/order/release', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8' },
        body: JSON.stringify(requestData)
    })
    .then(function(response) {
        if (!response.ok) throw new Error("出荷処理失敗");
        return response.text();
    })
    .then(function(result) {
        alert(result);
        location.reload(); // 데이터 갱신
    })
    .catch(function(error) {
        alert(error.message);
    });
}



</script>



<%@ include file="../includes/footer.jsp"%>
