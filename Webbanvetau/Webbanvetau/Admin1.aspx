<%@ Page Language="C#" MasterPageFile="~/Site_Admin.Master" AutoEventWireup="true" CodeBehind="Admin1.aspx.cs" Inherits="Webbanvetau.Admin1" %>

<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
<style type="text/css">
    .style1{color:Green;}
    
</style>
<table width="100%" bgcolor="#66FF99" border="1px">
    <tr>
        <td align="left" colspan="2">
            Chào mừng đến với Trang Quản Trị của <span class="style1">VietOpenTour</span></td>
    </tr>
    <tr>
        <td align="left">
            Tổng số vé : 
            <asp:Label ID="lbToTalMenu" runat="server" Text=""></asp:Label></td>
        <td align="left">
            Tổng số vé chưa thanh toán : 
            <asp:Label ID="lbToTalLoaiTin" runat="server" Text=""></asp:Label></td>
    </tr>
    <tr>
        <td align="left">
            Tổng số vé chưa thanh toán : 
            <asp:Label ID="lbToTalTour" runat="server" Text=""></asp:Label></td>
        <td align="left">
            Tổng số Tỉnh : 
            <asp:Label ID="lbToTalTinh" runat="server" Text=""></asp:Label></td>
    </tr>
    <tr>
        <td align="left">
            Tổng số Tin đã đăng : 
            <asp:Label ID="lbToTalTin" runat="server" Text=""></asp:Label></td>
        <td align="left">
            Tổng số Liên hệ : 
            <asp:Label ID="lbToTalLienHe" runat="server" Text=""></asp:Label></td>
    </tr>
    <tr>
        <td align="left">
            Tổng số Vé đã đặt : 
            <asp:Label ID="lbToTalVeDat" runat="server" Text=""></asp:Label></td>
        <td align="left">
            Tổng số Quảng Cáo : 
            <asp:Label ID="lbToTalQC" runat="server" Text=""></asp:Label></td>
    </tr>
</table>
</asp:Content>
