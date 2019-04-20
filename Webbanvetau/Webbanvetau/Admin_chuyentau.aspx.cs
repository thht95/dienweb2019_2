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
    public partial class Admin_chuyentau : System.Web.UI.Page
    {
        public string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
        string currentLink = HttpContext.Current.Request.Url.PathAndQuery;
        protected void Page_Load(object sender, EventArgs e)
        {
            lbSuccess.Text = "";
            if (!this.IsPostBack)
            {
                string session = Convert.ToString(Session["TAIKHOAN"]);
                if (session != null && (session == "qllichtrinh" || session == "admin"))
                {
                    fillTau();
                    fillGadi();
                    fillGaden();
                    HienChuyenTau();
                    btnsua.Enabled = false;
                    //cvSSngay.ValueToCompare = DateTime.Now.ToShortDateString();
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        public void HienChuyenTau()
        {
            using (SqlConnection CnnHiensp = new SqlConnection(conString))
            {
                using (SqlCommand CmdHiensp = new SqlCommand("spLichtrinh", CnnHiensp))
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
                using (SqlConnection Cnnxoa = new SqlConnection(conString))
                {
                    using (SqlCommand Cmd1 = new SqlCommand("spLichtrinh_Delete", Cnnxoa))
                        try
                        {
                            Cmd1.CommandType = CommandType.StoredProcedure;
                            Cmd1.Parameters.AddWithValue("@malichtrinh", mak);
                            Cnnxoa.Open();
                            Cmd1.ExecuteNonQuery();
                            Response.Write("<script> alert('Xóa thành công!')</script>");
                        }
                        catch (Exception) { Response.Write("<script> alert('Không xóa được!')</script>"); }
                    HienChuyenTau();
                }//cnn
            }//xoa  
            if (e.CommandName == "sua")
            {
                btnthem.Enabled = false;
                btnsua.Enabled = true;
                ImageButton ib = (ImageButton)e.CommandSource;
                int index = Convert.ToInt32(ib.CommandArgument);
                GridViewRow row = grv_sp.Rows[index];

                Label lmachuyentau = (Label)row.FindControl("lMachuyentau");
                Label lngaydi = (Label)row.FindControl("lNgaydi");
                Label lgiodi = (Label)row.FindControl("lGiodi");
                Label lngayden = (Label)row.FindControl("lNgayden");
                Label lgioden = (Label)row.FindControl("lGioden");
                Label lmatau = (Label)row.FindControl("lMatau");
                Label lgadi = (Label)row.FindControl("lGadi");
                Label lgaden = (Label)row.FindControl("lGaden");

                ddtau.Text = lmatau.Text;
                ddlGadi.Text = lgadi.Text;
                ddlGaden.Text = lgaden.Text;
                txtNgayden.Text = lngayden.Text;
                txtNgaydi.Text = lngaydi.Text;
                txtGiodi.Text = lgiodi.Text;
                txtGioden.Text = lgioden.Text;
                hdtest.Value = lmachuyentau.Text;
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
            HienChuyenTau();
        }


        protected void btnsua_Click(object sender, EventArgs e)
        {
            string strStrdate = txtNgaydi.Text + " " + txtGiodi.Text;
            string strEnddate = txtNgayden.Text + " " + txtGioden.Text;
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection cnn = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand("spLichtrinh_Update", cnn))
                {
                    string strNgaydi = Convert.ToDateTime(strStrdate).ToString("dd/MM/yyyy HH:mm");
                    string strNgayden = Convert.ToDateTime(strEnddate).ToString("dd/MM/yyyy HH:mm");
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@malichtrinh", hdtest.Value);
                    cmd.Parameters.AddWithValue("@matau", ddtau.SelectedValue);
                    cmd.Parameters.AddWithValue("@magadi", ddlGadi.SelectedValue);
                    cmd.Parameters.AddWithValue("@magaden", ddlGaden.SelectedValue);
                    cmd.Parameters.Add("@ngaydi", SqlDbType.DateTime);
                    cmd.Parameters.Add("@ngayden", SqlDbType.DateTime);
                    cmd.Parameters["@ngaydi"].Value = strNgaydi;
                    cmd.Parameters["@ngayden"].Value = strNgayden;
                    cnn.Open();
                    cmd.ExecuteNonQuery();
                }
                cnn.Close();
            }
            lbSuccess.Text = "Sửa thành công";
            HienChuyenTau();
        }

        protected void grv_sp_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            /*Hide*/
            //e.Row.Cells[0].Visible = false;
            grv_sp.Columns[0].Visible = false;
            grv_sp.Columns[1].Visible = false;
            grv_sp.Columns[2].Visible = false;
            grv_sp.Columns[3].Visible = false;
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
                    HienChuyenTau();
                }
            }
            else
            {
                Response.Write("<script>alert('Bạn chưa nhập từ khóa tìm kiếm !')</script>");
            }
        }

        protected void btnthem_Click(object sender, EventArgs e)
        {
            string strStrdate = txtNgaydi.Text + " " + txtGiodi.Text;
            string strEnddate = txtNgayden.Text + " " + txtGioden.Text;
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection cnn = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand("spLichtrinh_Insert", cnn))
                {

                    string strNgaydi = Convert.ToDateTime(strStrdate).ToString("dd/MM/yyyy HH:mm");
                    string strNgayden = Convert.ToDateTime(strEnddate).ToString("dd/MM/yyyy HH:mm");
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@matau", ddtau.SelectedValue);
                    cmd.Parameters.AddWithValue("@magadi", ddlGadi.SelectedValue);
                    cmd.Parameters.AddWithValue("@magaden", ddlGaden.SelectedValue);
                    cmd.Parameters.Add("@ngaydi", SqlDbType.DateTime);
                    cmd.Parameters.Add("@ngayden", SqlDbType.DateTime);
                    cmd.Parameters["@ngaydi"].Value = strNgaydi;
                    cmd.Parameters["@ngayden"].Value = strNgayden;
                    cnn.Open();
                    cmd.ExecuteNonQuery();
                }
                cnn.Close();

            }
            lbSuccess.Text = "Nhập thành công";
            HienChuyenTau();
        }
    }
}