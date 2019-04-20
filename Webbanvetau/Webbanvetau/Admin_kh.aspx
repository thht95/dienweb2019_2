<%@ Page Language="C#" MasterPageFile="~/Site_Admin.Master" AutoEventWireup="true" CodeBehind="Admin_kh.aspx.cs" Inherits="Webbanvetau.Admin_kh" %>

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
    <h1 align="center">Quản lý khách hàng</h1>  
        <table cellpadding="0" cellspacing="0" class="style_admin" align="center">
            <table cellpadding="0" cellspacing="0">
                <tr class="style_cot1_3">
                    <td>
                        Họ tên
                    </td>
                    <td class="style3_nhap">
                        <asp:TextBox ID="txtHoten" runat="server"></asp:TextBox>&nbsp;&nbsp;
                        </td>
                    <td>
                        Loại khách</td>
                    <td>
                        <asp:DropDownList ID="ddlLoaikh"  runat="server" Height="20px" Width="152px" AppendDataBoundItems="true" AutoPostBack="True">
                                    
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        CMND
                    </td>
                    <td class="style3_nhap">
                        <asp:TextBox ID="txtCmnd" runat="server"></asp:TextBox>
                    </td>
                    <td>Giới tính</td>
                    <td class="style3_nhap">
                        <asp:RadioButton ID="rdbNam" runat="server" Text="Nam" GroupName="gioitinh"/>
                        <asp:RadioButton ID="rdbNu" runat="server" Text="Nữ"  GroupName="gioitinh"/>
                    </td>
                </tr>
                <tr>
                    <td>Email</td>
                    <td class="style3_nhap">
                        <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                    </td>
                    <td>Số điện thoại</td>
                    <td class="style3_nhap">
                        <asp:TextBox ID="txtSdt" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <asp:HiddenField id="hdtest" runat="server" />
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Label ID="lberror" runat="server" ForeColor="Red"></asp:Label>
                        <asp:Label ID="lbSuccess" runat="server" ForeColor="Blue"></asp:Label>
                            <br />
                        <asp:Button ID="btnOk" runat="server" Text="Thêm khách hàng" OnClick="btnOk_Click"/>  &nbsp;&nbsp;  
                        <asp:Button ID="btnsua" runat="server" Text="Sửa khách hàng" OnClick="btnsua_Click"/>  &nbsp;&nbsp;
                            &nbsp;&nbsp;
                                                                
                    </td>
                </tr>
                <tr>
                    <td colspan="4">

                        <h2>DANH SÁCH KHÁCH HÀNG</h2>
                    <h2>
                        <asp:DropDownList ID="dlSort" runat="server" OnSelectedIndexChanged="dlSort_SelectedIndexChanged" AutoPostBack="True">
                        </asp:DropDownList>
                        <asp:TextBox  ID="txtTimkiem" runat="server"></asp:TextBox><asp:Button ID="btnTimkiem" runat="server" Text="Tìm" OnClick="btnTimkiem_Click" />
                    </h2>
                              
                        <asp:GridView ID="grv_sp" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White" runat="server" AllowPaging="True" AutoGenerateColumns="False" EnableModelValidation="true" OnRowCommand="grv_sp_RowCommand" PageSize="10" OnPageIndexChanging="grv_sp_PageIndexChanging" OnRowDataBound="grv_sp_RowDataBound" >
                            <Columns>
                            <asp:TemplateField HeaderText="Mã loại">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMa" runat="server" Text='<%# Bind("maloaikhach") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbMa" runat="server" Text='<%# Bind("maloaikhach") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mã khách">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMasp" runat="server" Text='<%# Bind("makh") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbMasp" runat="server" Text='<%# Bind("makh") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tên khách">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTensp" runat="server" Text='<%# Bind("hoten") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbHoten" runat="server" Text='<%# Bind("hoten") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Giới tinh">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtGioitinh" runat="server" Text='<%# Bind("gioitinh") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbGioitinh" runat="server" Text='<%# Bind("gioitinh") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="CMND">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("cmnd") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbCmnd" runat="server" Text='<%# Bind("cmnd") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Email">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("email") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbEmail" runat="server" Text='<%# Bind("email") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SĐT">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("sdt") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbSdt" runat="server" Text='<%# Bind("sdt") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                                <asp:TemplateField HeaderText="Xử lý">
                                <ItemTemplate>
                                    <asp:ImageButton ID="IBT_sua" runat="server" CommandName="sua"  CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                                            ImageUrl="~/Anh/sua.png" CssClass="anhxuly"  />          
                                    <asp:ImageButton ID="IBT_xoa" runat="server" CommandName="xoa"  CommandArgument='<%# Eval("makh") %>'
                                            ImageUrl="~/Anh/xoa.png" CssClass="anhxuly" OnClientClick="return confirm('Bạn có chắc muốn xóa sản phẩm này không');" />                            
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
            </table>
        </table>
</asp:Content>
