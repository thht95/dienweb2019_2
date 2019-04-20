<%@ Page Language="C#" MasterPageFile="~/Site_Admin.Master" AutoEventWireup="true" CodeBehind="Admin_banggia.aspx.cs" Inherits="Webbanvetau.Admin_banggia" %>

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

      #ctl00_ContentPlaceHolder1_txtGiatien{
          width:148px;
      }
    </style>

</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
        
        <table cellpadding="0" cellspacing="0" class="style_admin" align="center">
            <table cellpadding="0" cellspacing="0">
                <tr>
                    <td class="style_cot1_3">
                        Ga đi
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlGadi"  runat="server" Height="20px" Width="152px" AppendDataBoundItems="true" AutoPostBack="True">
                                    
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvGadi" runat="server" ControlToValidate="ddlGadi"
                                ErrorMessage="Chưa chọn ga đi" InitialValue="--Chọn ga đi--" Text="Chưa chọn ga đi"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style_cot1_3">
                        Ga đến
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlGaden"  runat="server" Height="20px" Width="152px" AppendDataBoundItems="true" AutoPostBack="True">
                                    
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvGaden" runat="server" ControlToValidate="ddlGaden"
                                ErrorMessage="Chưa chọn ga đến" InitialValue="--Chọn ga đến--" Text="Chưa chọn ga đến"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style_cot1_3">
                        Tàu
                    </td>
                    <td>
                        <asp:DropDownList ID="ddtau"  runat="server" Height="20px" Width="152px" AppendDataBoundItems="true" AutoPostBack="True">
                                    
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvRongDDL" runat="server" ControlToValidate="ddtau"
                                ErrorMessage="Chưa chọn tàu" InitialValue="--Chọn tàu--" Text="Chưa chọn tàu"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style_cot1_3">
                        Toa
                    </td>
                    <td>
                        <asp:DropDownList ID="ddToa"  runat="server" Height="20px" Width="152px" AppendDataBoundItems="true" AutoPostBack="True">
                                    
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvToa" runat="server" ControlToValidate="ddToa"
                                ErrorMessage="Chưa chọn toa" InitialValue="--Chọn toa--" Text="Chưa chọn toa"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style_cot1_3">
                        Giá tiền
                    </td>
                    <td>
                        <asp:TextBox ID="txtGiatien" runat="server"></asp:TextBox>&nbsp;VNĐ&nbsp;&nbsp;
                        <asp:RequiredFieldValidator ID="rfvGiodi" Display="Dynamic"  runat="server" ErrorMessage="Không được để trống." ControlToValidate="txtGiatien"></asp:RequiredFieldValidator>
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
                        <asp:Button ID="btnthem" runat="server" Text="Thêm bảng giá" OnClick="btnthem_Click" />  &nbsp;&nbsp;  
                        <asp:Button ID="btnsua" runat="server" Text="Sửa bảng giá" OnClick="btnsua_Click"/>  &nbsp;&nbsp;
                            &nbsp;&nbsp;
                                                                
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <h2 style="  padding-top: 12px;">DANH SÁCH BẢNG GIÁ</h2>
                    <h2>
                        <asp:TextBox  ID="txtTimkiem" runat="server"></asp:TextBox><asp:Button ID="btnTimkiem" runat="server" Text="Tìm" OnClick="btnTimkiem_Click" />
                    </h2>
                              
                        <asp:GridView ID="grv_sp" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White" runat="server" AllowPaging="True" AutoGenerateColumns="False" EnableModelValidation="true" OnRowCommand="grv_sp_RowCommand" PageSize="4" OnPageIndexChanging="grv_sp_PageIndexChanging" OnRowDataBound="grv_sp_RowDataBound" >
                            <Columns>
                            <asp:TemplateField HeaderText="Mã Bảng giá">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMabanggia" runat="server" Text='<%# Bind("mabanggia") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lMabanggia" runat="server" Text='<%# Bind("mabanggia") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mã ga đi">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMagadi" runat="server" Text='<%# Bind("ma_gadi") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lMagadi" runat="server" Text='<%# Bind("ma_gadi") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mã ga đến">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMagaden" runat="server" Text='<%# Bind("ma_gaden") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lMagaden" runat="server" Text='<%# Bind("ma_gaden") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mã toa">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMaloaitoa" runat="server" Text='<%# Bind("matoa") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lMaloaitoa" runat="server" Text='<%# Bind("matoa") %>'></asp:Label>
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
                            <asp:TemplateField HeaderText="Tàu">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTentau" runat="server" Text='<%# Bind("tentau") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lTentau" runat="server" Text='<%# Bind("tentau") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Toa">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTentoa" runat="server" Text='<%# Bind("tentoa") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lTentoa" runat="server" Text='<%# Bind("tentoa") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Ga đi">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTengadi" runat="server" Text='<%# Bind("ten_gadi") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lTengadi" runat="server" Text='<%# Bind("ten_gadi") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Ga đến">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTengaden" runat="server" Text='<%# Bind("ten_gaden") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lTengaden" runat="server" Text='<%# Bind("ten_gaden") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Gía tiền">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("giatien") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lGiatien" runat="server" Text='<%# Bind("giatien") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Xử lý">
                                <ItemTemplate>
                                    <asp:ImageButton ID="IBT_sua" runat="server" CommandName="sua" CausesValidation="false" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                                            ImageUrl="~/Anh/sua.png" CssClass="anhxuly"  />          
                                    <asp:ImageButton ID="IBT_xoa" runat="server" CommandName="xoa"  CommandArgument='<%# Eval("mabanggia") %>'
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
