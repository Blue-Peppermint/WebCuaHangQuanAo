package ptithcm.controller;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import ptithcm.entity.User;
import ptithcm.entity.UserDetail;
//import ptithcm.entity.UserRole;
import ptithcm.entity.UserRole;

@Controller
@Transactional
@RequestMapping("test/")
public class testController {
	@Autowired
	SessionFactory factory;
	
	
	@RequestMapping("index")
	public String home() {
		
		Session session = factory.getCurrentSession();
		String hql = "select pw.bill.idBill "
				+ "From BillDetail as p "
				+ "join p.productReview as pw ";
//				+ "Where u.id = :id";
		Query query = session.createQuery(hql);

//		query.setParameter("id", 2 );

		if(query.list().isEmpty()) {
			String u = "Rong, ko co du lieu";
			System.out.println(u);
		}else {
//			String u = (String) query.list().get(0);
			List<Integer> u = query.list();
			for(int item : u) {
				System.out.println(item);
			}
		}
		
		
		 session = factory.getCurrentSession();
		 hql = "Select pi.product.name From ProductReview as p "
		 		+ "join p.billDetail as pi ";
//		 		+ "Where idProduct = :id";
		 query = session.createQuery(hql);

//		query.setParameter("id", 1 );

		if(query.list().isEmpty()) {
			String u = "Rong, ko co du lieu";
			System.out.println(u);
		}else {
//			String u = (String) query.list().get(0);
			List<String> u = query.list();
			for(String item : u) {
				System.out.println(item);
			}

		}
//		String ur = (UserRole) query.list().get(0);
		
		
		 session = factory.getCurrentSession();
		// hql = "select user.userRole.roleName From UserDetail Where id = :id";
		 //query = session.createQuery(hql);

		//query.setParameter("id", 1 );

		//String ud = (String) query.list().get(0);
		
		
		
//		System.out.println(ur);
//		System.out.println(ud);
		return "testing/index";
	}
}
