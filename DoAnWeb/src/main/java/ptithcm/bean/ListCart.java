package ptithcm.bean;

import java.util.ArrayList;
import java.util.List;

import ptithcm.entity.Cart;

public class ListCart {
// Chỉ sử dụng với action update giỏ hàng trong CartController
	List<Cart> carts;

	public ListCart() {
		super();
	}

	public List<Cart> getCarts() {
		return carts;
	}

	public void setCarts(List<Cart> carts) {
		this.carts = carts;
	}


}
