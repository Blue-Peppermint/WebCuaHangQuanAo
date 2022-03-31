package ptithcm.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;


import ptithcm.bean.BillCheckout;
import ptithcm.bean.CartBean;
import ptithcm.bean.ListCart;
import ptithcm.bean.Mailer;
import ptithcm.bean.ProductReviewBean;
import ptithcm.entity.Bill;
import ptithcm.entity.BillDetail;
import ptithcm.entity.Cart;
import ptithcm.entity.Product;
import ptithcm.entity.ProductImg;
import ptithcm.entity.ProductReview;
import ptithcm.entity.ProductStock;
import ptithcm.entity.User;
import ptithcm.entity.UserDetail;

@Controller
@Transactional
@RequestMapping("cart/")
public class CartController {
	@Autowired
	Mailer mailer;
	
	@Autowired
	SessionFactory factory;

	@RequestMapping("showCart")
	public String showCart(ModelMap model, HttpSession httpSession) {
		 User user = (User) httpSession.getAttribute("user");
		 ArrayList<Cart> carts = (ArrayList<Cart>) getCarts(user.getId());

		//ArrayList<Cart> carts = (ArrayList<Cart>) getCarts(1);
		ListCart listCart = new ListCart();
		listCart.setCarts(carts);

//		for(Cart c: listCart.getCarts()) {
//			System.out.println(c);
//		}
		String showInfo = null;
		if(httpSession.getAttribute("showInfo") != null) {
			showInfo = (String) httpSession.getAttribute("showInfo");
			httpSession.removeAttribute("showInfo");
		}
		
		
		ArrayList<CartBean> cartbeans = convertCartEntitiesToBeans(carts);
		String jsonCarts = new Gson().toJson(cartbeans);

		model.addAttribute("listCart", listCart);
		model.addAttribute("jsonCarts", jsonCarts);
		model.addAttribute("showInfo",showInfo);
		

		return "customer/cart";
	}

	@RequestMapping(value = "updateCart", method = RequestMethod.POST)
	public String actionUpdateCart(@ModelAttribute("listCart") ListCart listCart, HttpSession httpSession) throws Exception {
		if(listCart.getCarts()!= null) {
			User user = (User) httpSession.getAttribute("user");
			for (Cart cart : listCart.getCarts()) {
				Product product = getProduct(cart.getProduct().getIdProduct());
				if(product.getInStock(cart.getSize()) == 0) {
					deleteCart(user.getId(),product.getIdProduct() , cart.getSize());
				}else {
					updateCart(cart);
				}
			}
		}
		return "redirect:/cart/showCart.htm";
	}

	@RequestMapping(value = "deleteCart")
	public String actionDeleteCart(@RequestParam("idProduct") int idProduct, @RequestParam("size") String size,
			HttpSession httpSession) {
		// System.out.println("idProduct :" + idProduct + " size :"+ size);
		User user = (User) httpSession.getAttribute("user");
		deleteCart(user.getId(), idProduct, size);

		return "redirect:/cart/showCart.htm";
	}

	@RequestMapping(value = "checkout", method = RequestMethod.GET)
	public String actionCheckOut(ModelMap model, HttpSession httpSession) {
		UserDetail userDetail = (UserDetail) httpSession.getAttribute("userDetail");
		
		List<Cart> carts = getCarts(userDetail.getId());
		if(carts.isEmpty()) {
//			ListCart listCart = new ListCart();
//			listCart.setCarts(carts);	
//			model.addAttribute("listCart", listCart);
			httpSession.setAttribute("showInfo", "GIỎ HÀNG CỦA BẠN ĐANG TRỐNG. CHƯA THỂ MUA HÀNG");	
			return "redirect:/cart/showCart.htm";
		}
		
		carts = removeProductsWithNoneQuantity(carts);
		if(carts.isEmpty()) {
			httpSession.setAttribute("showInfo", "BẠN KHÔNG CHỌN MUA BẤT KỲ SẢN PHẨM NÀO CẢ");	
			return "redirect:/cart/showCart.htm";
		}
		
		//UserDetail userDetail = getUserDetail(1);
		BillCheckout billCheckout = new BillCheckout();
		
		model.addAttribute("carts", carts);
		model.addAttribute("userDetail", userDetail);
		model.addAttribute("billCheckout", billCheckout);

		return "customer/checkout";
	}

	@RequestMapping(value = "checkout", method = RequestMethod.POST)
	public String actionCheckOut2(ModelMap model, 
			@Validated @ModelAttribute("billCheckout") BillCheckout billCheckout,
			BindingResult errors, HttpSession httpSession) {
		if (errors.hasErrors()) {
			UserDetail userDetail = (UserDetail) httpSession.getAttribute("userDetail");
			
			List<Cart> carts = getCarts(userDetail.getId());
			carts = removeProductsWithNoneQuantity(carts);
			
			
			UserDetail recipientInfo = new UserDetail();
			recipientInfo.setName(billCheckout.getBill().getRecipientName());
			recipientInfo.setPhone  (billCheckout.getBill().getRecipientPhone());
			recipientInfo.setEmail(billCheckout.getBill().getRecipientEmail());
			recipientInfo.setAddress(billCheckout.getBill().getRecipientAddress());
			
			model.addAttribute("carts", carts);
			
			model.addAttribute("userDetail", recipientInfo);
			return "customer/checkout";
		}
		
//		Map<Integer, String> mapId_SizeProducts =new HashMap<Integer, String>();
//		//List<Integer> idProducts = new ArrayList<Integer>();
//		for(BillDetail bd : billCheckout.getBillDetails()) {
//			mapId_SizeProducts.put(bd.getProduct().getIdProduct(), bd.getProductSize());
//			//idProducts.add(bd.getProduct().getIdProduct());
//		}
		boolean isEnoughProductQuantity = checkEnoughtProductQuantity((ArrayList<BillDetail>) billCheckout.getBillDetails()) ;
		if(!isEnoughProductQuantity) {
			httpSession.setAttribute("showInfo", "GIỎ HÀNG CỦA BẠN ĐANG CÓ SẢN PHẨM KHÔNG ĐỦ HÀNG TỒN ĐỂ MUA. XIN CẬP NHẬT LẠI.");
			return "redirect:/cart/showCart.htm";
		}
		
//		boolean isEnoughProductQuantity = checkEnoughtProductQuantity();
//		if(!isEnoughProductQuantity) {
//			httpSession.setAttribute("showInfo", "GIỎ HÀNG CỦA BẠN ĐANG CÓ SẢN PHẨM KHÔNG ĐỦ HÀNG TỒN ĐỂ MUA. XIN CẬP NHẬT LẠI.");
//			return "redirect:/cart/showCart.htm";
//		}
		
		User user = (User) httpSession.getAttribute("user");
		UserDetail userDetail = (UserDetail) httpSession.getAttribute("userDetail");
		
		Bill bill = billCheckout.getBill();
		//User user = getUser(1);
		bill.setUser(user);
		bill.setTimeCreated(new Date());
		
		ArrayList<BillDetail>  billDetails  = (ArrayList<BillDetail>) billCheckout.getBillDetails();
		boolean isSaved =  saveBill_BillDetails(bill, billDetails);
		
//		for (BillDetail bd : billCheckout.getBillDetails()) {
//		System.out.println(bd);
//	}

		sendMailToCustomer(userDetail.getEmail(), bill, billCheckout.getBillDetails());
		if(isSaved) {
			for(BillDetail billDetail : billDetails) {
				deleteCart(bill.getUser().getId(), billDetail.getProduct().getIdProduct(), billDetail.getProductSize());
			}
		}
		
		
		return "customer/success";
	}
	
//	@RequestMapping("abc")
//	public String getsg() {
//		return "customer/success";
//	}

	private ArrayList<Cart> removeProductsWithNoneQuantity(List<Cart> carts) {
		// Loại bỏ những sản phẩm có quantity = 0. Không hiển thị sản phẩm có số lượng mua = 0 trong đơn hàng
		 ArrayList<Cart> results = new ArrayList<Cart>();
		for(Cart cart : carts) {
			if(cart.getQuantity() != 0) {
				results.add(cart);
			}
		}
		return results;
	}

	private boolean checkEnoughtProductQuantity( ArrayList<BillDetail> billDetails) {
		// Kiểm tra trong danh sách sản phẩm có sản phẩm nào hết hàng tồn hoặc không đủ hàng tồn nếu mua không?
		
		for(BillDetail bd : billDetails) {
			Product product = getProduct(bd.getProduct().getIdProduct());
			
			int quantityBought = bd.getQuantity();
			int quantityLeft = product.getInStock(bd.getProductSize()) - quantityBought;
			
			if(quantityLeft < 0) {
				return false;
			}
		
		}
		
		
//		for(Map.Entry<Integer, String> id_sizeProduct: mapId_SizeProducts.entrySet()) {
//
//			Product product = getProduct(id_sizeProduct.getKey());
//			
////			System.out.println("id :" + id_sizeProduct.getKey() + " ,size :" + 
////					id_sizeProduct.getValue() + " , inStock :" + product.getInStock(id_sizeProduct.getValue()));
//
//			
//			if(product.getInStock(id_sizeProduct.getValue()) == 0) {
//				return false;
//			}
//		}
		return true;
	}

	private void sendMailToCustomer(String emailUser , Bill bill, List<BillDetail> list) {
		String from = "chuongungdinh@gmail.com";
		String to = emailUser;
		String subject = "Shop Sporter Mua Đơn Hàng Thành Công";
		String body = "";
		
		body += "idBill :" + bill.getIdBill() + " .Thông Tin Người Nhận Hàng ====================> "
				+ " Tên :" + bill.getRecipientName()
		+ " SĐT :" + bill.getRecipientPhone() + " Email :" + bill.getRecipientEmail() + " Địa Chỉ Nhận :"
		+ bill.getRecipientAddress();
		if(!bill.getNote().matches("\s*")) {
			body += " .Lời Nhắn Đến Shop ====================> " + bill.getNote();
		}
		body += " .Chi Tiết Đơn Hàng ====================> ";
		int count  = 0;
		int totalPriceAll = 0;
		for(BillDetail billDetail : list) {		
			Product product = billDetail.getProduct();
			body+= (++count) + ". " + billDetail.getProduct().getName() + " Size :" + billDetail.getProductSize()
			+ " Số Lượng :" + billDetail.getQuantity() + " Giảm Giá :" + billDetail.getDiscount() + "% ";
			
			int newPrice = product.getPrice() * (100 - billDetail.getDiscount())/100;
			int totalPrice = newPrice * billDetail.getQuantity();		
			body+= " Đơn Giá(đã trừ giảm giá) :" + newPrice + "₫ Thành Tiền :" + totalPrice + "₫";
			totalPriceAll += totalPrice;
		}
			
		 body+= " .Tổng Cộng ====================> " + totalPriceAll + "₫";
		 mailer.send(from, to, subject,body);
		
	}

	public User getUser(int idUser) {
		Session session = factory.getCurrentSession();
		String hql = "From User " + "where id = :idUser ";
		Query query = session.createQuery(hql);
		query.setParameter("idUser", idUser);
		return (User) query.list().get(0);
	}

	public UserDetail getUserDetail(int idUser) {
		Session session = factory.getCurrentSession();
		String hql = "From UserDetail " + "where id = :idUser ";
		Query query = session.createQuery(hql);
		query.setParameter("idUser", idUser);
		return (UserDetail) query.list().get(0);
	}

	public Product getProduct(int idProduct) {
		Session session = factory.getCurrentSession();
		String hql = "From Product " + "where idProduct = :idProduct ";
		Query query = session.createQuery(hql);
		query.setParameter("idProduct", idProduct);
		return (Product) query.list().get(0);
	}

	public List<Cart> getCarts(int idUser) {
		Session session = factory.getCurrentSession();
		String hql = "From Cart " + "where user.id = :idUser ";
		Query query = session.createQuery(hql);
		query.setParameter("idUser", idUser);
		List<Cart> list = query.list();
		return list;
	}

	public ArrayList<CartBean> convertCartEntitiesToBeans(List<Cart> carts) {
		ArrayList<CartBean> beans = new ArrayList<CartBean>();
		for (Cart cart : carts) {
			beans.add(converCartEntityToBean(cart));
		}
		return beans;
	}

	public CartBean converCartEntityToBean(Cart cart) {
		CartBean bean = new CartBean();

		Product product = cart.getProduct();
		bean.setIdProduct(product.getIdProduct());
		bean.setName(product.getName());
		bean.setPrice(product.getPrice());
		
		Map<String, Integer> stocks = new HashMap<String, Integer>();
		for(ProductStock ps: product.getProductStocks()) {
			stocks.put(ps.getSize(), ps.getInStock());
		}
		bean.setProductStocks(stocks);
		
		bean.setDiscount(product.getDiscount());
		ArrayList<String> imgSources = new ArrayList<String>();
		List<ProductImg> imgs = (List<ProductImg>) product.getProductImgs();
		for (ProductImg img : imgs) {
			imgSources.add(img.getSource());
		}
		bean.setImgSources(imgSources);
		bean.setSize(cart.getSize());
		bean.setQuantity(cart.getQuantity());
		
		return bean;
	}

	public boolean updateCart(Cart cart) {
//		System.out.println("idUser :" +cart.getUser().getId() + " idProduct :" 
//		+ cart.getProduct().getIdProduct() + " size :" + cart.getSize() + " quantity :" + cart.getQuantity());
		Session session = factory.openSession();
		String hql = "Update Cart set quantity = :quantity " + "where user.id = :idUser "
				+ "and product.idProduct = :idProduct " + "and size = :size";
		Query query = session.createQuery(hql);
		query.setParameter("quantity", cart.getQuantity());
		query.setParameter("idUser", cart.getUser().getId());
		query.setParameter("idProduct", cart.getProduct().getIdProduct());
		query.setParameter("size", cart.getSize());
		int result = query.executeUpdate();

		return result > 0 ? true : false;
	}

	public boolean deleteCart(int idUser, int idProduct, String size) {
		Session session = factory.openSession();
		String hql = "DELETE From Cart " + "where user.id = :idUser " + "and product.idProduct = :idProduct "
				+ "and size = :size";
		Query query = session.createQuery(hql);
		query.setParameter("idUser", idUser);
		query.setParameter("idProduct", idProduct);
		query.setParameter("size", size);
		int result = query.executeUpdate();

		return result > 0 ? true : false;
	}
	
	public boolean saveBill_BillDetails(Bill bill, ArrayList<BillDetail> billDetails) {
		
		// Cập nhật Bill và BillDetails đồng thời update số lượng hàng tồn trong ProductStock
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		
//		System.out.println(bill);
//		
//		for(BillDetail b: billDetails) {
//			System.out.println(b);
//		}
		
		
		try {
			session.save(bill);
			//System.out.println(bill);
			
			for(BillDetail billDetail : billDetails) {
				
				billDetail.setBill(bill);
				session.save(billDetail);
				
				//System.out.println(billDetail);
				
				int quantityBought = billDetail.getQuantity();
				
				Product product = getProduct(billDetail.getProduct().getIdProduct());
				int quantityLeft = product.getInStock(billDetail.getProductSize()) - quantityBought;

				
				boolean isUpdated = updateProductStock(billDetail.getProduct().getIdProduct(),billDetail.getProductSize(), quantityLeft);
				if(!isUpdated) {
					System.out.println("FAILED saveBill_BillDetail");
					t.rollback();
					return false;
				}
//				else {
//					t.commit();
//					t = session.beginTransaction();
//				}
				
			}
			t.commit();
			return true;
		}
		catch(Exception e) {
			System.out.println("saveBill_BillDetail" + e);
			t.rollback();
			return false;
		}
		finally {
			session.close();
		}
	}
	
	public boolean updateProductStock (int idProduct,String size, int inStock) {
		System.out.println("idProduct :" + idProduct + " ,Size :" + size + " ,inStock :" + inStock);
		Session session = factory.openSession();
		String hql = "Update ProductStock set inStock = :inStock " + "where idProduct = :idProduct and size = :size";
		Query query = session.createQuery(hql);
		query.setParameter("inStock", inStock);
		query.setParameter("idProduct", idProduct);
		query.setParameter("size", size);
		
		int result = query.executeUpdate();

		return result > 0 ? true : false;
	}

}
