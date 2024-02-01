<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>  
   <title>User Authentication</title>
    </head>
    <style>
  *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
   }
  body{
  width: 100%;
  height: 100vh;
  display: flex;
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  background-color: paleturquoise;
}
  </style>
    <body>
    <center>
        <form method="post" action="front.jsp">
            <table cellspacing="50" style="font-size:30px; color: black;" >
                <tr>
 
                    <th>
                        ENTER USERID
                    </th>
                    <br>
                    <br><br><br><br>    
                   
                    <td>
                         <input  type="text" name="id"> </h1>
                    </td>
                   
                </tr>
                <tr>
                   <th>
                        ENTER PASSWORD
                    </th>
                    <td>
                         <input type="password" name="pass"></h1>    
                    </td>
                </tr>
                <tr>
                    <th>
                        IP ADDRESS
                    </th>
                    <td>
                        <input type="text" name="ipadd">    
                    </td>
                </tr>
                <tr>
                    <th>
                       PORT NUMBER
                    </th>
                    <td>
                        <input type="text" name="port">
                    </td>
                </tr>
         
            </table>        
               
                    <input style=" cursor: pointer; font-size: 20px; padding: 10px 25px; border-radius: 20px; border: 1px solid lightblue; " type="submit" value="Submit">
           
        </form>
       
        <%
           
           
             try
            {
               
             String s=null;
             s=request.getParameter("dbname");
             session.setAttribute("db",s);
             if(s!=null)
             {
             response.sendRedirect("sqlquerybrowser.jsp");
             }
               
             }
            catch(Exception e)
            {
               out.println("dbname not found");
            }
           
            String id=null ,pass=null,ipadd=null,port=null;
               
            PreparedStatement ps=null;
            ResultSet rs=null;
            try{
            id=request.getParameter("id");
            pass=request.getParameter("pass");
            ipadd=request.getParameter("ipadd");
            port=request.getParameter("port");
            if(id!=null||pass!=null||ipadd!=null||port!=null)
            {
            session.setAttribute("uid",id);              // this userid and password is given by user and is of our mysql userid and password .
            session.setAttribute("upass",pass);          //  this is used in whole application .
            session.setAttribute("ipadd",ipadd);  
            session.setAttribute("port",port);  
            }
            }
            catch(Exception e)
            {
           
            }
            if (id!=null && pass!=null && ipadd!=null && port!=null)
          {
              try{
                  Class.forName("com.mysql.cj.jdbc.Driver");
                  Connection con=null;
               //   con=DriverManager.getConnection("jdbc:mysql://localhost:3306/",id,pass);
                  con=DriverManager.getConnection("jdbc:mysql://"+ipadd+":"+port+"/",id,pass);
                   String sql="show databases";
                  ps=con.prepareStatement(sql);
                  rs=ps.executeQuery();
                  out.println("<h3 style='color: white;margin: 20px 20px;font-size:20px;' > Select the Database</h3>");
                  out.println("<form method=post action=front.jsp>");
                  out.println("<select name=dbname>");
                  while(rs.next())
             {  
                 out.println("<option value="+rs.getString(1)+">");
                 out.println(rs.getString(1));
                 out.println("</option>");
             }
               
            out.println("</select>");
            out.println("<input type=submit value=submit>");
            out.println("</form>");
     
                 }
             catch(Exception e)
             {
                 out.println("<h4>Incorrect values</h4>");
             }
         
           
          }
           
           
        %>
        </center>
    </body>
</html>