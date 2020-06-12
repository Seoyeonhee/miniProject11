<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<title>���� �����ȸ</title>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
	
	
	<!-- jQuery UI toolTip ��� CSS-->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<!-- jQuery UI toolTip ��� JS-->
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
		 
		 
		//============= "ajax"  Event  ó�� =============	
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
									var str = "���� ��� : " + "���ݱ���" + "<br/>";
								} else if($.trim(JSONData.paymentOption)=='2') {
									var str = "���� ��� : " + "�ſ뱸��" + "<br/>";
								} else {
									var str = "error~~~!!!!" + "<br/>";
								}
								
								var displayValue = "<h6>"
															+ "��ǰ�� : " + JSONData.purchaseProd.prodName + "<br/>"
															+ "������ ���̵� : " + JSONData.buyer.userId + "<br/>"
															+ str
															+ "������ �̸� : " + JSONData.receiverName + "<br/>"
															+ "������ ����ó : " + JSONData.receiverPhone + "<br/>"
															+ "������ �ּ� : " + JSONData.divyAddr + "<br/>"
															+ "���ſ�û���� : " + JSONData.divyRequest + "<br/>"
															+ "�������� : " + JSONData.divyDate + "<br/>"
															+ "�ֹ��� : " + JSONData.orderDate + "<br/>"
															+ "</h6>"
															+ "<button type='button' class='btn btn-primary'>���ż���</button>";
								
								$("h6").remove();
								$("#"+tranNo+"").html(displayValue);
								
						}
					}); */
				
				
				/* $( "button.btn.btn-primary:contains('���ż���')" ).on("click" , function() {
					alert("���ż���");
					var tranNo = $( $($(this).parents("tr").children()[0]).children()[0] ).val();
					alert("/purchase/updatePurchase?tranNo="+tranNo);
					$("form").attr("method" , "POST").attr("action" , "/purchase/updatePurchase?tranNo="+tranNo).submit();
				}); */
				
				self.location = "/purchase/getPurchase?tranNo="+tranNo;
				
			});
			
			
			
			
			
			
		});
		
		
		
/* 		$(function() {
			$( "button.btn.btn-primary:contains('���ż���')" ).on("click" , function() {
				alert("���ż���");
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

			 $( "td:contains('���ǵ���')" ).css("color", "blue");
			 $( "td:contains('���ǵ���')" ).on("click", function() {
				 
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
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>���� ��� ��ȸ</h3>
	    </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">

				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table ���� �˻� Start /////////////////////////////////////-->
		
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >ȸ�� ID</th>
            <th align="left">ȸ����</th>
            <th align="left">��ȭ��ȣ</th>
            <th align="left">�����Ȳ</th>
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
				<td align="left"  title="Click : ȸ������ Ȯ��">${purchase.buyer.userId}</td>
				<td align="left">${purchase.receiverName}</td>
				<td align="left">${purchase.receiverPhone}</td>
				<td align="left"> ����
				
					<c:if test="${ ! empty purchase.tranCode && fn:trim(purchase.tranCode)=='1' }">
						���ſϷ�
					</c:if>
					<c:if test="${ ! empty purchase.tranCode && fn:trim(purchase.tranCode)=='2' }">
						�����
					</c:if>
					<c:if test="${ ! empty purchase.tranCode && fn:trim(purchase.tranCode)=='3' }">
						��ۿϷ�
					</c:if>
					<c:if test="${ empty purchase.tranCode && fn:trim(purchase.tranCode)=='3' }">
						��ۿϷ�
					</c:if>
					���� �Դϴ�.
					<c:if test="${ ! empty purchase.tranCode && fn:trim(purchase.tranCode)=='2' }">
						���ǵ���
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
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>