<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>

<h1>Shipment List</h1>
<table border="1">
    <thead>
        <tr>
            <th>일자-No</th>
            <th>창고명</th>
            <th>품목명</th>
            <th>수량합계</th>
            <th>진행상태</th>
            <th>인쇄</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="shipment" items="${shipList}">
            <tr>
<td>
<a href="#" onclick="fetchDataAndShowModal('${shipment.hitsuke_No}')">
    ${shipment.hitsuke_No}
</a>

</td>
                <td>${shipment.soukoID}</td>
                <td>${shipment.hinmokuID}</td>
                <td>${shipment.suuryouGoukei}</td>
                <td>
                	${shipment.shinkouZyoutai}
<select onchange="update(this.value, ${shipment.shukkaShiziShoukaiID})">
    <option value="進行中" ${shipment.shinkouZyoutai == '進行中' ? 'selected' : ''}>進行中</option>
    <option value="完了" ${shipment.shinkouZyoutai == '完了' ? 'selected' : ''}>完了</option>
</select>



                </td>
                <td><a href="print?shipmentId=${shipment.shukkaShiziShoukaiID}">인쇄</a></td>
            </tr>
        </c:forEach>
    </tbody>
</table>
  <div id="modal" style="
    display: none; 
    position: fixed; 
    top: 50%; 
    left: 50%; 
    transform: translate(-50%, -50%); 
    width: 800px; 
    background: #fff; 
    border: 1px solid #ccc; 
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); 
    z-index: 1000; 
    border-radius: 8px;">
  <div style="padding: 20px; font-family: Arial, sans-serif;">
    <h2 style="margin-bottom: 20px; text-align: left;">출하지시서 수정</h2>
    <form action="shipmentcorrection" method="post">
       <!--  첫 번째 행 -->
        <div style="display: flex; margin-bottom: 10px;">
            <label for="hitsuke_No" style="width: 120px; margin-right: 10px;">일자:</label>
            <input type="text" id="hitsuke_No" name="hitsuke_No" readonly style="flex: 1; border: 1px solid #ccc; padding: 5px;">
            <label for="torihikisaki" style="width: 120px; margin: 0 10px;">거래처:</label>
            <input type="text" id="torihikisaki" name="torihikisaki" style="flex: 1; border: 1px solid #ccc; padding: 5px;">
        </div>

      <!--   두 번째 행 -->
        <div style="display: flex; margin-bottom: 10px;">
            <label for="tantoushaID" style="width: 120px; margin-right: 10px;">담당자:</label>
            <input type="text" id="tantoushaID" name="tantoushaID" style="flex: 1; border: 1px solid #ccc; padding: 5px;">
            <label for="soukoID" style="width: 120px; margin: 0 10px;">출하창고:</label>
            <input type="text" id="soukoID" name="soukoID" style="flex: 1; border: 1px solid #ccc; padding: 5px;">
        </div>

       <!--  세 번째 행 -->
        <div style="display: flex; margin-bottom: 10px;">
            <label for="purojekuto" style="width: 120px; margin-right: 10px;">프로젝트:</label>
            <input type="text" id="purojekuto" name="purojekuto" style="flex: 1; border: 1px solid #ccc; padding: 5px;">
            <label for="renrakusaki" style="width: 120px; margin: 0 10px;">연락처:</label>
            <input type="text" id="renrakusaki" name="renrakusaki" style="flex: 1; border: 1px solid #ccc; padding: 5px;">
        </div>

 <!--        네 번째 행 -->
        <div style="display: flex; margin-bottom: 10px;">
            <label for="shukkaYoteibi" style="width: 120px; margin-right: 10px;">출하예정일:</label>
            <input type="date" id="shukkaYoteibi" name="shukkaYoteibi" style="flex: 1; border: 1px solid #ccc; padding: 5px;">
            <label for="yuubinBangou" style="width: 120px; margin: 0 10px;">우편번호:</label>
            <input type="text" id="yuubinBangou" name="yuubinBangou" style="flex: 1; border: 1px solid #ccc; padding: 5px;">
        </div>

        <div style="text-align: right;">
            <button type="button" onclick="closeModal()" style="padding: 5px 10px;">닫기</button>
        </div>



            <div style="margin-bottom: 10px;">
    <button type="button" onclick="showSearchBox()" style="padding: 5px 10px; margin-right: 5px;">찾기(F3)</button>
    <button type="button" onclick="sortItems()" style="padding: 5px 10px; margin-right: 5px;">정렬</button>
    <button type="button" onclick="myProducts()" style="padding: 5px 10px; margin-right: 5px;">My 품목</button>
    <button type="button" onclick="sales()" style="padding: 5px 10px; margin-right: 5px;">판매</button>
    <button type="button" onclick="reorderStock()" style="padding: 5px 10px; margin-right: 5px;">재고불러오기</button>
    <button type="button" onclick="generateBarcode()" style="padding: 5px 10px; margin-right: 5px;">생성한 전표</button>
</div>

        <!-- 항목 테이블 -->
        <div style="margin-top: 20px;">
            <table style="width: 100%; border: 1px solid #ccc; border-collapse: collapse;" id="itemTable">
                <thead>
                    <tr style="background-color: #f1f1f1;">
                        <th style="border: 1px solid #ccc; padding: 5px; width: 5%;">번호</th>
                        <th style="border: 1px solid #ccc; padding: 5px; width: 5%;">↓</th>
                        <th style="border: 1px solid #ccc; padding: 5px;">품목코드</th>
                        <th style="border: 1px solid #ccc; padding: 5px;">품목명</th>
                        <th style="border: 1px solid #ccc; padding: 5px;">규격</th>
                        <th style="border: 1px solid #ccc; padding: 5px;">수량</th>
                        <th style="border: 1px solid #ccc; padding: 5px;">새로운 항목 추가</th>
                    </tr>
                </thead>
               <tbody>
    <tr>
        <td style="border: 1px solid #ccc; padding: 5px; text-align: center;">1</td>
        <td style="border: 1px solid #ccc; padding: 5px; text-align: center;">
            <button type="button" onclick="addRowInModal()" style="padding: 2px 5px;">↓</button>
        </td>
        <td style="border: 1px solid #ccc; padding: 5px;"><input type="text" style="width: 100%;"></td>
        <td style="border: 1px solid #ccc; padding: 5px;"><input type="text" style="width: 100%;"></td>
        <td style="border: 1px solid #ccc; padding: 5px;"><input type="text" style="width: 100%;"></td>
        <td style="border: 1px solid #ccc; padding: 5px;"><input type="number" style="width: 100%;"></td>
        <td style="border: 1px solid #ccc; padding: 5px;"><input type="text" style="width: 100%;"></td>
    </tr>
</tbody>

            </table>
        </div>

        <!-- 저장 버튼 -->
        <table style="width: 100%; margin-top: 20px;">
            <tr>
                <td colspan="7" style="text-align: left;">
                    <div style="margin-top: 1px; text-align: left;">
                       <button type="button" onclick="saveShipmentData()" style="padding: 5px 10px;">저장(F8)</button>
                        <button type="button" style="padding: 1px 1px;">저장/전표(F7)</button>
                        <button type="reset" style="padding: 1px 1px;">다시 작성</button>
                        <button type="button" style="padding: 1px 1px;">리스트</button>
                        <button type="button" style="padding: 1px 1px;">웹자료올리기</button>
                    </div>
                </td>
            </tr>
        </table>
        </form>
    </div>
</div>	
 
<!-- <form action="/shipment/update" method="post">
    <input type="hidden" id="hitsuke_No" name="hitsuke_No">
    다른 입력 필드들
    <button type="submit">저장</button>
</form>  -->




<div id="modalBackground" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:999;" onclick="closeModal()"></div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
 function showModal(hitsuke_No) {
    $("#modal").show();
    $("#modalBackground").show();
    $("#hitsuke_No").val(hitsuke_No);
    console.log(shukkaShiziShoukaiID,shinkouZyoutai);
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

    function myProducts() {
        alert("My 품목 보기 실행됨");
    }

    function sales() {
        alert("판매 기능 실행됨");
    }

    function reorderStock() {
        alert("재고 불러오기 실행됨");
    }

    function generateBarcode() {
        alert("생성한 전표 보기 실행됨");
    }
    
    function update(newStatus, shukkaShiziShoukaiID) {
        $.ajax({
            url: '/shipment/update',
            type: 'POST',
            data: {
                shukkaShiziShoukaiID: shukkaShiziShoukaiID,
                shinkouZyoutai: newStatus
            },
            success: function(response) {
                // 상태 업데이트 성공 알림창
                alert("상태가 성공적으로 업데이트되었습니다. " + newStatus);

                // 알림창 확인 후 페이지 새로고침
                window.location.reload();
            },
            error: function(xhr, status, error) {
                alert("업데이트 실패: " + error);
                console.log(shukkaShiziShoukaiID, newStatus);
            }
        });
    }

    
    let rowCount = 2;

    function addRowInModal() {
        const table = document.getElementById('itemTable').getElementsByTagName('tbody')[0];
        const newRow = table.insertRow();

        const cell1 = newRow.insertCell(0);
        const cell2 = newRow.insertCell(1);
        const cell3 = newRow.insertCell(2);
        const cell4 = newRow.insertCell(3);
        const cell5 = newRow.insertCell(4);
        const cell6 = newRow.insertCell(5);
        const cell7 = newRow.insertCell(6);

        cell1.style.textAlign = "center";
        cell1.innerHTML = rowCount++;
        cell2.innerHTML = '<button type="button" onclick="addRowInModal()" style="padding: 2px 5px;">↓</button>';
	        cell3.innerHTML = '<input type="text" style="width: 95%;">';
	        cell4.innerHTML = '<input type="text" style="width: 100%;">';
	        cell5.innerHTML = '<input type="text" style="width: 100%;">';
	        cell6.innerHTML = '<input type="number" style="width: 100%;">';
	        cell7.innerHTML = '<input type="text" style="width: 100%;">';
    }
	
    function fetchDataAndShowModal(hitsuke_No) {
        // AJAX 요청을 통해 데이터를 가져옵니다.
        $.ajax({
            url: '/shipment/shipmentdetails', // 서버 요청 URL
            type: 'GET',
            data: { hitsuke_No: hitsuke_No },
            success: function(data) {
                // 가져온 데이터를 모달 창의 필드에 삽입
                document.getElementById('hitsuke_No').value = data.hitsuke_No;
                document.getElementById('torihikisaki').value = data.torihikisaki;
                document.getElementById('tantoushaID').value = data.tantoushaID;
                document.getElementById('soukoID').value = data.soukoID;
                document.getElementById('shukkaYoteibi').value = data.shukkaYoteibi;

                // 모달 표시
                document.getElementById('modal').style.display = 'block';
                document.getElementById('modalBackground').style.display = 'block';
            },
            error: function(xhr, status, error) {
                console.error("데이터 불러오기 실패:", error);
                alert("데이터를 불러오는 중 오류가 발생했습니다.");
            }
        });
    }
    
    function saveShipmentData() {
        const data = {
            hitsuke_No: document.getElementById('hitsuke_No').value,
            torihikisaki: document.getElementById('torihikisaki').value,
            tantoushaID: document.getElementById('tantoushaID').value,
            soukoID: document.getElementById('soukoID').value,
            purojekuto: document.getElementById('purojekuto').value,
            renrakusaki: document.getElementById('renrakusaki').value,
            shukkaYoteibi: document.getElementById('shukkaYoteibi').value,
            yuubinBangou: document.getElementById('yuubinBangou').value
        };

        $.ajax({
            url: '/shipment/shipmentcorrection',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data), // 데이터를 JSON 형식으로 전송
            success: function(response) {
                alert("저장 성공!");
                closeModal();
                window.location.reload(); // 페이지 새로고침
            },
            error: function(xhr, status, error) {
                console.error("저장 실패:", error);
                alert("저장 실패: " + error);
            }
        });
    }
</script>

<%@ include file="../includes/footer.jsp" %>
