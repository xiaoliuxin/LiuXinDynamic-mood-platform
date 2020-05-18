$(document).ready(function()
{
	$("#registerBtn").attr("disabled","disabled");

	$("#register").on('click',function()
	{
		$("#cancel").trigger("click");
		$("#toRegister").trigger("click");
	});



})
