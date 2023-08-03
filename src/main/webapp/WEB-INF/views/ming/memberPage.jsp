<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true" %>
<c:set var="loginId" value="${sessionScope.MBR_ID}" />
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}" />
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'ID='+=loginId}" />

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원관리 | 도비스프리</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'></script>
  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      font-family: "나눔바른고딕OTF", "돋움";
    }

    a {
      text-decoration: none;
      color: black;
    }

    table {
      border-collapse: collapse;
      width: 100%;
      border-top: 2px solid rgb(39, 39, 39);
    }

    tr:nth-child(even) {
      background-color: #f0f0f070;
    }

    th,
    td {
      width: 300px;
      text-align: center;
      padding: 10px 12px;
      border-bottom: 1px solid #ddd;
    }

    td {
      color: rgb(53, 53, 53);
    }

    .no {
      width: 150px;
    }

    .title {
      width: 50%;
    }

    td.title {
      text-align: left;
    }

    td.writer {
      text-align: left;
    }

    td.viewcnt {
      text-align: right;
    }

    td.title:hover {
      text-decoration: underline;
    }

    .paging {
      color: black;
      width: 100%;
      align-items: center;
    }

    .page {
      color: black;
      padding: 6px;
      margin-right: 10px;
    }

    .paging-active {
      background-color: rgb(216, 216, 216);
      border-radius: 5px;
      color: rgb(24, 24, 24);
    }

    .paging-container {
      width: 100%;
      height: 70px;
      display: flex;
      margin-top: 50px;
      margin: auto;
    }

    .btn-write {
      background-color: rgb(236, 236, 236);
      /* Blue background */
      border: none;
      /* Remove borders */
      color: black;
      /* White text */
      padding: 6px 12px;
      /* Some padding */
      font-size: 16px;
      /* Set a font size */
      cursor: pointer;
      /* Mouse pointer on hover */
      border-radius: 5px;
      margin-left: 30px;
    }

    .btn-write:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
<jsp:include page="../admin_header.jsp" />
<table class='table table-bordered'></table>
<thead>
<tr>
  <th>아이디</th>
  <th>이름</th>
  <th>비밀번호</th>
  <th>연락처</th>
  <th>생년월일</th>
  <th>성별</th>
  <th>이메일</th>
  <th>삭제</th>
</tr>
</thead>
<tbody>
<c:forEach var="userDto" items="${list}">
  <tr>
    <td>${userDto.getMBR_ID()}</td>
    <td>${userDto.getMBR_NM()}</td>
    <td>${userDto.getPWD()}</td>
    <td>${userDto.getMPNO()}</td>
    <td>${userDto.getBD()}</td>
    <td>${userDto.getSEX()}</td>
    <td>${userDto.getEMAIL()}</td>
    <td>${userDao.deletetUser(user)}</td>
  </tr>
</c:forEach>
</tbody>
</table>
<jsp:include page="../admin_footer.jsp" />
</body>
</html>