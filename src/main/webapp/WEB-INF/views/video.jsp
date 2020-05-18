<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/25
  Time: 10:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Video</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap -->
    <link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="../../bootstrap/jquery-1.9.1.js"></script>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="../../bootstrap/js/bootstrap.min.js"></script>
    <link href="../../easyui/css/video.css" rel="stylesheet" />
    <script type="text/javascript" src="../../easyui/js/video.js"></script>
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

        <!--用户信息显示栏-->
        <ul class="nav navbar-nav navbar-right">
            <li>
                <c:if test="${login_user.username != null && login_user.username!='' }">
                    <div id="head_imgs" onclick="window.location.href='userInfo.do?userid=${login_user.userid}' ">
                        <img width="100%" height="100%" src="${pageContext.request.contextPath}/img/${login_user.headImg}">
                    </div>
                </c:if>

                <c:if test="${login_user.username=='' || login_user.username==null}">
                    <div id="head_imgs">
                        <img width="100%" height="100%" src="../../easyui/img/tv_black.png">
                    </div>
                </c:if>

            </li>

            <li>
                <c:if test="${login_user.username!='' && login_user.username!=null}"><a href="/userInfo.do?userid=${login_user.userid}">${login_user.username}</a></c:if>
                <c:if test="${login_user.username=='' || login_user.username==null}"><a>请登录</a></c:if>
            </li>

            <li>
                <c:if test="${login_user.username=='' || login_user.username==null}">
                    <button style="height: 52px;width:60px;" type="button" class="btn btn-primary" data-toggle="modal" data-target="#LoginModal" data-whatever="@mdo">登录</button>
                </c:if>
                <c:if test="${login_user.username!='' && login_user.username!=null}">
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


<div id="videoInfo">
    <div id="video_head">
        <div id="video_title">
            <span id="title">${videoInfo.vname}</span><br>
            <span id="type">视频类型 -> ${videoType.typename}</span>
            <span id="time">${videoInfo.vtime}</span>
        </div>

        <div id="video_userInfo">
            <div id="v_user_head">
                <img src="${pageContext.request.contextPath}/img/${v_user.headImg}" />
            </div>


                <div id="username_and_follow">
                    <span>${v_user.username}</span><br><br>
                    <!-------------------------------------已登录状态:未关注------------------------------------>
                    <c:if test="${if_follow == 0 && login_user.userid!=null }">
                        <c:if test="${login_user.userid == v_user.userid}">
                            <button type="button" class="btn btn-primary" onclick="alert('不能关注自己')">
                                <i class="glyphicon glyphicon-plus"></i>&nbsp;关注&nbsp;${fans_count}</button>
                        </c:if>
                        <c:if test="${login_user.userid != v_user.userid}">
                            <button type="button" class="btn btn-primary" onclick="window.location.href='follow.do?userid=${login_user.userid}&followId=${v_user.userid}&vid=${videoInfo.vid}'">
                                <i class="glyphicon glyphicon-plus"></i>&nbsp;关注&nbsp;${fans_count}</button>
                        </c:if>
                    </c:if>
                    <!-------------------------------------已登录状态：已关注------------------------------------>
                    <c:if test="${if_follow == 1}">
                        <button type="button" class="btn btn-primary" onclick="window.location.href='cancelfollow.do?userid=${login_user.userid}&followId=${v_user.userid}&vid=${videoInfo.vid}'">
                            <i class="glyphicon glyphicon-plus"></i>&nbsp;已关注&nbsp;${fans_count}</button>
                    </c:if>
                    <!--------------------------未登录状态：默认未关注,点击跳转登录界面----------------------------->
                    <c:if test="${login_user.userid == null}">
                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#LoginModal" data-whatever="@mdo">
                            <i class="glyphicon glyphicon-plus"></i>&nbsp;关注&nbsp;${fans_count}</button>
                    </c:if>
                </div>


        </div>
    </div>

    <video id="play_video" src="${pageContext.request.contextPath}/img/${videoInfo.vsrc}" controls="controls">你的浏览器不支持video</video>

    <div id="SanLian">
        <!--------------------------------------点赞分割线--------------------------------------------->

        <!--已点赞-->
        <c:if test="${if_praise == 1}">
            <a  style="cursor: pointer;" onclick="Cancel_praise(this)">
                <i id="dianzaned"></i>
                <span>${videoInfo.praise}</span>
            </a>
        </c:if>

        <!--未点赞-->
        <c:if test="${if_praise == 0 && login_user.userid !=null }">
            <a style="cursor: pointer;" onclick="Praise(this)">
                <i id="not_dianzan"></i>
                <span>${videoInfo.praise}</span>
            </a>
        </c:if>

        <!--未登录-->
        <c:if test="${login_user.userid == null}">
            <a style="cursor: pointer;" data-toggle="modal" data-target="#LoginModal" data-whatever="@mdo">
                <i style="width: 24px;height: 24px;display: inline-block;background: url('../../easyui/img/icons-comment.png');background-position: -150px -22px;"></i>
                <span>${videoInfo.praise}</span>
            </a>
        </c:if>

        <!--------------------------------------投币分割线--------------------------------------------->
        <!--已投币-->
        <c:if test="${if_coin == 1}">
            <a>
                <i id="give_coin"></i>
                <span>${videoInfo.getIcon}</span>
            </a>
        </c:if>

        <!--未投币-->
        <c:if test="${if_coin == 0 && login_user.userid !=null }">
            <c:if test="${login_user.coin == 0 }">
                <a href="#" onclick="alert('硬币不足')">
                    <i id="give_coined"></i>${videoInfo.getIcon}
                </a>
            </c:if>

            <c:if test="${login_user.coin > 0 }">
                <a style="cursor: pointer" onclick="Coin(this)">
                    <i id="give_coineds"></i>
                    <span>${videoInfo.getIcon}</span>
                </a>
            </c:if>

        </c:if>

        <!--未登录-->
        <c:if test="${login_user.userid == null}">
            <a data-toggle="modal" data-target="#LoginModal" data-whatever="@mdo">
                <i style="width: 24px;
                          height: 24px;
                          display: inline-block;
                          background: url('../../easyui/img/icons.png');
                          background-position: -660px -2004px;"></i>${videoInfo.getIcon}
            </a>
        </c:if>

        <!--------------------------------------收藏分割线--------------------------------------------->
        <!--已收藏-->
        <c:if test="${if_collect == 1}">
            <a style="cursor: pointer;" onclick="Cancel_collect(this)">
                <i id="Yshoucang"></i>
                <span>${collect_count}</span>
            </a>
        </c:if>

        <!--未收藏-->
        <c:if test="${if_collect == 0 && login_user.userid !=null }">
            <a style="cursor: pointer;" onclick="Collect(this)" >
                <i id="Wshoucang"></i>
                <span>${collect_count}</span>
            </a>
        </c:if>

        <!--未登录-->
        <c:if test="${login_user.userid ==null }">
            <a data-toggle="modal" data-target="#LoginModal" data-whatever="@mdo">
                <i style="width: 24px;
                          height: 24px;
                          display: inline-block;
                          background: url('../../easyui/img/icons.png');
                          background-position: -658px -405px;"></i>
                <span>${collect_count}</span>
            </a>
        </c:if>
    </div>
    <!--------------------------------------评论区---------------------------------------------------->
    <div id="talking">
        <span id="talking_title">&nbsp;&nbsp;&nbsp;评论区</span>

        <!----------------未登录禁止发送评论，提示登录------------------->
        <c:if test="${ login_user.userid == null }">
            <div id="not_login_send">
                <a href="#" style="color: deepskyblue;" data-toggle="modal" data-target="#LoginModal" data-whatever="@mdo">登录</a>即可发送评论
            </div>
        </c:if>
        <!--------------------------已登录---------------------------->
        <c:if test="${ login_user.userid != null }">
            <div id="Send">
                <img id="talk_user_head" src="${pageContext.request.contextPath}/img/${login_user.headImg}" >
                <form action="/sendMess.do">
                    <input type="hidden" name="userid" value="${login_user.userid}">
                    <input type="hidden" name="vid" value="${videoInfo.vid}">
                    <textarea id="talk_text" name="comment" placeholder="输入内容发送评论"></textarea>
                    <button id="sendbtn" type="submit" class="btn btn-primary">发送</button>
                </form>
            </div>
        </c:if>

     <!----------------------------------------评论列表----------------------------------------------->
        <div id="users_talking">
            <ul>
                <c:forEach items="${messageList}" var="mess">
                    <li class="talk_line">
                        <img class="head" src="${pageContext.request.contextPath}/img/${mess.user.headImg}">
                        <span class="namez">${mess.user.username}</span>
                        <span class="contentz">${mess.comment}</span>
                        <span class="timez">${mess.sendTime}</span>
                        <!--userid == login_user.userid  btn show-->
                        <c:if test="${mess.user.userid == login_user.userid && login_user.userid!=null}">
                            <button name="deleteMess" class="btn btn-default" onclick="window.location.href='deleteMess.do?messId=${mess.messId}&vid=${videoInfo.vid}'">删除</button>
                        </c:if>
                    </li>
                </c:forEach>
            </ul>
        </div>
    <!----------------------------------------END----------------------------------------------->
    </div>

</div>
<br>





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
<button style="display:none;" id="toRegister" data-toggle="modal" data-target="#RegisterModal" data-whatever="@mdo"></button>

<input type="hidden" value="${videoInfo.vid}" id="now_vid"/>
<input type="hidden" value="${login_user.userid}" id="now_userid" />

</body>
<script type="text/javascript">
    var vid = $("#now_vid").val();
    var userid = $("#now_userid").val();
    //取消点赞
    function Cancel_praise(obj) {
        $.ajax({
            type:"POST",
            url:"${pageContext.request.contextPath}/cancel_praise.do",
            data:"vid="+vid+"&userid="+userid,
            dataType:"json",
            success:function (data) {
                if("no" == data.info)
                {
                    alert("取消点赞失败");
                }
                else
                {
                    $(obj).attr("onclick","Praise(this)");
                    $(obj).html("<i id='not_dianzan'></i><span>"+(data.info)+"</span>");
                }
            }

        });
    }

    //点赞
    function Praise(obj) {
        $.ajax({
            type:"POST",
            url:"${pageContext.request.contextPath}/praise.do",
            data:"vid="+vid+"&userid="+userid,
            dataType:"json",
            success:function (data) {
                if("no" == data.info)
                {
                    alert("点赞失败");
                }
                else
                {
                    $(obj).attr("onclick","Cancel_praise(this)");
                    $(obj).html("<i id='dianzaned'></i><span>"+(data.info)+"</span>");
                }
            }
        });
    }
    //投币
    function Coin(obj) {
        var coin_num = $(obj).find("span").val();
        coin_num = check_num_not_null(coin_num);
        $.ajax({
            type:"POST",
            url:"${pageContext.request.contextPath}/giveCoin.do",
            data:"vid="+vid+"&userid="+userid,
            dataType:"json",
            success:function (data) {
                if("yes" == data.info)
                {
                    $(obj).removeAttr("onclick");
                    $(obj).html("<i id='give_coin'></i><span>"+(coin_num+1)+"</span>");
                }
                if("no" == data.info)
                {
                    alert("投币失败");
                }
            }
        });
    }

    //收藏
    function Collect(obj) {
        $.ajax({
            type:"POST",
            url:"${pageContext.request.contextPath}/collect.do",
            data:"vid="+vid+"&userid="+userid,
            dataType:"json",
            success:function (data) {
                if("no" == data.info)
                {
                    alert("收藏失败");
                }
                else
                {
                    $(obj).attr("onclick","Cancel_collect(this)");
                    $(obj).html("<i id='Yshoucang'></i><span>"+((data.info))+"</span>");
                }
            }
        });
    }

    //取消收藏
    function Cancel_collect(obj) {
        $.ajax({
            type:"POST",
            url:"${pageContext.request.contextPath}/cancel_collect.do",
            data:"vid="+vid+"&userid="+userid,
            dataType:"json",
            success:function (data) {

                if("no" == data.info)
                {
                    alert("取消收藏失败");
                }
                else
                {
                    $(obj).attr("onclick","Collect(this)");
                    $(obj).html("<i id='Wshoucang'></i><span>"+(data.info)+"</span>");
                }
            }
        });
    }


    function check_num_not_null(num) {
        if(num == "" || num == null)
        {
            num = 0;
        }
        return num;
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
</script>
</html>
