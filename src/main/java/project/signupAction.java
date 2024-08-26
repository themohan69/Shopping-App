package project;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import project.ConnectionProvider;


public class signupAction extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		PrintWriter out = response.getWriter();
		
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String mobileNumber = request.getParameter("mobileNumber");
		String securityQuestion = request.getParameter("securityQuestion");
		String answer = request.getParameter("answer");
		String password = request.getParameter("password");
		String address = "";
		String city = "";
		String state = "";
		String country = "";
		
		
		try

		{
			Connection con = ConnectionProvider.getCon();
			PreparedStatement ps = con.prepareStatement("insert into users values(?,?,?,?,?,?,?,?,?,?)");
			ps.setString(1, name);
			ps.setString(2, email);
			ps.setString(3, mobileNumber);
			ps.setString(4, securityQuestion);
			ps.setString(5, answer);
			ps.setString(6, password);
			ps.setString(7, address);
			ps.setString(8, city);
			ps.setString(9, state);
			ps.setString(10, country);
			ps.executeUpdate();
			
			int count = ps.executeUpdate();
			if (count>0) {
				
				response.setContentType("text/html");
				out.println("<h2 style='color:green'> User Has Been Registered Successfully</h2>");
//				RequestDispatcher rd =  request.getRequestDispatcher("login.jsp");
//				rd.include(request	,	 response);
			
			} else {
				response.setContentType("text/html");
				out.println("<h2 style='color:Red'> User is not Registered</h2>");
				
//				RequestDispatcher rd =  response.getRequestDispatcher("index.jsp");
//				rd.include(request,	 response);
			}
			
			}
		catch(Exception e)
		{

			System.out.println(e);
			
		}
	}

	
}


