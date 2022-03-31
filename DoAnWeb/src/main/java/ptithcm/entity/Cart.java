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
@Table(name = "Cart")
@IdClass(Cart.class)
public class Cart implements Serializable{
	/**
	 * 
	 */
	//private static final long serialVersionUID = 8411510563494735231L;
	
	@Id
	@ManyToOne
	@JoinColumn(name = "idUser")
	private User user;
	
	@Id
	@ManyToOne
	@JoinColumn(name = "idProduct")
	private Product product;
	
	// Thêm Size vào giỏ hàng nếu không trong 1 bill 
	// khách hàng mua cùng 1 sản phẩm nhưng 2 size khác nhau sẽ không đc
	@Id
	@Column(name ="size")
	private String size;
	
	@Column(name ="quantity")
	private int quantity;
	
	public Cart() {
		super();
	}
	
	public Cart(User user, Product product, String size, int quantity) {
		super();
		this.user = user;
		this.product = product;
		this.size = size;
		this.quantity = quantity;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
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
	
}
