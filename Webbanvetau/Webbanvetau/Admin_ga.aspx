<%@ Page Language="C#" MasterPageFile="~/Site_Admin.Master" AutoEventWireup="true" CodeBehind="Admin_ga.aspx.cs" Inherits="Webbanvetau.Admin_ga" %>

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
        .style2_nhap {
            width: 100px;
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
<h1 align="center">Quản lý ga tàu</h1>  
        <table cellpadding="0" cellspacing="0" class="style_admin" align="center">
            <table cellpadding="0" cellspacing="0">
                <tr class="style_cot1_3">
                    <td class="style2_nhap">
                        Ga
                    </td>
                    <td >
                        <asp:TextBox ID="txtga" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="rfvRong"  runat="server" ErrorMessage="Không được rỗng" ControlToValidate="txtga"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style2_nhap">
                        Thành phố
                    </td>
                    <td>
                        <asp:DropDownList ID="ddtp"  runat="server" Height="20px" Width="152px" AppendDataBoundItems="true" AutoPostBack="True">
                                    
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="rfvRongDDL" runat="server" ControlToValidate="ddtp"
                                ErrorMessage="Chưa chọn thành phố" InitialValue="--Chọn thành phố--" ></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                <asp:HiddenField id="hdtest" runat="server" />
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Label ID="lberror" runat="server" ForeColor="Red"></asp:Label>
                        <asp:Label ID="lbSuccess" runat="server" ForeColor="Blue"></asp:Label>
                            <br />
                        <asp:Button ID="btnOk" runat="server" Text="Thêm Ga" OnClick="btnOk_Click"/>  &nbsp;&nbsp;  
                        <asp:Button ID="btnsua" runat="server" Text="Sửa Ga" OnClick="btnsua_Click"/>  &nbsp;&nbsp;
                            &nbsp;&nbsp;
                                                                
                    </td>
                </tr>
                <tr>
                    <td colspan="4">

                        <h2>DANH SÁCH GA TÀU</h2>
                    <h2>
                        <asp:TextBox  ID="txtTimkiem" runat="server"></asp:TextBox><asp:Button ID="btnTimkiem" runat="server" Text="Tìm" OnClick="btnTimkiem_Click" />
                    </h2>
                              
                        <asp:GridView ID="grv_sp" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White" runat="server" AllowPaging="True" AutoGenerateColumns="False" EnableModelValidation="true" OnRowCommand="grv_sp_RowCommand" PageSize="5" OnPageIndexChanging="grv_sp_PageIndexChanging" OnRowDataBound="grv_sp_RowDataBound" >
                            <Columns>
                            <asp:TemplateField HeaderText="Mã ga">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMaga" runat="server" Text='<%# Bind("maga") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbMaga" runat="server" Text='<%# Bind("maga") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mã khách">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMatp" runat="server" Text='<%# Bind("matp") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbMatp" runat="server" Text='<%# Bind("matp") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tên ga">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTenga" runat="server" Text='<%# Bind("tenga") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbTenga" runat="server" Text='<%# Bind("tenga") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Thành phố">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTentp" runat="server" Text='<%# Bind("tentp") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbTentp" runat="server" Text='<%# Bind("tentp") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Xử lý">
                                <ItemTemplate>
                                    <asp:ImageButton ID="IBT_sua" runat="server" CommandName="sua" CausesValidation="false" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                                            ImageUrl="~/Anh/sua.png" CssClass="anhxuly"  />          
                                    <asp:ImageButton ID="IBT_xoa" runat="server" CommandName="xoa"  CommandArgument='<%# Eval("maga") %>'
                                            ImageUrl="~/Anh/xoa.png" CssClass="anhxuly" OnClientClick="return confirm('Bạn có chắc muốn xóa ga này không');" />                            
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
            </table>
        </table>
</asp:Content>
