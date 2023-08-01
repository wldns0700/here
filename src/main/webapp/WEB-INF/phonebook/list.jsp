<%@page import="phonebook.PhonebookVO"%>
<%@page import="java.util.ArrayList"%>

<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- 코드와 view를 한페이지에서 분리 -->
    <%
Class.forName("oracle.jdbc.driver.OracleDriver");

Connection conn
=DriverManager.getConnection
("jdbc:oracle:thin:@localhost:1521:xe","system","1234");

String sql="select * from phonebook";
PreparedStatement pstat=conn.prepareStatement(sql);
ResultSet rs=pstat.executeQuery();
//phonrnook을 리스트로 저장할 수 있는 객체(단일객채 vo 생성)
List<PhonebookVO>list = new ArrayList<PhonebookVO>();
while(rs.next()){
	list.add(new PhonebookVO(
 
      rs.getInt("ph_num"),
      rs.getString("ph_name"),
      rs.getString("ph_hp"),
      rs.getString("ph_memo")
));
}
rs.close();
pstat.close();
conn.close();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"></script>
  <script>
  function selectkind(kind){
	  //alert(kind);
	  document.querySelector("#searchbtn").innerText=kind;
  }
  
  function search(){
	  kind=document.querySelector("#searchbtn").innerText;
	  //alert(kind);
	  svalue=document.querySelector("#search").value;
	  //alert(svalue);
	  location.href="/phonebook/searchList.jsp?kind="+kind+"&search="+svalue
  }
  </script>
</head>
<body>

<div class="container mt-3">
  <h2>전화번호부</h2>

<div class="input-group mt-3 mb-3">
    <button id="searchbtn" type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown">
      검색 선택
    </button>
    <ul class="dropdown-menu">
      <li><a class="dropdown-item" href="#" onclick="selectkind('이름')">이름</a></li>
      <li><a class="dropdown-item" href="#" onclick="selectkind('전화번호')">전화번호</a></li>
      <li><a class="dropdown-item" href="#" onclick="selectkind('메모')">메모</a></li>
    </ul>
    <input type="text" class="form-control" placeholder="검색값 입력" name="search"  id="search" >
    <button type="button" class="btn btn-success" onclick="search()">검색</button>
  </div>


  <table class="table">
    <thead>
      <tr>
        <th>번호</th>
        <th>이름</th>
        <th>전화번호</th>
        <th>메모</th>
      </tr>
    </thead>
    <tbody>
    <%
for(PhonebookVO pb:list){
%>
    <tr onclick="location.href='view.jsp?idx=<%=pb.getIdx()%>'">
        <td><%=pb.getIdx()%></td>
        <td><%=pb.getName() %> </td>
        <td><%=pb.getHp() %> </td> 
        <td><%=pb.getMemo() %></td>
   </tr> 
<%} %>
  </tbody>
  </table>
<button type="button" class="btn btn-success" onclick="location.href='insert.jsp'">전화번호 추가</button>
</div>

</body>
</html>