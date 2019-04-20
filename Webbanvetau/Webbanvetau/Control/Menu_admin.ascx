<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Menu_admin.ascx.cs" Inherits="Webbanvetau.Control.Menu_admin" %>
<style type="text/css">
    .style1_menu_admin {
        width: 230px;
        height:100%;
        background-color:#e5e198;
        color:#6f2804;
        font-family:'Times New Roman';
        border:dashed;
    }
    .style2_text {
        margin-left:20px;
    }
    .style3_dong1 {
        height: 30px;
        background-color:#e5e4cf;
    }
    .style3_dong2 {
        height:30px;
        background-color:#eae46c;
    }
     a:hover {
        color:#ff6a00;
     }

    div#wraper {
    margin: 40px auto;
    line-height: 2em;
    font-family: helvetica, arial, tahoma;
    font-size: 12px;
    margin: 0; padding: 0;
    }

    div#mainNav {
    width: 200px;
    margin: 0; padding: 0
    }

    div#mainNav h1 {
    font-size: 14px;
    background: #3883cc;
    color: white;
    text-align: center;
    -moz-border-radius: 5px 5px 0px 0px;
    margin: 0; padding: 0
    }

    div#mainNav ul {
    list-style: none;
    border: 1px solid #bccbd8;
    margin: 0; padding: 0
    }

    div#mainNav ul li {
    position: relative;
    border-bottom: 1px solid #bccbd8;
    margin: 0; padding: 0;
    background:#e6e6e6;
    }
    div#mainNav ul li:hover {
    background:#75A8DB
    }

    div#mainNav ul li a {
    color: #1e5b7e;
    text-decoration: none;
    padding: 5px;
    margin: 0; padding: 0;
    padding-left:10px
    }

    div#mainNav ul li a:hover {
    text-decoration: underline;
    }

    div#mainNav ul li ul {
    position: absolute;
    top: -1px;
    left: 198px;
    display: none;
    margin: 0; padding: 0
    }

    div#mainNav ul li:hover ul {
    display: block;
    width: 100%;
    margin: 0; padding: 0
    }
</style>

<script>
    var someSession = '<%= Session["TAIKHOAN"].ToString() %>';
    $(document).ready(function () {
        if (someSession == "admin") {
            $('li#qlv').show();
            $('li#qllt').show();
            $('li#qltau').show();
            $('li#qlkh').show();
            $('li#qltk').show();
        }
        if (someSession == "qllichtrinh") {
            $('li#qlv').hide();
            $('li#qllt').show();
            $('li#qltau').hide();
            $('li#qlkh').hide();
            $('li#qltk').hide();
        }
        if (someSession == "qltau") {
            $('li#qlv').hide();
            $('li#qllt').hide();
            $('li#qltau').show();
            $('li#qlkh').hide();
            $('li#qltk').hide();
        }
        if (someSession == "qlve") {
            $('li#qlv').show();
            $('li#qllt').hide();
            $('li#qltau').hide();
            $('li#qlkh').show();
            $('li#qltk').hide();
        }
     });
</script>

<div id="wraper">
		<div id="mainNav">
			<h1>Main Menu</h1>
			<ul id="nav"> 
			  <!--<li><asp:HyperLink ID="hpTrangchu" runat="server" CssClass="style2_text" NavigateUrl="~/Admin_lsp.aspx">Trang chủ &raquo;</asp:HyperLink></li>-->
			  <li id="qlv"><asp:HyperLink ID="hpVetau" runat="server" CssClass="style2_text" NavigateUrl="~/Admin.aspx">Quản Vé tàu &raquo;</asp:HyperLink></li>
                <script src="../Scripts/jquery-1.7.1.min.js"></script>
              <!--<li ><a href="#">Quản Vé tàu &raquo;</a> 
			    <ul> 
			      <li><asp:HyperLink ID="hpVe" runat="server" CssClass="style2_text" NavigateUrl="~/Admin.aspx">Vé</asp:HyperLink></li> 
			      <li><asp:HyperLink ID="hpBanggia" runat="server" CssClass="style2_text" NavigateUrl="~/Admin_lsp.aspx">Bảng giá</asp:HyperLink></li>
			    </ul> 
			  </li> -->


			  <li id="qllt"><a href="#">Quản lý lịch trình &raquo;</a> 
			    <ul> 
                  <li><asp:HyperLink ID="hpLichtrinh" runat="server" CssClass="style2_text" NavigateUrl="~/Admin_chuyentau.aspx">Lịch trình</asp:HyperLink></li>
			      <li><asp:HyperLink ID="hpGatau" runat="server" CssClass="style2_text" NavigateUrl="~/Admin_ga.aspx">Ga tàu</asp:HyperLink></li> 
			      <li><asp:HyperLink ID="hpThanhpho" runat="server" CssClass="style2_text" NavigateUrl="~/Admin_tinh.aspx">Thành phố</asp:HyperLink></li>
			    </ul> 
			  </li> 

			  <li id="qltau"><a href="#">Quản lý tàu &raquo;</a> 
			    <ul> 
                  <li><asp:HyperLink ID="hpTau" runat="server" CssClass="style2_text" NavigateUrl="~/Admin_tau.aspx">Tàu</asp:HyperLink></li>
			      <li><asp:HyperLink ID="hpLoaitoa" runat="server" CssClass="style2_text" NavigateUrl="~/Admin_ltoa.aspx">Loại toa</asp:HyperLink></li> 
			      <li><asp:HyperLink ID="hpToatau" runat="server" CssClass="style2_text" NavigateUrl="~/Admin_toa.aspx">Toa tàu</asp:HyperLink></li>
                  <li><asp:HyperLink ID="hpghe" runat="server" CssClass="style2_text" NavigateUrl="~/Admin_ghe.aspx">Ghế</asp:HyperLink></li>
			    </ul> 
			  </li>

              <li id="qlkh"><a href="#">Quản lý khác hàng&raquo;</a> 
			    <ul> 
                  <li><asp:HyperLink ID="hpKhach" runat="server" CssClass="style2_text" NavigateUrl="~/Admin_kh.aspx">Khách</asp:HyperLink></li>
                  <li><asp:HyperLink ID="hpLoaikhach" runat="server" CssClass="style2_text" NavigateUrl="~/Admin_lk.aspx">Loại khách</asp:HyperLink></li>
			    </ul> 
			  </li>

              <li id="qltk"><asp:HyperLink ID="hpTaikhoan" runat="server" CssClass="style2_text" NavigateUrl="~/Admin_taikhoan.aspx">Quản lý tài khoản &raquo;</asp:HyperLink></li> 
              
              <li><asp:HyperLink ID="hpDangxuat" runat="server" CssClass="style2_text" NavigateUrl="~/Login.aspx">Đăng xuất &raquo;</asp:HyperLink></li>
			</ul> 

			
		</div><!--End #mainNav-->
		
</div><!--End #wrapper-->
