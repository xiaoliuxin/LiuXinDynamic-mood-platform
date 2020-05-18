$(document).ready(function()
{
    $("#register").on('click',function()
    {
        $("#cancel").trigger("click");
        $("#toRegister").trigger("click");
    });

    $("#content input").on("focus",function()
    {
        $(this).css("background","white");
        $("#changeContent").css("display","inline");
    });

    $("#changeContent").on("click",function()
    {
        $(this).css("display","none");
        $("#content input").css("background","none");
    });


    $("#follow_list li").hover(function()
    {
        $(this).find("button").css("display","block");
    },function()
    {
        $(this).find("button").css("display","none");
    });

    $("#fans_list li").hover(function()
    {
        $(this).find("button").css("display","block");
    },function()
    {
        $(this).find("button").css("display","none");
    });

    $("#ManuScripts li").hover(function()
    {
        $(this).find("div[name='edit_Manu_btns']").show(200);
    },function()
    {
        $(this).find("div[name='edit_Manu_btns']").hide(200);
    });

})


