package com.model2.mvc.web.purchase;

import java.util.Map;

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
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

//==> 구매관리 Controller
@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public PurchaseController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	//@RequestMapping("/addPurchaseView.do")
	@RequestMapping(value="addPurchaseView", method=RequestMethod.GET)
	public ModelAndView addPurchaseView( @RequestParam("prodNo") String prodNo, HttpSession session, HttpServletRequest request ) throws Exception {

		System.out.println("/purchase/addPurchaseView : GET");
		
		Purchase purchase = new Purchase();
		purchase.setBuyer((User)session.getAttribute("user"));
		purchase.setPurchaseProd(productService.getProduct(Integer.parseInt(prodNo)));
		purchase.setDivyAddr(request.getParameter("receiverAddr"));
		purchase.setDivyRequest(request.getParameter("receiverRequest"));
		purchase.setDivyDate(request.getParameter("receiverDate"));
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/addPurchaseView.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}
	
	//@RequestMapping("/addPurchase.do")
	@RequestMapping(value="addPurchase", method=RequestMethod.POST)
	public ModelAndView addPurchase( @RequestParam("prodNo") String prodNo, @ModelAttribute("purchase") Purchase purchase, HttpSession session, HttpServletRequest request ) throws Exception {

		System.out.println("/purchase/addPurchase : POST");
		
		purchase.setBuyer((User)session.getAttribute("user"));
		purchase.setPurchaseProd(productService.getProduct(Integer.parseInt(prodNo)));
		purchase.setDivyAddr(request.getParameter("receiverAddr"));
		purchase.setDivyRequest(request.getParameter("receiverRequest"));
		purchase.setDivyDate(request.getParameter("receiverDate"));
		purchase.setTranCode("1");
		purchaseService.addPurchase(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/addPurchase.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}
	
	//@RequestMapping("/getPurchase.do")
	@RequestMapping(value="getPurchase", method=RequestMethod.GET)
	public ModelAndView getPurchase( @RequestParam("tranNo") String tranNo, @ModelAttribute("purchase") Purchase purchase, HttpSession session, HttpServletRequest request ) throws Exception {
		
		System.out.println("/getPurchase/getPurchase : GET");
		
		String userId = ((User)session.getAttribute("user")).getUserId();
		purchase = purchaseService.getPurchase(Integer.parseInt(tranNo));
		
		//model.addAttribute("purchase", purchase);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/getPurchase.jsp");
		modelAndView.addObject("purchase", purchase);

		return modelAndView;
	}
	
	//@RequestMapping("/updatePurchaseView.do")
	@RequestMapping(value="updatePurchaseView", method=RequestMethod.GET)
	public ModelAndView updatePurchaseView( @RequestParam("tranNo") String tranNo, @ModelAttribute("purchase") Purchase purchase ) throws Exception{

		System.out.println("/purchase/updatePurchaseView : GET");
		
		purchase = purchaseService.getPurchase(Integer.parseInt(tranNo));
		
		//model.addAttribute("purchase", purchase);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/updatePurchaseView.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}
	
	//@RequestMapping("/updatePurchase.do")
	@RequestMapping(value="updatePurchase", method=RequestMethod.POST)
	public ModelAndView updatePurchase( @RequestParam("tranNo") String tranNo, @ModelAttribute("purchase") Purchase purchase, HttpServletRequest request ) throws Exception{

		System.out.println("/purchase/updatePurchase : POST");
		
		purchase.setDivyAddr(request.getParameter("receiverAddr"));
		purchase.setDivyRequest(request.getParameter("receiverRequest"));
		purchase.setDivyDate(request.getParameter("divyDate"));
		
		purchaseService.updatePurcahse(purchase);
		purchase = purchaseService.getPurchase(Integer.parseInt(tranNo));
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/updatePurchase.jsp");
		modelAndView.addObject("purchase", purchase);
		
		//model.addAttribute("purchase", purchase);
		
		return modelAndView;
	}
	
	//@RequestMapping("/listPurchase.do")
	@RequestMapping(value="listPurchase")
	public ModelAndView listPurchase( @ModelAttribute("search") Search search , HttpSession session ) throws Exception{
		
		System.out.println("/purchase/listPurchase : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=purchaseService.getPurchaseList(search, ((User)session.getAttribute("user")).getUserId());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/listPurchase.jsp");
		modelAndView.addObject("map", map);
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		return modelAndView;
	}
	
	//@RequestMapping("/listSale.do")
	//@RequestMapping(value="listSale")
	public String listSale() throws Exception{
		
		System.out.println("/purchase/listSale");

		return null;
	}
	
	//@RequestMapping("/updateTranCode.do")
	@RequestMapping(value="updateTranCode", method=RequestMethod.GET)
	public ModelAndView updateTranCode( @RequestParam("tranNo") String tranNo, @RequestParam("tranCode") String tranCode, @ModelAttribute("purchase") Purchase purchase, @ModelAttribute("product") Product product) throws Exception{
		
		System.out.println("/purchase/updateTranCode : GET");
		
		purchase = purchaseService.getPurchase(Integer.parseInt(tranNo));
		product = purchase.getPurchaseProd();
		
		product.setProTranCode(tranCode);
		purchase.setPurchaseProd(product);
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/listPurchase?");
		System.out.println("서연희_modelAndView === " + modelAndView);
		return modelAndView;
	}
	
	// 기존 기능
	//@RequestMapping("/updateTranCodeByProd.do")
	@RequestMapping(value="updateTranCodeByProd", method=RequestMethod.GET)
	public ModelAndView updateTranCodeByProd( @RequestParam("prodNo") String prodNo, @RequestParam("tranCode") String tranCode, @ModelAttribute("purchase") Purchase purchase, @ModelAttribute("product") Product product) throws Exception{
		
		System.out.println("/purchase/updateTranCodeByProd : GET");
		
		purchase = purchaseService.getPurchase2(Integer.parseInt(prodNo));
		product = purchase.getPurchaseProd();
		
		product.setProTranCode(tranCode);
		purchase.setPurchaseProd(product);
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/listProduct?menu=manage");
		
		return modelAndView;
	}
	
	// 추가기능 - 상품재등록
	//@RequestMapping("/updateTranCodeByProd.do")
	@RequestMapping(value="updateTranCodeByProd", method=RequestMethod.POST)
	public ModelAndView updateTranCodeByProd( @RequestParam("tranCode") String tranCode, @ModelAttribute("purchase") Purchase purchase, @ModelAttribute("product") Product product) throws Exception{
		
		System.out.println("/purchase/updateTranCodeByProd : POST");

		purchase = purchaseService.getPurchase2(product.getProdNo());
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase);
		product = productService.getProduct(product.getProdNo());
		product.setProTranCode(tranCode);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("/product/listProduct?menu=manage");
		
		return modelAndView;
	}
}