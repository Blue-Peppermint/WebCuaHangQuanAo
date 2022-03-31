package ptithcm.entity;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "Product")
public class Product {
	@Id
	@GeneratedValue
	@Column(name = "idProduct")
	private int idProduct;
	
	@OneToMany(mappedBy = "product", fetch = FetchType.EAGER)
	private Collection<Wishlist> wishlists;
	
	@OneToMany(mappedBy = "product", fetch = FetchType.EAGER)
	private Collection<Cart> carts;
	
	@ManyToOne
	@JoinColumn(name = "idCategory")
	private Category category;

	@OneToMany(mappedBy = "product", fetch = FetchType.EAGER)
	private Collection<ProductImg> productImgs;
	
	@OneToMany(mappedBy = "product", fetch = FetchType.EAGER)
	private Collection<BillDetail> billDetails;
	
	@OneToMany(mappedBy = "product", fetch = FetchType.EAGER)
	private Collection<ProductStock> productStocks;
	
	@Column(name ="name")
	private String name;
	
	@Column(name ="price")
	private int price;
	
//	@Column(name ="inStock")
//	private int  inStock;
	
	@Column(name ="decription")
	private String decription;
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "MM/dd/yyyy")
//	@DateTimeFormat(pattern = "yyyy/dd/MM")
	@Column(name ="dateAdd")
	private Date dateAdd;
	
	@Column(name ="discount")
	private int discount;

	public Product() {
		super();
	}
	
	
	
	public Product(int idProduct, Collection<Wishlist> wishlists, Collection<Cart> carts, Category category,
			Collection<ProductImg> productImgs, Collection<BillDetail> billDetails,
			Collection<ProductStock> productStocks, String name, int price, String decription, Date dateAdd,
			int discount) {
		super();
		this.idProduct = idProduct;
		this.wishlists = wishlists;
		this.carts = carts;
		this.category = category;
		this.productImgs = productImgs;
		this.billDetails = billDetails;
		this.productStocks = productStocks;
		this.name = name;
		this.price = price;
		this.decription = decription;
		this.dateAdd = dateAdd;
		this.discount = discount;
	}



	public int getIdProduct() {
		return idProduct;
	}

	public void setIdProduct(int idProduct) {
		this.idProduct = idProduct;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

//	public int getInStock() {
//		return inStock;
//	}
//
//	public void setInStock(int inStock) {
//		this.inStock = inStock;
//	}

	public String getDecription() {
		return decription;
	}

	public void setDecription(String decription) {
		this.decription = decription;
	}

	public Date getDateAdd() {
		return dateAdd;
	}

	public void setDateAdd(Date dateAdd) {
		this.dateAdd = dateAdd;
	}

	public int getDiscount() {
		return discount;
	}

	public void setDiscount(int discount) {
		this.discount = discount;
	}

	public Collection<Wishlist> getWishlists() {
		return wishlists;
	}

	public void setWishlists(Collection<Wishlist> wishlists) {
		this.wishlists = wishlists;
	}

	public Collection<Cart> getCarts() {
		return carts;
	}

	public void setCarts(Collection<Cart> carts) {
		this.carts = carts;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public Collection<ProductImg> getProductImgs() {
		return productImgs;
	}

	public void setProductImgs(Collection<ProductImg> productImgs) {
		this.productImgs = productImgs;
	}

	public Collection<BillDetail> getBillDetails() {
		return billDetails;
	}

	public void setBillDetails(Collection<BillDetail> billDetails) {
		this.billDetails = billDetails;
	}
	
	
	public Collection<ProductStock> getProductStocks() {
		return productStocks;
	}



	public void setProductStocks(Collection<ProductStock> productStocks) {
		this.productStocks = productStocks;
	}



	@Override
	public String toString() {
		return "Product [idProduct=" + idProduct + ", wishlists=" + wishlists + ", carts=" + carts + ", category="
				+ category + ", productImgs=" + productImgs + ", billDetails=" + billDetails + ", name=" + name
				+ ", price=" + price + ", inStock= doiThanh1Entity r"  + ", decription=" + decription + ", dateAdd=" + dateAdd
				+ ", discount=" + discount + "]";
	}
	
	public int getSale() {
		// tính doanh số của 1 sản phẩm = tổng billDetail.quantity
		ArrayList<BillDetail> list = (ArrayList<BillDetail>) removeDuplicateVal(this.getBillDetails());
		int totalSale  = 0;
		for(BillDetail billDetail : list) {
			totalSale += billDetail.getQuantity();
		}
		return totalSale;
	}
	
	public List removeDuplicateVal(Collection collection){
		List li = new ArrayList(new HashSet(collection));
		return li;
	}
	
	public int getInStock(String size) {
		// Lấy số lượng hàng tồn của Size
		for(ProductStock ps : productStocks) {
			if(ps.getSize().equals(size)) {
				return ps.getInStock();
			}
		}
		return 0;
	}
	
	public int getTotalInStock() {
		// Lấy tổng số lượng hàng tồn của tất cả Size
		int totalInStock = 0;
		for(ProductStock ps : productStocks) {
			totalInStock += ps.getInStock();
		}
		return totalInStock;
	}
	
	public ProductStock getProductStock(String size) {
		for(ProductStock ps: productStocks) {
			if(ps.getSize().equals(size)) {
				return ps;
			}
		}
		return null;
	}
}
