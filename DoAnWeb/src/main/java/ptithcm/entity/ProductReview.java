package ptithcm.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.validation.annotation.Validated;

@Entity
@Table(name = "ProductReview")
@IdClass(BillDetail_ProductReviewKey.class)
public class ProductReview {
	/**
	 * 
	 */
//	private static final long serialVersionUID = 2478640428803487434L;

	@Id
	@ManyToOne
	@JoinColumn(name = "idBill")
	private Bill bill;

	@Id
	@ManyToOne
	@JoinColumn(name = "idProduct")
	private Product product;

	@Id
	@Column(name = "productSize")
	private String productSize;

	@OneToOne(mappedBy = "productReview")
	private BillDetail billDetail;

	@Column(name = "ratingScore")
	@Min(value = 1, message = "Chọn Sao Đánh Giá")
	@Max(value = 5, message = "Chọn Sao Đánh Giá")
	private int ratingScore;

	@Column(name = "contentText")
	private String contentText;

	@Column(name = "dateReview")
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "MM/dd/yyyy")
	private Date dateReview;

	public ProductReview() {
		super();
	}

	public Bill getBill() {
		return bill;
	}

	public void setBill(Bill bill) {
		this.bill = bill;
	}

	public int getRatingScore() {
		return ratingScore;
	}

	public void setRatingScore(int ratingScore) {
		this.ratingScore = ratingScore;
	}

	public String getContentText() {
		return contentText;
	}

	public void setContentText(String contentText) {
		this.contentText = contentText;
	}

	public Date getDateReview() {
		return dateReview;
	}

	public void setDateReview(Date dateReview) {
		this.dateReview = dateReview;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public BillDetail getBillDetail() {
		return billDetail;
	}

	public void setBillDetail(BillDetail billDetail) {
		this.billDetail = billDetail;
	}

	public String getProductSize() {
		return productSize;
	}

	public void setProductSize(String productSize) {
		this.productSize = productSize;
	}

	@Override
	public String toString() {
		return "ProductReview [IDbill=" + bill.getIdBill() + ", IDproduct=" + product.getIdProduct() + ", productSize="
				+ productSize + ", ratingScore=" + ratingScore + ", contentText=" + contentText + ", dateReview="
				+ dateReview + "]";
	}

}
