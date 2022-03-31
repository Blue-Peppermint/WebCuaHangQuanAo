package ptithcm.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "ProductStock")
@IdClass(ProductStock.class)
public class ProductStock implements Serializable{
	@Id
	@ManyToOne
	@JoinColumn(name = "idProduct")
	private Product product;
	
	@Id
	@Column(name = "size")
	private String size;
	
	@Column(name = "inStock")
	private int inStock;

	public ProductStock() {
		super();
	}

	public ProductStock(Product product, String size, int inStock) {
		super();
		this.product = product;
		this.size = size;
		this.inStock = inStock;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public int getInStock() {
		return inStock;
	}

	public void setInStock(int inStock) {
		this.inStock = inStock;
	}

	@Override
	public String toString() {
		return "ProductStock [IDproduct=" + product.getIdProduct() + ", size=" + size + ", inStock=" + inStock + "]";
	}
	
	
}
