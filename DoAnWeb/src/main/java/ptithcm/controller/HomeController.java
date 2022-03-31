package ptithcm.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
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

import ptithcm.bean.Mailer;
import ptithcm.bean.ProductBean;
import ptithcm.bean.UserRegister;
import ptithcm.entity.Category;
import ptithcm.entity.Product;
import ptithcm.entity.ProductImg;
import ptithcm.entity.User;
import ptithcm.entity.UserDetail;
import ptithcm.entity.UserRole;

@Controller
@Transactional
@RequestMapping("home/")
public class HomeController {
	@Autowired
	Mailer mailer;

	@Autowired
	SessionFactory factory;

	@RequestMapping("index")
	public String showHome(ModelMap model) {
		List<Product> discountProducts = getDiscountProducts();
		List<Product> wishlistProducts = getWishlistProducts();
		List<Product> bestSellingProducts = getBestSellingProducts();
		// Cần thiết để show các product lần đầu tiên
		model.addAttribute("discountProducts", discountProducts);

		String jsonDiscountProducts = new Gson().toJson(convertProductEntitiesToBeans(discountProducts));
		String jsonWishlistProducts = new Gson().toJson(convertProductEntitiesToBeans(wishlistProducts));
		String jsonBestSellingProducts = new Gson().toJson(convertProductEntitiesToBeans(bestSellingProducts));

		model.addAttribute("jsonDiscountProducts", jsonDiscountProducts);
		model.addAttribute("jsonWishlistProducts", jsonWishlistProducts);
		model.addAttribute("jsonBestSellingProducts", jsonBestSellingProducts);

		model.addAttribute("categories", getCategories());

		// testSaveProduct_ProductImgs();
		return "home/index";
	}

	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String showLogin(ModelMap model) {
		System.out.println("vao getLogin");
		model.addAttribute("userLog", new User());
		return "home/login";
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String postLogin(ModelMap model, @Validated @ModelAttribute("userLog") User user, BindingResult errors,
			HttpSession httpSession) {

		System.out.println("vao postLogin");

//		if (user.getPass().length() == 0) {
//			errors.rejectValue("pass", "userLog", "Mật Khẩu Không Được Bỏ Trống");
//		} else if (user.getPass().length() > 20) {
//			errors.rejectValue("pass", "userLog", "Mật Khẩu Tối Đa 20 Ký Tự");
//		}

		if (errors.hasErrors()) {
			return "home/login";
		}

		Session session = factory.getCurrentSession();
		String hql = "Select userRole.roleName " + "From User " + "where username = :username " + "and pass = :pass";
		Query query = session.createQuery(hql);
		query.setParameter("username", user.getUsername());
		query.setParameter("pass", user.getPass());

		if (query.list().isEmpty()) {
			model.addAttribute("message", "Sai Tên Đăng Nhập hoặc Mật Khẩu");
			return "home/login";
		} else {

			String roleName = query.list().get(0).toString().trim();
			UserDetail userDetail = getUserDetail(user.getUsername(), user.getPass());
			User u = getUser(userDetail.getId());

			httpSession.setAttribute("userDetail", userDetail);
			httpSession.setAttribute("user", u);
			if (roleName.equals("admin")) {
				return "redirect:/admin/editProduct.htm";
			} else if (roleName.equals("customer")) {			
				return "redirect:/home/index.htm";
			}
		}
		return "home/login";
	}

	@RequestMapping(value = "register", method = RequestMethod.GET)
	public String getRegister(ModelMap model) {
		System.out.println("vao get Register");
		model.addAttribute("userRegist", new UserRegister());
		return "home/register";
	}

	@RequestMapping(value = "register", method = RequestMethod.POST)
	public String postRegister(ModelMap model, @Validated @ModelAttribute("userRegist") UserRegister userBean,
			BindingResult errors, @RequestParam("repeatPassword") String repeatPassword) {
		System.out.println("Vao postRegister");

		if (userBean.getPass().trim().length() == 0) {
			errors.rejectValue("pass", "user", "Mật Khẩu Không Được Để Trống");
		} else if (repeatPassword.trim().length() == 0) {
			errors.rejectValue("pass", "user", "Mật Khẩu Nhập Lại Không Được Để Trống");
		} else if (!userBean.getPass().equals(repeatPassword)) {
			errors.rejectValue("pass", "user", "Mật Khẩu Nhập Lại Không Trùng");
		}

		if (errors.hasErrors()) {
			return "home/register";
		}

		// Chuẩn hóa lại các giá trị đã nhập
		userBean.setUsername(userBean.getUsername().trim());
		userBean.setPass(userBean.getPass().trim());
		userBean.setName(userBean.getName().trim());

		// Kiểm tra username đã tồn tại chưa?
		User uTmp = getUser(userBean.getUsername());
		if (uTmp != null) {
			model.addAttribute("message", "Tên Đăng Nhập Đã Được Sử Dụng");
			return "home/register";
		}
		// Kiểm tra Email đã được đăng ký chưa?
		UserDetail uTmp2 = getUserDetailByEmail(userBean.getEmail());
		if (uTmp2 != null) {
			model.addAttribute("message", "Email Này Đã Được Sử Dụng");
			return "home/register";
		}

		User userEntity = new User();
		int idUser = getMaxIDUser() + 1;
		userEntity.setId(idUser);
		userEntity.setUsername(userBean.getUsername());
		userEntity.setPass(userBean.getPass());
		saveUserCustomer(userEntity);

		UserDetail userDEntity = new UserDetail();
		userDEntity.setId(idUser);
		userDEntity.setName(userBean.getName());
		userDEntity.setPhone(userBean.getPhone());
		userDEntity.setEmail(userBean.getEmail());
		saveUserCustomerDetail(userDEntity);

		mailer.send("chuongungdinh@gmail.com", userDEntity.getEmail(), "Đăng Ký Tài Khoản Shop Sporter",
				"Bạn Đã Đăng Ký Tài Khoản Thành Công");

		// Gửi thông báo lại cho User rằng phải xác nhận Email để hoàn tất thủ tục đăng
		// ký
		model.addAttribute("message", "Xác Nhận Email Để Đăng Ký Hoàn Tất");

		return "home/register";
	}
	
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logOut(HttpSession httpSession) {
		httpSession.removeAttribute("user");
		httpSession.removeAttribute("userDetail");
		return "redirect:/home/index.htm";
	}

	public UserDetail getUserDetail(String username, String pass) {
		Session session = factory.getCurrentSession();
		String hql = "Select ud " + "From User as u " + ",UserDetail as ud " + "where u.username = :username "
				+ "and u.pass = :pass " + "and u.id = ud.id";
		Query query = session.createQuery(hql);
		query.setParameter("username", username);
		query.setParameter("pass", pass);
		UserDetail userDetail = (UserDetail) query.list().get(0);
		return userDetail;
	}

	public User getUser(int idUser) {
		Session session = factory.getCurrentSession();
		String hql = "From User " + "where id = :idUser ";
		Query query = session.createQuery(hql);
		query.setParameter("idUser", idUser);
		User user = (User) query.list().get(0);
		return user;
	}

	// @ModelAttribute("discountProducts")
	public List<Product> getDiscountProducts() {
		// Get listProduct đang giảm giá
		Session session = factory.getCurrentSession();
		String hql = "Select p From Product as p " + "where p.discount != 0";
		Query query = session.createQuery(hql);
		List<Product> list = query.list();
		return list;
	}

	// @ModelAttribute("wishlistProducts")
	public List<Product> getWishlistProducts() {
		// Get listProduct nhiều người thích nhất
		List<Product> lovedProducts = new ArrayList<Product>();
		Session session = factory.getCurrentSession();
		String hqlGetIDProductsLoveMost = "Select p.idProduct, COUNT(w.user.id) as tongLuongNguoiThich  "
				+ "From Product as p, Wishlist as w " + "where p.idProduct = w.product.idProduct "
				+ "Group by p.idProduct " + "order by tongLuongNguoiThich DESC ";

		Query query = session.createQuery(hqlGetIDProductsLoveMost);

		for (Iterator it = query.list().iterator(); it.hasNext();) {
			Object[] myResult = (Object[]) it.next();
			int idProduct = (int) myResult[0];
			lovedProducts.add(getProduct(idProduct));
//            long totalUserLove = (long) myResult[1];
//            System.out.println( "Found idProduct " + idProduct + "total :" + totalUserLove);
		}

//		for(Product p : lovedProducts) {
//			System.out.println(p.getProductImgs());
//		}

		return lovedProducts;
	}

	// @ModelAttribute("bestSellingProducts")
	public List<Product> getBestSellingProducts() {
		// Get listProduct bán chạy nhất
		List<Product> bestSellingProducts = new ArrayList<Product>();
		Session session = factory.getCurrentSession();
		String hql = "Select pb.product.idProduct, COUNT(pb.quantity) as tongLuongHangBan "
				+ "From Product as p join p.billDetails as pb  " + "Group by pb.product.idProduct  "
				+ "order by tongLuongHangBan DESC ";
		Query query = session.createQuery(hql);

		for (Iterator it = query.list().iterator(); it.hasNext();) {
			Object[] myResult = (Object[]) it.next();
			int idProduct = (int) myResult[0];
			bestSellingProducts.add(getProduct(idProduct));
			long total = (long) myResult[1];
			// System.out.println( "Found idProduct " + idProduct + "total :" + total);
		}
		return bestSellingProducts;
	}

	public boolean checkExistUser(String username, String pass) {
		Session session = factory.getCurrentSession();
		String hql = "Select 1 " + "From User " + "where username = :username " + "and pass = :pass";
		Query query = session.createQuery(hql);
		query.setParameter("username", username);
		query.setParameter("pass", pass);
		if (query.list().isEmpty()) {
			return false;
		} else {
			return true;
		}
	}

	public User getUser(String username) {
		Session session = factory.getCurrentSession();
		String hql = "From User as u " + "where u.username = :username ";
		Query query = session.createQuery(hql);
		query.setParameter("username", username);

		if (query.list().isEmpty()) {
			// System.out.println("getUser Null");
			return null;
		} else {
			// System.out.println("getUser Not Null");
			return (User) query.list().get(0);
		}
	}

	public UserDetail getUserDetailByEmail(String email) {
		Session session = factory.getCurrentSession();
		String hql = "From UserDetail as u " + "where u.email = :email ";
		Query query = session.createQuery(hql);
		query.setParameter("email", email);

		if (query.list().isEmpty()) {
			// System.out.println("getUser Null");
			return null;
		} else {
			// System.out.println("getUser Not Null");
			return (UserDetail) query.list().get(0);
		}
	}

	public boolean saveUserCustomer(User user) {
		user.setUserRole(getUserRole(2));
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(user);
			t.commit();
			return true;
		} catch (Exception e) {
			t.rollback();
			System.out.println("saveUserCustomer" + e);
			return false;
		} finally {
			session.close();
		}

	}

	public boolean saveUserCustomerDetail(UserDetail userDetail) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(userDetail);
			t.commit();
			return true;
		} catch (Exception e) {
			t.rollback();
			System.out.println("saveUserCustomerDetail" + e);
			return false;
		} finally {
			session.close();
		}
	}

	public UserRole getUserRole(int idRole) {
		Session session = factory.getCurrentSession();
		String hql = "From UserRole " + "where idRole = :idRole ";
		Query query = session.createQuery(hql);
		query.setParameter("idRole", idRole);

		if (query.list().isEmpty()) {
			return null;
		} else {
			return (UserRole) query.list().get(0);
		}
	}

	public int getMaxIDUser() {
		Session session = factory.getCurrentSession();
		String hql = "Select Max(id) " + "From User ";
		Query query = session.createQuery(hql);
		if (query.list().isEmpty()) {
			return 0;
		} else {
			return (int) query.list().get(0);
		}
	}

	public Product getProduct(int idProduct) {
		Session session = factory.getCurrentSession();
		String hql = "From Product where idProduct = :idProduct";
		Query query = session.createQuery(hql);
		query.setParameter("idProduct", idProduct);
		return (Product) query.list().get(0);
	}

	public ProductBean convertProductEntityToBean(Product product) {
		ProductBean productBean = new ProductBean();

		productBean.setIdProduct(product.getIdProduct());
		productBean.setName(product.getName());
		productBean.setPrice(product.getPrice());
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

	public ArrayList<Category> getCategories() {
		Session session = factory.getCurrentSession();
		String hql = "From Category ";
		Query query = session.createQuery(hql);
		return (ArrayList<Category>) query.list();
	}

//	public boolean testSaveProduct_ProductImgs() {
//		Category cate = getCategories().get(0);
//
//		Product p = new Product();
//		p.setName("san Pham moi");
//		p.setPrice(100);
//		p.setInStock(3);
//		p.setDecription("Cha co gi");
//		p.setDateAdd(new Date());
//		p.setDiscount(0);
//
//		// p-cate
//		p.setCategory(cate);
//
//		Session session = factory.openSession();
//		Transaction t = session.beginTransaction();
//
//		try {
//			session.save(p);
//
//			ProductImg pi2 = new ProductImg();
//			pi2.setProduct(p);
//			pi2.setSource("Ảnh mới.png");
//			session.save(pi2);
//
//			t.commit();
//			System.out.println("Save thanh cong");
//			return true;
//		} catch (Exception e) {
//			t.rollback();
//			System.out.println("Save that bai" + e);
//			return false;
//		} finally {
//			session.close();
//		}
//	}
}
