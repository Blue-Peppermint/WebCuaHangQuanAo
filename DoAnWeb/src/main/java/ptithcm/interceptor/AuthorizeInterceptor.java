package ptithcm.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthorizeInterceptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//System.out.print("Vao Prehandle AuthrorizeInterceptor");
		HttpSession session = request.getSession();
		if(session.getAttribute("userDetail") == null) {
			response.sendRedirect(request.getContextPath() + "/home/login.htm");
			return false;
		}
		return true;
	}
	
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// Load dữ liệu view header ở đây??
		super.postHandle(request, response, handler, modelAndView);
	}


	
}
