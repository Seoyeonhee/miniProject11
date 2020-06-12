package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

//==> ���Ű��� RestController
@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
		
	public PurchaseRestController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@RequestMapping( value="json/addPurchaseView/{prodNo}", method=RequestMethod.GET )
	public Purchase addPurchaseView( @PathVariable int prodNo ) throws Exception {
		
		System.out.println("/purchase/json/addPurchaseView : GET");
		
		Purchase purchase = new Purchase();
		Product product = new Product();
		User user = new User();
		
		// �α���ó���� ���� ���Ƿ� �α����� user���� ����
		user.setUserId("user01");
		user.setPassword("1111");
		
		purchase.setBuyer(user);
		purchase.setPurchaseProd(productService.getProduct(prodNo));
		
		return purchase;
		
	}
	
	@RequestMapping( value="json/addPurchase/{prodNo}", method=RequestMethod.POST )
	public Purchase addPurchase( @PathVariable int prodNo, @RequestBody Purchase purchase ) throws Exception {
		
		System.out.println("/purchase/json/addPurchase : POST");
		
		// �α���ó���� ���� ���Ƿ� �α����� user ���� ����
		User user = new User();
		user.setUserId("user01");
		user.setPassword("1111");

		purchase.setBuyer(user);
		purchase.setTranCode("1");
		purchase.setPurchaseProd(productService.getProduct(prodNo));
		System.out.println("purchaseService�� addPurchase ���� �� purchase => " + purchase);
		purchaseService.addPurchase(purchase);
		
		return purchase;
		
	}

	@RequestMapping( value="json/getPurchase/{tranNo}", method=RequestMethod.GET )
	public Purchase getPurchase( @PathVariable int tranNo ) throws Exception {
		
		System.out.println("/purchase/json/getPurchase : GET");
		
		Purchase purchase = new Purchase();
		
		// �α���ó���� ���� ���Ƿ� �α����� user���� ����
		String userId = "user01";
		purchase = purchaseService.getPurchase(tranNo);
		
		return purchase;
		
	}
	
	@RequestMapping( value="json/updatePurchaseView/{tranNo}", method=RequestMethod.GET )
	public Purchase updatePurchaseView( @PathVariable int tranNo ) throws Exception {
		
		System.out.println("/purchase/json/updatePurchaseView : GET");
		
		Purchase purchase = new Purchase();
		purchase = purchaseService.getPurchase(tranNo);
		
		return purchase;
		
	}

	@RequestMapping( value="json/updatePurchase/{tranNo}", method=RequestMethod.POST )
	public Purchase updatePurchase( @PathVariable int tranNo, @RequestBody Purchase purchase ) throws Exception {
		
		System.out.println("/purchase/json/updatePurchase : POST");
		purchase.setTranNo(tranNo);
		
		purchaseService.updatePurcahse(purchase);
		purchase = purchaseService.getPurchase(tranNo);
		
		return purchase;
		
	}
	///////////////////////////  ----- ���⼭���� �����丵 �߰������ϸ� �� (list �ڵ��Ͽ콺 ���� ���� �ʿ�) -----  /////////////////////////////
	@RequestMapping( value="json/listPurchase", method=RequestMethod.POST )
	public Map listPurchase( @RequestBody User user ) throws Exception {
		
		System.out.println("/purchase/json/listPurchase : POST");
		
		Search search = new Search();
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		System.out.println("user���� ��������????????????" + user);
		
		Map<String, Object> map = purchaseService.getPurchaseList(search, user.getUserId());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize );
		System.out.println(resultPage);
		
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		System.out.println("listPurchase ���ϰ�(map) : " + map);
		
		return map;
		
	}
	
	@RequestMapping( value="json/updateTranCode/{tranNo}/{tranCode}", method=RequestMethod.GET )
	public void updateTranCode( @PathVariable int tranNo, @PathVariable String tranCode ) throws Exception {
		
		System.out.println("/purchase/json/updateTranCode : GET");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		Product product = purchase.getPurchaseProd();
		
		product.setProTranCode(tranCode);
		purchase.setTranCode(tranCode);
		purchase.setPurchaseProd(product);
		purchaseService.updateTranCode(purchase);
		
	}
	
	@RequestMapping( value="json/updateTranCodeByProd/{prodNo}/{tranCode}", method=RequestMethod.GET )
	public void updateTranCodeByProd( @PathVariable int prodNo, @PathVariable String tranCode ) throws Exception {
		
		System.out.println("/purchase/json/updateTranCodeByProd : GET");
		
		Purchase purchase = purchaseService.getPurchase2(prodNo);
		Product product = purchase.getPurchaseProd();
		
		product.setProTranCode(tranCode);
		purchase.setTranCode(tranCode);
		purchase.setPurchaseProd(product);
		purchaseService.updateTranCode(purchase);
		
	}
	
	// �߰���� - ��ǰ����
	@RequestMapping( value="json/updateTranCodeByProd", method=RequestMethod.POST )
	public void updateTranCodeByProd( @RequestBody Product product ) throws Exception {
		
		System.out.println("/purchase/json/updateTranCodeByProd : POST");
		
		Purchase purchase = purchaseService.getPurchase2(product.getProdNo());
		purchase.setTranCode("0");
		purchaseService.updateTranCode(purchase);
		
	}
	
}