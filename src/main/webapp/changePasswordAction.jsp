<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%
String email = session.getAttribute("email").toString(); 
String oldPassword = request.getParameter("oldPassword");
String newPassword = request.getParameter("newPassword");
String confirmPassword = request.getParameter("confirmPassword");

if (!confirmPassword.equals(newPassword)) {
    response.sendRedirect("changePassword.jsp?msg=notMatch");
} else {
    int check = 0;
    try {
        Connection con = ConnectionProvider.getCon();
        String query = "SELECT * FROM users WHERE email=? AND password=?";
        PreparedStatement pst = con.prepareStatement(query);
        pst.setString(1, email);
        pst.setString(2, oldPassword);
        ResultSet rs = pst.executeQuery();

        if (rs.next()) {
            check = 1;
            query = "UPDATE users SET password=? WHERE email=?";
            pst = con.prepareStatement(query);
            pst.setString(1, newPassword);
            pst.setString(2, email);
            pst.executeUpdate();
            response.sendRedirect("changePassword.jsp?msg=done");
        }
        
        if (check == 0) {
            response.sendRedirect("changePassword.jsp?msg=wrong");
        }
        
        rs.close();
        pst.close();
        con.close();
    } catch (Exception e) {
        System.out.println(e);
    }
}
%>
