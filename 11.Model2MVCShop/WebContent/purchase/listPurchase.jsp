<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<title>구매 목록조회</title>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
	<link href="/css/animate.min.css" rel="stylesheet">
	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	 <!-- Bootstrap Dropdown Hover JS -->
	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	
	<!-- jQuery UI toolTip 사용 CSS-->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<!-- jQuery UI toolTip 사용 JS-->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	body {
	         padding-top : 50px;
	     }
	 </style>
	<script type="text/javascript">
	
		function fncGetUserList(currentPage) {
			 
			 $("#currentPage").val(currentPage);
			 
			 $("form").attr("method", "POST").attr("action", "/purchase/listPurchase").submit();
			 
		 };
		 
		 
		//============= "ajax"  Event  처리 =============	
		$(function() {
			
			$( "td:nth-child(1)" ).css("color" , "green");
			$( "td:nth-child(1)" ).on("click", function() {
				/* var tranNo = $( $(this).parents("tr").children()[0] ).val(); */
				var tranNo = $( $($(this).parents("tr").children()[0]).children()[0] ).val();

				/* 
				$.ajax (
						{
							url : "/purchase/json/getPurchase/"+tranNo,
							method : "GET",
							dataType : "json",
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData, status) {
								if($.trim(JSONData.paymentOption)=='1') {
									var str = "구매 방법 : " + "현금구매" + "<br/>";
								} else if($.trim(JSONData.paymentOption)=='2') {
									var str = "구매 방법 : " + "신용구매" + "<br/>";
								} else {
									var str = "error~~~!!!!" + "<br/>";
								}
								
								var displayValue = "<h6>"
															+ "물품명 : " + JSONData.purchaseProd.prodName + "<br/>"
															+ "구매자 아이디 : " + JSONData.buyer.userId + "<br/>"
															+ str
															+ "구매자 이름 : " + JSONData.receiverName + "<br/>"
															+ "구매자 연락처 : " + JSONData.receiverPhone + "<br/>"
															+ "구매자 주소 : " + JSONData.divyAddr + "<br/>"
															+ "구매요청사항 : " + JSONData.divyRequest + "<br/>"
															+ "배송희망일 : " + JSONData.divyDate + "<br/>"
															+ "주문일 : " + JSONData.orderDate + "<br/>"
															+ "</h6>"
															+ "<button type='button' class='btn btn-primary'>구매수정</button>";
								
								$("h6").remove();
								$("#"+tranNo+"").html(displayValue);
								
						}
					}); */
				
				
				/* $( "button.btn.btn-primary:contains('구매수정')" ).on("click" , function() {
					alert("구매수정");
					var tranNo = $( $($(this).parents("tr").children()[0]).children()[0] ).val();
					alert("/purchase/updatePurchase?tranNo="+tranNo);
					$("form").attr("method" , "POST").attr("action" , "/purchase/updatePurchase?tranNo="+tranNo).submit();
				}); */
				
				self.location = "/purchase/getPurchase?tranNo="+tranNo;
				
			});
			
			
			
			
			
			
		});
		
		
		
/* 		$(function() {
			$( "button.btn.btn-primary:contains('구매수정')" ).on("click" , function() {
				alert("구매수정");
				$("form").attr("method" , "POST").attr("action" , "/purchase/updatePurchase?tranNo=${ purchase.tranNo }").submit();
			});
		}); */
		 
		 
		 $(function() {

			 $( "td:nth-child(2)" ).css("color" , "red");
			 $( "td:nth-child(2)" ).on("click", function() {
				
				 self.location = "/user/getUser?userId="+$(this).text().trim();
				 
			 });
		 });
		 
		 
		 
		 $(function() {

			 $( "td:contains('물건도착')" ).css("color", "blue");
			 $( "td:contains('물건도착')" ).on("click", function() {
				 
				 /* var tranNo = $( $(this).parents("tr").children()[0] ).val(); */
				 /* var tranNo = $( $($(this).parents("tr").parents().children()[0]).children()[0] ).val(); */
				 var tranNo = $( $($(this).parents("tr").children()[0]).children()[0] ).val();

				 self.location = "/purchase/updateTranCode?tranNo="+tranNo+"&tranCode=3";
				 
			 });
			 
			 
		 });
		
	</script>
</head>

<!-- <body bgcolor="#ffffff" text="#000000"> -->
<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>구매 목록 조회</h3>
	    </div>
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">

				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >회원 ID</th>
            <th align="left">회원명</th>
            <th align="left">전화번호</th>
            <th align="left">배송현황</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
<%-- 				
				<input type="hidden" class="tranNo" value="${purchase.tranNo}"/>
				<input type="hidden" class="tranCode" value="${fn:trim(purchase.tranCode)}"/>
				 --%>
				<td align="center">
					<input type="hidden" class="tranNo" value="${purchase.tranNo}"/>
					<%-- <input type="hidden" class="tranCode" value="${fn:trim(purchase.tranCode)}"/> --%>
					${ i }
				</td>
				<td align="left"  title="Click : 회원정보 확인">${purchase.buyer.userId}</td>
				<td align="left">${purchase.receiverName}</td>
				<td align="left">${purchase.receiverPhone}</td>
				<td align="left"> 현재
				
					<c:if test="${ ! empty purchase.tranCode && fn:trim(purchase.tranCode)=='1' }">
						구매완료
					</c:if>
					<c:if test="${ ! empty purchase.tranCode && fn:trim(purchase.tranCode)=='2' }">
						배송중
					</c:if>
					<c:if test="${ ! empty purchase.tranCode && fn:trim(purchase.tranCode)=='3' }">
						배송완료
					</c:if>
					<c:if test="${ empty purchase.tranCode && fn:trim(purchase.tranCode)=='3' }">
						배송완료
					</c:if>
					상태 입니다.
					<c:if test="${ ! empty purchase.tranCode && fn:trim(purchase.tranCode)=='2' }">
						물건도착
					</c:if>
				 
			  	<%-- <i class="glyphicon glyphicon-ok" id= "${purchase.tranNo}"></i> --%>
			  	<%-- <input type="hidden" value="${user.userId}"> --%>
			  	<%-- <input type="hidden" class="tranNo" value="${purchase.tranNo}"/> --%>
				<%-- <input type="hidden" class="tranCode" value="${fn:trim(purchase.tranCode)}"/> --%>
			  	
			  	 
			  </td>
			</tr>
			<tr>
				<td id="${purchase.tranNo}"></td>
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>