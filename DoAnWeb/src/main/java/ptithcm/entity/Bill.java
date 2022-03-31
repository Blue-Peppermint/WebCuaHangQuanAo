package ptithcm.entity;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "Bill")
public class Bill {
	@Id
	@GeneratedValue
	@Column(name = "idBill")
	private int idBill;
	
	@OneToMany(mappedBy = "bill", fetch = FetchType.EAGER)
	private Collection<BillDetail>  billDetails;
	
	@ManyToOne
	@JoinColumn(name = "idUser")
	private User user;
	
	@Column(name = "timeCreated")
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "MM/dd/yyyy")
	private Date timeCreated;
	
	@Column(name = "recipientName")
	@NotBlank(message = "Họ Và Tên Không Được Để Trống")
	@Size(max = 50, message = "Họ Và Tên Tối Đa 50 Ký Tự")
	private String recipientName;
	
	@Column(name = "recipientPhone")
	@NotBlank(message = "Số Điện Thoại Không Được Để Trống")
	@Pattern(regexp = "(84|0[3|5|7|8|9])+([0-9]{8})\\b", message = "Nhập Đúng Số Điện Thoại Việt Nam")
	private String recipientPhone;
	
	@Column(name = "recipientEmail")
	@NotBlank(message = "Email Không Được Để Trống")
	@Size(max = 50, message = "Email Tối Đa 50 Ký Tự")
	@Pattern(regexp = "^[a-zA-Z0-9_!#$%&’*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$", message = "Nhập Đúng Địa Chỉ Email")
	private String recipientEmail;
	
	@Column(name = "recipientAddress")
	@NotBlank(message = "Địa Chỉ Nhận Hàng Không Được Để Trống")
	@Size(max = 150, message = "Địa Chỉ Nhận Tối Đa 150 Ký Tự")
	private String recipientAddress;
	
	@Column(name = "note")
	@Size(max = 300, message = "Lời Nhắn Tối Đa 300 Ký Tự")
	private String note;

	public Bill() {
		super();
	}

	public int getIdBill() {
		return idBill;
	}

	public void setIdBill(int idBill) {
		this.idBill = idBill;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Date getTimeCreated() {
		return timeCreated;
	}

	public void setTimeCreated(Date timeCreated) {
		this.timeCreated = timeCreated;
	}

	public String getRecipientName() {
		return recipientName;
	}

	public void setRecipientName(String recipientName) {
		this.recipientName = recipientName;
	}

	public String getRecipientPhone() {
		return recipientPhone;
	}

	public void setRecipientPhone(String recipientPhone) {
		this.recipientPhone = recipientPhone;
	}

	public String getRecipientEmail() {
		return recipientEmail;
	}

	public void setRecipientEmail(String recipientEmail) {
		this.recipientEmail = recipientEmail;
	}

	public String getRecipientAddress() {
		return recipientAddress;
	}

	public void setRecipientAddress(String recipientAddress) {
		this.recipientAddress = recipientAddress;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Collection<BillDetail> getBillDetails() {
		return billDetails;
	}

	public void setBillDetails(Collection<BillDetail> billDetails) {
		this.billDetails = billDetails;
	}

	@Override
	public String toString() {
		return "Bill [idBill=" + idBill + ", timeCreated=" + timeCreated + ", recipientName=" + recipientName
				+ ", recipientPhone=" + recipientPhone + ", recipientEmail=" + recipientEmail + ", recipientAddress="
				+ recipientAddress + ", note=" + note + "]";
	}
	
	//TotalBill
	public float totalBill() {
		float total=0;
		List<BillDetail> listBD= this.removeDuplicateVal(this.billDetails);
		for(int i=0; i<listBD.size();i++) {
			total+=listBD.get(i).getTotalPrice();
		}
		return total;
	}
	//NameBill
	public String namePD() {
		List<BillDetail> listBD= this.removeDuplicateVal(this.billDetails);
		int length=listBD.size();
		if(length!=0) {
			String name="";
			if(length>1) {
				name=listBD.get(0).getProduct().getName()+"... và "+(length-1)+" sản phẩm khác";
				return name;
			}
			else {
				name=listBD.get(0).getProduct().getName();
				return name;
			}
		}
		return"";
	}
	public List removeDuplicateVal(Collection collection){
		List li = new ArrayList(new HashSet(collection));
		return li;
	}
	
	
}
