<%@ Page Language="C#" MasterPageFile="~/Site_Admin.Master" AutoEventWireup="true" CodeBehind="Admin_taikhoan.aspx.cs" Inherits="Webbanvetau.Admin_taikhoan" %>

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

         .auto-style1 {
             width: 312px;
             height: 40px;
         }
         .auto-style2 {
             width: 312px;
         }

    </style>

</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
 <h1 align="center">Quản lý tài khoản</h1>         
        <table cellpadding="0" cellspacing="0" class="style_admin" align="center">
            <table cellpadding="0" cellspacing="0">
                <tr>
                    <td class="style_cot1_3">
                        Tài khoản
                    </td>
                    <td class="auto-style1">
                        <asp:TextBox ID="txtTaikhoan" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator Display="Dynamic" ID="rfvTaikhoan" runat="server" ControlToValidate="txtTaikhoan"
                                ErrorMessage="Không được để rỗng" ></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style_cot1_3">
                        Mật khẩu
                    </td>
                    <td class="auto-style2">
                        <asp:TextBox ID="txtMatkhau" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator Display="Dynamic" ID="rfvMatkhau" runat="server" ControlToValidate="txtMatkhau"
                                ErrorMessage="Không được để rỗng" ></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style_cot1_3">
                        Quyền hạn
                    </td>
                    <td class="auto-style2">
                        <asp:DropDownList ID="ddlQuyenhan"  runat="server" Height="20px" Width="152px" AppendDataBoundItems="true" AutoPostBack="True">
                                    
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator Display="Dynamic" ID="rfvQuyen" runat="server" ControlToValidate="ddlQuyenhan"
                                ErrorMessage="Chưa chọn quyền" InitialValue="--Chọn ghế--" Text="Chưa chọn quyền"></asp:RequiredFieldValidator>
                    </td>
                </tr> 
                <tr> 
                    <asp:HiddenField id="hdtest" runat="server" />
                    <asp:HiddenField id="hdTaikhoan" runat="server" />
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lberror" runat="server" ForeColor="Red"></asp:Label>
                        <asp:Label ID="lbSuccess" runat="server" ForeColor="Blue"></asp:Label>
                            <br />
                        <asp:Button ID="btnthem" runat="server" Text="Thêm tài khoản" OnClick="btnthem_Click" />  &nbsp;&nbsp;  
                        <asp:Button ID="btnsua" runat="server" Text="Sửa tài khoản" OnClick="btnsua_Click"/>  &nbsp;&nbsp;
                            &nbsp;&nbsp;
                                                                
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <h2 style="  padding-top: 12px;">DANH SÁCH TÀI KHOẢN</h2>
                    <h2>
                        <asp:TextBox  ID="txtTimkiem" runat="server"></asp:TextBox><asp:Button ID="btnTimkiem" runat="server" Text="Tìm" OnClick="btnTimkiem_Click" />
                    </h2>
                        <br />      
                        <asp:GridView ID="grv_sp" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White" runat="server" AllowPaging="True" AutoGenerateColumns="False" EnableModelValidation="true" OnRowCommand="grv_sp_RowCommand" PageSize="5" OnPageIndexChanging="grv_sp_PageIndexChanging" OnRowDataBound="grv_sp_RowDataBound" >
                            <Columns>
                            <asp:TemplateField HeaderText="Mã quyền hạn">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMaquyenhan" runat="server" Text='<%# Bind("maquyenhan") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lMaquyenhan" runat="server" Text='<%# Bind("maquyenhan") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mã tài khoản">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMatk" runat="server" Text='<%# Bind("mataikhoan") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lMatk" runat="server" Text='<%# Bind("mataikhoan") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tài khoản">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("taikhoan") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lTaikhoan" runat="server" Text='<%# Bind("taikhoan") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mật khẩu">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("matkhau") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lMatkhau" runat="server" Text='<%# Bind("matkhau") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Quyền">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtQuyen" runat="server" Text='<%# Bind("quyenhan") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lQuyen" runat="server" Text='<%# Bind("quyenhan") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Xử lý">
                                <ItemTemplate>
                                    <asp:ImageButton ID="IBT_sua" runat="server" CommandName="sua" CausesValidation="false"  CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                                            ImageUrl="~/Anh/sua.png" CssClass="anhxuly"  />          
                                    <asp:ImageButton ID="IBT_xoa" runat="server" CommandName="xoa" CausesValidation="false" CommandArgument='<%# Eval("mataikhoan") %>'
                                            ImageUrl="~/Anh/xoa.png" CssClass="anhxuly" OnClientClick="return confirm('Bạn có chắc muốn xóa ghế này không');" />                            
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

