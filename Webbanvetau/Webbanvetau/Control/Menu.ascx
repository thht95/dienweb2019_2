<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Menu.ascx.cs" Inherits="Webbanvetau.Control.Menu" %>
<style type="text/css">
    .style_menu {
        width: 100%;
        height: 160px;
        background:center;
        background-repeat:no-repeat;
    }
    .style_textMenu {
            color: #993300;
            font-family:'Times New Roman';
            margin-top:7px;
            text-align:center;
    }
    .style_logo {
        margin-left:165px;
        margin-top:0px
    }
    *{
        margin:0px;
        padding:0px;
    }

    .main_menu {
            background: #00A69B;
        }

            .main_menu > ul > li {
                float: left;
                padding: 11px 27px;
                position: relative;
                border-right: 1px dotted #ACACAC;
        top: 0px;
        left: -38px;
    }

                .main_menu > ul > li:last-child {
                    border-right: none;
                }

                .main_menu > ul > li > ul {
                    display: none;
                    position: absolute;
                    background: #00A69B;
                    top: 41px;
                    width: 198px;
                    left: 0px;
                    z-index:999;
                }

                .main_menu > ul > li:hover ul {
                    display: block;
                }

            .main_menu ul li:hover {
                background: #5F5C5C;
                transition: all 0.25s;
            }

            .main_menu > ul > li > ul > li {
                padding: 5px 10px;
            }

            .main_menu > ul > li > ul > li {
                border-bottom: 1px dotted #ACACAC;
            }

             #wrap{margin:0 auto;
            position:relative;}
            #menu{
                padding:5px;
                display:block;
            }
            #menu li,#menu li a, #sub li a{
                display:block;
                width:90px;
                text-align:center;
                color:#FFF;
            }
            #menu li{
                float:left;
                list-style:none;
                height:20px;
                width:100px;
                padding:0px;
                }
            #menu li a, #sub li a{
                text-decoration:none;
                padding:5px;
            }
            #sub li{
                clear:both;
                border:thin #FFF solid;
                margin-top:0px;
            }
            #menu #sub{
                visibility:hidden;
                padding:0px;
                display:block;
            }
            #menu li:hover #sub{
                visibility:visible;
                }
  
</style>

<section style="background: #eee url(../Anh/banner-top.jpg); width:960px; height:117px; margin: 0px auto;">
    <div style="width: 450px; margin-left:505px; padding-right: 11px;height: 85px;">
        <ul id="menu" style="margin-left:220px;" >
            <li> <span style="color:white;"><asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="../DangNhap.aspx">Đăng nhập </asp:HyperLink></span></li>
            <li style="width:10px;"><b style="font-family:Arial;font-size:24px;">/</b></li>
            <li><a href="#">Đăng ký</a>
                <ul id="sub">
                    <li><asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="../DangKy.aspx">Nhà hàng</asp:HyperLink></li>
                    <li><asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl="../DangKykh.aspx">Khách hàng</asp:HyperLink></li>
                </ul>
            </li>
        </ul>
        <table style="margin-top:70px">
            <tr>
                <td style="background:#09c87c; width: 110px;  height: 30px;  text-align:center">
                     <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="../TrangChu.aspx">  <span style="color:white">Trang chủ</span>  </asp:HyperLink>
                </td>
                  <td style="background: #09c87c; width: 110px;  height: 30px;  text-align:center">
                     <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="../DangNhap.aspx">  <span style="color:white">Nhà hàng</span>  </asp:HyperLink>
                </td>
                <td style="background: #09c87c; width: 110px;  height: 30px;  text-align:center">
                     <asp:HyperLink ID="HyperLink7" runat="server" NavigateUrl="../ViewCart.aspx">  <span style="color:white">Đơn hàng</span>  </asp:HyperLink>
                </td>
                  <td style="background: #09c87c; width: 110px;  height: 30px;  text-align:center">
                     <asp:HyperLink ID="HyperLink6" runat="server" NavigateUrl="../TinTuc.aspx">  <span style="color:white">Tin tức</span>  </asp:HyperLink>
                </td>
            </tr>
        </table>
            </div>
</section>

<section style="height:auto; width:960px;margin: 0px auto;">
    <div>