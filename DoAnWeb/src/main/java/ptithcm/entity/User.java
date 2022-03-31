package ptithcm.entity;

import java.util.Collection;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.validation.Valid;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.validation.annotation.Validated;

@Entity
@Table(name = "[User]")
public class User {
	@Id
	@Column(name ="idUser")
	private int id;
	
//	@OneToOne( fetch = FetchType.LAZY ,cascade = CascadeType.ALL)
//	// @PrimaryKeyJoinColumn tốt nhất nên khai báo ở cả 2 bên
//	//@PrimaryKeyJoinColumn
//	@JoinColumn(name ="idUserDetail")
//	@Valid
//	private UserDetail userDetail;
	
	@OneToMany(mappedBy = "user", fetch =  FetchType.EAGER)
	private Collection<Wishlist> wishlists;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
	private Collection<Cart> carts;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
	private Collection<Bill> bills;
	
	@Column(name = "username")
	@NotBlank(message = "Tên Đăng Nhập Không Được Để Trống")
	@Size(max = 20, message = "Tên Đăng Nhập Tối Đa 20 Ký Tự")
	private String username;
	
	@Column(name ="pass")
// 	Validate bằng cách truyền thống.
	@NotBlank(message = "Mật Khẩu Không Được Để Trống")
	@Size(max = 20, message = "Mật Khẩu nhiều nhất chứa 20 ký tự")
	private String pass;
	
	@ManyToOne
	@JoinColumn(name= "idRole")
	private UserRole userRole;

	public User() {
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

	public UserRole getUserRole() {
		return userRole;
	}

	public void setUserRole(UserRole userRole) {
		this.userRole = userRole;
	}

	public Collection<Wishlist> getWishlists() {
		return wishlists;
	}

	public void setWishLists(Collection<Wishlist> wishLists) {
		this.wishlists = wishLists;
	}

	public Collection<Cart> getCarts() {
		return carts;
	}

	public void setCarts(Collection<Cart> carts) {
		this.carts = carts;
	}

	public Collection<Bill> getBills() {
		return bills;
	}

	public void setBills(Collection<Bill> bills) {
		this.bills = bills;
	}

	public void setWishlists(Collection<Wishlist> wishlists) {
		this.wishlists = wishlists;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", userDetail=" + "Ko thik hien thi" +
				", username=" + username + ", pass=" + pass + ", userRole=" + userRole + "]";
	}
	
	
}
