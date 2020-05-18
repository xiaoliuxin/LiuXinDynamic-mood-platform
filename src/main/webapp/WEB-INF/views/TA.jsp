<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/25
  Time: 10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>${TA_user.username}的主页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap -->
    <link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="../../bootstrap/jquery-1.9.1.js"></script>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="../../bootstrap/js/bootstrap.min.js"></script>
    <link href="../../easyui/css/userInfo.css" rel="stylesheet" />
    <script type="text/javascript" src="../../easyui/js/userInfo.js"></script>
</head>
<body>
<nav  class="navbar navbar-default navbar-fixed-top" id="navs" >
    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav navbar-left">
            <li><div id="left_img"><img width="100%" src="../../easyui/img/tv_black.png"></div></li>
            <li><a href="/bilibili.do" ><i class="glyphicon glyphicon-home"></i>首页</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">

        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="#" id="tg">投稿</a></li>
        </ul>

        <!--用户信息显示栏-->
        <ul class="nav navbar-nav navbar-right">
            <li>
                <div id="head_imgs" onclick="window.location.href='userInfo.do?userid=${user.userid}' ">
                    <img width="100%" height="100%" src="${pageContext.request.contextPath}/img/${user.headImg}">
                </div>
            </li>
            <li>
                <a>${user.username}</a>
            </li>
            <li>
                <button style="height: 52px;width:60px;" type="button" class="btn btn-primary" onclick="window.location.href='exit_login.do'" >注销</button>
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

<!--------------------------------------TA的信息 ---------------------------------------->
<div id="userInfo">
    <div id="h_info" >
        <div id="h_user">
            <img id="head" src="${pageContext.request.contextPath}/img/${TA_user.headImg}"/>
            <span id="username">${TA_user.username}</span>&nbsp;&nbsp;
            <span id="level">Lv${TA_user.level}</span>&nbsp;&nbsp;

            <span id="exp">
				<progress value="${TA_user.exp}" max="${maxExp}"></progress>
                <span id="ExpNum">${TA_user.exp} / ${maxExp}</span>
			</span>

            <form class="navbar-form navbar-right" id="content" >
                <input type="text" name="content" class="form-control" value="${TA_user.content}" placeholder="这个人没有填简介啊~~~" disabled="disabled">
            </form>
        </div>
    </div>

    <div id="follow_fans">
        <ul class="nav nav-tabs" >
            <li role="presentation" class="active">
                <a href="#tab1" data-toggle="tab" ><i style="color: green;" class="glyphicon glyphicon-home"></i>
                    TA的主页
                </a>
            </li>

            <li role="presentation">
                <a href="#tab3" data-toggle="tab" ><i style="color: #EB9316" class="glyphicon glyphicon-star"></i>
                    TA的收藏夹
                </a>
            </li>
            <li role="presentation">
                <a href="#tab4" data-toggle="tab" ><i style="color: mediumpurple;" class="glyphicon glyphicon-user"></i>
                    TA的关注列表
                </a>
            </li>
            <li role="presentation">
                <a href="#tab5" data-toggle="tab" ><i style="color: #D43F3A;" class="glyphicon glyphicon-heart"></i>
                    TA的粉丝列表
                </a>
            </li>

            <li style="float: right;top: 10px;">
                <span style="color: #666;">关注</span>
                <span style="color: #F25D8E;">${follow_conut}</span>
                &nbsp;&nbsp;&nbsp;
                <span style="color: #666;">粉丝</span>
                <span style="color: #F25D8E;">${fans_count}</span>
                &nbsp;&nbsp;&nbsp;
            </li>
        </ul>

        <div class="tab-content">
            <div id="tab1" class="tab-pane active">
                <span name="my_video_title"><i id="my_video_icon"></i>TA的视频</span>
                <div id="my_videos">
                    <c:forEach items="${videoList}" var="vl">
                        <c:forEach items="${vl.videos}" var="v">
                            <a href="/video.do?vid=${v.vid}">
                                <div name="vid">
                                    <img src="${pageContext.request.contextPath}/img/${v.vImage}">
                                    <br>
                                    <span name="video_name">${v.vname}</span>
                                    <br>
                                </div>
                            </a>
                        </c:forEach>
                    </c:forEach>
                </div>
            </div>

            <div id="tab3" class="tab-pane">
                <span name="my_video_title"><i id="my_Collection_icon"></i>TA的收藏</span>
                <div id="my_Collection">
                    <c:forEach items="${user_collects}" var="u_c">

                        <a href="/video.do?vid=${u_c.video.vid}">
                            <div name="vid">
                                <img src="${pageContext.request.contextPath}/img/${u_c.video.vImage}">
                                <br>
                                <span name="video_name">${u_c.video.vname}</span>
                                <br>
                            </div>
                        </a>

                    </c:forEach>
                </div>
            </div>


            <div id="tab4" class="tab-pane">
                <span name="my_video_title"><i id="my_follow_icon"></i>TA的关注</span>

                <ul id="follow_list">
                    <c:forEach items="${user_follow_list}" var="ufl">
                        <% Integer bol = 0 ; %>
                        <li>
                            <img name="follow_head"  src="${pageContext.request.contextPath}/img/${ufl.headImg}" onclick="window.location.href='userInfo.do?userid=${ufl.userid}'">
                            <span name="f_name">${ufl.username}</span>
                            <span name="f_content">${ufl.content}</span>

                            <c:forEach items="${if_follow_Ta_followed}" var="iff"  >
                                <c:if test="${ufl.userid == iff}">
                                    <input type="hidden" name="fid" value="${ufl.userid}">
                                    <button name="del_follow" type="button" class="btn btn-default" onclick="deleteFollow(this)">
                                        <i class="glyphicon glyphicon-ban-circle" style="color: red;"></i>
                                        取消关注
                                    </button>
                                    <%
                                        bol = 1 ;  //flag = 1 代表该 userfans.userid 存在于这个集合中
                                    %>
                                </c:if>
                            </c:forEach>
                            <input type="hidden" name="fansId" value="${ufl.userid}" />
                            <!--flag = 0 代表该 userfans.userid 不存在于这个集合,变更为关注按钮-->
                            <%
                                if(bol == 0)
                                {
                                    out.print("<button name='add_fans' type='button' class='btn btn-default' onclick='addFollow(this)'>" +
                                            "<i class='glyphicon glyphicon-plus'></i>关注</button>");
                                }
                            %>
                        </li>
                    </c:forEach>
                </ul>
            </div>


            <div id="tab5" class="tab-pane">
                <span name="my_video_title"><i id="my_fans_icon"></i>TA的粉丝</span>
                <ul id="fans_list">
                    <c:forEach items="${user_fans_list}" var="userfans">
                        <% Integer flag = 0 ;  %>
                        <li>
                            <img name="fans_head" src="${pageContext.request.contextPath}/img/${userfans.headImg}" onclick="window.location.href='userInfo.do?userid=${userfans.userid}'" >
                            <span name="fans_name">${userfans.username}</span>
                            <span name="fans_content">${userfans.content}</span>
                            <!--- if_follow 集合: 当前登录用户已经关注的人的ID--->
                            <!--如果该粉丝的 ID 存在于这个集合中，则变更按钮内容 -->
                            <c:forEach items="${if_follow_Ta_fans}" var="iff" >
                                <c:if test="${userfans.userid == iff}">
                                    <input type="hidden" name="fansId" value="${userfans.userid}" />
                                    <button name="del_follow" type="button" class="btn btn-default" onclick="deleteFollow(this)">
                                        <i class="glyphicon glyphicon-ban-circle" style="color: red;"></i>
                                        取消关注
                                    </button>
                                    <%
                                        flag = 1 ;  //flag = 1 代表该 userfans.userid 存在于这个集合中
                                    %>
                                </c:if>
                            </c:forEach>
                            <input type="hidden" name="fansId" value="${userfans.userid}" />
                            <!--flag = 0 代表该 userfans.userid 不存在于这个集合,变更为关注按钮-->
                            <%
                                if(flag == 0)
                                {
                                    out.print("<button name='add_fans' type='button' class='btn btn-default' onclick='addFollow(this)'>" +
                                            "<i class='glyphicon glyphicon-plus'></i>关注</button>");
                                }
                            %>
                        </li>
                    </c:forEach>
                </ul>
            </div>



        </div>

    </div>

</div>






</body>
<script type="text/javascript">
    function addFollow(obj) {   //关注 (X)
        var fansId= obj.previousElementSibling.value;
        var my_uid = ${user.userid};

        if(my_uid != fansId)
        {
        $.ajax({
            type:"POST",
            url:"${pageContext.request.contextPath}/addFollow.do",
            data:"fansId="+fansId+"&myid="+my_uid,
            dataType:"json",
            success:function (data) {
                if("yes" == data.info)
                {
                    var followed ="<i class='glyphicon glyphicon-ban-circle' style='color: red;'></i>取消关注";
                    $(obj).attr("onclick","deleteFollow(this)").attr("name","del_follow").html(followed);  //obj 按钮本身变更状态为：取消关注
                }
                if("no" == data.info)
                {
                    alert("关注失败");
                }
            }
        });
        }
        else
        {
            alert("不能关注自己");
        }
    }

    function deleteFollow(obj) {   //取消关注 (√)
        var val_uid= obj.previousElementSibling.value;
        var my_uid = ${user.userid};
        $.ajax({
            type:"POST",
            url:"${pageContext.request.contextPath}/deleteFollow.do",
            data:"userid="+val_uid+"&myid="+my_uid,
            dataType:"json",
            success:function (data) {
                if("yes" == data.info)
                {
                    var fol ="<i class='glyphicon glyphicon-plus' style='color: red;'></i>关注";
                    $(obj).attr("onclick","addFollow(this)").attr("name","add_fans").html(fol);  //obj 按钮本身变更状态为：关注

                }
                if("no" == data.info)
                {
                    alert("取消关注失败");
                }
            }
        });
    }
</script>
</html>
