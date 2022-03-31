package ptithcm.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import ptithcm.entity.UserRole;

public class UserRegister {
	
	
	private int id;
	
	@NotBlank(message = "Tên Đăng Nhập Không Được Để Trống")
	@Size(max = 20, message = "Tên Đăng Nhập Tối Đa 20 Ký Tự")
	private String username;
	private String pass;
	private int idRole;
	
	@Column(name ="name")
	@NotBlank(message = "Họ Và Tên Không Được Để Trống")
	@Size(max = 50, message = "Họ Và Tên Tối Đa 50 Ký Tự")
	private String name;
	
	@Column(name ="phone")
	@NotBlank(message = "Số Điện Thoại Không Được Để Trống")
	@Pattern(regexp = "(84|0[3|5|7|8|9])+([0-9]{8})\\b", message = "Nhập Đúng Số Điện Thoại Việt Nam")
	private String phone;
	
	@NotBlank(message = "Email Không Được Để Trống")
	@Size(max = 50, message = "Email Tối Đa 50 Ký Tự")
	@Pattern(regexp = "^[a-zA-Z0-9_!#$%&’*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$", message = "Nhập Đúng Địa Chỉ Email")
	private String email;
	
	private String gender;
	private Date birthday;
	private String address;
	private String imgAvatar;
	
	
	public UserRegister() {
		super();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public int getIdRole() {
		return idRole;
	}
	public void setIdRole(int idRole) {
		this.idRole = idRole;
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
	public Date getBirthday() {
		return birthday;
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
	@Override
	public String toString() {
		return "UserRegister [id=" + id + ", username=" + username + ", pass=" + pass + ", idRole=" + idRole + ", name="
				+ name + ", phone=" + phone + ", email=" + email + ", gender=" + gender + ", birthday=" + birthday
				+ ", address=" + address + ", imgAvatar=" + imgAvatar + "]";
	}
	
}
