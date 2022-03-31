package ptithcm.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
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
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;

import ptithcm.bean.ProductBean;
import ptithcm.bean.ProductReviewBean;
import ptithcm.entity.Cart;
import ptithcm.entity.Product;
import ptithcm.entity.ProductImg;
import ptithcm.entity.ProductReview;
import ptithcm.entity.ProductStock;
import ptithcm.entity.User;
import ptithcm.entity.UserDetail;
import ptithcm.entity.Wishlist;

@Controller
@Transactional
@RequestMapping("shop-detail/")
public class ShopDetailController {
	@Autowired
	SessionFactory factory;
	
	@RequestMapping(value = "showProduct", params = "idProduct")
	public String showProductDetail(ModelMap model, @RequestParam("idProduct") int idProduct) {
		//System.out.println("idProduct :"+ idProduct);
		Product product = getProduct(idProduct);
		List liStocks = removeDuplicateVal(product.getProductStocks());
		// Sau khi removeDuplicateVal, liStocks sẽ bị lộn xộn nên phải sắp xếp lại
		Collections.sort(liStocks, new Comparator<ProductStock>() {
			@Override
			public int compare(ProductStock o1, ProductStock o2) {
				return o1.getSize().compareTo(o2.getSize());
			}
			
		});
		product.setProductStocks(liStocks);
		
		List liImgs = removeDuplicateVal(product.getProductImgs());
		product.setProductImgs(liImgs);
		
		
		//System.out.println(product.getProductImgs());
		
		ArrayList<ProductReview> productReviews = getProductReviews(idProduct);
		
		ArrayList<UserDetail> u = getUserDetailsReviewProduct(idProduct);
		
//		for(UserDetail user : u) {
//			System.out.println(user);
//		}
		
		String jsonProductReviews = new Gson().toJson(convertProductReviewEntitiesToBeans(productReviews));
		String jsonProductDetail = new Gson().toJson(convertProductEntityToBean(product));
		
		
		List<Product> similarProducts = getProductsRandom(product.getCategory().getId());
		similarProducts = removeDuplicateVal(similarProducts);
//		for(Product p : similarProducts) {
//			//System.out.println(p.getProductImgs());
//			System.out.println(p.getIdProduct());
//		}
		
		model.addAttribute("productDetail", product);
		model.addAttribute("productReviews", productReviews);
		model.addAttribute("userDetail",u);
		model.addAttribute("jsonProductReviews", jsonProductReviews);
		model.addAttribute("jsonProductDetail", jsonProductDetail);
		model.addAttribute("similarProducts", similarProducts);
		
		
		return "home/shop-detail";
	}
	
	@RequestMapping(value = "addToCart")
	public String addCart(@RequestParam("idProduct")int idProduct, 
			@RequestParam("quantity") int quantity, @RequestParam("size") String size,
			HttpSession httpSession) {
		UserDetail userDetail = (UserDetail) httpSession.getAttribute("userDetail");
		User user = (User) httpSession.getAttribute("user");
		Product product = getProduct(idProduct);
		
		// Nếu sản phẩm vẫn còn số lượng hàng tồn thì cho add Cart
		if(product.getInStock(size) != 0) {
			boolean isSaved = addProductToCart(product, quantity, size, user);
			if(!isSaved) {
				System.out.println("add to cart failed");
			}
		}

		return "redirect:/shop-detail/showProduct.htm?idProduct=" + idProduct;
	}
	
	@RequestMapping(value ="addToWishlist")
	public String addWishtlist(@RequestParam("idProduct")int idProduct,
			@RequestParam("size")String size ,HttpSession httpSession){
		UserDetail userDetail = (UserDetail) httpSession.getAttribute("userDetail");
		User user = (User) httpSession.getAttribute("user");
		Product product = getProduct(idProduct);
		boolean isSaved = addProductToWishlist(product, size, user);
		if(!isSaved) {
			System.out.println("add to wishlist failed");
		}

		return "redirect:/shop-detail/showProduct.htm?idProduct=" + idProduct;
	}
	
	public Product getProduct(int idProduct) {
		Session session = factory.getCurrentSession();
		String hql = "select p From Product as p join p.productImgs as pp where p.idProduct = :idProduct "
				+ "and p.id = pp.product.id ";
		Query query = session.createQuery(hql);
		query.setParameter("idProduct", idProduct);
		return (Product) query.list().get(0);
	}
	
	public ArrayList<ProductReview> getProductReviews(int idProduct) {
		// Sắp xếp thứ tự productReview theo ngày gần nhất		
		Session session = factory.getCurrentSession();
		String hql = "select pb.productReview From Product as p join p.billDetails as pb "
				+ "where p.idProduct = :idProduct "
				+ "order by pb.productReview.dateReview DESC";
		Query query = session.createQuery(hql);
		query.setParameter("idProduct", idProduct);
		return (ArrayList<ProductReview>) query.list();
	}
	
	public ArrayList<UserDetail> getUserDetailsReviewProduct(int idProduct){
		ArrayList<UserDetail> userDetailsReviewProduct = new ArrayList<UserDetail>();
		
		Session session = factory.getCurrentSession();	
		String hqlIDUserBoughtProduct = "select b.user.id From ProductReview as pr "
				+ ",Bill as b "
				+ "where pr.bill.idBill = b.idBill "
				+ "and pr.product.idProduct = :idProduct";
		Query query = session.createQuery(hqlIDUserBoughtProduct);		
		query.setParameter("idProduct", idProduct);
		
		List<Integer> listIDUserBoughtProduct = query.list();
		for(int id : listIDUserBoughtProduct) {
			userDetailsReviewProduct.add(getUserDetail(id));
		}
		
		return userDetailsReviewProduct;
	}
	
	public UserDetail getUserDetail(int idUser) {
		Session session = factory.getCurrentSession();
		String hql = "From UserDetail "
				+ "where id = :idUser";
		Query query = session.createQuery(hql);		
		query.setParameter("idUser", idUser);
		return (UserDetail) query.list().get(0);
	}
	
	public UserDetail getUserDetailFromBill (int idBill) {
		Session session = factory.getCurrentSession();
		String hql = "Select ud From Bill as b "
				+ ", UserDetail as ud "
				+ "where b.user.id = ud.id "
				+ "and b.idBill = :idBill ";
		Query query = session.createQuery(hql);		
		query.setParameter("idBill", idBill);
		return (UserDetail) query.list().get(0);
	}
	
	public ArrayList<ProductReviewBean> convertProductReviewEntitiesToBeans(List<ProductReview> productReviews) {
		ArrayList<ProductReviewBean> beans = new ArrayList<ProductReviewBean>();	
		for(ProductReview review : productReviews) {
			beans.add(convertProductReviewEntityToBean(review));
		}
		return beans;
	}
	
	public ProductReviewBean convertProductReviewEntityToBean(ProductReview review) {
		ProductReviewBean bean = new ProductReviewBean();
		UserDetail ud = getUserDetailFromBill(review.getBill().getIdBill());
		bean.setCustomerName(ud.getName());
		bean.setImgAvatar(ud.getImgAvatar());
		bean.setRatingScore(review.getRatingScore());
		bean.setContentText(review.getContentText());
		bean.setDateReview(review.getDateReview());	
		return bean;
	}
	
	public ProductBean convertProductEntityToBean(Product product) {
		ProductBean productBean = new ProductBean();

		productBean.setIdProduct(product.getIdProduct());
		productBean.setName(product.getName());
		productBean.setPrice(product.getPrice());
		productBean.setDiscount(product.getDiscount());
		
		Map<String, Integer> productStocks = new HashMap<String, Integer>();
		for (ProductStock productStock : product.getProductStocks()) {
			productStocks.put(productStock.getSize(), productStock.getInStock());
		}
		productBean.setProductStocks(productStocks);
		
		ArrayList<String> imgSources = new ArrayList<String>();
		for (ProductImg img : product.getProductImgs()) {
			imgSources.add(img.getSource());
		}
		productBean.setImgSources(imgSources);
		return productBean;
	}

//	public ArrayList<ProductBean> convertProductEntitiesToBeans(List<Product> products) {
//		ArrayList<ProductBean> productBeans = new ArrayList<ProductBean>();
//		for (Product product : products) {
//			productBeans.add(convertProductEntityToBean(product));
//		}
//		return productBeans;
//	}
	
	public List<Product> getProductsRandom (int idCategory) {
		Session session = factory.getCurrentSession();
		String hql = "From Product  "
				+ "where category.id = :idCategory "
				+ "order by NEWID() ";
		Query query = session.createQuery(hql);
		query.setMaxResults(7);
		query.setParameter("idCategory", idCategory);
		
		List<Product> list = query.list();
		return list;
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
		}catch(Exception e) {
			t.rollback();
			return false;
		}finally {
			session.close();
		}
	}
	
	public boolean addProductToWishlist(Product product, String size, User user) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		
		Wishlist wishlist = new Wishlist();
		wishlist.setProduct(product);
		wishlist.setSize(size);
		wishlist.setUser(user);
		try {
			session.save(wishlist);
			t.commit();
			return true;
		}catch(Exception e) {
			t.rollback();
			return false;
		}finally {
			session.close();
		}
	}
	
	
	public List removeDuplicateVal(Collection collection){
		List li = new ArrayList(new HashSet(collection));
		return li;
	}
	
	
}
