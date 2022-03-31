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
@Table(name = "Wishlist")
@IdClass(Wishlist.class)
public class Wishlist implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 3303003571387378813L;

//	@Id
//	@Column(name= "idUser")
//	private int idUser;
//	
//	@Id
//	@Column (name = "idProduct")
//	private int idProduct;
	
	@Id
	@ManyToOne
	@JoinColumn(name = "idUser")
	private User user;
	
	@Id
	@ManyToOne
	@JoinColumn (name = "idProduct")
	private Product product;

	@Id
	@Column(name = "size")
	private String size;
	
	public Wishlist() {
		super();
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
