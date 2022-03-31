package ptithcm.bean;

public class ForShopViewBean {
	// Chỉ dùng để chuyển sang JSON cho JS bên view home/shop.jsp
	private int maxPrice;
	private int totalResultFound;
	private int indexSortType;
	private int idCategory;
	private int fromPrice;
	private int toPrice;

	public ForShopViewBean() {
		super();
	}

	public ForShopViewBean(int maxPrice, int totalResultFound, int indexSortType, int idCategory, int fromPrice,
			int toPrice) {
		super();
		this.maxPrice = maxPrice;
		this.totalResultFound = totalResultFound;
		this.indexSortType = indexSortType;
		this.idCategory = idCategory;
		this.fromPrice = fromPrice;
		this.toPrice = toPrice;
	}

	public int getIndexSortType() {
		return indexSortType;
	}

	public void setIndexSortType(int indexSortType) {
		this.indexSortType = indexSortType;
	}

	public int getPrice() {
		return maxPrice;
	}

	public void setPrice(int price) {
		this.maxPrice = price;
	}

	public int getTotalResultFound() {
		return totalResultFound;
	}

	public void setTotalResultFound(int totalResultFound) {
		this.totalResultFound = totalResultFound;
	}

	public int getIdCategory() {
		return idCategory;
	}

	public void setIdCategory(int idCategory) {
		this.idCategory = idCategory;
	}

	public int getMaxPrice() {
		return maxPrice;
	}

	public void setMaxPrice(int maxPrice) {
		this.maxPrice = maxPrice;
	}

	public int getFromPrice() {
		return fromPrice;
	}

	public void setFromPrice(int fromPrice) {
		this.fromPrice = fromPrice;
	}

	public int getToPrice() {
		return toPrice;
	}

	public void setToPrice(int toPrice) {
		this.toPrice = toPrice;
	}

}
