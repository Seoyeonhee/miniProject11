package com.model2.mvc.web.product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;


//==> ȸ������ RestController
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
		
	public ProductRestController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@RequestMapping( value="json/addProduct", method=RequestMethod.POST )
	public void addProduct( @RequestBody Product product ) throws Exception {
		
		System.out.println("/product/json/addProduct : POST");
		
		productService.addProduct(product);
		
	}
	
	@RequestMapping( value="json/getProduct/{prodNo}/{menu}", method=RequestMethod.GET )
	public Map getProduct( @PathVariable int prodNo, @PathVariable String menu, @ModelAttribute("product") Product product ) throws Exception{
		
		System.out.println("/product/json/getProduct : GET");
		
		product = productService.getProduct(prodNo);
		if(purchaseService.getPurchase2(prodNo) != null) {
			product.setProTranCode(purchaseService.getPurchase2(prodNo).getTranCode());
		} else {
			product.setProTranCode("0");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("product", product);
		map.put("menu", menu);
		
		System.out.println("getProduct ���ϰ�(map) : " + map);

		return map;
	}

	@RequestMapping( value="json/updateProduct", method=RequestMethod.POST )
	public Map updateProduct( @RequestBody Product product ) throws Exception{
	
		System.out.println("/product/json/updateProduct : POST");

		productService.updateProduct(product);
		product = productService.getProduct(product.getProdNo());
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("product", product);
		map.put("menu", "manage");
		
		System.out.println("updateProduct ���ϰ�(map) : " + map);
		
		return map;
	}
//	
//	@RequestMapping( value="json/listProduct" )
//	public Map listPrduct( @RequestBody String menu, HttpSession session ) throws Exception {
//		
//		System.out.println("/product/json/listProduct : GET / POST");
//		
//		Search search = new Search();
//		Product product = new Product();
//		
//		if(search.getCurrentPage() == 0) {
//			search.setCurrentPage(1);
//		}
//		search.setPageSize(pageSize);
//		
////		String role = ((User)session.getAttribute("user")).getRole();
//		// �׽�Ʈ�����δ� session���� �޾ƿ��� ���� ���� �ϵ��ڵ����� role�� admin���� �����ع���
//		String role = "admin";
//		
//		Map<String, Object> map = productService.getProductList(search, role);
//		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
//		System.out.println(resultPage);
//		
//		Purchase purchase = new Purchase();
//		ArrayList<Product> list = null;
//		int[] proTranCode = null;
//		int prodNo = 0;
//		
//		if(map!=null) {
//			list = (ArrayList<Product>)map.get("list");
//		}
//		for(int i=0 ; i<list.size() ; i++) {
//			prodNo = list.get(i).getProdNo();
//			purchase = purchaseService.getPurchase2(prodNo);
//			if(purchase!=null) {
//				purchase.setPurchaseProd(list.get(i));
//				product.setProTranCode(purchase.getTranCode());
//				
//				if(!purchase.getTranCode().trim().equals("0") && purchase.getTranCode()!=null) {
//					product.setProTranCode(purchase.getTranCode());
//					list.set(i, purchase.getPurchaseProd());
//					list.get(i).setProTranCode(purchase.getTranCode());
//				} else {
//					product.setProTranCode(purchase.getTranCode());
//					list.get(i).setProTranCode(purchase.getTranCode());
//				}
//			} else {
//				list.get(i).setProTranCode("0");
//			}
//		}
//		
//		map.put("resultPage", resultPage);
//		map.put("search", search);
//		map.put("menu", menu);
//		
//		System.out.println("listProduct ���ϰ�(map) : " + map);
//		
//		return map;
//		
//	}
	
	
	@RequestMapping( value="json/listProduct/{menu}", method=RequestMethod.GET )
	public Map listPrduct(@PathVariable("menu") String menu, HttpSession session ) throws Exception {
		
		System.out.println("/product/json/listProduct : GET / POST");
		
		Search search = new Search();
		Product product = new Product();
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
//		String role = ((User)session.getAttribute("user")).getRole();
		// �׽�Ʈ�����δ� session���� �޾ƿ��� ���� ���� �ϵ��ڵ����� role�� admin���� �����ع���
		String role = "admin";
		
		Map<String, Object> map = productService.getProductList(search, role);
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		Purchase purchase = new Purchase();
		ArrayList<Product> list = null;
		int[] proTranCode = null;
		int prodNo = 0;
		
		if(map!=null) {
			list = (ArrayList<Product>)map.get("list");
		}
		for(int i=0 ; i<list.size() ; i++) {
			prodNo = list.get(i).getProdNo();
			purchase = purchaseService.getPurchase2(prodNo);
			if(purchase!=null) {
				purchase.setPurchaseProd(list.get(i));
				product.setProTranCode(purchase.getTranCode());
				
				if(!purchase.getTranCode().trim().equals("0") && purchase.getTranCode()!=null) {
					product.setProTranCode(purchase.getTranCode());
					list.set(i, purchase.getPurchaseProd());
					list.get(i).setProTranCode(purchase.getTranCode());
				} else {
					product.setProTranCode(purchase.getTranCode());
					list.get(i).setProTranCode(purchase.getTranCode());
				}
			} else {
				list.get(i).setProTranCode("0");
			}
		}
		
		map.put("resultPage", resultPage);
		map.put("search", search);
		map.put("menu", menu);
		
		System.out.println("listProduct ���ϰ�(map) : " + map);
		
		return map;
		
	}
	
}