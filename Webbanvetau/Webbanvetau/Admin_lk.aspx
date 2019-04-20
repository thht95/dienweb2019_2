<%@ Page Language="C#" MasterPageFile="~/Site_Admin.Master" AutoEventWireup="true" CodeBehind="Admin_lk.aspx.cs" Inherits="Webbanvetau.Admin_lk" %>

<%@ Register src="Control/Menu_admin.ascx" tagname="Menu_admin" tagprefix="uc2" %>
<%@ Register src="Control/Fotder.ascx" tagname="Fotder" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style type="text/css">
        .style_admin {
            width: 100%;
        }
        .style_menu {
            width: 218px;
        }
        .style_cot1_3 {
             width: 120px;
             height:40px;
        } 
        .style3_nhap {
            width: 250px;
            height:40px;
        }

        .anh {
            width:100px;
            height:100px; 
        }
      .anhxuly {
            width:20px;
            height:20px;
        }

      #ctl00_ContentPlaceHolder1_grv_sp{
          width:100%;
      }

    </style>

</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
  <h1 align="center">Quản lý loại khách hàng</h1>        
        <table cellpadding="0" cellspacing="0" class="style_admin" align="center">
            <table cellpadding="0" cellspacing="0">
                <tr>
                    <td class="style_cot1_3">
                        Loại khách
                    </td>
                    <td class="style3_nhap">
                        <asp:TextBox ID="txtLoaikhach" runat="server"></asp:TextBox>&nbsp;&nbsp;
                    </td>
                    <td class="style_cot1_3">
                        Phần trăm giảm
                    </td>
                    <td class="style3_nhap">
                        <asp:TextBox ID="txtGiamgia" runat="server"></asp:TextBox>&nbsp;&nbsp;
                    </td>
                </tr>
                        
                <asp:HiddenField id="hdtest" runat="server" />
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Label ID="lberror" runat="server" ForeColor="Red"></asp:Label>
                        <asp:Label ID="lbSuccess" runat="server" ForeColor="Blue"></asp:Label>
                            <br />
                        <asp:Button ID="btnthem" runat="server" Text="Thêm loại khách" OnClick="btnthem_Click" />  &nbsp;&nbsp;  
                        <asp:Button ID="btnsua" runat="server" Text="Sửa loại hàng" OnClick="btnsua_Click"/>  &nbsp;&nbsp;
                            &nbsp;&nbsp;
                                                                
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <h2 style="  padding-top: 12px;">DANH SÁCH LOẠI KHÁCH HÀNG</h2>
                    <h2>
                        <asp:TextBox  ID="txtTimkiem" runat="server"></asp:TextBox><asp:Button ID="btnTimkiem" runat="server" Text="Tìm" OnClick="btnTimkiem_Click" />
                    </h2>
                              
                        <asp:GridView ID="grv_sp" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White" runat="server" AllowPaging="True" AutoGenerateColumns="False" EnableModelValidation="true" OnRowCommand="grv_sp_RowCommand" PageSize="9" OnPageIndexChanging="grv_sp_PageIndexChanging" OnRowDataBound="grv_sp_RowDataBound" >
                            <Columns>
                            <asp:TemplateField HeaderText="Mã loại">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMaloai" runat="server" Text='<%# Bind("maloaikhach") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lMaloai" runat="server" Text='<%# Bind("maloaikhach") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tên loại">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTenloai" runat="server" Text='<%# Bind("tenloaikhach") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lTenloai" runat="server" Text='<%# Bind("tenloaikhach") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Phần trăn giảm">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtPhangiam" runat="server" Text='<%# Bind("phantramgiam") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lPhangiam" runat="server" Text='<%# Bind("phantramgiam") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Xử lý">
                                <ItemTemplate>
                                    <asp:ImageButton ID="IBT_sua" runat="server" CommandName="sua"  CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                                            ImageUrl="~/Anh/sua.png" CssClass="anhxuly"  />          
                                    <asp:ImageButton ID="IBT_xoa" runat="server" CommandName="xoa"  CommandArgument='<%# Eval("maloaikhach") %>'
                                            ImageUrl="~/Anh/xoa.png" CssClass="anhxuly" OnClientClick="return confirm('Bạn có chắc muốn xóa sản phẩm này không');" />                            
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                <br />
                </td>
                </tr>
            </table>
        </table>
</asp:Content>
