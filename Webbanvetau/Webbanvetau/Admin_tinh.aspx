<%@ Page Language="C#" MasterPageFile="~/Site_Admin.Master" AutoEventWireup="true" CodeBehind="Admin_tinh.aspx.cs" Inherits="Webbanvetau.Admin_tinh" %>

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
 <h1 align="center">Danh mục tỉnh thành</h1>         
        <table cellpadding="0" cellspacing="0" class="style_admin" align="center">
            <table cellpadding="0" cellspacing="0">
                <tr>
                    <td class="style_cot1_3">
                        Tên thành phố
                    </td>
                    <td>
                        <asp:TextBox ID="txtThanhpho" runat="server"></asp:TextBox>&nbsp;&nbsp;
                        <asp:RequiredFieldValidator ID="rfvRong" Display="Dynamic" ControlToValidate="txtThanhpho" runat="server" ErrorMessage="Không được để trống."></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>     
                <asp:HiddenField id="hdtest" runat="server" />
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lberror" runat="server" ForeColor="Red"></asp:Label>
                        <asp:Label ID="lbSuccess" runat="server" ForeColor="Blue"></asp:Label>
                            <br />
                        <asp:Button ID="btnthem" runat="server" Text="Thêm thành phố" OnClick="btnthem_Click" />  &nbsp;&nbsp;  
                        <asp:Button ID="btnsua" runat="server" Text="Sửa thành phố" OnClick="btnsua_Click"/>  &nbsp;&nbsp;
                            &nbsp;&nbsp;                                     
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <h2 style="  padding-top: 12px;">DANH SÁCH THÀNH PHỐ</h2>
                    <h2>
                        <asp:TextBox  ID="txtTimkiem" runat="server"></asp:TextBox><asp:Button ID="btnTimkiem" runat="server" Text="Tìm" OnClick="btnTimkiem_Click" />
                    </h2>
                              
                        <asp:GridView ID="grv_sp" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White" runat="server" AllowPaging="True" AutoGenerateColumns="False" EnableModelValidation="true" OnRowCommand="grv_sp_RowCommand" PageSize="4" OnPageIndexChanging="grv_sp_PageIndexChanging" OnRowDataBound="grv_sp_RowDataBound" >
                            <Columns>
                            <asp:TemplateField HeaderText="Mã thành phố">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMathanhpho" runat="server" Text='<%# Bind("matp") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lMathanhpho" runat="server" Text='<%# Bind("matp") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tên thành phố">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTp" runat="server" Text='<%# Bind("tentp") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lTp" runat="server" Text='<%# Bind("tentp") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Xử lý">
                                <ItemTemplate>
                                    <asp:ImageButton ID="IBT_sua" runat="server" CommandName="sua"  CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                                            ImageUrl="~/Anh/sua.png" CssClass="anhxuly"  />          
                                    <asp:ImageButton ID="IBT_xoa" runat="server" CommandName="xoa"  CommandArgument='<%# Eval("matp") %>'
                                            ImageUrl="~/Anh/xoa.png" CssClass="anhxuly" OnClientClick="return confirm('Bạn có chắc muốn xóa thành phố này không');" />                            
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