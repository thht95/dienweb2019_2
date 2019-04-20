<%@ Page Language="C#" MasterPageFile="~/Site_Admin.Master" AutoEventWireup="true" CodeBehind="Admin_tau.aspx.cs" Inherits="Webbanvetau.Admin_tau" %>

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
		<h1 align="center">Quản lý Tàu</h1>
        <table cellpadding="0" cellspacing="0" class="style_admin" align="center">
            <table cellpadding="0" cellspacing="0"  >
                <tr>
                    <td class="style_cot1_3">
                        Tàu
                    </td>
                    <td class="style3_nhap">
                        <asp:TextBox ID="txtTau" runat="server"></asp:TextBox>&nbsp;&nbsp;
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Vui lòng nhập vào trường này!" Text="Vui lòng nhập vào trường này!" Display="Dynamic" ControlToValidate="txtTau" SetFocusOnError="True" ValidationGroup="vgg"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style_cot1_3">
                        Giá tàu
                    </td>
                    <td class="style3_nhap">
                        <asp:TextBox ID="txtGia" runat="server"></asp:TextBox>x1000
                    </td>
                    <td> 
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Vui lòng nhập vào trường này!" Text="Vui lòng nhập vào trường này!" Display="Dynamic" ControlToValidate="txtGia" SetFocusOnError="True" ValidationGroup="vgg"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Vui lòng nhập chữ số vào trường này!" Type="Integer" ValidationGroup="vgg" ValueToCompare="0" SetFocusOnError="True" Operator="GreaterThanEqual" ControlToValidate="txtGia" Text="Vui lòng nhập chữ số vào trường này!"></asp:CompareValidator>
                    </td>
                </tr>
                <tr>       
                <asp:HiddenField id="message" runat="server" />
                </tr>
                <tr>
                    <td colspan="3"  >
                        <asp:Label ID="lberror" runat="server" ForeColor="Red"></asp:Label>
                        <asp:Label ID="lbSuccess" runat="server" ForeColor="Blue"></asp:Label>
                            <br />
                        <asp:Button ID="btnthem" runat="server" Text="Thêm tàu" OnClick="btnthem_Click" ValidationGroup="vgg" />  &nbsp;&nbsp;  
                        <asp:Button ID="btnsua" runat="server" Text="Sửa tàu" OnClick="btnsua_Click"/>  &nbsp;&nbsp;
                            &nbsp;&nbsp;                                         
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <h2 style="  padding-top: 12px;">DANH SÁCH TÀU</h2>
                    <h2>
                        <asp:TextBox  ID="txtTimkiem" runat="server"></asp:TextBox><asp:Button ID="btnTimkiem" runat="server" Text="Tìm" OnClick="btnTimkiem_Click" />
                    </h2><br />
                              
                        <asp:GridView ID="grv_sp" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White" runat="server" AllowPaging="True" AutoGenerateColumns="False" EnableModelValidation="true" OnRowCommand="grv_sp_RowCommand" PageSize="10" OnPageIndexChanging="grv_sp_PageIndexChanging" OnRowDataBound="grv_sp_RowDataBound" OnSelectedIndexChanged="grv_sp_SelectedIndexChanged" >
                            <Columns>
                            <asp:TemplateField HeaderText="#">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMatau" runat="server" Text='<%# Bind("matau") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lMatau" runat="server" Text='<%# Bind("matau") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tên tàu">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTentau" runat="server" Text='<%# Bind("tentau") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lTentau" runat="server" Text='<%# Bind("tentau") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Giá tiền">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtGiatien" runat="server" Text='<%# Bind("giatien") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lGiatien" runat="server" Text='<%# Bind("giatien") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Xử lý">
                                <ItemTemplate>
                                    <asp:ImageButton ID="IBT_sua" runat="server" CommandName="sua"  CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                                            ImageUrl="~/Anh/sua.png" CssClass="anhxuly"  />          
                                    <asp:ImageButton ID="IBT_xoa" runat="server" CommandName="xoa"  CommandArgument='<%# Eval("matau") %>'
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
</div>  
</asp:Content>
