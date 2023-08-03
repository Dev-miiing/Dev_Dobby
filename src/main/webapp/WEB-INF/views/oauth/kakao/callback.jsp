<%--
  Created by IntelliJ IDEA.
  User: leemi
  Date: 2023-05-02
  Time: PM 9:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<script>
  const express = require("express");
  const axios = require("axios");

  const app = express();
  const CLIENT_ID = "23628d037e66122459b7fd7d8fe4fc48"; //REST API 키
  const CLIENT_SECRET = "23628d037e66122459b7fd7d8fe4fc48";
  const REDIRECT_URI = "http://localhost:3000/oauth/kakao/callback";

  app.use(express.static("public"));

  app.get("/", (req, res) => {
    res.send("Hello World!");
  });

  app.get("/oauth/kakao/callback", function (req, res) {
    const code = req.query.code;

    const options = {
      method: "post",
      url: "https://kauth.kakao.com/oauth/token",
      data: {
        grant_type: "authorization_code",
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET,
        redirect_uri: REDIRECT_URI,
        code: code,
      },
      headers: {
        "Content-Type": "application/x-www-form-urlencoded;charset=utf-8",
      },
    };

    axios(options)
            .then(function (response) {
              const access_token = response.data.access_token;

              res.cookie("token", access_token, { httpOnly: true });
              res.send(access_token);

              const options = {
                method: "get",
                url: "https://kapi.kakao.com/v2/user/me",
                headers: {
                  Authorization: `Bearer ${access_token}`,
                  "Content-Type": "application/x-www-form-urlencoded;charset=utf-8",
                },
              };

              axios(options)
                      .then(function (response) {
                        const user = response.data;

                        // 사용자 정보 처리
                      })
                      .catch(function (error) {
                        console.log(error);
                      });
            })
            .catch(function (error) {
              console.log(error);
            });
  });

</script>
</body>
</html>
