<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>

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
	
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
     </style>
     
	<script type="text/javascript">
	
		$(function() {
			
			$( ".btn.btn-primary:contains('�� ��')" ).on("click", function() {
				
				self.location = "/purchase/updatePurchaseView?tranNo=${ purchase.tranNo }";
				
			});
			
			$( ".btn.btn-primary:contains('Ȯ ��')" ).on("click", function() {
				
				history.go(-1);
				
			});
			
		});
	
	</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">���Ż���ȸ</h3>
	    </div>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>�� ǰ �� ȣ</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.purchaseProd.prodNo}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>������ ���̵�</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.buyer.userId}</div>
		</div>
		
		<hr/>
		

		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�� �� �� ��</strong></div>
			<div class="col-xs-8 col-md-4">
				<c:if test="${ ! empty purchase.paymentOption && fn:trim(purchase.paymentOption)=='1' }">
					���ݱ���
				</c:if>
				<c:if test="${ ! empty purchase.paymentOption && fn:trim(purchase.paymentOption)=='2' }">
					�ſ뱸��
				</c:if>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>������ �̸�</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.receiverName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>������ ����ó</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.receiverPhone}</div>
		</div>
		
		<hr/>
		
		<div class="row">
			<div class="col-xs-4 col-md-2 "><strong>������ �ּ�</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyAddr}</div>
		</div>
		
		<hr/>
		
		<div class="row">
			<div class="col-xs-4 col-md-2 "><strong>���� ��û ����</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyRequest}</div>
		</div>
		
		<hr/>
		
		<div class="row">
			<div class="col-xs-4 col-md-2 "><strong>��� �����</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
			<div class="col-xs-4 col-md-2 "><strong>�� �� ��</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.orderDate}</div>
		</div>

		<hr/>


		<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<button type="button" class="btn btn-primary">�� ��</button>
	  			<button type="button" class="btn btn-primary">Ȯ ��</button>
	  		</div>
		</div>

		
		<br/>
		
 	</div>


</body>
</html>