package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;


// ==> 상품관리 Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {

	/// Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	public ProductController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	// 파일업로드할 경로
	@Value("#{commonProperties['UPLOAD_PATH']}")
	String UPLOAD_PATH;
	 
	
	
	//@RequestMapping("/addProduct.do")
	//public String addProduct(@ModelAttribute("product") Product product) throws Exception {
	@RequestMapping( value="addProduct", method=RequestMethod.POST )
	public String addProduct(@ModelAttribute("product") Product product, @RequestParam("file") MultipartFile file) throws Exception {
	
		System.out.println("/prouct/addProduct : POST");

		String fileName = null;
		
		if(!file.isEmpty()) {
			fileName = file.getOriginalFilename();
			product.setFileName(fileName);
			
			File tmpFile = new File(UPLOAD_PATH, fileName);
			file.transferTo(tmpFile);
		}
		
		// Business Logic
		productService.addProduct(product);
		
		return "forward:/product/addProduct.jsp";
	}
	
	//@RequestMapping("/getProduct.do")
	@RequestMapping( value="getProduct", method=RequestMethod.GET )
	public String getProduct( @RequestParam("prodNo") String prodNo, @RequestParam("menu") String menu , Model model ) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		
		Product product = productService.getProduct(Integer.parseInt(prodNo));
		if(purchaseService.getPurchase2(Integer.parseInt(prodNo))!=null) {
			product.setProTranCode(purchaseService.getPurchase2(Integer.parseInt(prodNo)).getTranCode());
		} else {
			product.setProTranCode("0");
		}
		
		model.addAttribute("product", product);
		
		if(menu.equals("manage")) {
			model.addAttribute("menu", "manage");
			return "forward:/product/updateProductView.jsp";
		} else if(menu.equals("search")) {
			model.addAttribute("menu", "search");
			return "forward:/product/getProduct.jsp";
		}
		return null;
	}
	
	//@RequestMapping("/updateProduct.do")
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public String updateProduct(@ModelAttribute("product") Product product, @RequestParam("file") MultipartFile file, Model model) throws Exception {

		System.out.println("/product/updateProduct : POST");
		
		
		
		String fileName = null;
		
		if(!file.isEmpty()) {
			fileName = file.getOriginalFilename();
			product.setFileName(fileName);
			
			File tmpFile = new File(UPLOAD_PATH, fileName);
			file.transferTo(tmpFile);
		}
		
		
		
		productService.updateProduct(product);
		product = productService.getProduct(product.getProdNo());
		
		model.addAttribute("product", product);
		model.addAttribute("menu", "manage");
		
		return "forward:/product/getProduct.jsp";
	}
	
	//@RequestMapping("/listProduct.do")
	//public String listProduct( @ModelAttribute("search") Search search , @RequestParam("menu") String menu, Model model, HttpSession session ) throws Exception{
	@RequestMapping( value="listProduct" )
	public String listProduct( @ModelAttribute("search") Search search , @RequestParam("menu") String menu, Model model, HttpSession session ) throws Exception{

		System.out.println("/product/listProduct : GET / POST");

		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		String role = ((User)session.getAttribute("user")).getRole();

		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search, role);
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		Purchase purchase = new Purchase();
		Product product = new Product();
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
		
		map.put("list", list);
		
		// Model 과 View 연결
		model.addAttribute("map", map);
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("menu", menu);
		
		return "forward:/product/listProduct.jsp";
	}

}
