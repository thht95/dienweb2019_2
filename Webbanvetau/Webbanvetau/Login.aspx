<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Webbanvetau.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Đăng Nhập Quản Trị</title>
    <link rel="Stylesheet" type="text/css" href="../mycss/basicdn.css" />
    <link rel="Shortcut Icon" type="icon/x-icon" href="../images/logourl.png" />
    <style>
        .login{
            background: #D9D9D9;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <table align="center" class="login" id="main">
            <div style="padding:80px;">
                <tr >
                    <td style="padding-top:20px; padding-left:20px; padding-right:20px" align="center" colspan="2" class="tieude">
                    ĐĂNG NHẬP QUẢN TRỊ&nbsp;</td>
                </tr>
                <tr>
                    <td style="padding-left:20px" align="right" class="dn">
                        User :
                    </td>
                    <td>
                        <asp:TextBox ID="txtdangnhap" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                            ControlToValidate="txtdangnhap" ErrorMessage="Chưa nhập tên đăng nhập">(*)</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td align="right" class="dn">
                        Pass :
                    </td>
                    <td>
                        <asp:TextBox ID="txtmatkhau" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                            ControlToValidate="txtmatkhau" ErrorMessage="Chưa nhập mật khẩu">(*)</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;</td>
                    <td>
                        <asp:Button ID="btdangnhap" runat="server" Text="Đăng Nhập" OnClick="btdangnhap_Click" 
                            />
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;</td>
                    <td>
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
                        <br />
                        <asp:Label ID="lbBaoLoi" runat="server"></asp:Label>
                    </td>
                </tr>
            </div>
        </table>
    </form>
</body>
<script type="text/javascript" src="../Scripts/jquery-core.js"></script>
<!-- Page Scripts -->
<!--<script type="text/javascript">
    jQuery("document").ready(function () {
        jQuery("#txtdangnhap").focus(function () {
            if (jQuery(this).val() == "Tên Đăng Nhập") {
                jQuery(this).val("");
            }
        });
        jQuery("#txtdangnhap").blur(function () {
            if (jQuery(this).val() == "") {
                jQuery(this).val("Tên Đăng Nhập");
            }
        });
        jQuery("#txtmatkhau").focus(function () {
            if (jQuery(this).val() == "Password") {
                jQuery(this).val("Password");
            }
        });
        jQuery("#txtmatkhau").click(function () {
            if (jQuery(this).val() == "Password") {
                jQuery(this).val("");
            }
        });
        jQuery("#txtmatkhau").blur(function () {
            if (jQuery(this).val() == "") {
                jQuery(this).val("Password");
            }
        });
    });
</script>-->
</html>
