<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>

<%
String email = request.getParameter("email");
String mobileNumber = request.getParameter("mobileNumber");
String securityQuestion = request.getParameter("securityQuestion");
String answer = request.getParameter("answer");
String newPassword = request.getParameter("newPassword");

int check = 0;
try {
    Connection con = ConnectionProvider.getCon();
    String query = "SELECT * FROM users WHERE email = ? AND mobileNumber = ? AND securityQuestion = ? AND answer = ?";
    PreparedStatement pst = con.prepareStatement(query);
    pst.setString(1, email);
    pst.setString(2, mobileNumber);
    pst.setString(3, securityQuestion);
    pst.setString(4, answer);
    ResultSet rs = pst.executeQuery();
    
    if (rs.next()) {
        check = 1;
        String updateQuery = "UPDATE users SET password = ? WHERE email = ?";
        PreparedStatement pstUpdate = con.prepareStatement(updateQuery);
        pstUpdate.setString(1, newPassword);
        pstUpdate.setString(2, email);
        pstUpdate.executeUpdate();
        response.sendRedirect("forgotPassword.jsp?msg=done");
    }
    
    if (check == 0) {
        response.sendRedirect("forgotPassword.jsp?msg=invalid");
    }
    
    rs.close();
    pst.close();
    con.close();
} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("forgotPassword.jsp?msg=error");
}
%>
