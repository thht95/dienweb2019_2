<%@ Page Language="C#" MasterPageFile="~/Site_Admin.Master" AutoEventWireup="true" CodeBehind="Admin_ghe.aspx.cs" Inherits="Webbanvetau.Admin_ghe" %>

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
<div id="box">
    <h1 align="center">Quản lý Toa Ghế</h1>        
        <table cellpadding="0" cellspacing="0" class="style_admin" align="center">
            <table cellpadding="0" cellspacing="0">
                <tr>
                    <td class="style_cot1_3">
                        Tàu
                    </td>
                    <td class="auto-style2">
                        <asp:DropDownList ID="ddlTau"  runat="server" Height="20px" Width="152px" AppendDataBoundItems="true" AutoPostBack="True" OnSelectedIndexChanged="ddlTau_SelectedIndexChanged">
                                    
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlTau"
                                ErrorMessage="Chưa chọn tàu" InitialValue="--Chọn Tàu--" Text="Chưa chọn tàu" ValidationGroup="vgg"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style_cot1_3">
                        Toa
                    </td>
                    <td class="auto-style2">
                        <asp:DropDownList ID="ddlToa"  runat="server" Height="20px" Width="152px" AppendDataBoundItems="true" AutoPostBack="True" OnSelectedIndexChanged="ddlToa_SelectedIndexChanged">       
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator Display="Dynamic" ID="rfvToa" runat="server" ControlToValidate="ddlToa"
                                ErrorMessage="Chưa chọn toa" InitialValue="--Chọn Toa--" Text="Chưa chọn toa" ValidationGroup="vgg"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style_cot1_3">
                        Số ghế
                    </td>
                    <td class="auto-style1">
                        <asp:TextBox ID="txtGhe" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator Display="Dynamic" ID="rfvghe" runat="server" ControlToValidate="txtGhe"
                                ErrorMessage="Không được để rỗng" ValidationGroup="vgg" ></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Không được nhập chữ cái vào mục này!" Type="Double" ValidationGroup="vgg" SetFocusOnError="True" Operator="GreaterThan" ControlToValidate="txtGhe" Text="Không được nhập chữ cái vào mục này!" Display="Dynamic" ValueToCompare="0"></asp:CompareValidator>

                    </td>
                </tr>
                <tr>
                    <td class="style_cot1_3">
                        Trạng thái
                    </td>
                    <td class="auto-style2">
                        <asp:DropDownList ID="ddlTrangthai"  runat="server" Height="20px" Width="152px" AppendDataBoundItems="true" AutoPostBack="false" >       
                        </asp:DropDownList>

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
                        <asp:Button ID="btnthem" runat="server" Text="Thêm ghế" OnClick="btnthem_Click"  ValidationGroup="vgg"/>  &nbsp;&nbsp;  
                        <asp:Button ID="btnsua" runat="server" Text="Sửa ghế" OnClick="btnsua_Click"/>  &nbsp;&nbsp;
                            &nbsp;&nbsp;
                                                                
                    </td>
                </tr>
                <tr>
                    <td>

                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <h2 style="  padding-top: 12px;">DANH SÁCH GHẾ</h2>
                    <div>
                        <asp:TextBox  ID="txtTimkiem" runat="server"></asp:TextBox><asp:Button ID="btnTimkiem" runat="server" Text="Tìm" OnClick="btnTimkiem_Click" />
                    </div>
                        <asp:DropDownList ID="ddlTau_view" runat="server" OnSelectedIndexChanged="ddlTau_view_SelectedIndexChanged" AutoPostBack="True">
                        </asp:DropDownList>
&nbsp;
                        <asp:DropDownList ID="ddlToa_view" runat="server" OnSelectedIndexChanged="ddlToa_view_SelectedIndexChanged" AutoPostBack="True">
                        </asp:DropDownList>
                       <asp:DropDownList ID="ddlLoaicho" runat="server" OnSelectedIndexChanged="ddlLoaicho_SelectedIndexChanged" AutoPostBack="True">
                        </asp:DropDownList> &nbsp 
                        <asp:Label ID="txtTong" runat="server" Text=""></asp:Label>
                        <br />      
                        <asp:GridView ID="grv_sp" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White" runat="server" AllowPaging="True" AutoGenerateColumns="False" EnableModelValidation="true" OnRowCommand="grv_sp_RowCommand" PageSize="10" OnPageIndexChanging="grv_sp_PageIndexChanging" OnRowDataBound="grv_sp_RowDataBound" >
                            <Columns>
                            <asp:TemplateField HeaderText="#">
                                
                                <ItemTemplate>
                                    <asp:Label ID="lMaghe" runat="server" Text='<%# Bind("maghe") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mã toa">
                                
                                <ItemTemplate>
                                    <asp:Label ID="lMatoa" runat="server" Text='<%# Bind("matoa") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mã tau">
                                
                                <ItemTemplate>
                                    <asp:Label ID="lMatau" runat="server" Text='<%# Bind("matau") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Số ghế">
                                
                                <ItemTemplate>
                                    <asp:Label ID="lTenghe" runat="server" Text='<%# Bind("tenghe") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Toa">
                                
                                <ItemTemplate>
                                    <asp:Label ID="lTentoa" runat="server" Text='<%# Bind("tentoa") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Loại chỗ">
                                <ItemTemplate>
                                    <asp:Label ID="lTenloaitoa" runat="server" Text='<%# Bind("tenloaitoa") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Tàu">
                                
                                <ItemTemplate>
                                    <asp:Label ID="lTentau" runat="server" Text='<%# Bind("tentau") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tình trạng">
                                
                                <ItemTemplate>
                                    <asp:Label ID="lTinhtrangghe" runat="server" Text='<%# Bind("tinhtrangghe") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Xử lý">
                                <ItemTemplate>
                                    <asp:ImageButton ID="IBT_sua" runat="server" CommandName="sua" CausesValidation="false"  CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                                            ImageUrl="~/Anh/sua.png" CssClass="anhxuly"  />          
                                    <asp:ImageButton ID="IBT_xoa" runat="server" CommandName="xoa" CausesValidation="false" CommandArgument='<%# Eval("maghe") %>'
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
	<di>
</asp:Content>

