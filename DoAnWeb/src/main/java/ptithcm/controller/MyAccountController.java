package ptithcm.controller;

import java.io.File;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import ptithcm.bean.CartBean;
import ptithcm.bean.ProductBean;
import ptithcm.bean.UploadFiles;
import ptithcm.entity.Bill;
import ptithcm.entity.BillDetail;
import ptithcm.entity.Cart;
import ptithcm.entity.Product;
import ptithcm.entity.ProductImg;
import ptithcm.entity.ProductReview;
import ptithcm.entity.ProductStock;
import ptithcm.entity.User;
import ptithcm.entity.UserDetail;
import ptithcm.entity.UserRole;
import ptithcm.entity.Wishlist;

@Controller
@Transactional
@RequestMapping("my-account/")
public class MyAccountController {
	@Autowired
	ServletContext context;

	@Autowired
	@Qualifier("uploadFilePath")
	UploadFiles uploadFile;

	@Autowired
	SessionFactory factory;

	@RequestMapping("home")
	public String showHome() {
		return "customer/my-account";
	}

	@RequestMapping("wishlist/showWishlist")
	public String showWishlist(ModelMap model, HttpSession httpSession) {
		User user = (User) httpSession.getAttribute("user");
		
		String showInfo = "";
		if (httpSession.getAttribute("showInfo") != null) {
			showInfo = (String) httpSession.getAttribute("showInfo");
			httpSession.removeAttribute("showInfo");
		}

		List<Wishlist> wishlists = getWishlists(user.getId());


		ArrayList<Cart> carts = (ArrayList<Cart>) getCarts(user.getId());
		ArrayList<CartBean> cartbeans = convertCartEntitiesToBeans(carts);
		String jsonCarts = new Gson().toJson(cartbeans);

		ArrayList<Product> products = getProducts();
		ArrayList<ProductBean> productBeans = convertProductEntitiesToBeans(products);
		String jsonProducts = new Gson().toJson(productBeans);

		model.addAttribute("showInfo", showInfo);
		model.addAttribute("wishlists", wishlists);
		model.addAttribute("jsonCarts", jsonCarts);
		model.addAttribute("jsonProducts", jsonProducts);

		return "customer/wishlist";
	}

	@RequestMapping("wishlist/addToCart")
	public String addToCart(HttpSession httpSession, @RequestParam("idProduct") int idProduct,
			@RequestParam("size") String size) {

		User user = (User) httpSession.getAttribute("user");
		Product product = getProduct(idProduct);
		boolean isSaved = addProductToCart(product, 1, size, user);
		if (isSaved) {
			httpSession.setAttribute("showInfo", "THÊM VÀO GIỎ HÀNG THÀNH CÔNG");
		} else {
			httpSession.setAttribute("showInfo", "THÊM VÀO GIỎ HÀNG THẤT BẠI");
		}
		return "redirect:/my-account/wishlist/showWishlist.htm";
	}

	@RequestMapping("wishlist/deleteWishlist")
	public String deleteWishlist(HttpSession httpSession, @RequestParam("idProduct") int idProduct,
			@RequestParam("size") String size) {
		User user = (User) httpSession.getAttribute("user");
		//User user = getUser(1);
		Product product = getProduct(idProduct);
		boolean isSaved = deleteWishlist(user.getId(), idProduct, size);
		if (isSaved) {
			httpSession.setAttribute("showInfo", "XÓA KHỎI DANH SÁCH THÀNH CÔNG");
		} else {
			httpSession.setAttribute("showInfo", "XÓA KHỎI DANH SÁCH THẤT BẠI");
		}

		return "redirect:/my-account/wishlist/showWishlist.htm";
	}

	@RequestMapping("settingAccount")
	public String showSettingAccount(ModelMap model, HttpSession httpSession) {

		UserDetail userDetail = (UserDetail) httpSession.getAttribute("userDetail");
		User user = (User) httpSession.getAttribute("user");

		// Không hiển thị mật khẩu tài khoản bên View
		User userTmp = new User();
		userTmp.setUsername(user.getUsername());
		String showInfo = null;
		if (httpSession.getAttribute("showInfo") != null) {
			showInfo = (String) httpSession.getAttribute("showInfo");
			httpSession.removeAttribute("showInfo");
		}

		model.addAttribute("user", userTmp);
		model.addAttribute("userDetail", userDetail);
		model.addAttribute("showInfo", showInfo);

		// System.out.println(userDetail);
		return "customer/setting-account";
	}

	@RequestMapping(value = "settingAccount", params = "btnSaveInfo", method = RequestMethod.POST)
	public String saveSettingPersonalInfo(ModelMap model,
			@Validated @ModelAttribute("userDetail") UserDetail userDetail, BindingResult errors,
			@RequestParam("username") String username, @RequestParam("birthdayStr") String birthdayStr,
			HttpSession httpSession) {
		// System.out.println("Vao Save Info");

		String partternDate = "(\s*)|(([0-9]{2})/([0-9]{2})/([0-9]{4}))";
		if (!birthdayStr.matches(partternDate)) {
			errors.rejectValue("birthday", "userDetail", "Nhập Đúng Format Ngày/Tháng/Năm");
		} else if (!birthdayStr.matches("\s*")) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			try {
				Date birthday = dateFormat.parse(birthdayStr);
				userDetail.setBirthday(birthday);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			userDetail.setBirthday(null);
		}

		if (errors.hasErrors()) {
			User user = new User();
			user.setUsername(username);
			model.addAttribute("user", user);
			httpSession.setAttribute("showInfo", "Kiểm Tra Lại Các Lỗi Hiển Thị");
			return "customer/setting-account";
		}

		boolean isUpdated = updateUserDetail2(userDetail);
		if (!isUpdated) {
			System.out.println("FAILED Save UserDetail - saveSettingPersonalInfo()");
			httpSession.setAttribute("showInfo", "Lưu Thay Đổi Thất Bại");
		} else {
			httpSession.setAttribute("userDetail", userDetail);
			httpSession.setAttribute("showInfo", "Lưu Thay Đổi Thành Công");
		}
		return "redirect:/my-account/settingAccount.htm";
	}

	@RequestMapping(value = "settingAccount", params = "btnSaveEmail", method = RequestMethod.POST)
	public String saveSettingEmail(ModelMap model, @Validated @ModelAttribute("userDetail") UserDetail userDetail,
			BindingResult errors, @RequestParam("username") String username, HttpSession httpSession) {
		// System.out.println("Vao Save btnSaveEmail");
		if (errors.hasErrors()) {
			User user = new User();
			user.setUsername(username);
			model.addAttribute("user", user);
			httpSession.setAttribute("showInfo", "Kiểm Tra Lại Các Lỗi Hiển Thị");
			return "customer/setting-account";
		}
		boolean isUpdated = updateUserDetail2(userDetail);
		if (!isUpdated) {
			System.out.println("FAILED Save UserDetail - saveSettingEmail()");
			httpSession.setAttribute("showInfo", "Lưu Thay Đổi Thất Bại");
		} else {
			httpSession.setAttribute("userDetail", userDetail);
			httpSession.setAttribute("showInfo", "Lưu Thay Đổi Thành Công");
		}
		return "redirect:/my-account/settingAccount.htm";
	}

	@RequestMapping(value = "settingAccount", params = "btnSavePassword", method = RequestMethod.POST)
	public String saveSettingPassword(ModelMap model, @ModelAttribute("user") User user, BindingResult errors,
			@RequestParam("newPassword") String newPass, @RequestParam("newPasswordRepeat") String newPassRepeat,
			HttpSession httpSession) {
		// System.out.println("Vao Save btnSavePassword");
		User userReal = (User) httpSession.getAttribute("user");

		if (user.getPass().length() == 0) {
			errors.rejectValue("pass", "user", "Mật Khẩu Cũ Không Được Để Trống");
		} else if (!user.getPass().equals(userReal.getPass())) {
			errors.rejectValue("pass", "user", "Mật Khẩu Cũ Không Đúng");
		} else if (newPass.length() == 0) {
			errors.rejectValue("pass", "user", "Mật Khẩu Mới Không Được Để Trống");
		} else if (newPass.length() > 20) {
			errors.rejectValue("pass", "user", "Mật Khẩu Mới Nhiều Nhất Chứa 20 Ký Tự");
		} else if (newPass.length() > 0 && !newPass.equals(newPassRepeat)) {
			errors.rejectValue("pass", "user", "Mật Khẩu Xác Nhận Không Trùng Mới Mật Khẩu Mới");
		}

		if (errors.hasErrors()) {
			UserDetail userDetail = (UserDetail) httpSession.getAttribute("userDetail");
			model.addAttribute("userDetail", userDetail);
			model.addAttribute("user", user);
			httpSession.setAttribute("showInfo", "Kiểm Tra Lại Các Lỗi Hiển Thị");
			return "customer/setting-account";
		}

		user.setUserRole(userReal.getUserRole());
		user.setUsername(userReal.getUsername());
		user.setId(userReal.getId());
		user.setPass(newPass);
		boolean isUpdated = updateUser(user);
		if (!isUpdated) {
			System.out.println("FAILED Save UserDetail - saveSettingEmail()");
			httpSession.setAttribute("showInfo", "Lưu Thay Đổi Thất Bại");
		} else {
			httpSession.setAttribute("user", user);
			httpSession.setAttribute("showInfo", "Lưu Thay Đổi Thành Công");
		}

		return "redirect:/my-account/settingAccount.htm";
	}

	@RequestMapping(value = "settingAccount", params = "btnSaveAvatar", method = RequestMethod.POST)
	public String saveAvatar(ModelMap model, @Validated @ModelAttribute("userDetail") UserDetail userDetail,
			BindingResult errors, @RequestParam("username") String username,
			@RequestParam("img") MultipartFile imgAvatar, HttpSession httpSession) {
		if (imgAvatar.isEmpty()) {
			errors.rejectValue("imgAvatar", "userDetail", "Chọn Ảnh Avatar Muốn Đổi");
		}

		if (errors.hasErrors()) {
			User user = new User();
			user.setUsername(username);
			model.addAttribute("user", user);
			httpSession.setAttribute("showInfo", "Kiểm Tra Lại Các Lỗi Hiển Thị");
			return "customer/setting-account";
		}

		// String pathOfnewImgAvatar = context.getRealPath("/images/" +
		// imgAvatar.getOriginalFilename());
		String pathOfnewImgAvatar = uploadFile.getBasePath() + "/images/" + imgAvatar.getOriginalFilename();
		try {
			imgAvatar.transferTo(new File(pathOfnewImgAvatar));
			Thread.sleep(2500);
			userDetail.setImgAvatar(imgAvatar.getOriginalFilename());
		} catch (Exception e) {
			e.printStackTrace();
			User user = new User();
			user.setUsername(username);
			model.addAttribute("user", user);
			httpSession.setAttribute("showInfo", "Lỗi Chuyển Ảnh Avatar");
			return "customer/setting-account";
		}
		boolean isUpdated = updateUserDetail2(userDetail);
		if (!isUpdated) {
			System.out.println("FAILED Save UserDetail - saveSettingEmail()");
			httpSession.setAttribute("showInfo", "Lưu Thay Đổi Thất Bại");
		} else {
			httpSession.setAttribute("userDetail", userDetail);
			httpSession.setAttribute("showInfo", "Lưu Thay Đổi Thành Công");
		}

		return "redirect:/my-account/settingAccount.htm";
	}

	@RequestMapping(value = "ratingComment", params = { "idBill", "idProduct", "productSize" }, method = RequestMethod.GET)
	public String sendComment(ModelMap model, @RequestParam("idBill") int idBill,
			@RequestParam("idProduct") int idProduct,
			@RequestParam("productSize") String productSize, HttpSession httpSession) {
		// Kiểm tra user có chịu trách nhiệm bill này không và đã comment trên bài này
		// chưa rồi mới hiển thị view
		UserDetail userDetail = (UserDetail) httpSession.getAttribute("userDetail");

		boolean isAllowedComment = checkUserAllowComment(userDetail.getId(), idBill, idProduct, productSize);
		if (!isAllowedComment) {
			return "";
		}

		ProductReview productReview = new ProductReview();
		Bill bill = new Bill();
		bill.setIdBill(idBill);
		Product product = new Product();
		product.setIdProduct(idProduct);
		
		productReview.setBill(bill);
		productReview.setProduct(product);
		productReview.setProductSize(productSize);
		
		model.addAttribute("productReview", productReview);
//		model.addAttribute("idBill", idBill);
//		model.addAttribute("idProduct", idProduct);
//		model.addAttribute("size", productSize);
		model.addAttribute("imgAvatar", userDetail.getImgAvatar());

		//System.out.println("productSize1 :" + productSize);
		return "customer/rating-comment";
	}

//	@RequestMapping(value = "ratingComment", params = { "idBill", "idProduct", "productSize" }, method = RequestMethod.POST)
//	public String getComment(ModelMap model, @Validated @ModelAttribute("productReview") ProductReview productReview,
//			BindingResult errors, @RequestParam("idBill") int idBill, @RequestParam("idProduct") int idProduct
//			, @RequestParam("size") String productSize, HttpSession httpSession) {	
//		if (errors.hasErrors()) {
//			UserDetail userDetail = (UserDetail) httpSession.getAttribute("userDetail");
//			model.addAttribute("idBill", idBill);
//			model.addAttribute("idProduct", idProduct);
//			model.addAttribute("size", productSize);
//			model.addAttribute("imgAvatar", userDetail.getImgAvatar());
//			return "customer/rating-comment";
//		}
//		System.out.println("productSize :" + productSize);
//		
//		System.out.println("productReview.productSize :" + productReview.getProductSize());
//		
//		boolean isSaved = saveProductReview(productReview);
//		if (!isSaved)
//			return "";
//
//		return "redirect:/shop-detail/showProduct.htm?idProduct=" + idProduct;
//	}
	
	
	@RequestMapping(value = "ratingComment", method = RequestMethod.POST)
	public String getComment(ModelMap model, @Validated @ModelAttribute("productReview") ProductReview productReview,
			BindingResult errors, HttpSession httpSession) {	
		if (errors.hasErrors()) {
			UserDetail userDetail = (UserDetail) httpSession.getAttribute("userDetail");
			model.addAttribute("productReview", productReview);
			model.addAttribute("imgAvatar", userDetail.getImgAvatar());
			return "customer/rating-comment";
		}
		//System.out.println("productSize :" + productSize);
		
		System.out.println("productReview.productSize :" + productReview.getProductSize());
		
		boolean isSaved = saveProductReview(productReview);
		if (!isSaved)
			return "";

		return "redirect:/shop-detail/showProduct.htm?idProduct=" + productReview.getProduct().getIdProduct();
	}

	@RequestMapping("bills")
	public String billUser() {
		//System.out.println("vao billUser");
		return "redirect:/my-account/bill/page.htm?p=0";
	}
	@RequestMapping("bill/page")
	public String loadBillUser( HttpServletRequest request, ModelMap model, @RequestParam("p") int p,
			HttpSession httpSession) {		
		//System.out.println("vao loadBillUser");
		User user = (User) httpSession.getAttribute("user");
		List<Bill> list= this.getListBill_idUser(user.getId());
		PagedListHolder pagedListHolder = new PagedListHolder(list);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);	
		pagedListHolder.setPageSize(5);
		model.addAttribute("pagedListHolder", pagedListHolder);
		model.addAttribute("number", list.size());
		return "customer/bill";
	}
	
	@RequestMapping("bill/detail")
	public String billDetailUser( ModelMap model, @RequestParam("id") int id) {
		//System.out.println("vao billDetailUser");
		List<BillDetail> list= this.getListBD_Billid(id);
		model.addAttribute("listBillDetail",list);
		Bill bill= this.getBill_idBill(id);
		model.addAttribute("bill", bill);
		return "customer/billDetail";
	}
	
	
	public List<Wishlist> getWishlists(int idUser) {
		Session session = factory.getCurrentSession();
		String hql = "From Wishlist " + "where user.id = :idUser ";
		Query query = session.createQuery(hql);
		query.setParameter("idUser", idUser);
		List<Wishlist> list = query.list();
		return list;
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

	public Product getProduct(int idProduct) {
		Session session = factory.getCurrentSession();
		String hql = "select p From Product as p join p.productImgs where p.idProduct = :idProduct";
		Query query = session.createQuery(hql);
		query.setParameter("idProduct", idProduct);
		return (Product) query.list().get(0);
	}

	public boolean addProductToCart(Product product, int quantity, String size, User user) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		Cart cart = new Cart();
		cart.setProduct(product);
		cart.setQuantity(quantity);
		cart.setSize(size);
		cart.setUser(user);
		try {
			session.save(cart);
			t.commit();
			return true;
		} catch (Exception e) {
			t.rollback();
			return false;
		} finally {
			session.close();
		}
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

	public ProductBean convertProductEntityToBean(Product product) {
		ProductBean productBean = new ProductBean();

		productBean.setIdProduct(product.getIdProduct());
		productBean.setName(product.getName());
		productBean.setPrice(product.getPrice());
		
		//productBean.setInStock(product.getInStock());
		
		Map<String, Integer> stocks = new HashMap<String, Integer>();
		for(ProductStock ps: product.getProductStocks()) {
			stocks.put(ps.getSize(), ps.getInStock());
		}
		productBean.setProductStocks(stocks);
		
		productBean.setDiscount(product.getDiscount());
		ArrayList<String> imgSources = new ArrayList<String>();
		for (ProductImg img : product.getProductImgs()) {
			imgSources.add(img.getSource());
		}
		productBean.setImgSources(imgSources);
		return productBean;
	}

	public ArrayList<ProductBean> convertProductEntitiesToBeans(List<Product> products) {
		ArrayList<ProductBean> productBeans = new ArrayList<ProductBean>();
		for (Product product : products) {
			productBeans.add(convertProductEntityToBean(product));
		}
		return productBeans;
	}

	public ArrayList<Product> getProducts() {
		Session session = factory.getCurrentSession();
		String hql = "From Product ";
		Query query = session.createQuery(hql);
		return (ArrayList<Product>) query.list();
	}

	public boolean deleteWishlist(int idUser, int idProduct, String size) {
		Session session = factory.openSession();
		String hql = "DELETE From Wishlist " + "where user.id = :idUser " + "and product.idProduct = :idProduct "
				+ "and size = :size";
		Query query = session.createQuery(hql);
		query.setParameter("idUser", idUser);
		query.setParameter("idProduct", idProduct);
		query.setParameter("size", size);
		int result = query.executeUpdate();

		return result > 0 ? true : false;
	}

	public boolean updateUserDetail(UserDetail userDetail) {
		// Hàm này sử dụng là bị lỗi ko bik vì sao
		System.out.println(userDetail);
		Session session = factory.openSession();
		String hql = "Update UserDetail set " + "name = :name, " + "phone = :phone," + "email = :email, "
				+ "gender = :gender, " + "birthday = :birthday " + "address = :address " + "imgAvatar = :imgAvatar "
				+ "where id = :idUser ";
		Query query = session.createQuery(hql);
		query.setParameter("name", userDetail.getName());
		query.setParameter("phone", userDetail.getPhone());
		query.setParameter("email", userDetail.getEmail());
		query.setParameter("gender", userDetail.getGender());
		query.setParameter("birthday", userDetail.getBirthday());
		query.setParameter("address", userDetail.getAddress());
		query.setParameter("imgAvatar", userDetail.getImgAvatar());
		query.setParameter("idUser", userDetail.getId());

		int result = query.executeUpdate();

		return result > 0 ? true : false;
	}

	public boolean updateUserDetail2(UserDetail userDetail) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		try {
			session.update(userDetail);
			t.commit();
			return true;
		} catch (Exception e) {
			t.rollback();
			return false;
		} finally {
			session.close();
		}
	}

	private boolean updateUser(User user) {
		// System.out.println(user);
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		try {
			session.update(user);
			t.commit();
			return true;
		} catch (Exception e) {
			t.rollback();
			return false;
		} finally {
			session.close();
		}
	}

	private boolean checkUserAllowComment(int idUser, int idBill, int idProduct, String productSize) {
		// Kiểm tra user này có chịu trách nhiệm cho sản phẩm này không
		Session session = factory.getCurrentSession();
		String hql1 = "Select b.idBill From Bill as b " + "join b.billDetails as bb " + "where b.user.id = :idUser "
				+ "and b.idBill = :idBill " + "and bb.product.idProduct = :idProduct and bb.productSize = :productSize";
		Query query1 = session.createQuery(hql1);
		query1.setParameter("idUser", idUser);
		query1.setParameter("idBill", idBill);
		query1.setParameter("idProduct", idProduct);
		query1.setParameter("productSize", productSize);

		if (query1.list().isEmpty()) {
			return false;
		}
		// Kiểm tra đã có bản ghi Product Review này chưa?
		String hql2 = "Select p.bill.idBill From ProductReview as p " + "where p.bill.idBill = :idBill "
				+ "and p.product.idProduct = :idProduct and p.productSize = :productSize";
		Query query2 = session.createQuery(hql2);
		query2.setParameter("idBill", idBill);
		query2.setParameter("idProduct", idProduct);
		query2.setParameter("productSize", productSize);
		
		if (query2.list().isEmpty()) {
			return true;
		}
		return false;
	}

	private boolean saveProductReview(ProductReview productReview) {
		productReview.setDateReview(new Date());
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		//System.out.println(productReview.getProductSize());
		try {
			session.save(productReview);
			t.commit();
			return true;
		} catch (Exception e) {
			System.out.println("FAILED saveProductReview ");
			e.printStackTrace();
			t.rollback();
			return false;
		} finally {
			session.close();
		}
	}
	
	public List<Bill> getListBill_idUser(int idUser)
	{
		Session session = factory.getCurrentSession();
		String hql = "From Bill WHERE idUser= :idUser order by idBill DESC";
		Query query = session.createQuery(hql);
		query.setParameter("idUser", idUser);
		return query.list();
	}
	
	public Bill getBill_idBill(int idBill){
		Session session = factory.getCurrentSession();
		String hql = "From Bill WHERE idBill= :id";
		Query query = session.createQuery(hql);
		query.setParameter("id", idBill);
		return (Bill) query.uniqueResult();
	}
	
	public List<BillDetail> getListBD_Billid(int idBill) {
		Session session = factory.getCurrentSession();
		String hql = "From BillDetail WHERE idBill= :id";
		Query query = session.createQuery(hql);
		query.setParameter("id", idBill);
		return query.list();
	}

}
