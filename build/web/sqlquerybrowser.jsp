<%
    if(session.isNew())
    response.sendRedirect("front.jsp");
%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>sqlquerybrowser</title>
        <style>
   body{
  width: 100%;
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background-size: 300% 300%;
  background-image:linear-gradient(
        -45deg, 
        rgba(59,173,227,1) 0%, 
        rgba(87,111,230,1) 25%, 
        rgba(152,68,183,1) 51%, 
        rgba(255,53,127,1) 100%
  );  
 
  
}



@keyframes AnimateBG { 
  0%{background-position:0% 50%}
  50%{background-position:100% 50%}
  100%{background-position:0% 50%}
 }
 
 button:hover{
    color:red;
    background-color: mediumspringgreen;
}
  
    </style>
    </head>
    
    <body>
    <center>
        
         
         <button style=" border-radius: 5px; cursor: pointer; margin-left: 0px; font-size: 20px; padding: 5px 10px;" onClick="displaymsg()">Create</button>
         <button style=" border-radius: 5px; cursor: pointer; margin-left: 800px; font-size: 20px; padding: 5px 10px;" onClick="displaymsg1()">Drop</button>
        
         <br><br><h1><font color="black">GraphifyDB : Your Visual Data Hub</font></h1><h1 style="background-color: white; display:inline;"><font color="voilet"></font> </h1>
          
         <br>
         
         <button style=" border-radius: 5px; cursor: pointer; margin-left: 0px; font-size: 20px; padding: 5px 10px;" onClick="displaymsg2()">Insert</button>
         <button style=" border-radius: 5px; cursor: pointer; margin-left: 800px; font-size: 20px; padding: 5px 10px;" onClick="displaymsg3()">Update</button>
         
         
         <form method="post" action="sqlquerybrowser.jsp">
             <table>
                 <textarea style=" border-radius: 5px;" rows="8"cols="50" id="area" name="qry" placeholder="PLEASE ENTER QUERY"></textarea>
                 
                 
                 <br><br><input style=" cursor: pointer; font-size: 20px; padding: 5px 10px;" type="submit" value="Execute"></h1>

             </table>
             <br>
         </form>
         <button style=" border-radius: 5px; cursor: pointer; margin-left: 0px; font-size: 20px; padding: 5px 10px;" onClick="displaymsg4()">Select</button>
         <button style=" border-radius: 5px; cursor: pointer; margin-left: 800px; font-size: 20px; padding: 5px 10px;" onClick="displaymsg5()">Alter</button>
         <button style=" border-radius: 5px; cursor: pointer; margin-left: 1200px; font-size: 20px; padding: 5px 10px;" onClick="displaymsg6()">Join</button>
         
         <%
             String qry=null,dbname=null;
              try
            {
            String id=null, pass=null,port=null,ipadd=null;
            id=session.getAttribute("uid").toString();
            pass=session.getAttribute("upass").toString();
            dbname=session.getAttribute("db").toString();
            port=session.getAttribute("port").toString();
            ipadd=session.getAttribute("ipadd").toString();
            
            PreparedStatement ps=null;
            ResultSet rs=null;
            ResultSetMetaData rsmd=null;
           
           if(dbname!=null&&id!=null&&pass!=null&&ipadd!=null&&port!=null)
           {   
             qry=request.getParameter("qry"); 
             if(qry.startsWith("USE")||qry.startsWith("use")||qry.startsWith("Use"))
             {
                 dbname=qry.substring(4);
                 session.setAttribute("db",dbname);
             }
             Class.forName("com.mysql.cj.jdbc.Driver");
             Connection con=null;
           //  con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+dbname,id,pass);
             con=DriverManager.getConnection("jdbc:mysql://"+ipadd+":"+port+"/"+dbname+"",id,pass);
             ps=con.prepareStatement(qry);
             qry=qry.toUpperCase();
           
             if(qry.startsWith("SELECT")||qry.startsWith("SHOW")||qry.startsWith("DESC"))
             {
               rs=ps.executeQuery();
               rsmd=rs.getMetaData();
               out.println("<table border=1>");
               out.println("<tr>");
               int i;
               for(i=1;i<=rsmd.getColumnCount();i++)
               {   
               out.println("<th>"+rsmd.getColumnName(i)+"</th>");
               }
               out.println("</tr>");
               while(rs.next())
               {
               out.println("<tr>");
               for(i=1;i<=rsmd.getColumnCount();i++) 
               {
                   out.println("<td>"+rs.getString(i)+"</td>");  
                
                //  out.println("<td><input type=txt name="+""+"</td>");  
               }  
               out.println("</tr>");
               }
               out.println("</table>");                                   
               }
               else
               {
               out.println("<br>query ok"+ps.executeUpdate()+"record inserted");
               }
             }
            }
                catch(Exception e)
               {
                   if(qry==null)
                    out.println("<h1>PLEASE ENTER QUERY<h1>"); 
                   else {
                       out.println("<h1>"+e+"<h1>"); 
                   out.println("ENTER CORRECT QUERY"); 
                   }
               }
        %> 
        <script>
                     function displaymsg()
                     {
                         document.getElementById("area").innerHTML="create table <table_name> (column1 datatype, column2 datatype);";
                     }
                      function displaymsg1()
                     {
                         document.getElementById("area").innerHTML="drop table <table_name>;";
                     }
                     function displaymsg2()
                     {
                         document.getElementById("area").innerHTML="insert into <table_name> values ( <data> );";
                     }
                     function displaymsg3()
                     {
                         document.getElementById("area").innerHTML="update <table_name> set column1=value1 where <condition>;";
                     }
                     function displaymsg4()
                     {
                         document.getElementById("area").innerHTML="select * from <table_name> where <condition>;";
                     }
                     function displaymsg5()
                     {
                         document.getElementById("area").innerHTML="alter table <table_name> add <column_name> datatype;";
                     }
                     function displaymsg6 ()
                     {
                         document.getElementById("area").innerHTML="select <column1> from table1,table2 where table1.col1 = table2.col1;";
                     }
                      
                 </Script>
                 
    </center>
    </body>
</html>