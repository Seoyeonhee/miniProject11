<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<title>구매정보 수정</title>
	
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
	</style>
	
	<script type="text/javascript">

		$(function() {
			$( "button.btn.btn-primary:contains('수정')" ).on("click" , function() {
				$("form").attr("method" , "POST").attr("action" , "/purchase/updatePurchase?tranNo=${ purchase.tranNo }").submit();
			});
		});
		
		
		$(function() {
			$( "button.btn.btn-primary:contains('취소')" ).on("click" , function() {
				 history.go(-1);
			});
		});

		
		$( function() {
			$( "#receiverDate" ).datepicker({dateFormat: 'yy/mm/dd'});
		});
	
	</script>
</head>


<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">구 매 정 보 수 정</h3>
	    </div>
	    
		<!-- <h1 class="bg-primary text-center">상 품 등 록</h1> -->
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		<%-- <input type="hidden" name="tranNo" value="${ purchase.tranNo }" /> --%>
		
			<!-- 
			<div class="form-group">
				<label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">상품번호</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodNo" name="prodNo" placeholder="상품번호">
			    </div>
			</div>
			 -->
		
		<div class="form-group">
			<label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">구매자 아이디</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="buyerId" name="buyerId" placeholder="구매자 아이디" value="${purchase.buyer.userId}" readonly>
		    	<span id="helpBlock" class="help-block">
		      		<strong class="text-danger">아이디는 수정불가</strong>
				</span>
		    </div>
		</div>
		
		<hr/>
		
		
		<div class="form-group">
			<label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
			<div class="col-sm-2">
				<select class="form-control" name="paymentOption" id="paymentOption">
					<option value="1" >현금구매</option>
					<option value="2" >신용구매</option>
				</select>
			</div>
		<!-- <input type="hidden" name="paymentOption" /> -->
		</div>
		
		
		<hr/>
		
		<div class="form-group">
			<label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자 이름</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="receiverName" name="receiverName" placeholder="구매자 이름">
		    </div>
		</div>
		
		<div class="form-group">
			<label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자 연락처</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" placeholder="구매자 연락처">
		    </div>
		</div>
		
		<div class="form-group">
			<label for="receiverAddr" class="col-sm-offset-1 col-sm-3 control-label">구매자 주소</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="receiverAddr" name="receiverAddr" placeholder="구매자 주소">
		    </div>
		</div>
		
		<div class="form-group">
			<label for="receiverRequest" class="col-sm-offset-1 col-sm-3 control-label">구매 요청사항</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="receiverRequest" name="receiverRequest" placeholder="구매 요청사항">
		    </div>
		</div>
		
		<div class="form-group">
			<label for="receiverDate" class="col-sm-offset-1 col-sm-3 control-label">배송 희망일자</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="receiverDate" name="receiverDate" placeholder="배송 희망일자">
		    </div>
		</div>
		

		
	
			
		
		
		
				<div class="row">
					<div class="col-md-12 text-center ">
						<button type="button" class="btn btn-primary">수정</button>
						<button type="button" class="btn btn-primary">취소</button>
					</div>
				</div>
		
			<br/>

		</form>
	</div>
</body>


</html>