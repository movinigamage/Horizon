<%-- 
    Document   : finddocchannel
    Created on : Apr 26, 2021, 11:40:40 AM
    Author     : SHATTER
--%>

<%@page import="Model.user"%>
<%@page import="Model.dfind"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    session.setMaxInactiveInterval(5000);
    String id = (String)session.getAttribute("id");
    String type = (String)session.getAttribute("type");
    String name = (String)session.getAttribute("name");
    if(id == null){
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            String symp_1=request.getParameter("symptom1");
            String symp_2=request.getParameter("symptom2");
            String symp_3=request.getParameter("symptom3");


            dfind con = new dfind();
            try {
                ResultSet rs = con.symptomCheck(symp_1, symp_2,symp_3);
                int i=0;
                while(rs.next()){
                    i++;
                    String disease = rs.getString("disease");
                %>
                <h2>Possible : <%=disease%></h2>
                <%
                    String sid = rs.getString("specialist_id");
                    ResultSet r=con.getDoctor(sid);
                    while(r.next()){
                        String iid =r.getString("id");
                        user data = new user();
                        ResultSet rr = data.udata(iid);
                        if(rr.next()){
                            
                %>
                <h3>Dr. <%=rr.getString("name")%>     <a href='patients/channel.jsp?doc=<%=rr.getString("id")%>'>Channel Doctor</a></h3>
                
                <%
                            }

                    }




                }
if(i==0){
%>
not found!!
<%
}
            } catch (Exception ex) {
                System.out.println(ex);
            } 
        %>
    </body>
</html>
