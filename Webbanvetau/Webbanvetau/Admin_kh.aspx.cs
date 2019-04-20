using System;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

namespace Webbanvetau
{
    public partial class Admin_kh : System.Web.UI.Page
    {
        public string connectionString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
        string currentLink = HttpContext.Current.Request.Url.PathAndQuery;
        protected void Page_Load(object sender, EventArgs e)
        {
            
            lbSuccess.Text = "";
            if (!this.IsPostBack)
            {
                string session = Convert.ToString(Session["TAIKHOAN"]);
                if (session != null && (session == "qlve" || session == "admin"))
                {
                    fillLoaiKhach();
                    fillNhomKhach();
                    HienKhach();
                    btnsua.Enabled = false;
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        public void HienKhach()
        {
            using (SqlConnection CnnHiensp = new SqlConnection(connectionString))
            {
                using (SqlCommand CmdHiensp = new SqlCommand("select * from tblkhachhang, tblloaikhach where tblkhachhang.maloaikhach = tblloaikhach.maloaikhach", CnnHiensp))
                {
                    using (SqlDataAdapter da_Hiensp = new SqlDataAdapter(CmdHiensp))
                    {
                        DataTable dt_Hiensp = new DataTable();
                        da_Hiensp.Fill(dt_Hiensp);
                        grv_sp.DataSource = dt_Hiensp;
                        grv_sp.DataBind();
                    }
                }
            }
        }//Hien
        private void fillLoaiKhach()
        {
            ddlLoaikh.Items.Clear();
            ddlLoaikh.Items.Add("--Chọn Loại Khách--");
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conString))
            {
                string cmdString = "Select * from tblloaikhach";
                using (SqlCommand cmd = new SqlCommand(cmdString, con))
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            ListItem imageItem = new ListItem();
                            imageItem.Value = dr["maloaikhach"].ToString();
                            imageItem.Text = dr["tenloaikhach"].ToString();
                            ddlLoaikh.Items.Add(imageItem);
                        }
                        dr.Close();
                    }
                    else
                    {
                        ListItem error = new ListItem();
                        error.Text = "Lỗi";
                        ddlLoaikh.Items.Add(error);
                    }
                }
                con.Close();
            }

        }

        private void fillNhomKhach()
        {
            dlSort.Items.Clear();

            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conString))
            {
                string cmdString = "Select * from tblloaikhach";
                using (SqlCommand cmd = new SqlCommand(cmdString, con))
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            ListItem catItem = new ListItem();
                            catItem.Value = dr["maloaikhach"].ToString();
                            catItem.Text = dr["tenloaikhach"].ToString();
                            dlSort.Items.Add(catItem);
                        }
                        dr.Close();
                    }
                }
                con.Close();
                sortDDL(dlSort);
            }
        }

        protected void sortDDL(DropDownList ddl)
        {
            SortedList items = new SortedList();
            foreach (ListItem item in ddl.Items)
            {
                items.Add(item.Text, item.Value);
            }
            ddl.Items.Clear();
            ListItem allItem = new ListItem();
            allItem.Value = "all";
            allItem.Text = "Tất cả";
            dlSort.Items.Add(allItem);
            foreach (string key in items.Keys)
            {
                ListItem item = new ListItem(key, items[key].ToString());
                ddl.Items.Add(item);
            }
        }

        protected void dlSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conString))
            {
                string query;
                if (dlSort.SelectedItem.Value == "all")
                {
                    query = "Select * from tblkhachhang ";
                }
                else
                {
                    query = "Select * from tblkhachhang , tblloaikhach where tblkhachhang.maloaikhach =  tblloaikhach.maloaikhach and tblkhachhang.maloaikhach='" + dlSort.SelectedItem.Value + "'";
                }
                using (SqlDataAdapter da = new SqlDataAdapter(query, con))
                {
                    con.Open();
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    grv_sp.DataSource = dt;
                    grv_sp.DataBind();
                }
                con.Close();
            }
        }

        protected void grv_sp_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.ToLower().Equals("xoa"))
            {
                int mak = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection Cnnxoa = new SqlConnection(connectionString))
                {
                    using (SqlCommand Cmd1 = new SqlCommand("spKhachhang_Delete", Cnnxoa))
                        try
                        {
                            Cmd1.CommandType = CommandType.StoredProcedure;
                            Cmd1.Parameters.AddWithValue("@makh", mak);
                            Cnnxoa.Open();
                            Cmd1.ExecuteNonQuery();
                            Response.Write("<script> alert('Xóa thành công!')</script>");
                        }
                        catch (Exception) { Response.Write("<script> alert('Không xóa được!')</script>"); }
                    HienKhach();
                }//cnn
            }//xoa  
            if (e.CommandName == "sua")
            {
                btnOk.Enabled = false;
                btnsua.Enabled = true;
                ImageButton ib = (ImageButton)e.CommandSource;
                int index = Convert.ToInt32(ib.CommandArgument);
                GridViewRow row = grv_sp.Rows[index];

                Label lHoten = (Label)row.FindControl("lbHoten");
                Label lloaikhach = (Label)row.FindControl("lbMa");
                Label lcmnd = (Label)row.FindControl("lbCmnd");
                Label lgioitinh = (Label)row.FindControl("lbGioitinh");
                Label lemail = (Label)row.FindControl("lbEmail");
                Label lsdt = (Label)row.FindControl("lbSdt");
                Label lmakh = (Label)row.FindControl("lbMasp");

                txtHoten.Text = lHoten.Text;
                txtCmnd.Text = lcmnd.Text;
                txtEmail.Text = lemail.Text;
                txtSdt.Text = lsdt.Text;
                ddlLoaikh.Text = lloaikhach.Text;
                hdtest.Value = lmakh.Text;

                if (lgioitinh.Text.ToString().Equals("Nữ"))
                {
                    rdbNu.Checked = true;
                    rdbNam.Checked = false;
                }
                else if (lgioitinh.Text.ToString().Equals("Nam"))
                {
                    rdbNam.Checked = true;
                    rdbNu.Checked = false;
                }
            }//sua
        }

        int stt = 1;
        public string get_stt()
        { return Convert.ToString(stt++); }

        protected void grv_sp_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grv_sp.PageIndex = e.NewPageIndex;
            int trang_thu = e.NewPageIndex; //the hien trang thu may 
            int so_dong = grv_sp.PageSize; //moi trang co bao nhieu dong 
            stt = trang_thu * so_dong + 1;
            grv_sp.DataBind();
            HienKhach();
        }

        protected void btnOk_Click(object sender, EventArgs e)
        {
            btnsua.Enabled = false;
            if (ddlLoaikh.Text == "--Chọn Loại Khách--")
            {
                Response.Write("<script> alert('Bạn chưa chọn loại khách')</script>");
            }
            else
            {
                string gt;
                if (rdbNam.Checked == true)
                {
                    gt = "Nam";
                }
                else
                {
                    gt = "Nữ";
                }

                string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
                using (SqlConnection cnn = new SqlConnection(conString))
                {
                    using (SqlCommand cmd = new SqlCommand("spKhachhang_Insert", cnn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@maloaikhach", ddlLoaikh.SelectedValue);
                        cmd.Parameters.AddWithValue("@hoten", txtHoten.Text);
                        cmd.Parameters.AddWithValue("@cmnd", txtCmnd.Text);
                        cmd.Parameters.AddWithValue("@gioitinh", gt);
                        cmd.Parameters.AddWithValue("@email", txtEmail.Text);
                        cmd.Parameters.AddWithValue("@sdt", txtSdt.Text);
                        cnn.Open();
                        cmd.ExecuteNonQuery();
                    }
                    cnn.Close();

                }
                lbSuccess.Text = "Nhập hàng thành công";
                HienKhach();
            }
        }



        protected void btnsua_Click(object sender, EventArgs e)
        {
            if (ddlLoaikh.Text == "--Chọn Loại Khách--")
            {
                Response.Write("<script> alert('Bạn chưa chọn loại khách')</script>");
            }
            else
            {
                string gt;
                if (rdbNam.Checked == true)
                {
                    gt = "Nam";
                }
                else
                {
                    gt = "Nữ";
                }

                string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
                using (SqlConnection cnn = new SqlConnection(conString))
                {
                    using (SqlCommand cmd = new SqlCommand("spKhachhang_Update", cnn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@makh", hdtest.Value);
                        cmd.Parameters.AddWithValue("@maloaikhach", ddlLoaikh.SelectedValue);
                        cmd.Parameters.AddWithValue("@hoten", txtHoten.Text);
                        cmd.Parameters.AddWithValue("@cmnd", txtCmnd.Text);
                        cmd.Parameters.AddWithValue("@gioitinh", gt);
                        cmd.Parameters.AddWithValue("@email", txtEmail.Text);
                        cmd.Parameters.AddWithValue("@sdt", txtSdt.Text);
                        cnn.Open();
                        cmd.ExecuteNonQuery();
                    }
                    cnn.Close();
                }
                lbSuccess.Text = "Sửa thành công";
                HienKhach();
            }
        }

        protected void grv_sp_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            /*Hide*/
            //e.Row.Cells[0].Visible = false;
            grv_sp.Columns[0].Visible = false;
            grv_sp.Columns[1].Visible = false;
            /*Show*/
            //e.Row.Cells[3].Visible = true;
        }

        protected void btnTimkiem_Click(object sender, EventArgs e)
        {
            if (txtTimkiem.Text != string.Empty)
            {
                string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(conString))
                {
                    string sql = "select * from tblkhachhang, tblloaikhach where tblkhachhang.maloaikhach = tblloaikhach.maloaikhach and gioitinh like '%" + txtTimkiem.Text + "%'order by makh DESC";
                    using (SqlDataAdapter da = new SqlDataAdapter(sql, con))
                    {
                        con.Open();
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        grv_sp.DataSource = dt;
                        grv_sp.DataBind();
                    }
                    con.Close();
                }
                if (grv_sp.Rows.Count == 0)
                {
                    Response.Write("<script> alert('Không có dữ liệu')</script>");
                    HienKhach();
                }
            }
            else
            {
                Response.Write("<script>alert('Bạn chưa nhập từ khóa tìm kiếm !')</script>");
            }
        }



    }
}