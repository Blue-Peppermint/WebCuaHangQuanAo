package ptithcm.entity;

import java.io.Serializable;

public class BillDetail_ProductReviewKey implements Serializable{
	protected Bill bill;
	protected Product product;
	protected String productSize;
	public BillDetail_ProductReviewKey() {
		super();
	}
	
	public BillDetail_ProductReviewKey(Bill bill, Product product, String productSize) {
		super();
		this.bill = bill;
		this.product = product;
		this.productSize = productSize;
	}

	public Bill getBill() {
		return bill;
	}
	public void setBill(Bill bill) {
		this.bill = bill;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}

	public String getProductSize() {
		return productSize;
	}

	public void setProductSize(String productSize) {
		this.productSize = productSize;
	}
	
	
}
