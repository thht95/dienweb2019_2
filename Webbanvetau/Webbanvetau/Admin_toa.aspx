<%@ Page Language="C#" MasterPageFile="~/Site_Admin.Master" AutoEventWireup="true" CodeBehind="Admin_toa.aspx.cs" Inherits="Webbanvetau.Admin_toa" %>

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
	  #box{
         padding-left: 20px;
         }

    </style>

</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
 <div id="box">  
		<h1 align="center">Quản lý Toa tàu</h1>        
        <table cellpadding="0" cellspacing="0" class="style_admin" align="center">
            <table cellpadding="0" cellspacing="0">
               
                <tr>
                    <td class="style_cot1_3">
                        Tàu
                    </td>
                    <td>
                        <asp:DropDownList ID="ddTau"  runat="server" Height="20px" Width="152px" AppendDataBoundItems="true" AutoPostBack="false">        
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                   <td class="style3_nhap">
                        Loại toa
                    </td>
                    <td class="style_cot1_3">
                        <asp:DropDownList ID="ddltoa"  runat="server" Height="20px" Width="152px" AppendDataBoundItems="true" AutoPostBack="false">       
                        </asp:DropDownList>
                    </td>
                </tr> 
                 <tr>
                    <td class="style_cot1_3">
                        Toa tàu
                    </td>
                    <td class="style3_nhap">
                        <asp:TextBox ID="txtToa" runat="server"></asp:TextBox>&nbsp;&nbsp;
                    </td>
                </tr>       
                <asp:HiddenField id="hdtest" runat="server" />
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lberror" runat="server" ForeColor="Red"></asp:Label>
                        <asp:Label ID="lbSuccess" runat="server" ForeColor="Blue"></asp:Label>
                            <br />
                        <asp:Button ID="btnthem" runat="server" Text="Thêm toa" OnClick="btnthem_Click" />  &nbsp;&nbsp;  
                        <asp:Button ID="btnsua" runat="server" Text="Sửa toa" OnClick="btnsua_Click"/>  &nbsp;&nbsp;
                            &nbsp;&nbsp;
                                                                
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <h2 style="  padding-top: 12px;">DANH SÁCH TOA TÀU</h2>
                    <h2>
                        <asp:TextBox  ID="txtTimkiem" runat="server"></asp:TextBox><asp:Button ID="btnTimkiem" runat="server" Text="Tìm" OnClick="btnTimkiem_Click" />
                    </h2><br>
                              
                        <asp:GridView ID="grv_sp" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White" runat="server" AllowPaging="True" AutoGenerateColumns="False" EnableModelValidation="true" OnRowCommand="grv_sp_RowCommand" PageSize="9" OnPageIndexChanging="grv_sp_PageIndexChanging" OnRowDataBound="grv_sp_RowDataBound" >
                            <Columns>
                            <asp:TemplateField HeaderText="#">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMatoa" runat="server" Text='<%# Bind("matoa") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lMatoa" runat="server" Text='<%# Bind("matoa") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mã loại toa">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMaloaitoa" runat="server" Text='<%# Bind("maloaitoa") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lMaloaitoa" runat="server" Text='<%# Bind("maloaitoa") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mã tàu">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMatau" runat="server" Text='<%# Bind("matau") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lMatau" runat="server" Text='<%# Bind("matau") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tên toa">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTentoa" runat="server" Text='<%# Bind("tentoa") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lTentoa" runat="server" Text='<%# Bind("tentoa") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Loại toa">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtLtoa" runat="server" Text='<%# Bind("tenloaitoa") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lLtoa" runat="server" Text='<%# Bind("tenloaitoa") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tàu">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTau" runat="server" Text='<%# Bind("tentau") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lTau" runat="server" Text='<%# Bind("tentau") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Xử lý">
                                <ItemTemplate>
                                    <asp:ImageButton ID="IBT_sua" runat="server" CommandName="sua"  CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                                            ImageUrl="~/Anh/sua.png" CssClass="anhxuly"  />          
                                    <asp:ImageButton ID="IBT_xoa" runat="server" CommandName="xoa"  CommandArgument='<%# Eval("matoa") %>'
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