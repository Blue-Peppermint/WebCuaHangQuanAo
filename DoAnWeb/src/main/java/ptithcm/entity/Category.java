package ptithcm.entity;

import java.util.Collection;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name ="Category")
public class Category {
	@GeneratedValue
	@Column(name ="id")
	@Id
	private int id;
	
	@OneToMany(mappedBy = "category", fetch =  FetchType.EAGER)
	private Collection<Product> products;
	
	@Column(name = "name")
	private String name;

	@Column(name = "img")
	private String img;
	
	public Category() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Collection<Product> getProducts() {
		return products;
	}

	public void setProducts(Collection<Product> products) {
		this.products = products;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	@Override
	public String toString() {
		return "Category [id=" + id + ", name=" + name + ", img=" + img + "]";
	}
	
	
}
