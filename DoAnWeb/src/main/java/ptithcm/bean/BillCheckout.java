package ptithcm.bean;

import java.util.List;

import javax.validation.Valid;

import ptithcm.entity.Bill;
import ptithcm.entity.BillDetail;

public class BillCheckout {
	@Valid
	private Bill bill;
	
	private List<BillDetail> billDetails;
	
	public BillCheckout() {
		super();
	}
	public Bill getBill() {
		return bill;
	}
	public void setBill(Bill bill) {
		this.bill = bill;
	}
	public List<BillDetail> getBillDetails() {
		return billDetails;
	}
	public void setBillDetails(List<BillDetail> billDetails) {
		this.billDetails = billDetails;
	}
	
	
}
