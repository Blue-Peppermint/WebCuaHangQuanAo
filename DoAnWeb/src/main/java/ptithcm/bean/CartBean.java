package ptithcm.bean;

import java.util.ArrayList;
import java.util.Map;

public class CartBean extends ProductBean{
	
	private String size;
	private int quantity;
	
	public CartBean() {
		super();
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	@Override
	public int getIdProduct() {
		// TODO Auto-generated method stub
		return super.getIdProduct();
	}
	@Override
	public void setIdProduct(int idProduct) {
		// TODO Auto-generated method stub
		super.setIdProduct(idProduct);
	}
	@Override
	public String getName() {
		// TODO Auto-generated method stub
		return super.getName();
	}
	@Override
	public void setName(String name) {
		// TODO Auto-generated method stub
		super.setName(name);
	}
	@Override
	public int getPrice() {
		// TODO Auto-generated method stub
		return super.getPrice();
	}
	@Override
	public void setPrice(int price) {
		// TODO Auto-generated method stub
		super.setPrice(price);
	}
	@Override
	public int getDiscount() {
		// TODO Auto-generated method stub
		return super.getDiscount();
	}
	@Override
	public void setDiscount(int discount) {
		// TODO Auto-generated method stub
		super.setDiscount(discount);
	}
	@Override
	public ArrayList<String> getImgSources() {
		// TODO Auto-generated method stub
		return super.getImgSources();
	}
	@Override
	public void setImgSources(ArrayList<String> imgSources) {
		// TODO Auto-generated method stub
		super.setImgSources(imgSources);
	}
	@Override
	public Map<String, Integer> getProductStocks() {
		// TODO Auto-generated method stub
		return super.getProductStocks();
	}
	@Override
	public void setProductStocks(Map<String, Integer> productStocks) {
		// TODO Auto-generated method stub
		super.setProductStocks(productStocks);
	}

}
