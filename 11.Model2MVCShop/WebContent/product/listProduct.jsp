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
	
		function fncGetUserList(currentPage){
			$("#currentPage").val(currentPage);
			$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=${requestScope.menu}").submit();
		};
	
		
		//============= "�˻�"  Event  ó�� =============	
		$(function() {
			
			$( "button.btn.btn-default" ).on("click", function() {
				fncGetUserList('1');
			});
		});
	
	
		//============= No ������ �� getProduct ȭ������ �̵�  Event  ó�� =============
		$(function() {
			$( "td:nth-child(3)" ).css("color" , "red");
			$( "td:nth-child(3)" ).on("click" , function() {
				var prodNo =$( $(this).parents("tr").children()[0] ).val();
				var proTranCode =$( $(this).parents("tr").children()[1] ).val();
				
				if(proTranCode=='0' || proTranCode=='3') {
					self.location = "/product/getProduct?prodNo="+prodNo+"&menu=${ requestScope.menu }";
				};
			});
		});
		
		
		//============= ��ǰ�� ������ ��  ajax Event  ó�� =============
		$(function() {	
			$( "td:nth-child(4)" ).css("color" , "green");
			
			$( "td:nth-child(4)" ).on("click", function() {
				var prodNo =$( $(this).parents("tr").children()[0] ).val();
				var proTranCode =$( $(this).parents("tr").children()[1] ).val();
				
				if(proTranCode=='0' || proTranCode=='3') {
					$.ajax(
							{
								url : "/product/json/getProduct/"+prodNo+"/${ requestScope.menu }",
								method : "GET",
								dataType : "json",
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								success : function(JSONData, status) {
									if(JSONData.product.fileName != null) {
										var filePrint = "<img src = '/images/uploadFiles/"+ JSONData.product.fileName +"'/>"
									};
									var displayValue = "<h6>"
																+ "��ǰ��ȣ : " + JSONData.product.prodNo + "<br/>"
																+ "��ǰ �̸� : " + JSONData.product.prodName + "<br/>"
																/* + "��ǰ �̹��� : " + JSONData.product.fileName + "<br/>" */
																+ "��ǰ �̹��� : " + filePrint + "<br/>"
																+ "��ǰ ������ : " + JSONData.product.prodDetail + "<br/>"
																+ "�������� : " + JSONData.product.manuDate + "<br/>"
																+ "���� : " + JSONData.product.price + "<br/>"
																+ "������� : " + JSONData.product.regDate + "<br/>"
																+ "</h6>";
																
									$("h6").remove();
									$( "#"+prodNo+"" ).html(displayValue);
									
								}
						});
				}
				
				
			});
			
			$( "td:nth-child(7)" ).on("click", function() {
				var prodNo =$( $(this).parents("tr").children()[0] ).val();
				var proTranCode =$( $(this).parents("tr").children()[1] ).val();
	
	
				self.location = "/purchase/updateTranCodeByProd?prodNo="+prodNo+"&tranCode=2";
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
			<c:if test="${ ! empty requestScope.menu && requestScope.menu=='manage' }">
					<h3>��ǰ ����</h3>
			</c:if>
			<c:if test="${ ! empty requestScope.menu && requestScope.menu=='search' }">
					<h3>��ǰ �����ȸ</h3>
			</c:if>
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
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
						<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
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
            <th align="left" >��ǰ��</th>
            <th align="left">����</th>
            <th align="left">�����</th>
            <th align="left">�������</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			
				<input type="hidden" class="prodNo" value="${product.prodNo}"/>
				<input type="hidden" class="proTranCode" value="${fn:trim(product.proTranCode)}"/>
			
				<td align="center">${ i }</td>
				<td align="left"  title="Click : ��ǰ���� Ȯ��">${ product.prodName }</td>
				<td align="left">${ product.price}</td>
				<td align="left">${ product.regDate}</td>
				<td align="left">
				  	<%-- <i class="glyphicon glyphicon-ok" id= "${ product.prodNo }"></i> --%>
				  	<!-- <i class="glyphicon glyphicon-ok"></i> -->
				  	
					<c:if test="${ ! empty user.role && user.role=='admin' }">
						<c:if test="${ ! empty product.proTranCode && fn:trim(product.proTranCode)=='0' }">
							�Ǹ���
						</c:if>
						<c:if test="${ ! empty product.proTranCode && fn:trim(product.proTranCode)=='1' }">
							���ſϷ�
							<c:if test="${ ! empty requestScope.menu && requestScope.menu=='manage' }">
								����ϱ�
							</c:if>
						</c:if>
						<c:if test="${ ! empty product.proTranCode && fn:trim(product.proTranCode)=='2' }">
							�����
						</c:if>
						<c:if test="${ ! empty product.proTranCode && fn:trim(product.proTranCode)=='3' }">
							��ۿϷ�
						</c:if>
					</c:if>
					<c:if test="${ ! empty user.role && user.role!='admin' }">
						<c:if test="${ ! empty product.proTranCode && fn:trim(product.proTranCode)=='0' }">
							�Ǹ���
						</c:if>
						<c:if test="${ ! empty product.proTranCode && fn:trim(product.proTranCode)!='0' }">
							������
						</c:if>
					</c:if>
					<c:if test="${ empty user.role }">
						user.role�� empty!!!!!!!!!!!!!!
					</c:if>	
				</td>
			</tr>
			<tr>
				<!-- <i class="glyphicon glyphicon-ok"></i> -->
				<td id="${product.prodNo}"></td>
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