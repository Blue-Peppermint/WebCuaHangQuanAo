package ptithcm.entity;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "UserDetail")
public class UserDetail {
	@Id
	@Column(name = "idUser")
//	@GeneratedValue(strategy = GenerationType.IDENTITY)
//	@SequenceGenerator(name = "id_generator", sequenceName = "id_seq")
//	@GeneratedValue(strategy = GenerationType.AUTO, generator = "id_generator")
	private int id;
	
//	@OneToOne(fetch = FetchType.LAZY , cascade = CascadeType.ALL, mappedBy = "userDetail")
////	@PrimaryKeyJoinColumn
//	private User user;
	
	@Column(name ="name")
	@NotBlank(message = "Họ Và Tên Không Được Để Trống")
	@Size(max = 50, message = "Họ Và Tên Tối Đa 50 Ký Tự")
	private String name;
	
	@Column(name ="phone")
	@NotBlank(message = "Số Điện Thoại Không Được Để Trống")
	@Pattern(regexp = "(84|0[3|5|7|8|9])+([0-9]{8})\\b", message = "Nhập Đúng Số Điện Thoại Việt Nam")
	private String phone;
	
	@Column(name ="email")
	@NotBlank(message = "Email Không Được Để Trống")
	@Size(max = 50, message = "Email Tối Đa 50 Ký Tự")
	@Pattern(regexp = "^[a-zA-Z0-9_!#$%&’*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$", message = "Nhập Đúng Địa Chỉ Email")
	private String email;
	
	@Column(name ="gender")
	private String gender;
	
	@Column(name ="birthday")
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "dd/MM/yyyy")	
	private Date birthday;
	
	@Column(name ="address")
	@Size(max = 150, message = "Email Tối Đa 150 Ký Tự")
	private String address;
	
	@Column(name ="imgAvatar")
	@Size(max = 150, message = "Email Tối Đa 150 Ký Tự")
	private String imgAvatar;

	public UserDetail() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getImgAvatar() {
		return imgAvatar;
	}

	public void setImgAvatar(String imgAvatar) {
		this.imgAvatar = imgAvatar;
	}

	public Date getBirthday() {
		return birthday;
	}

	@Override
	public String toString() {
		return "UserDetail [id=" + id + ", name=" + name + ", phone=" + phone + ", email=" + email + ", gender="
				+ gender + ", birthday=" + birthday + ", address=" + address + ", imgAvatar=" + imgAvatar + "]";
	}

	@Override
	protected Object clone() throws CloneNotSupportedException {
		// TODO Auto-generated method stub
		return super.clone();
	}

	
	
	
}
