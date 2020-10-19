<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <title></title>
    <style type="text/css">
        body { font-family: Arial; font-size: 10pt; }
        #dialog { height: 600px; overflow: auto; font-size: 10pt !important; font-weight: normal !important; background-color: #FFFFC1; margin: 10px; border: 1px solid #ff6a00; }
        #dialog div { margin-bottom: 15px; }
    </style>
         <script type = "text/javascript">
         jQuery.curCSS = function (element, prop, val) {
             return jQuery(element).css(prop, val);
         };
         function ShowFileName() {
             var dpf = $("#File1").val().split('\\').pop();
             var checksum = $("#File2").val().split('\\').pop();
            $.ajax({
                type: "POST",
                url: "Default.aspx/GetFileName",
                //data: '{DPF: "' + $("#<%=txtUserName.ClientID%>")[0].value + '"}',
                data: '{DPF: "' + dpf + '",CHECKSUM: "' + checksum + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function(response) {
                    var exception = JSON.parse(xhr.responseText);
                    alert(exception.Message);
                },
                error: OnError
                    //alert(exception.Message);
            });
        }
        function OnSuccess(response) {
            alert(response.d);
        }
        function OnError(xhr, errorType, exception) {
            var responseText;
            $("#dialog").html("");
            try {
                responseText = jQuery.parseJSON(xhr.responseText);
                $("#dialog").append("<div><b>" + errorType + " " + exception + "</b></div>");
                $("#dialog").append("<div><u>Exception</u>:<br /><br />" + responseText.ExceptionType + "</div>");
                $("#dialog").append("<div><u>StackTrace</u>:<br /><br />" + responseText.StackTrace + "</div>");
                $("#dialog").append("<div><u>Message</u>:<br /><br />" + responseText.Message + "</div>");
            } catch (e) {
                responseText = xhr.responseText;
                $("#dialog").html(responseText);
            }
            $("#dialog").dialog({
                title: "jQuery Exception Details",
                width: 700,
                buttons: {
                    Close: function () {
                        $(this).dialog('close');
                    }
                }
            });
        }
    </script>
</head>

<body>
    <form id="form1" runat="server">
    <div>
    File Name :
    <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
    <input id="File1" type="file" />
    <br />
    Checksum Name :
    <br />
    <input id="File2" type="file" />
    <input id="btnGetTime" type="button" value="GetFileName"
        onclick = "ShowFileName()" />
    <div id="dialog" style="display: none"></div>
    </div>
    </form>
</body>

</html>
