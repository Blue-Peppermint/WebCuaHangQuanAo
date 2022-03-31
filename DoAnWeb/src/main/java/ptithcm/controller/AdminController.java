package ptithcm.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.net.http.HttpRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.jboss.logging.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import ptithcm.bean.UploadFiles;
import ptithcm.entity.Bill;
import ptithcm.entity.BillDetail;
import ptithcm.entity.Category;
import ptithcm.entity.Product;
import ptithcm.entity.ProductImg;
import ptithcm.entity.ProductStock;


@Controller
@Transactional
@RequestMapping("admin/")
public class AdminController {
	//Path file for upload image
	@Autowired
	@Qualifier("uploadFilePath")
	UploadFiles uploadFile;
	//public String FILEPATH="C:\\Users\\Trong Hieu\\eclipse-workspace\\WEB_CuoiKy\\src\\main\\webapp\\anh";
	final String DATE_FORMAT = "dd-MM-yyyy";
	final String DATE_FORMAT_DISPLAY= "yyyy-MM-dd";
	
	@Autowired
	SessionFactory factory;
	
	@RequestMapping(value="editProduct", method = RequestMethod.GET)
	public String load1( ModelMap model, @ModelAttribute("product") Product product) {
		return "redirect:/admin/page.htm?p=0";
	}
	
	@RequestMapping(value="page")
	public String loadProduct( HttpServletRequest request, ModelMap model, @ModelAttribute("product") Product product,
			@RequestParam("p") int p) {	
		PagedListHolder pagedListHolder = new PagedListHolder(this.getListProduct());
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);	
		pagedListHolder.setPageSize(5);
		model.addAttribute("pagedListHolder", pagedListHolder);
		
		SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT_DISPLAY);
		String date1= sdf.format(new Date());
		model.addAttribute("date",date1);
		model.addAttribute("btnStatus", "btnAdd");
		return "admin/edit-product";
	}
	
	@RequestMapping(value="editProduct", params="btnAdd", method=RequestMethod.POST)
	public String addProduct(HttpServletRequest request,ModelMap model, @ModelAttribute("product") Product product,
			@RequestParam MultipartFile[] file) {
		int inStockL=0;
		int inStockXL=0;
		int inStockXXL=0;
		try {
			inStockL=Integer.valueOf(request.getParameter("inStockL"));						
		} catch (Exception e) {
			
		}
		try {
			inStockXL=Integer.valueOf(request.getParameter("inStockXL"));
		} catch (Exception e) {
			
		}
		try {
			inStockXXL=Integer.valueOf(request.getParameter("inStockXXL"));
		} catch (Exception e) {
			
		}
		
		int length=file.length;
		Date date = new Date();
		product.setDateAdd(date);
		int temp=this.insertProduct(product);
		String filename;
		ProductImg pdImg = new ProductImg();
		Product pdTemp=this.getProduct_name(product.getName());
		if(inStockL>0) {
			ProductStock pdSt= new ProductStock(pdTemp,"L",inStockL);
			temp=this.insertProductStock(pdSt);
		}
		if(inStockXL>0) {
			ProductStock pdSt= new ProductStock(pdTemp,"XL",inStockXL);
			temp=this.insertProductStock(pdSt);
		}
		if(inStockXXL>0) {
			ProductStock pdSt= new ProductStock(pdTemp,"XXL",inStockXXL);
			temp=this.insertProductStock(pdSt);
		}
		
		pdImg.setProduct(pdTemp);
		if(file[0].getSize()!=0)
		{
			for(int i=0; i<length; i++) {
				try {
					filename = file[i].getOriginalFilename();
			        String path = uploadFile.getBasePath();
			        byte[] bytes = file[i].getBytes();
			        BufferedOutputStream stream =new BufferedOutputStream(new FileOutputStream(
			                new File(path + "/images/" + File.separator + filename)));
			        stream.write(bytes);
			        stream.flush();
			        stream.close();
			        //insert productImg
			        pdImg.setSource(filename);
			        temp=this.insertImgPd(pdImg);
				}
				catch (Exception e) {
					System.out.println(e);
				}
			}
		}
		model.addAttribute("product", new Product());
		return "redirect:/admin/editProduct.htm";
	}
	
	@RequestMapping("edit")
	public String edit(HttpServletRequest request,ModelMap model, @RequestParam("id") int id) {
		Product product =getProduct_id(id);
		
		PagedListHolder pagedListHolder = new PagedListHolder(this.getListProduct());
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);	
		pagedListHolder.setPageSize(5);
		model.addAttribute("pagedListHolder", pagedListHolder);
		List<ProductStock> listPdSt= new ArrayList<>(product.getProductStocks());
		for(int i=0; i<product.getProductStocks().size();i++)
		{
			ProductStock pdSt= listPdSt.get(i);
			String size= pdSt.getSize().trim();
			if(size.equals("L")) {
				model.addAttribute("inStockL", pdSt.getInStock());
			}
			else if(size.equals("XL")) {
				model.addAttribute("inStockXL", pdSt.getInStock());
			}
			else if(size.equals("XXL")) {
				model.addAttribute("inStockXXL", pdSt.getInStock());
			}
		}
		
		List<ProductImg> listImg=getProductImg_id(id);
		model.addAttribute("product",product);
		model.addAttribute("images",listImg);
		model.addAttribute("date",product.getDateAdd());
		model.addAttribute("btnStatus", "btnEdit");
		return "admin/edit-product";
	}
	
	
	
	@RequestMapping(value="editProduct", params="btnEdit", method=RequestMethod.POST)
	public String editProduct(HttpServletRequest request,ModelMap model, @ModelAttribute("product") Product product,
			@RequestParam MultipartFile file[], HttpSession session) {
		int inStockL=0;
		int inStockXL=0;
		int inStockXXL=0;
		try {
			inStockL=Integer.valueOf(request.getParameter("inStockL"));						
		} catch (Exception e) {
			
		}
		try {
			inStockXL=Integer.valueOf(request.getParameter("inStockXL"));
		} catch (Exception e) {
			
		}
		try {
			inStockXXL=Integer.valueOf(request.getParameter("inStockXXL"));
		} catch (Exception e) {
			
		}
		String filename;
		int length=file.length;
		int temp;
		ProductImg pdImg= new ProductImg();
		pdImg.setProduct(product);
		this.deleteProductStock_idPd(product.getIdProduct());
		if(inStockL>0) {
			ProductStock pdSt= new ProductStock(product,"L",inStockL);
			temp=this.insertProductStock(pdSt);
		}
		if(inStockXL>0) {
			ProductStock pdSt= new ProductStock(product,"XL",inStockXL);
			temp=this.insertProductStock(pdSt);
		}
		if(inStockXXL>0) {
			ProductStock pdSt= new ProductStock(product,"XXL",inStockXXL);
			temp=this.insertProductStock(pdSt);
		}
		
		if(file[0].getSize()!=0)
		{
			temp=this.deleteImage_idPd(product.getIdProduct());
			for(int i=0; i<length; i++) {
				try {
					filename = file[i].getOriginalFilename();
			        String path = uploadFile.getBasePath();
			        byte[] bytes = file[i].getBytes();
			        BufferedOutputStream stream =new BufferedOutputStream(new FileOutputStream(
			                new File(path +  "/images/" + File.separator + filename)));
			        stream.write(bytes);
			        stream.flush();
			        stream.close();
			        //insert productImg
			        pdImg.setSource(filename);
			        temp=this.insertImgPd(pdImg);
				}
				catch (Exception e) {
					System.out.println(e);
				}
			}
		}
		
		temp=this.updateProduct(product);
		
			if (temp != 0) { 
				model.addAttribute("message", "Sửa Success!!"); 
			} 
			else {
				model.addAttribute("message", "Sửa Failed!!"); 
			}
		return "redirect:/admin/editProduct.htm";
	}
	
	@RequestMapping("del")
	public String del(ModelMap model, @RequestParam("id") int id) {
		int temp= this.deleteImage_idPd(id);
		this.deleteProductStock_idPd(id);
		temp = this.deleteProduct(this.getProduct_id(id));
		if (temp != 0) {
			model.addAttribute("message", "Delete Success");
		} else {
			model.addAttribute("message", "Delete Failed!");
		}
		return "redirect:/admin/editProduct.htm";
	}
	
	
	//*********bill**********
	@RequestMapping("bills")
	public String bills() {
		return "redirect:/admin/bill/page.htm?p=0";
	}
	@RequestMapping(value="bill/page")
	public String loadBill( HttpServletRequest request, ModelMap model, @RequestParam("p") int p) {		
		PagedListHolder pagedListHolder = new PagedListHolder(this.getListBill());
		model.addAttribute("link","bill/page.htm");
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);	
		pagedListHolder.setPageSize(5);
		model.addAttribute("pagedListHolder", pagedListHolder);
		model.addAttribute("number", this.getListBill().size());
		return "admin/bill";
	}
	@RequestMapping(value="bill/search")
	public String loadBill_filterDate(HttpServletRequest request, ModelMap model,
			@RequestParam("dateFrom") @DateTimeFormat(pattern=DATE_FORMAT) Date dateFrom,
			@RequestParam("dateTo") @DateTimeFormat(pattern=DATE_FORMAT) Date dateTo) {
		model.addAttribute("link","bill/searchs.htm");
		SimpleDateFormat sdf= new SimpleDateFormat(this.DATE_FORMAT);
		String strDF=sdf.format(dateFrom);
		String strDT=sdf.format(dateTo);
		SimpleDateFormat sdf1= new SimpleDateFormat(this.DATE_FORMAT_DISPLAY);
		String strDF1=sdf1.format(dateFrom);
		String strDT1=sdf1.format(dateTo);
		String strDate="&dateFrom="+ strDF+ "&dateTo="+strDT;
		System.out.println(strDate);
		model.addAttribute("strDF",strDF1);
		model.addAttribute("strDT",strDT1);
		model.addAttribute("strDate",strDate);
		List<Bill> list= this.getListBill_DF_DT(dateFrom,dateTo);
		PagedListHolder pagedListHolder = new PagedListHolder(list);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);	
		pagedListHolder.setPageSize(5);
		model.addAttribute("number", list.size());
		model.addAttribute("pagedListHolder", pagedListHolder);

		return "admin/bill";
	}
	
	@RequestMapping(value="bill/searchs", params = "p")
	public String convertURL(@RequestParam("p") String p) {
		String temp= p.replaceAll("%26", "&");
		String url= temp.replaceAll("%3d", "=");
		return "redirect:/admin/bill/search.htm?p="+url;
	}
	
	//*********billDetail**********
	@RequestMapping("bill/detail")
	public String billDetail( ModelMap model, @RequestParam("id") int id) {
		List<BillDetail> list= this.getListBD_Billid(id);
		model.addAttribute("listBillDetail",list);
		Bill bill= this.getBill_idBill(id);
		model.addAttribute("bill", bill);
		return "admin/billDetail";
	}
	
	//*********Log out**********
	@RequestMapping("logout")
	public String logOut(HttpSession httpSession) {
//		httpSession.setAttribute("user", null);
//		httpSession.setAttribute("userDetail", null);
		httpSession.removeAttribute("user");
		httpSession.removeAttribute("userDetail");
		return "redirect:/home/index.htm";
	}
	
	
	//ModelAttribute
	@ModelAttribute("categories")
	public List<Category> getCategories() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Category";
		Query query = session.createQuery(hql);
		List<Category> list = query.list();
		return list;
	}
	
	//delete ProductImgs
	
	
	//Product
	public List<Product> getListProduct(){
		Session session = factory.getCurrentSession();
		String hql = "From Product order by idProduct desc";
		Query query = session.createQuery(hql);
		return query.list();
	}
	public Product getProduct_id(int id) {
		Session session = factory.getCurrentSession();
		String hql = "From Product WHERE id=" +id;
		Query query = session.createQuery(hql);
		return (Product) query.uniqueResult();
		
	}
	
	public Product getProduct_name(String name) {
		Session session = factory.getCurrentSession();
		String hql = "From Product WHERE name= :name" ;
		Query query = session.createQuery(hql);
		query.setParameter("name", name);
		return (Product) query.uniqueResult();
	}
	
	public int insertProduct(Product pd) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(pd);
			t.commit();
		} catch (Exception e) {
			t.rollback();
			return 0;
		} finally {
			session.close();
		}
		return 1;
	}
	public int updateProduct(Product pd) {
		System.out.println(pd);
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		try {
			session.update(pd);
			t.commit();
		} catch (Exception e) {
			t.rollback();
			return 0;
		} finally {
			session.close();
		}
		return 1;
	}
	
	public int deleteProduct(Product pd) {
		Session session = factory.getCurrentSession();
		String hql="Delete FROM Product where idProduct= :id";
		Query query= session.createQuery(hql);
		query.setParameter("id", pd.getIdProduct());
		return query.executeUpdate();
	}
	
	//ProductImg
	public List<ProductImg> getProductImg_id(int idProduct) {
		Session session = factory.getCurrentSession();
		String hql = "From ProductImg WHERE idProduct= :id";
		Query query = session.createQuery(hql);
		query.setParameter("id", idProduct);
		//query.setParameter("urlImg", urlImg);
		return query.list();
	}
	
	public int deleteImage_idPd(int idProduct) {
		Session session = factory.getCurrentSession();
		try {
		  // your code
		  String hql = "DELETE FROM ProductImg WHERE idProduct= :id";
		  Query query = session.createQuery(hql);
		  query.setParameter("id", idProduct);
		  System.out.println(query.executeUpdate());
		  // your code end
		  query.executeUpdate();
		  return 1;
		} 
		catch (Exception e) {
			System.out.println(e);
			return 0;
		}	
	}
	
	public int insertImgPd(ProductImg pdImg) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(pdImg);
			t.commit();
		} catch (Exception e) {
			System.out.println(e);
			t.rollback();
			return 0;
		} finally {
			session.close();
		}
		return 1;
	}
	
	public int deleteImPd(ProductImg pdImg) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.delete(pdImg);
			t.commit();
		} catch (Exception e) {
			System.out.println(e);
			t.rollback();
			return 0;
		} finally {
			session.close();
		}
		return 1;
	}
	public int updateImPd(ProductImg pdImg) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.update(pdImg);
			t.commit();
		} catch (Exception e) {
			t.rollback();
			return 0;
		} finally {
			session.close();
		}
		return 1;
	}
	
	//*******bill*******
	public List<Bill> getListBill(){
		Session session = factory.getCurrentSession();
		String hql = "From Bill order by idBill desc";
		Query query = session.createQuery(hql);
		return query.list();
	}
	
	public List<Bill> getListBill_DF_DT(Date dateFrom, Date dateTo){
		Session session = factory.getCurrentSession();
		String hql = "From Bill WHERE timeCreated BETWEEN :stDate AND :edDate order by idBill";
		Query query = session.createQuery(hql);
		query.setParameter("stDate", dateFrom);
		query.setParameter("edDate", dateTo);
		return query.list();
	}
	
	public List<Bill> getListBill_idUser(int idUser)
	{
		Session session = factory.getCurrentSession();
		String hql = "From Bill WHERE idUser= :idUser";
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
		//query.setParameter("urlImg", urlImg);
		return query.list();
	}
	
	//ProductStock
	public int insertProductStock(ProductStock pdSt) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(pdSt);
			t.commit();
		} catch (Exception e) {
			t.rollback();
			return 0;
		} finally {
			session.close();
		}
		return 1;
	}
	
	public int updateProductStock(ProductStock pdSt) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.update(pdSt);
			t.commit();
		} catch (Exception e) {
			t.rollback();
			return 0;
		} finally {
			session.close();
		}
		return 1;
	}
	public void deleteProductStock_idPd(int idPd) {
		Session session = factory.getCurrentSession();
		try {
		  // your code
		  String hql = "DELETE FROM ProductStock WHERE idProduct= :id";
		  Query query = session.createQuery(hql);
		  query.setParameter("id", idPd);
		  System.out.println(query.executeUpdate());
		  // your code end
		  query.executeUpdate();
		} 
		catch (Exception e) {
			System.out.println(e);
		}
	}
}
