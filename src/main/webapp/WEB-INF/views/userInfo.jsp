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
    <title>UserInfo</title>
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
            <li><a href="#" id="tg" data-toggle="modal" data-target="#ContributionModal" data-whatever="@mdo" >投稿</a></li>
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


<div id="userInfo">
    <div id="h_info" >
        <div id="h_user">
            <img id="head" src="${pageContext.request.contextPath}/img/${user.headImg}"/>
            <span id="username">${user.username}</span>&nbsp;&nbsp;
            <span id="level">Lv${user.level}</span>&nbsp;&nbsp;

            <span id="exp">
				<progress value="${user.exp}" max="${maxExp}"></progress>
                <span id="ExpNum">${user.exp} / ${maxExp}</span>
				&nbsp;&nbsp;
				<span id="coin"></span>
				&nbsp;
				<span id="CoinNum">${user.coin}</span>
			</span>

            <form class="navbar-form navbar-right" id="content" action="saveContent.do">
                <input type="hidden" name="uid" value="${user.userid}"/>
                <input type="text" name="content" class="form-control" value="${user.content}" placeholder="编辑个性签名">
                <button id="changeContent" type="submit" class="btn btn-info">保存</button>
            </form>
        </div>
    </div>

    <div id="follow_fans">

        <ul class="nav nav-tabs" >
            <li role="presentation" class="active">
                <a href="#tab1" data-toggle="tab" ><i style="color: green;" class="glyphicon glyphicon-home"></i>
                    主页
                </a>
            </li>

            <li role="presentation">
                <a href="#tab3" data-toggle="tab" ><i style="color: #EB9316" class="glyphicon glyphicon-star"></i>
                    收藏夹
                </a>
            </li>
            <li role="presentation">
                <a href="#tab4" data-toggle="tab" ><i style="color: mediumpurple;" class="glyphicon glyphicon-user"></i>
                    关注列表
                </a>
            </li>
            <li role="presentation">
                <a href="#tab5" data-toggle="tab" ><i style="color: #D43F3A;" class="glyphicon glyphicon-heart"></i>
                    粉丝列表
                </a>
            </li>
            <li role="presentation">
                <a href="#tab6" data-toggle="tab" ><i style="color: blue;" class="glyphicon glyphicon-pencil"></i>
                    个人信息
                </a>
            </li>
            <li role="presentation">
                <a href="#tab7" data-toggle="tab" ><i style="color: #00BFFF" class="glyphicon glyphicon-edit"></i>
                    稿件管理
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
                <span name="my_video_title"><i id="my_video_icon"></i>我的视频</span>
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
                <span name="my_video_title"><i id="my_Collection_icon"></i>我的收藏</span>
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
                <span name="my_video_title"><i id="my_follow_icon"></i>我的关注</span>

                <ul id="follow_list">
                    <c:forEach items="${user_follow_list}" var="ufl">
                        <li>
                            <img name="follow_head" onclick="window.location.href='userInfo.do?userid=${ufl.userid}'" src="${pageContext.request.contextPath}/img/${ufl.headImg}"  />
                            <span name="f_name">${ufl.username}</span>
                            <span name="f_content">${ufl.content}</span>
                            <input type="hidden" name="fid" value="${ufl.userid}">
                            <button name="del_follow" type="button" class="btn btn-default" onclick="deleteFollow(this)">
                                <i class="glyphicon glyphicon-ban-circle" style="color: red;"></i>
                                取消关注
                            </button>
                        </li>
                    </c:forEach>
                </ul>
            </div>


            <div id="tab5" class="tab-pane">
                <span name="my_video_title"><i id="my_fans_icon"></i>我的粉丝</span>
                <ul id="fans_list">
                    <c:forEach items="${user_fans_list}" var="userfans">
                        <% Integer flag = 0 ;  %>
                        <li>
                            <img name="fans_head" src="${pageContext.request.contextPath}/img/${userfans.headImg}" onclick="window.location.href='userInfo.do?userid=${userfans.userid}'" >
                            <span name="fans_name">${userfans.username}</span>
                            <span name="fans_content">${userfans.content}</span>
                            <!--- if_follow 集合: 当前登录用户已经关注的人的ID--->
                            <!--如果该粉丝的 ID 存在于这个集合中，则变更按钮内容 -->
                            <c:forEach items="${if_follow_fans}" var="iff" >
                                <c:if test="${userfans.userid == iff}">
                                    <input type="hidden" name="fansId" value="${userfans.userid}" />
                                    <button name="del_follow" type="button" class="btn btn-default" disabled="disabled">
                                        <i class="glyphicon glyphicon-ban-circle" style="color: red;"></i>
                                        已关注
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

            <div id="tab6" class="tab-pane">
                <span name="my_video_title"><i id="change_userInfo_icon"></i>修改个人信息</span>
                <form id="change_userInfo_from" method="post" enctype="multipart/form-data" action="update_user_info.do?userid=${user.userid}">
                    <div class="form-group" style="width: 50%;">
                        <label for="changeUserName" style="font-family: '微软雅黑';font-size: 15px;">用户名</label>
                        <input type="text" class="form-control" id="changeUserName" onchange="ajaxValidate()" value="${user.username}" name="username" >
                        <span id="remind"></span>
                    </div>

                    <div class="form-group" style="width: 50%;">
                        <label for="changePassword">密码</label>
                        <input type="password" class="form-control" id="changePassword" placeholder="Password" name="password" onchange="check_notnull()">
                    </div>

                    <div class="form-group" style="width: 50%;">
                        <label for="changeHeadImg">更换头像</label>
                        <input type="file" id="changeHeadImg" onchange="check_notnull()" name="headImg" accept="image/jpeg,imgae/png" >
                        <p class="help-block">Choose a profile picture.</p>
                    </div>

                    <button type="submit" id="saveBtn" class="btn btn-default">保存修改</button>
                </form>
            </div>

            <div id="tab7" class="tab-pane">
                <span name="my_video_title"><i id="ManuScript_Manager"></i>稿件管理</span>
                <ul id="ManuScripts">
                    <c:forEach items="${videoList}" var="manus">
                        <c:forEach items="${manus.videos}" var="mv">
                    <li>
                        <img name="Manu_imgs" src="${pageContext.request.contextPath}/img/${mv.vImage}">
                        <div name="Manu_info">
                            <input name="Manu_title" value="${mv.vname}" class="form-control" disabled="disabled" />
                            <span name="Manu_type" style="margin-left:10px ;" >
                                <c:forEach items="${types}" var="v_type">
                                    <c:if test="${v_type.typeId == mv.typeId}" >
                                        ${v_type.typename}
                                    </c:if>
                                </c:forEach>
                            </span><br>
                            <span name="Manu_date" style="margin-left:10px ;">${mv.vtime}</span>
                        </div>
                        <div name="edit_Manu_btns">
                            <input type="hidden" value="${mv.vid}">
                            <button class="btn btn-info" onclick="edit_title(this)" >编辑视频信息</button>
                            <br><br><br><br><br>
                            <button class="btn btn-danger" onclick="deleteManu_Video(this)">删除稿件</button>
                        </div>
                    </li>
                        </c:forEach>
                    </c:forEach>
                </ul>
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
                        <label for="vsrc" class="control-label">视频文件</label>
                        <input class="form-control"  type="file" id="vsrc" name="upfile"  multiple="multiple" />
                    </div>

                    <div class="form-group">
                        <label class="control-label">请选择封面</label>
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




</body>
<script type="text/javascript">
    $(document).ready(function () {
        $("#saveBtn").attr("disabled","disabled");

    });
    function ajaxValidate() {

        var username=$("#changeUserName").val();

        $.ajax({
            type:"POST",
            url:"${pageContext.request.contextPath}/checkUserName.do",//提交地址
            data:"username="+username,//提交数据
            dataType:"json",//返回json格式
            //contentType:"application/json;charset=utf-8",
            success:function(data){
                if ("no" == data.info ) {//后端传来的msg的值是no,不能注册。反之。
                    $("#remind").html("<b style='color:red'>该用户名被注册，请更换！</b>");
                }if("yes" == data.info){
                    $("#remind").html("<b style='color: green;'>该用户名可用</b>");//如果没有被注册，提示可用
                }
                if("${user.username}" == username)  //如果没有修改名称
                {
                    $("#remind").html("");//提示语清空。
                }
            }
        });
    }

    function check_notnull() {
        var username=$("#changeUserName").val();
        var pwd = $("#changePassword").val();
        var headImg = $("#changeHeadImg").val();
        if(username=="" || username==null || pwd=="" || pwd==null || headImg=="" || headImg==null)
        {
            $("#saveBtn").attr("disabled","disabled");
        }
        else
        {
            $("#saveBtn").removeAttr("disabled");
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
                    var $parent = $(obj.parentNode);
                    $parent.hide(200);
                    $("input[name='fansId'][value="+val_uid+"]")
                        .next().attr("onclick","addFollow(this)")
                        .removeAttr("disabled")
                        .attr("name","add_fans")
                        .html("<i class='glyphicon glyphicon-plus'></i>关注");
                }
                if("no" == data.info)
                {
                    alert("取消关注失败");
                }
            }
        });
    }

    function addFollow(obj) {   //关注 (X)

        var fansId= obj.previousElementSibling.value;
        var my_uid = ${user.userid};
        $.ajax({
            type:"POST",
            url:"${pageContext.request.contextPath}/addFollow.do",
            data:"fansId="+fansId+"&myid="+my_uid,
            dataType:"json",
            success:function (data) {
                if("yes" == data.info)
                {
                    var cancel = "<i class='glyphicon glyphicon-ban-circle' style='color: red;'></i>取消关注";
                    var followed ="<i class='glyphicon glyphicon-ban-circle' style='color: red;'></i>已关注";
                    /*点击关注后，加入关注列表*/
                    var $p = $(obj).parent().clone(true);   // 复制要关注的用户，并改变其按钮
                    $p.children("button[name='add_fans']").attr("onclick","deleteFollow(this)");
                    $p.children("button[name='add_fans']").html(cancel);    // 要加入关注列表的按钮本身变更状态为：取消关注


                    $("#follow_list").append($p);  //加入已隔壁的关注列表
                    $(obj).attr("disabled","disabled").html(followed);  //obj 按钮本身变更状态为：已关注
                }
                if("no" == data.info)
                {
                    alert("关注失败");
                }
            }
        });
    }

    function edit_title(obj)
    {
        var Maun_type_style = "width:80px;height: 34px;background-color: #fff;padding: 6px 12px;"
            +"background-image: none;border: 1px solid #ccc;"
            +"border-radius: 4px;-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);"
            +"box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);"
            +"-webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;"
            +"-o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;"
            +"transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;";

        $(obj).parent().prev().children("input[name='Manu_title']").removeAttr("disabled").css({"border":"1px solid gainsboro"});

        $(obj).parent().prev().children("span[name='Manu_type']").html("<select style='"+Maun_type_style+"' >"
            +"<c:forEach items='${types}' var='t'>"
            +"<option id='${t.typeId}'>${t.typename}</option>"
            +"</c:forEach></select>");

        $(obj).html("保存");
        $(obj).attr("onclick","save_title(this)");
    }

    function save_title(obj)
    {
        var vname = $(obj).parent().prev().children("input[name='Manu_title']").val();  //获取 vname
        var manu_type_val = $(obj).parent().prev().children("span[name='Manu_type']").children().val(); // 获取value
        var manu_type_id =  $(obj).parent().prev().children("span[name='Manu_type']").find("select option:checked").attr("id"); //获取ID
        var vid = $(obj).prev().val();  //获取vid

        /*更改视频信息：vname & typeid*/
        $.ajax({
            type:"POST",
            url:"${pageContext.request.contextPath}/update_vname_typeid.do",
            data:"vname="+vname+"&typeid="+manu_type_id+"&vid="+vid,
            dataType:"json",
            success:function (data) {
                if("yes" == data.info)
                {
                    alert("ajax..success");
                    $(obj).parent().prev().children("input[name='Manu_title']").attr("disabled","disabled").css("border","none").val(vname); // input禁用
                    $(obj).parent().prev().children("span[name='Manu_type']").html(manu_type_val);  //更新视频类型
                    $(obj).html("编辑视频信息");
                    $(obj).attr("onclick","edit_title(this)");
                }
                if("no" == data.info)
                {
                    alert("更改失败");
                }
            }
        });
    }

    function deleteManu_Video(obj) {
        var flag = confirm("确认删除稿件？");
        if(flag == true){
            var vid = $(obj).parent().children(":first-child").val();
            $.ajax({
                type:"POST",
                url:"${pageContext.request.contextPath}/deleteManu_Video.do",
                data:"vid="+vid,
                dataType:"json",
                success:function (data) {
                    if("yes" == data.info)
                    {
                        $(obj).parent().parent().hide(200);
                    }
                    if("no" == data.info)
                    {
                        alert("删除稿件失败");
                    }
                }
            });
        }
    }
    
</script>
</html>
