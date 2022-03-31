package ptithcm.interceptor;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import ptithcm.entity.Cart;
import ptithcm.entity.Category;
import ptithcm.entity.UserDetail;

@Transactional
public class MetaDataInterceptor extends HandlerInterceptorAdapter {
	// Interceptor cho các dữ liệu meta như load dữ liệu lên header
	@Autowired
	SessionFactory factory;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession httpSession = request.getSession();
		if (httpSession.getAttribute("categories") == null) {
			httpSession.setAttribute("categories", getCategories());
		}

		if (httpSession.getAttribute("userDetail") != null) {
			UserDetail userDetail = (UserDetail) httpSession.getAttribute("userDetail");
			httpSession.setAttribute("cartItemSize", getCartItemSize(userDetail.getId()));
		}
		return true;
	}

	public ArrayList<Category> getCategories() {
		Session session = factory.getCurrentSession();
		String hql = "From Category ";
		Query query = session.createQuery(hql);
		return (ArrayList<Category>) query.list();
	}

	public int getCartItemSize(int idUser) {
		Session session = factory.getCurrentSession();
		String hql = "From Cart " + "where user.id = :idUser ";
		Query query = session.createQuery(hql);
		query.setParameter("idUser", idUser);
		List<Cart> list = query.list();
		return list.size();
	}

}
