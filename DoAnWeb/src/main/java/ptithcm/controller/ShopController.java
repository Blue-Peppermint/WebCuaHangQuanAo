package ptithcm.controller;

import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;

import ptithcm.bean.ForShopViewBean;
import ptithcm.entity.Category;
import ptithcm.entity.Product;

import java.net.http.HttpRequest;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;

@Controller
@Transactional
@RequestMapping("shop/")
public class ShopController {
	@Autowired
	SessionFactory factory;

	public String sortTypes[] = { "Mặc định (a-z)", "Giá thấp → cao", "Giá cao → thấp", "Mua nhiều", "Mới nhất" };

	@RequestMapping(value = "{category}")
	public String showCategory(ModelMap model, @PathVariable("category") String categoryName) {
		int idCategory = 0;
		if (!categoryName.equals("all")) {
			idCategory = getCategory(categoryName).getId();
		}

		return "redirect:/shop/showCategory.htm?p=0&idCategory=" + idCategory;
	}

	@RequestMapping(value = "showCategory", params = { "p", "idCategory" })
	public String showPage(ModelMap model, @RequestParam("p") int p, @RequestParam("idCategory") int idCategory,
			HttpServletRequest request) {

		String urlParam = "&idCategory=" + idCategory;

		String categoryName = "Tất Cả";
		if (idCategory != 0) {
			categoryName = getCategory(idCategory).getName();
		}

		ArrayList<Product> products = null;
		if (categoryName.equals("Tất Cả")) {
			products = getProducts();
		} else {
			products = getProducts(categoryName);
		}

		int indexSortType = 0;
		if (request.getParameter("indexSortType") != null) {
			indexSortType = Integer.parseInt(request.getParameter("indexSortType"));
			sortProducts(products, sortTypes[indexSortType]);
			urlParam += "&indexSortType=" + indexSortType;
		}

		int maxProductPrice = getMaxProductPriceOfCategory(categoryName);
		int fromPrice = 0;
		int toPrice = maxProductPrice;

		if (request.getParameter("fromPrice") != null && request.getParameter("toPrice") != null) {
			fromPrice = Integer.parseInt(request.getParameter("fromPrice"));
			toPrice = Integer.parseInt(request.getParameter("toPrice"));
			products = filterProducts(products, fromPrice, toPrice);
			urlParam += "&fromPrice=" + fromPrice + "&toPrice=" + toPrice;
		}

		ForShopViewBean bean = new ForShopViewBean(getMaxProductPriceOfCategory(categoryName), products.size(),
				indexSortType, idCategory, fromPrice, toPrice);
		String json = new Gson().toJson(bean);

		model.addAttribute("categoryNameNow", categoryName);

		model.addAttribute("jsonForShopViewBean", json);

		PagedListHolder pagedListHolder = new PagedListHolder(products);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(12);
		model.addAttribute("pagedListHolder", pagedListHolder);
		model.addAttribute("urlParam", urlParam);

		model.addAttribute("sortTypes", getSortTypes());
		model.addAttribute("categories", getCategories());

		return "home/shop";
	}

	@RequestMapping(value = "redirect", params = "p")
	public String redirectToShowPage(@RequestParam("p") String p) {
		String temp = p.replaceAll("%26", "&");
		String url = temp.replaceAll("%3d", "=");
		
//		byte[] bytes = url.getBytes(StandardCharsets.UTF_8);
//		String urlUTF8 = new String(bytes, StandardCharsets.UTF_8);
//		
//		System.out.println(urlUTF8);
		return "redirect:/shop/showCategory.htm?p=" + url;
	}

	@RequestMapping(value = "showCategory", params = {"p","search"})
	public String searchProduct(ModelMap model, @RequestParam("search")String searchVal
			, HttpServletRequest request) {
		
		System.out.println("vao all search");
		
		String urlParam ="&search="+searchVal;
		ArrayList<Product> products = getProducts();
		products = getProductsWithKey(products,searchVal);
		
		PagedListHolder pagedListHolder = new PagedListHolder(products);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(12);
		model.addAttribute("pagedListHolder", pagedListHolder);
		model.addAttribute("urlParam", urlParam);
		
		
		int maxProductPrice = getMaxProductPriceOfCategory("Tất Cả");
		ForShopViewBean bean = new ForShopViewBean(maxProductPrice, products.size(),
				0, 0, 0, maxProductPrice);
		String json = new Gson().toJson(bean);
		
		model.addAttribute("categoryNameNow", "Tất Cả");
		//model.addAttribute("products", products);
		model.addAttribute("jsonForShopViewBean", json);
		
		model.addAttribute("sortTypes", getSortTypes());
		model.addAttribute("categories", getCategories());
		
		return "home/shop";
	}

//	@ModelAttribute("categories")
	public ArrayList<Category> getCategories() {
		Session session = factory.getCurrentSession();
		String hql = "From Category ";
		Query query = session.createQuery(hql);
		return (ArrayList<Category>) query.list();
	}

//
//	@ModelAttribute("sortTypes")
	public String[] getSortTypes() {
		return sortTypes;
	}

	public ArrayList<Product> filterProducts(ArrayList<Product> products, int fromPrice, int toPrice) {
		ArrayList<Product> result = new ArrayList<Product>();
		for (Product product : products) {
			int newPrice = product.getPrice() * (100 - product.getDiscount()) / 100;
			if ((newPrice >= fromPrice && newPrice < toPrice) || (newPrice > fromPrice && newPrice <= toPrice)) {
				result.add(product);
			}
		}
		return result;
	}

	public ArrayList<Product> getProducts(String categoryName) {
		Session session = factory.getCurrentSession();
		String hql = "From Product " + "where category.name = :categoryName ";
		Query query = session.createQuery(hql);
		query.setParameter("categoryName", categoryName);
		return (ArrayList<Product>) query.list();
	}

	public ArrayList<Product> sortProducts(ArrayList<Product> products, String sortType) {
		// System.out.println(sortType);
		switch (sortType) {
		case "Mặc định (a-z)":
			Collections.sort(products, new Comparator<Product>() {
				@Override
				public int compare(Product o1, Product o2) {
					if (o1.getName().compareTo(o2.getName()) == 0) {
						return 0;
					} else if (o1.getName().compareTo(o2.getName()) > 0) {
						return 1;
					} else {
						return -1;
					}
				}

			});
			break;
		case "Giá thấp → cao":
			Collections.sort(products, new Comparator<Product>() {
				@Override
				public int compare(Product o1, Product o2) {
					int newPrice1 = o1.getPrice() * (100 - o1.getDiscount()) / 100;
					int newPrice2 = o2.getPrice() * (100 - o2.getDiscount()) / 100;
					if (newPrice1 == newPrice2) {
						return 0;
					} else if (newPrice1 > newPrice2) {
						return 1;
					} else {
						return -1;
					}
				}

			});
			break;
		case "Giá cao → thấp":
			Collections.sort(products, new Comparator<Product>() {
				@Override
				public int compare(Product o1, Product o2) {
					int newPrice1 = o1.getPrice() * (100 - o1.getDiscount()) / 100;
					int newPrice2 = o2.getPrice() * (100 - o2.getDiscount()) / 100;
					if (newPrice1 == newPrice2) {
						return 0;
					} else if (newPrice1 > newPrice2) {
						return -1;
					} else {
						return 1;
					}
				}
			});
			break;
		case "Mua nhiều":
			Collections.sort(products, new Comparator<Product>() {
				@Override
				public int compare(Product o1, Product o2) {
					int sale1 = o1.getSale();
					int sale2 = o2.getSale();
					if (sale1 == sale2) {
						return 0;
					} else if (sale1 > sale2) {
						return -1;
					} else {
						return 1;
					}
				}
			});

			break;
		case "Mới nhất":
			Collections.sort(products, new Comparator<Product>() {
				@Override
				public int compare(Product o1, Product o2) {
					return o2.getDateAdd().compareTo(o1.getDateAdd());
				}
			});

			break;
		}
		return products;
	}

	public ArrayList<Product> getProducts() {
		Session session = factory.getCurrentSession();
		String hql = "From Product ";
		Query query = session.createQuery(hql);
		return (ArrayList<Product>) query.list();
	}

	public int getMaxProductPriceOfCategory(String categoryName) {
		ArrayList<Product> products = null;
		if (categoryName.equals("Tất Cả")) {
			products = getProducts();
		} else {
			products = getProducts(categoryName);
		}

		int maxPrice = 0;
		for (Product product : products) {

			int newPrice = product.getPrice() * (100 - product.getDiscount()) / 100;
			if (newPrice > maxPrice) {
				maxPrice = newPrice;
			}
		}

		return maxPrice;
	}

	public ArrayList<Product> getProductsWithKey(ArrayList<Product> products, String key) {
		// Tìm kiếm các product, có thuộc tính name chứa giá trị key
		ArrayList<Product> result = new ArrayList<Product>();
		for (Product product : products) {
			if (product.getName().contains(key)) {
				result.add(product);
			}
		}
		return result;
	}

	public Category getCategory(String categoryName) {
		// System.out.println(categoryName);
		Session session = factory.getCurrentSession();
		String hql = "From Category where name = :categoryName";
		Query query = session.createQuery(hql);
		query.setParameter("categoryName", categoryName);
		return (Category) query.list().get(0);
	}

	public Category getCategory(int idCategory) {
		// System.out.println(categoryName);
		Session session = factory.getCurrentSession();
		String hql = "From Category where id = :idCategory";
		Query query = session.createQuery(hql);
		query.setParameter("idCategory", idCategory);
		return (Category) query.list().get(0);
	}

}
