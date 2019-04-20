<%@ Page Language="C#" MasterPageFile="~/Site_Admin.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="Webbanvetau.Admin" %>

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
        .style3_drop {
            width: 173px;
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

      #wapper{
          width: 1100px;
      }

      #main{
          width:100%;
      }

      #right{
          width:870px;
      }
    </style>

</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
 <h1 align="center">Quản lý vé tàu</h1>       
        <table cellpadding="0" cellspacing="0" class="style_admin" align="center">
            <table cellpadding="0" cellspacing="0">
                <tr>
                    <td class="style_cot1_3">
                        Ga đi
                    </td>
                    <td >
                        <asp:DropDownList ID="ddlGadi"  runat="server" Height="20px" Width="152px" AppendDataBoundItems="true" AutoPostBack="True" OnSelectedIndexChanged="ddlGadi_SelectedIndexChanged">
                                    
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvGadi" runat="server" ControlToValidate="ddlGadi"
                                ErrorMessage="Chưa chọn ga đi" InitialValue="--Chọn ga đi--" Text="Chưa chọn ga đi"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style_cot1_3">
                        Ga đến
                    </td>
                    <td >
                        <asp:DropDownList ID="ddlGaden"  runat="server" Height="20px" Width="152px" AppendDataBoundItems="true" AutoPostBack="True" OnSelectedIndexChanged="ddlGaden_SelectedIndexChanged">
                                    
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvGaden" runat="server" ControlToValidate="ddlGaden"
                                ErrorMessage="Chưa chọn ga đến" InitialValue="--Chọn ga đến--" Text="Chưa chọn ga đến"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Giá lịch trình</td>
                    <td>
                        <asp:TextBox ID="txtGialichtrinh" runat="server" Enabled="False"></asp:TextBox>&nbsp; VNĐ &nbsp;&nbsp;
                        <asp:RequiredFieldValidator ID="rfvGialt" runat="server" ControlToValidate="txtGialichtrinh"
                                ErrorMessage="Không được để rỗng" ></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style_cot1_3">
                        Tàu
                    </td>
                    <td >
                        <asp:DropDownList ID="ddtau"  runat="server" Height="20px" Width="152px" AppendDataBoundItems="true" AutoPostBack="True" OnSelectedIndexChanged="ddtau_SelectedIndexChanged">
                                    
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvRongDDL" runat="server" ControlToValidate="ddtau"
                                ErrorMessage="Chưa chọn tàu" InitialValue="--Chọn tàu--" Text="Chưa chọn tàu"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Giá tàu</td>
                    <td>
                        <asp:TextBox ID="txtGiatau" runat="server" Enabled="False"></asp:TextBox>&nbsp; VNĐ &nbsp;&nbsp;
                        <asp:RequiredFieldValidator ID="rfvGiatau" runat="server" ControlToValidate="txtGiatau"
                                ErrorMessage="Không được để rỗng" ></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style_cot1_3">
                        Toa
                    </td>
                    <td >
                        <asp:DropDownList ID="ddToa"  runat="server" Height="20px" Width="152px" AppendDataBoundItems="true" AutoPostBack="True" OnSelectedIndexChanged="ddToa_SelectedIndexChanged">
                                    
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvToa" runat="server" ControlToValidate="ddToa"
                                ErrorMessage="Chưa chọn toa" InitialValue="--Chọn toa--" Text="Chưa chọn toa"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Giá toa</td>
                    <td>
                        <asp:TextBox ID="txtGiatoa" runat="server" Enabled="false"></asp:TextBox> &nbsp; VMĐ &nbsp;&nbsp;
                        <asp:RequiredFieldValidator ID="rfvGiatoa" runat="server" ControlToValidate="txtGiatoa"
                                ErrorMessage="Không được để rỗng" ></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                <td class="style_cot1_3">
                        Ghế
                    </td>
                    <td >
                        <asp:DropDownList ID="ddGhe"  runat="server" Height="20px" Width="152px" AppendDataBoundItems="true" AutoPostBack="True" OnSelectedIndexChanged="ddGhe_SelectedIndexChanged" >
                                    
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvGhe" runat="server" ControlToValidate="ddGhe"
                                ErrorMessage="Chưa chọn ghế" InitialValue="--Chọn ghế--" Text="Chưa chọn ghế"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style_cot1_3">
                        Khách hàng
                    </td>
                    <td>
                        <asp:DropDownList ID="ddKhach"  runat="server" Height="20px" Width="152px" AppendDataBoundItems="true" AutoPostBack="True" OnSelectedIndexChanged="ddKhach_SelectedIndexChanged">
                                    
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvKhach" runat="server" ControlToValidate="ddKhach"
                                ErrorMessage="Chưa chọn khách" InitialValue="--Chọn khách--" Text="Chưa chọn khách"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style_cot1_3">Phần trăm giảm</td>
                    <td>
                        <asp:TextBox ID="txtPhantram" runat="server" Enabled="False"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPhantram" runat="server" ControlToValidate="txtPhantram"
                                ErrorMessage="Không được để rỗng" ></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style_cot1_3">
                        Ngày bán
                    </td>
                    <td>
                        <asp:TextBox ID="txtNgayban" runat="server" placeholder="Ngày/Tháng/Năm"></asp:TextBox>&nbsp;&nbsp;
                        <asp:RequiredFieldValidator ID="rfvRong1" Display="Dynamic"  runat="server" ErrorMessage="Không được để trống." ControlToValidate="txtNgayban"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revNgaydi" Display="Dynamic" runat="server" ControlToValidate="txtNgayban" ValidationExpression="^(((((0[1-9])|(1\d)|(2[0-8]))\/((0[1-9])|(1[0-2])))|((31\/((0[13578])|(1[02])))|((29|30)\/((0[1,3-9])|(1[0-2])))))\/((20[0-9][0-9])|(19[0-9][0-9])))|((29\/02\/(19|20)(([02468][048])|([13579][26]))))$ " ErrorMessage="Ngày đi không hợp lệ."></asp:RegularExpressionValidator>
<%--                        <asp:CompareValidator ID="cvSSngay" Display="Dynamic" EnableViewState="true"  ControlToValidate="txtNgayban" Type="Date" Operator="GreaterThanEqual" runat="server" ErrorMessage="Ngày bán phải lớn hơn hoặc bằng ngày hiện tại."></asp:CompareValidator>--%>
                    </td>
                </tr>
                <tr>
                    <td>Thành tiền</td>
                    <td>
                        <asp:TextBox ID="txtThanhtien" runat="server" Enabled="False"></asp:TextBox> &nbsp; VNĐ &nbsp;&nbsp;
                        <asp:RequiredFieldValidator ID="rfvThanhtien" runat="server" ControlToValidate="txtThanhtien"
                                ErrorMessage="Không được rỗng" ></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>     
                    <asp:HiddenField id="hdtest" runat="server" />
                    <asp:HiddenField id="hdmalichtrinh" runat="server" />
                    <asp:HiddenField id="Hdmaghe" runat="server" />
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lberror" runat="server" ForeColor="Red"></asp:Label>
                        <asp:Label ID="lbSuccess" runat="server" ForeColor="Blue"></asp:Label>
                            <br />
                        <asp:Button ID="btnthem" runat="server" Text="Đặt vé" OnClick="btnthem_Click" />  &nbsp;&nbsp;  
                        <asp:Button ID="btnsua" runat="server" Text="Sửa vé" OnClick="btnsua_Click"/>  &nbsp;&nbsp;
                            &nbsp;&nbsp;
                                                                
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <h2 style="  padding-top: 12px;">DANH SÁCH VÉ TÀU</h2>
                    <h2>
                        <asp:DropDownList ID="ddTinhtrang"  runat="server" Height="20px" Width="152px" AppendDataBoundItems="true" AutoPostBack="True">
                                    
                        </asp:DropDownList>
                        <asp:TextBox  ID="txtTimkiem" runat="server"></asp:TextBox><asp:Button ID="btnTimkiem" runat="server" Text="Tìm" OnClick="btnTimkiem_Click" />
                    </h2>
                              
                        <asp:GridView ID="grv_sp" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White" runat="server" AllowPaging="True" AutoGenerateColumns="False" EnableModelValidation="true" OnRowCommand="grv_sp_RowCommand" PageSize="4" OnPageIndexChanging="grv_sp_PageIndexChanging" OnRowDataBound="grv_sp_RowDataBound" ShowFooter="True" >
                            <Columns>
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
                                    <asp:TextBox ID="txtMatoa" runat="server" Text='<%# Bind("matoa") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lMatoa" runat="server" Text='<%# Bind("matoa") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mã khách">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMakhach" runat="server" Text='<%# Bind("makh") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lMakhach" runat="server" Text='<%# Bind("makh") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mã tình trạng vé">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMaTT" runat="server" Text='<%# Bind("matinhtrang") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lMaTT" runat="server" Text='<%# Bind("matinhtrang") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Giá tàu">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("giatau") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lGiatau" runat="server" Text='<%# Bind("giatau") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Giá toa">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("giatoa") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lGiatoa" runat="server" Text='<%# Bind("giatoa") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Giá lịch trình">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("gialichtrinh") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lGialichtrinh" runat="server" Text='<%# Bind("gialichtrinh") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Phần trăm giảm">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("phantramgiam") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lPhantram" runat="server" Text='<%# Bind("phantramgiam") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mã lịch trình">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMalictrinh" runat="server" Text='<%# Bind("malichtrinh") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lMalichtrinh" runat="server" Text='<%# Bind("malichtrinh") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mã ghế">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMaghe" runat="server" Text='<%# Bind("maghe") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lMaghe" runat="server" Text='<%# Bind("maghe") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mã vé">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMave" runat="server" Text='<%# Bind("mave") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lMave" runat="server" Text='<%# Bind("mave") %>'></asp:Label>
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
                            <asp:TemplateField HeaderText="Toa">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTentoa" runat="server" Text='<%# Bind("tentoa") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lTentoa" runat="server" Text='<%# Bind("tentoa") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Khách">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtHoten" runat="server" Text='<%# Bind("hoten") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lhoten" runat="server" Text='<%# Bind("hoten") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Ghế">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtGhe" runat="server" Text='<%# Bind("tenghe") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lGhe" runat="server" Text='<%# Bind("tenghe") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tình trạng vé">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTTrang" runat="server" Text='<%# Bind("tinhtrang") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lTTrang" runat="server" Text='<%# Bind("tinhtrang") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Ngày bán">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("ngayban", "{0:dd/MM/yyyy}") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lNgayban" runat="server" Text='<%# Bind("ngayban", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Ngày trả">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtNgaytra" runat="server" Text='<%# Bind("ngaytra", "{0:dd/MM/yyyy}") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lNgaytra" runat="server" Text='<%# Bind("ngaytra", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Thành tiền">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTTien" runat="server" Text='<%# Bind("thanhtien") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
				                    <div style="text-align: left;">
				                    <asp:Label ID="lblTotalqty" runat="server" />
				                    </div>
			                    </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lTTien" runat="server" Text='<%# Bind("thanhtien") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Xử lý">
                                <ItemTemplate>
                                    <asp:ImageButton ID="IBT_sua" ToolTip="Sửa" runat="server" CommandName="sua" CausesValidation="false" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                                            ImageUrl="~/Anh/sua.png" CssClass="anhxuly"  />    
                                    <asp:ImageButton ID="imbThanhtoan" ToolTip="Thanh toán" runat="server" CommandName="thanhtoan" CausesValidation="false" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                                            ImageUrl="~/Anh/thanhtoan.png" CssClass="anhxuly" OnClientClick="return confirm('Bạn có muốn xác nhận thanh toán vé này không?');" />      
                                    <asp:ImageButton ID="IBT_xoa" ToolTip="Xóa" runat="server" CommandName="xoa" CausesValidation="false" CommandArgument='<%# Eval("mave") %>'
                                            ImageUrl="~/Anh/xoa.png" CssClass="anhxuly" OnClientClick="return confirm('Bạn có chắc chắn muốn xóa không?');" />  
                                                              
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lbSoluongve" runat="server" Text="Số lượng vé: "></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#cccccc" Font-Bold="True" ForeColor="Black" HorizontalAlign="Left" />
                        <HeaderStyle BackColor="#3AC0F2" ForeColor="White"></HeaderStyle>
                    </asp:GridView>
                <br />
                </td>
                </tr>
            </table>
        </table>
</asp:Content>
