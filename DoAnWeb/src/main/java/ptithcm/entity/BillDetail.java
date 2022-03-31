package ptithcm.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@Entity
@Table(name = "BillDetail")
@IdClass(BillDetail_ProductReviewKey.class)
public class BillDetail  {	
	
	@Id
	@ManyToOne
	@JoinColumn(name = "idBill")
	private Bill bill;
	
	@Id
	@ManyToOne
	@JoinColumn(name = "idProduct")
	private Product product;
	
	@Id
	@Column(name = "productSize")
	private String productSize;
	
	@OneToOne
	@PrimaryKeyJoinColumn
//	@JoinColumns({
//	@JoinColumn(name = "idBill", referencedColumnName = "idBill"),
//	@JoinColumn(name = "idProduct", referencedColumnName = "idProduct")
//})
	private ProductReview productReview;
	
	@Column(name = "quantity")
	private int quantity;
	
	@Column(name = "discount")
	private int discount;
	
	@Column(name = "totalPrice")
	private int totalPrice;

	public BillDetail() {
		super();
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
	
	

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getDiscount() {
		return discount;
	}

	public void setDiscount(int discount) {
		this.discount = discount;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public Bill getBill() {
		return bill;
	}

	public void setBill(Bill bill) {
		this.bill = bill;
	}

	public ProductReview getProductReview() {
		return productReview;
	}

	public void setProductReview(ProductReview productReview) {
		this.productReview = productReview;
	}
	
	
	
	public String getProductSize() {
		return productSize;
	}

	public void setProductSize(String productSize) {
		this.productSize = productSize;
	}

	@Override
	public String toString() {
		return " BillDetail [ idBill= " + bill.getIdBill() + "productSize="  + productSize + ", product id=" + product.getIdProduct()  + ", quantity=" + quantity + ", discount=" + discount
				+ ", unitPrice=" + product.getPrice() 
				+ ", totalPrice=" + totalPrice + "]";
	}

	

	
}
