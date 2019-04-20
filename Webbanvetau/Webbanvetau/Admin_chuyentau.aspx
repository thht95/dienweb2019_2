<%@ Page Language="C#" MasterPageFile="~/Site_Admin.Master" AutoEventWireup="true" CodeBehind="Admin_chuyentau.aspx.cs" Inherits="Webbanvetau.Admin_chuyentau" %>

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
        
        <table cellpadding="0" cellspacing="0" class="style_admin" align="center">
            <table cellpadding="0" cellspacing="0">
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
                        Ngày đi
                    </td>
                    <td>
                        <asp:TextBox ID="txtNgaydi" runat="server" placeholder="dd/mm/Y"></asp:TextBox>&nbsp;&nbsp;
                        <asp:RequiredFieldValidator ID="rfvRong1" Display="Dynamic"  runat="server" ErrorMessage="Không được để trống." ControlToValidate="txtNgaydi"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revNgaydi" Display="Dynamic" runat="server" ControlToValidate="txtNgaydi" ValidationExpression="^(((((0[1-9])|(1\d)|(2[0-8]))\/((0[1-9])|(1[0-2])))|((31\/((0[13578])|(1[02])))|((29|30)\/((0[1,3-9])|(1[0-2])))))\/((20[0-9][0-9])|(19[0-9][0-9])))|((29\/02\/(19|20)(([02468][048])|([13579][26]))))$ " ErrorMessage="Ngày đi không hợp lệ."></asp:RegularExpressionValidator>
  <%--                      <asp:CompareValidator ID="cvSSngay" Display="Dynamic" EnableViewState="true"  ControlToValidate="txtNgaydi" Type="Date" Operator="GreaterThanEqual" runat="server" ErrorMessage="Ngày đi phải lớn hơn hoặc bằng ngày hiện tại."></asp:CompareValidator>--%>
                    </td>
                </tr>
                <tr>
                    <td class="style_cot1_3">
                        Giờ đi
                    </td>
                    <td>
                        <asp:TextBox ID="txtGiodi" runat="server" placeholder="HH:mm"></asp:TextBox>&nbsp;&nbsp;
                        <asp:RequiredFieldValidator ID="rfvGiodi" Display="Dynamic"  runat="server" ErrorMessage="Không được để trống." ControlToValidate="txtGiodi"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revGiodi" Display="Dynamic" runat="server" EnableViewState="true" ControlToValidate="txtGiodi" ValidationExpression="^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$" ErrorMessage="Giờ đi không hợp lệ."></asp:RegularExpressionValidator>
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
                        Ngày đến
                    </td>
                    <td>
                        <asp:TextBox ID="txtNgayden" runat="server"  placeholder="Ngày/Tháng/Năm"></asp:TextBox>&nbsp;&nbsp;
                        <asp:RequiredFieldValidator ID="rfvRong2" Display="Dynamic" runat="server" ErrorMessage="Không được để trống." ControlToValidate="txtNgayden"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revNgayden" Display="Dynamic" runat="server" EnableViewState="true" ControlToValidate="txtNgayden" ValidationExpression="^(((((0[1-9])|(1\d)|(2[0-8]))\/((0[1-9])|(1[0-2])))|((31\/((0[13578])|(1[02])))|((29|30)\/((0[1,3-9])|(1[0-2])))))\/((20[0-9][0-9])|(19[0-9][0-9])))|((29\/02\/(19|20)(([02468][048])|([13579][26]))))$" ErrorMessage="Ngày đến không hợp lệ."></asp:RegularExpressionValidator>
                        <asp:CompareValidator ID="cvSE" runat="server" Display="Dynamic" ControlToCompare="txtNgaydi" ControlToValidate="txtNgayden" Type="Date" Operator="GreaterThanEqual" ErrorMessage="Ngày đến phải lớn hơn hoặc bằng ngày đi."></asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style_cot1_3">
                        Giờ đến
                    </td>
                    <td>
                        <asp:TextBox ID="txtGioden" runat="server" placeholder="HH:mm"></asp:TextBox>&nbsp;&nbsp;
                        <asp:RequiredFieldValidator ID="rfvGioden" Display="Dynamic"  runat="server" ErrorMessage="Không được để trống." ControlToValidate="txtGioden"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revGioden" Display="Dynamic" runat="server" EnableViewState="true" ControlToValidate="txtGioden" ValidationExpression="^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$" ErrorMessage="Giờ đến không hợp lệ."></asp:RegularExpressionValidator>
                        <asp:CompareValidator ID="cvGioden" runat="server" Display="Dynamic" ControlToCompare="txtGiodi" ControlToValidate="txtGioden" Type="String" Operator="GreaterThan" ErrorMessage="Giờ đến phải lớn hơn giờ đi."></asp:CompareValidator>
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
                        <asp:Button ID="btnthem" runat="server" Text="Thêm chuyến tàu" OnClick="btnthem_Click" />  &nbsp;&nbsp;  
                        <asp:Button ID="btnsua" runat="server" Text="Sửa chuyến tàu" OnClick="btnsua_Click"/>  &nbsp;&nbsp;
                            &nbsp;&nbsp;
                                                                
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <h2 style="  padding-top: 12px;">DANH SÁCH CHUYẾN TÀU</h2>
                    <h2>
                        <asp:TextBox  ID="txtTimkiem" runat="server"></asp:TextBox><asp:Button ID="btnTimkiem" runat="server" Text="Tìm" OnClick="btnTimkiem_Click" />
                    </h2>
                              
                        <asp:GridView ID="grv_sp" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White" runat="server" AllowPaging="True" AutoGenerateColumns="False" EnableModelValidation="true" OnRowCommand="grv_sp_RowCommand" PageSize="4" OnPageIndexChanging="grv_sp_PageIndexChanging" OnRowDataBound="grv_sp_RowDataBound" >
                            <Columns>
                            <asp:TemplateField HeaderText="Mã chuyến tàu">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMachuyentau" runat="server" Text='<%# Bind("malichtrinh") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lMachuyentau" runat="server" Text='<%# Bind("malichtrinh") %>'></asp:Label>
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
                            <asp:TemplateField HeaderText="Mã ga đi">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtGadi" runat="server" Text='<%# Bind("ma_gadi") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lGadi" runat="server" Text='<%# Bind("ma_gadi") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mã ga đến">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtGaden" runat="server" Text='<%# Bind("ma_gaden") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lGaden" runat="server" Text='<%# Bind("ma_gaden") %>'></asp:Label>
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
                            <asp:TemplateField HeaderText="Ngày đi">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ngaydi", "{0:dd/MM/yyyy}") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lNgaydi" runat="server" Text='<%# Bind("ngaydi", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Giờ đi">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("ngaydi", "{0:HH:mm}") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lGiodi" runat="server" Text='<%# Bind("ngaydi", "{0:HH:mm}") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Ngày đến">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("ngayden", "{0:dd/MM/yyyy}") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lNgayden" runat="server" Text='<%# Bind("ngayden", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Giờ đến">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("ngayden", "{0:HH:mm}") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lGioden" runat="server" Text='<%# Bind("ngayden", "{0:HH:mm}") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Xử lý">
                                <ItemTemplate>
                                    <asp:ImageButton ID="IBT_sua" runat="server" CommandName="sua" CausesValidation="false" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                                            ImageUrl="~/Anh/sua.png" CssClass="anhxuly"  />          
                                    <asp:ImageButton ID="IBT_xoa" runat="server" CommandName="xoa"  CommandArgument='<%# Eval("malichtrinh") %>'
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

