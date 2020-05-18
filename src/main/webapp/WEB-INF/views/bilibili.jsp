<%@ page import="java.net.URLDecoder" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/22
  Time: 15:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="multipart/form-data;charset=utf-8" />
    <title>bilibili</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap -->
    <link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="../../bootstrap/jquery-1.9.1.js"></script>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="../../bootstrap/js/bootstrap.min.js"></script>
    <link href="../../easyui/css/blibili.css" rel="stylesheet" />
    <script type="text/javascript" src="../../easyui/js/bili.js"></script>
</head>
<body>
<nav  class="navbar navbar-inverse navbar-fixed-top" id="navs" >

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav navbar-left">
            <li><div id="left_img"><img width="100%" src="../../easyui/img/tv.png"></div></li>
            <li><a href="#" ><i class="glyphicon glyphicon-home"></i>首页</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">

        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="#" id="tg" data-toggle="modal" data-target="#ContributionModal" data-whatever="@mdo">投稿</a></li>
        </ul>
        <%
            Cookie[] coooklist = request.getCookies();
            String str ="";
            for(Cookie c:coooklist)
            {
                if(c.getName().equals("loginName"))
                {
                    str = URLDecoder.decode(c.getValue(), "UTF-8");
                    break;
                }
            }
            request.setAttribute("myname",str);
        %>
        <!--用户信息显示栏-->
        <ul class="nav navbar-nav navbar-right">
            <li>
                <c:if test="${myname != null && myname!='' }">
                    <div id="head_imgs" onclick="window.location.href='userInfo.do?userid=${u.userid}' ">
                        <img width="100%" height="100%" src="${pageContext.request.contextPath}/img/${u.headImg}">
                    </div>
                </c:if>

                <c:if test="${myname=='' || myname==null}">
                    <div id="head_imgs">
                        <img width="100%" height="100%" src="../../easyui/img/tv.png">
                    </div>
                </c:if>

            </li>

            <li>
                <c:if test="${myname!='' && myname!=null}"><a href="/userInfo.do?userid=${u.userid}">${myname}</a></c:if>
                <c:if test="${myname=='' || myname==null}"><a>请登录</a></c:if>
            </li>

            <li>
                <c:if test="${myname=='' || myname==null}">
                    <button style="height: 52px;width:60px;" type="button" class="btn btn-primary" data-toggle="modal" data-target="#LoginModal" data-whatever="@mdo">登录</button>
                </c:if>
                <c:if test="${myname!='' && myname!=null}">
                    <button style="height: 52px;width:60px;" type="button" class="btn btn-primary" onclick="window.location.href='exit_login.do'" >注销</button>
                </c:if>
            </li>
        </ul>
        <!--搜索栏-->
        <form class="navbar-form navbar-right">
            <div class="form-group">
                <input type="text" class="form-control" placeholder="Search">
            </div>
            <button type="submit" class="btn btn-success"><i class="glyphicon glyphicon-search"></i>&nbsp;搜索</button>
        </form>

    </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>


<div id="middle"><br>
    <div id="menu">
        <ul>
            <a href="/bilibili.do">主页</a>
            <c:forEach items="${types}" var="type">
                <a href="/bilibili.do?videoType=${type.typeId}"><li>${type.typename}</li></a>
            </c:forEach>
        </ul>
    </div>
    <!--每日推荐    -->
    <div id="Recommend">
        <div id="rec_img"></div>
        <span>每日推荐</span>

        <a href="#">
		<span id="more">
			更多&nbsp;<i class="glyphicon glyphicon-list"></i>
		</span>
        </a>
    </div>
    <br>
    <!-- 轮播图 -->
    <div name="LBT" id="carousel-example-generic" class="carousel slide" data-ride="carousel">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
            <li data-target="#carousel-example-generic" data-slide-to="3"></li>
        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner" role="listbox">

            <div class="item active">
                <img src="../../easyui/img/【鬼灭全程踩点燃】这一击赌上现在的我，献出我的一切！.jpg"  >
                <div class="carousel-caption">
                </div>
            </div>

            <div class="item">
                <img src="${pageContext.request.contextPath}/img/【剧场版】我想吃掉你的胰脏 预告PV【1080P】.jpg">
                <div class="carousel-caption">
                </div>
            </div>

            <div class="item">
                <img src="${pageContext.request.contextPath}/img/【裸眼3D】金木VS壁虎，更近距离的视觉体验.jpg" >
                <div class="carousel-caption">
                </div>
            </div>

            <div class="item">
                <img src="${pageContext.request.contextPath}/img/Unravel the world.jpg" >
                <div class="carousel-caption">
                </div>
            </div>
        </div>
    </div>

    <div id="Ranking">
        <span id="Rank_title">排行榜</span>
        <ul id="Rank_content">
            <c:forEach items="${rank}" var="r" varStatus="vs">

                <li style="cursor: pointer;" onclick="window.location.href='video.do?vid=${r.vid}'">
                    <span name="r_v_name"><i class="num">${vs.index+1}</i>&nbsp;${r.vname}</span>
                </li>
            </c:forEach>

        </ul>
    </div>


    <div id="comprehensive">
        <div id="comprehensive_img"></div>
        <span>综合</span>
    </div>



    <div id="videos">
        <c:forEach items="${pageInfo.list}" var="v">
            <a href="/video.do?vid=${v.vid}">
                <div name="vid">
                    <img src="${pageContext.request.contextPath}/img/${v.vImage}">
                    <br>
                    <span name="video_name">${v.vname}</span>
                    <br>
                </div>
            </a>
        </c:forEach>




        <!-----------------------------------------分页插件-------------------------------------------->
        <nav aria-label="Page navigation" id="fenye">
            <ul class="pagination">
                <!-----------------------------------------首页分割线-------------------------------------------->
                <c:if test="${videoType==null}">
                    <li class="page-item"><a class="page-link" href="/bilibili.do?page=1">首页</a></li>
                </c:if>
                <c:if test="${videoType!=null}">
                    <li class="page-item"><a class="page-link" href="/bilibili.do?videoType=${videoType}&page=1">首页</a></li>
                </c:if>
                <!-----------------------------------------上一页分割线------------------------------------------>
                <c:if test="${pageInfo.hasPreviousPage}">
                    <li>
                        <c:if test="${videoType == null}">
                            <a href="/bilibili.do?page=${pageInfo.pageNum-1}" aria-label="Previous">
                        </c:if>

                        <c:if test="${videoType != null}">
                            <a href="/bilibili.do?videoType=${videoType}&page=${pageInfo.pageNum-1}" aria-label="Previous">
                        </c:if>
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:if>
                <!-----------------------------------------数字翻页分割线---------------------------------------->
                <c:forEach items="${pageInfo.navigatepageNums}" var="page">
                    <c:if test="${page==pageInfo.pageNum}">
                        <li class="active"><a href="#">${page}</a></li>
                    </c:if>

                    <c:if test="${page!=pageInfo.pageNum && videoType == null }">
                        <li><a href="/bilibili.do?page=${page}">${page}</a></li>
                    </c:if>
                    <c:if test="${page!=pageInfo.pageNum && videoType != null }">
                        <li><a href="/bilibili.do?videoType=${videoType}&page=${page}">${page}</a></li>
                    </c:if>

                </c:forEach>

                <!-----------------------------------------下一页分割线------------------------------------------>
                <c:if test="${pageInfo.hasNextPage && videoType == null}">
                <li>
                    <a href="/bilibili.do?page=${pageInfo.pageNum+1}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
                </c:if>
                <c:if test="${pageInfo.hasNextPage && videoType !=null }">
                    <li>
                        <a href="/bilibili.do?videoType=${videoType}&page=${pageInfo.pageNum+1}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>

                <!-----------------------------------------末页分割线-------------------------------------------->
                <c:if test="${videoType == null}">
                    <li class="page-item"><a class="page-link" href="/bilibili.do?page=${pageInfo.pages}">末页</a></li>
                </c:if>
                <c:if test="${videoType != null}">
                    <li class="page-item"><a class="page-link" href="/bilibili.do?videoType=${videoType}&page=${pageInfo.pages}">末页</a></li>
                </c:if>
            </ul>
        </nav>
        <!------------------------------------------------------------------------------------->
    </div>
</div>

<div class="modal fade" id="LoginModal" tabindex="-1" role="dialog" aria-labelledby="LoginModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel"><i id="login_icon"></i>登录</h4>
            </div>
            <div class="modal-body">

                    <div class="form-group">

                        <label for="username" class="control-label">用户名</label>
                        <input type="text" class="form-control" id="username" name="username"  />
                        <span id="checkNamePwd"></span>
                    </div>

                    <div class="form-group">
                        <label for="pwd" class="control-label">密码</label>
                        <input class="form-control" id="pwd" type="password" name="password" />
                    </div>

                     <div class="modal-footer">
                        <button id="cancel" type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary" id="register" >注册</button>
                        <button  class="btn btn-primary" onclick="login()">登录</button>
                    </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="RegisterModal" tabindex="-1" role="dialog" aria-labelledby="RegisterModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="RegisterModalLabel"><i id="register_icon"></i>注册</h4>
            </div>

            <div class="modal-body">
                <form action="register.do" method="post" enctype="multipart/form-data"><!-- 注册功能 -->
                    <div class="form-group">
                        <label for="setusername" class="control-label">设置你的用户名</label>
                        <input type="text" class="form-control"  id="setusername" name="username" onchange="ajaxValidate()" />
                        <span id="remind"></span>
                    </div>
                    <div class="form-group">
                        <label for="setpwd" class="control-label">设置你的密码</label>
                        <input class="form-control" id="setpwd" type="password" name="password" onchange="check_notnull()" />
                    </div>
                    <div class="form-group">
                        <label for="head_Img" class="control-label">请选择头像</label>
                        <input class="form-control" id="head_Img" type="file" name="headImg" onchange="check_notnull()"/>
                    </div>
                    <div class="form-group">
                        <label for="content_text" class="control-label">个性签名</label>
                        <textarea class="form-control" id="content_text" name="content"></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button id="registerBtn" type="submit" class="btn btn-primary">提交</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="ContributionModal" tabindex="-1" role="dialog" aria-labelledby="ContributionModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="ContributionModalLabel"><i id="Contribution_icon"></i>投稿</h4>
            </div>

            <form action="uploadvideo.do" method="post" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="vname" class="control-label">视频标题</label>
                        <input type="text" class="form-control" id="vname" name="vname" />
                    </div>

                    <div class="form-group">
                        <label for="vsrc" class="control-label">视频文件(.mp4)</label>
                        <input class="form-control"  type="file" id="vsrc" name="upfile"  multiple="multiple" />
                    </div>

                    <div class="form-group">
                        <label  class="control-label">请选择封面(.jpg/.png)</label>
                        <input class="form-control" type="file" name="upfile"  multiple="multiple" />
                    </div>

                    <div class="form-group">
                        <label class="control-label">视频类型</label>
                        <select class="form-control" name="typeId">
                            <c:forEach items="${types}" var="t">
                                <option value="${t.typeId}">${t.typename}</option>
                            </c:forEach>
                        </select>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary" >上传</button>
                </div>
            </form>
        </div>
    </div>
</div>


<button style="display:none;" id="toRegister" data-toggle="modal" data-target="#RegisterModal" data-whatever="@mdo"></button>


<footer id="foot"></footer>
</body>
<script type="text/javascript">
    function ajaxValidate() {

        var username=$("#setusername").val();

        $.ajax({
            type:"POST",
            url:"${pageContext.request.contextPath}/checkUserName.do",//提交地址
            data:"username="+username,//提交数据
            dataType:"json",//返回json格式
            //contentType:"application/json;charset=utf-8",

            success:function(data){

                if ("no" == data.info) {//后端传来的msg的值是no,不能注册。反之。
                    $("#remind").html("<b style='color:red'>该用户名被注册，请更换！</b>");
                    $("#registerBtn").attr("disabled","disabled");

                }if("yes" == data.info){
                    $("#remind").html("<b style='color: green;'>该用户名可用</b>");//如果没有被注册，将提示语清空。
                }
            }
        });
    }
    
    function check_notnull() {
        var username=$("#setusername").val();
        var pwd = $("#setpwd").val();
        var headImg = $("#head_Img").val();
        if(username=="" || username==null || pwd=="" || pwd==null || headImg=="" || headImg==null)
        {
            $("#registerBtn").attr("disabled","disabled");
        }
        else
        {
            $("#registerBtn").removeAttr("disabled");
        }
    }
    
    
    function login() {
        var loginName = $("#username").val();
        var loginPwd = $("#pwd").val();
        $.ajax({
            type:"POST",
            url:"${pageContext.request.contextPath}/login.do",
            data:"username="+loginName+"&password="+loginPwd,
            dataType:"json",
            success:function (data) {
                if("loginSuccess" == data.info)
                {
                    alert("登录成功");
                    window.location.href="bilibili.do";

                }
                if("loginFailed" == data.info)
                {
                    $("#checkNamePwd").html("<b style='color:red;'>用户名或密码错误！</b>");
                }
            }
        });
    }
</script>
</html>
