<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%
String email = request.getParameter("email");
String password = request.getParameter("password");

if ("admin@gmail.com".equals(email) && "admin".equals(password)) {
	session.setAttribute("email", email);
	response.sendRedirect("admin/adminHome.jsp");
} else {
	int z = 0;
	try {
		Connection con = ConnectionProvider.getCon();
		String query = "SELECT * FROM users WHERE email = ? AND password = ?";
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, email);
		pst.setString(2, password);
		ResultSet rs = pst.executeQuery();

		if (rs.next()) {
	z = 1;
	session.setAttribute("email", email);
	response.sendRedirect("home.jsp");
		}

		if (z == 0) {
	response.sendRedirect("login.jsp?msg=notexist");
		}

		rs.close();
		pst.close();
		con.close();
	} catch (Exception e) {
		e.printStackTrace();
		response.sendRedirect("login.jsp?msg=invalid");
	}
}
%>
