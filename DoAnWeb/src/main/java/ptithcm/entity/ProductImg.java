package ptithcm.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name ="ProductImg")
@IdClass(ProductImg.class)
public class ProductImg implements Serializable{
	/**
	 * 
	 */
	
	@Id
	@Column(name ="source")
	private String source;

	@Id
	@ManyToOne
	@JoinColumn(name = "idProduct")
	private Product product;
	
	public ProductImg() {
		super();
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	
	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	@Override
	public String toString() {
		return "ProductImg [idProduct="  + ", source=" + source + "]";
	}
	
}
