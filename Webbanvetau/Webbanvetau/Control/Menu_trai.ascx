<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Menu_trai.ascx.cs" Inherits="Webbanvetau.Control.Menu_trai" %>
<style type="text/css">
     .style_menutrai {
            width:250px;
            height:100%;
        }
    .style_quanao {
        color: #993300;
        font-family:'Times New Roman';
        font-size:medium;
    }
    .style_loai {
        color: #993300;
        margin-left:15px;
        font-family:'Times New Roman';
        background-repeat:no-repeat;
    }
    .style_danhmuc {
        background-image:url('Anh/the h2.png');
        background-repeat:no-repeat;
        color:#fff;
        color: #fff;
        height: 40px;
        text-align:center;

    }
    a:hover {
        color:#ff6a00;
     }

    .auto-style1
    {
        background-image: url('Anh/the%20h2.png');
        background-repeat: no-repeat;
        color: #fff;
        color: #fff;
        height: 40px;
        text-align: center;
        width: 180px;
    }
    .auto-style2
    {
        width: 180px;
    }

</style>


<table class="style_menutrai" style="border-right-style: dotted; border-color: #FFCC66; border-width: thin; margin:auto;">
    <tr>
        <td>
            Thông tin hành trình
            <p>Ga đi</p>
            <asp:DropDownList ID="dropGadi" runat="server"></asp:DropDownList>
            <p>Ga đến</p>
            <asp:DropDownList ID="dropGaden" runat="server" AutoPostBack="True"></asp:DropDownList>
            <p>Ngày đi</p>
            <asp:Calendar ID="caleNgaydi" runat="server" SelectedDate="<%# DateTime.Now %>"></asp:Calendar>
            <br />
            <asp:Button ID="btTimKiem" runat="server" Text="Tìm Kiếm" CausesValidation="False" OnClick="btTimKiem_Click" />
        </td>
    </tr>
    <tr>
        <td class="auto-style2">&nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style2">&nbsp;</td>
    </tr>
     <tr>
        <td class="auto-style2">&nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style2">&nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style2">&nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style2">&nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style2">&nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style2">&nbsp;</td>
    </tr>
    
</table>