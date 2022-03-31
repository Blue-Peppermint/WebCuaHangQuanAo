package ptithcm.bean;

import java.util.ArrayList;
import java.util.Map;

public class ProductBean {
	
	private int idProduct;
	private String name;
	private int price;
	private int discount;
	// Map: key = size; value = product quantity of that size
	private Map<String, Integer> productStocks;
	private ArrayList<String> imgSources;
	
	public ProductBean() {
		super();
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

	public int getDiscount() {
		return discount;
	}

	public void setDiscount(int discount) {
		this.discount = discount;
	}
	
	

	public Map<String, Integer> getProductStocks() {
		return productStocks;
	}

	public void setProductStocks(Map<String, Integer> productStocks) {
		this.productStocks = productStocks;
	}

	public ArrayList<String> getImgSources() {
		return imgSources;
	}

	public void setImgSources(ArrayList<String> imgSources) {
		this.imgSources = imgSources;
	}
	
	

	@Override
	public String toString() {
		return "ProductBean [idProduct=" + idProduct + ", name=" + name + ", price=" + price + ", discount=" + discount
				+ ", imgSources=" + imgSources + "]";
	}


}
