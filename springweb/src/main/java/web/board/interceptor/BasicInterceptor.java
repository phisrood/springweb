package web.board.interceptor;

import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class BasicInterceptor implements HandlerInterceptor {
	// controller로 보내기 전에 처리하는 인터셉터
		// 반환이 false라면 controller로 요청을 안함
		// 매개변수 Object는 핸들러 정보를 의미한다. ( RequestMapping , DefaultServletHandler ) 
		@Override
		public boolean preHandle(
				HttpServletRequest request, HttpServletResponse response,
				Object obj) throws Exception {
			
			System.out.println("BasicInterceptor - preHandle");
			return true;
		}

		// controller의 handler가 끝나면 처리됨
		@Override
		public void postHandle(
				HttpServletRequest request, HttpServletResponse response,
				Object handler, ModelAndView mav)
				throws Exception {
			System.out.println("BasicInterceptor - postHandle");
		}

		// view까지 처리가 끝난 후에 처리됨
		@Override
		public void afterCompletion(
				HttpServletRequest request, HttpServletResponse response,
				Object obj, Exception e)
				throws Exception {
			System.out.println("BasicInterceptor - afterCompletion");
		}
}
