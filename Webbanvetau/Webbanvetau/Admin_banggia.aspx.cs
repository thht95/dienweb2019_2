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
    public partial class Admin_banggia : System.Web.UI.Page
    {
        public string connectionString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
        string currentLink = HttpContext.Current.Request.Url.PathAndQuery;
        protected void Page_Load(object sender, EventArgs e)
        {
            lbSuccess.Text = "";
            if (!this.IsPostBack)
            {
                fillTau();
                fillGadi();
                fillGaden();
                fillToa();
                HienBangGia();
                btnsua.Enabled = false;
            }
        }

        public void HienBangGia()
        {
            using (SqlConnection CnnHiensp = new SqlConnection(connectionString))
            {
                using (SqlCommand CmdHiensp = new SqlCommand("spBanggia", CnnHiensp))
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

        private void fillTau()
        {
            ddtau.Items.Clear();
            ddtau.Items.Add("--Chọn tàu--");
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conString))
            {
                string cmdString = "Select * from tbltau";
                using (SqlCommand cmd = new SqlCommand(cmdString, con))
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            ListItem imageItem = new ListItem();
                            imageItem.Value = dr["matau"].ToString();
                            imageItem.Text = dr["tentau"].ToString();
                            ddtau.Items.Add(imageItem);
                        }
                        dr.Close();
                    }
                    else
                    {
                        ListItem error = new ListItem();
                        error.Text = "Lỗi";
                        ddtau.Items.Add(error);
                    }
                }
                con.Close();
            }

        }

        private void fillToa()
        {
            ddToa.Items.Clear();
            ddToa.Items.Add("--Chọn toa--");
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conString))
            {
                string cmdString = "Select * from tbltoatau";
                using (SqlCommand cmd = new SqlCommand(cmdString, con))
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            ListItem imageItem = new ListItem();
                            imageItem.Value = dr["matoa"].ToString();
                            imageItem.Text = dr["tentoa"].ToString();
                            ddToa.Items.Add(imageItem);
                        }
                        dr.Close();
                    }
                    else
                    {
                        ListItem error = new ListItem();
                        error.Text = "Lỗi";
                        ddToa.Items.Add(error);
                    }
                }
                con.Close();
            }

        }

        private void fillGadi()
        {
            ddlGadi.Items.Clear();
            ddlGadi.Items.Add("--Chọn ga đi--");
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conString))
            {
                string cmdString = "Select * from tblgatau";
                using (SqlCommand cmd = new SqlCommand(cmdString, con))
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            ListItem imageItem = new ListItem();
                            imageItem.Value = dr["maga"].ToString();
                            imageItem.Text = dr["tenga"].ToString();
                            ddlGadi.Items.Add(imageItem);
                        }
                        dr.Close();
                    }
                    else
                    {
                        ListItem error = new ListItem();
                        error.Text = "Lỗi";
                        ddlGadi.Items.Add(error);
                    }
                }
                con.Close();
            }

        }

        private void fillGaden()
        {
            ddlGaden.Items.Clear();
            ddlGaden.Items.Add("--Chọn ga đến--");
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conString))
            {
                string cmdString = "Select * from tblgatau";
                using (SqlCommand cmd = new SqlCommand(cmdString, con))
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            ListItem imageItem = new ListItem();
                            imageItem.Value = dr["maga"].ToString();
                            imageItem.Text = dr["tenga"].ToString();
                            ddlGaden.Items.Add(imageItem);
                        }
                        dr.Close();
                    }
                    else
                    {
                        ListItem error = new ListItem();
                        error.Text = "Lỗi";
                        ddlGaden.Items.Add(error);
                    }
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
                    using (SqlCommand Cmd1 = new SqlCommand("spBgia_Delete", Cnnxoa))
                        try
                        {
                            Cmd1.CommandType = CommandType.StoredProcedure;
                            Cmd1.Parameters.AddWithValue("@mabanggia", mak);
                            Cnnxoa.Open();
                            Cmd1.ExecuteNonQuery();
                            Response.Write("<script> alert('Xóa thành công!')</script>");
                        }
                        catch (Exception) { Response.Write("<script> alert('Không xóa được!')</script>"); }
                    HienBangGia();
                }//cnn
            }//xoa  
            if (e.CommandName == "sua")
            {
                btnthem.Enabled = false;
                btnsua.Enabled = true;
                ImageButton ib = (ImageButton)e.CommandSource;
                int index = Convert.ToInt32(ib.CommandArgument);
                GridViewRow row = grv_sp.Rows[index];

                Label lmabanggia = (Label)row.FindControl("lMabanggia");
                Label lmatau = (Label)row.FindControl("lMatau");
                Label lgadi = (Label)row.FindControl("lMagadi");
                Label lgaden = (Label)row.FindControl("lMagaden");
                Label ltoa = (Label)row.FindControl("lMaloaitoa");
                Label lgiatien = (Label)row.FindControl("lGiatien");

                ddtau.Text = lmatau.Text;
                ddlGadi.Text = lgadi.Text;
                ddlGaden.Text = lgaden.Text;
                txtGiatien.Text = lgiatien.Text;
                ddToa.Text = ltoa.Text;
                hdtest.Value = lmabanggia.Text;
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
            HienBangGia();
        }


        protected void btnsua_Click(object sender, EventArgs e)
        {
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection cnn = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand("spBanggia_Update", cnn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@mabanggia", hdtest.Value);
                    cmd.Parameters.AddWithValue("@matau", ddtau.SelectedValue);
                    cmd.Parameters.AddWithValue("@magadi", ddlGadi.SelectedValue);
                    cmd.Parameters.AddWithValue("@magaden", ddlGaden.SelectedValue);
                    cmd.Parameters.AddWithValue("@matoa", ddToa.SelectedValue);
                    cmd.Parameters.AddWithValue("@giatien", txtGiatien.Text);
                    cnn.Open();
                    cmd.ExecuteNonQuery();
                }
                cnn.Close();
            }
            lbSuccess.Text = "Sửa thành công";
            HienBangGia();
        }

        protected void grv_sp_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            /*Hide*/
            //e.Row.Cells[0].Visible = false;
            grv_sp.Columns[0].Visible = false;
            grv_sp.Columns[1].Visible = false;
            grv_sp.Columns[2].Visible = false;
            grv_sp.Columns[3].Visible = false;
            grv_sp.Columns[4].Visible = false;
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
                    HienBangGia();
                }
            }
            else
            {
                Response.Write("<script>alert('Bạn chưa nhập từ khóa tìm kiếm !')</script>");
            }
        }

        protected void btnthem_Click(object sender, EventArgs e)
        {
            btnsua.Enabled = false;

            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection cnn = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand("spBgia_Insert", cnn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@mabanggia", SqlDbType.Int).Direction = ParameterDirection.Output;
                    cmd.Parameters.AddWithValue("@matau", ddtau.SelectedValue);
                    cmd.Parameters.AddWithValue("@magadi", ddlGadi.SelectedValue);
                    cmd.Parameters.AddWithValue("@magaden", ddlGaden.SelectedValue);
                    cmd.Parameters.AddWithValue("@matoa", ddToa.SelectedValue);
                    cmd.Parameters.AddWithValue("@giatien", txtGiatien.Text);
                    cnn.Open();
                    cmd.ExecuteNonQuery();
                }
                cnn.Close();

            }
            lbSuccess.Text = "Nhập hàng thành công";
            HienBangGia();
        }
    }
}