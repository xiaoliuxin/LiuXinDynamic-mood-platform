$(document).ready(function()
{
    $("#register").on('click',function()
    {
        $("#cancel").trigger("click");
        $("#toRegister").trigger("click");
    });

    $(".talk_line").hover(function()
        {
            $(this).find("button[name='deleteMess']").show();
        },
        function()
        {
            $(this).find("button[name='deleteMess']").hide();
        });
})
