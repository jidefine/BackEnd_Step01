package _01_FirstWebProject;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.GenericServlet;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;

@WebServlet("/calc")
public class CalculatorServlet extends GenericServlet {

	public CalculatorServlet() {
		// TODO Auto-generated constructor stub
	}
	// 요청, 응답
	// request 내에는 calculator.html이 보내는 v1, v2, op의 값이 전달된다.
	@Override
	public void service(ServletRequest request, ServletResponse response) throws ServletException, IOException {
		
		// 전송된 값을 꺼낸다.
		String operator = request.getParameter("op");
		int v1 = Integer.parseInt(request.getParameter("v1"));
		int v2 = Integer.parseInt(request.getParameter("v2"));
		int result = 0;
		
		//한글이 
		response.setContentType("text/html;charset=UFT-8");
		
		// 브라우저로 응답률 전송
		// response에는 브라우저와의 소켓 스크림이 연결되어 있다
		PrintWriter out = response.getWriter();
		
		switch(operator) {
		case "+": result = v1 + v2; break;
		case "-": result = v1 - v2; break;
		case "*": result = v1 * v2; break;
		case "/": 
			if(v2==0) {
				out.println("0으로 나눌 수 없음");
				return;
			}
			result = v1 / v2; 
			break;
		}
		out.println(v1 + " " + operator + " " + v2 + " = " + result);
	}

}
