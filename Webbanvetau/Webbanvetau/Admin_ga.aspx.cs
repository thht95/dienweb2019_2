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
    public partial class Admin_ga : System.Web.UI.Page
    {
        public string connectionString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
        string currentLink = HttpContext.Current.Request.Url.PathAndQuery;
        protected void Page_Load(object sender, EventArgs e)
        {
            lbSuccess.Text = "";
            if (!this.IsPostBack)
            {
                string session = Convert.ToString(Session["TAIKHOAN"]);
                if (session != null && (session == "qllichtrinh" || session == "admin"))
                {
                    fillThanhpho();
                    HienGa();
                    btnsua.Enabled = false;
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        public void HienGa()
        {
            using (SqlConnection CnnHiensp = new SqlConnection(connectionString))
            {
                using (SqlCommand CmdHiensp = new SqlCommand("select * from tblgatau, tblthanhpho where tblgatau.matp = tblthanhpho.matp", CnnHiensp))
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
        private void fillThanhpho()
        {
            ddtp.Items.Clear();
            ddtp.Items.Add("--Chọn thành phố--");
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conString))
            {
                string cmdString = "Select * from tblthanhpho";
                using (SqlCommand cmd = new SqlCommand(cmdString, con))
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            ListItem imageItem = new ListItem();
                            imageItem.Value = dr["matp"].ToString();
                            imageItem.Text = dr["tentp"].ToString();
                            ddtp.Items.Add(imageItem);
                        }
                        dr.Close();
                    }
                    else
                    {
                        ListItem error = new ListItem();
                        error.Text = "Lỗi";
                        ddtp.Items.Add(error);
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
                    using (SqlCommand Cmd1 = new SqlCommand("spGa_Delete", Cnnxoa))
                        try
                        {
                            Cmd1.CommandType = CommandType.StoredProcedure;
                            Cmd1.Parameters.AddWithValue("@maga", mak);
                            Cnnxoa.Open();
                            Cmd1.ExecuteNonQuery();
                            Response.Write("<script> alert('Xóa thành công!')</script>");
                        }
                        catch (Exception) { Response.Write("<script> alert('Không xóa được!')</script>"); }
                    HienGa();
                }//cnn
            }//xoa  
            if (e.CommandName == "sua")
            {
                btnOk.Enabled = false;
                btnsua.Enabled = true;
                ImageButton ib = (ImageButton)e.CommandSource;
                int index = Convert.ToInt32(ib.CommandArgument);
                GridViewRow row = grv_sp.Rows[index];

                Label ltenga = (Label)row.FindControl("lbTenga");
                Label lmaga = (Label)row.FindControl("lbMaga");
                Label lmatp = (Label)row.FindControl("lbMatp");

                txtga.Text = ltenga.Text;
                ddtp.Text = lmatp.Text;
                hdtest.Value = lmaga.Text;
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
            HienGa();
        }

        protected void btnOk_Click(object sender, EventArgs e)
        {
            btnsua.Enabled = false;

            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            SqlConnection cnn = new SqlConnection(conString);
            try
            {
                cnn.Open();
                SqlDataAdapter da = new SqlDataAdapter("Select * from tblgatau where tenga = N'" + txtga.Text + "'", cnn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    Response.Write("<script> alert('Ga đã tồn tại!')</script>");
                    txtga.Focus();
                    txtga.Attributes.Add("onfocusin", " select();");
                }
                else if (dt.Rows.Count == 0)
                {
                    SqlCommand cmd = new SqlCommand("spGa_Insert", cnn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@maga", SqlDbType.Int).Direction = ParameterDirection.Output;
                    cmd.Parameters.AddWithValue("@tenga", txtga.Text);
                    cmd.Parameters.AddWithValue("@matp", ddtp.SelectedValue);
                    cmd.ExecuteNonQuery();
                    cmd.Dispose();
                    cnn.Close();
                    lbSuccess.Text = "Nhập hàng thành công";
                }
            }
            finally
            {
                cnn.Close();
            }
            HienGa();
        }



        protected void btnsua_Click(object sender, EventArgs e)
        {
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection cnn = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand("spGa_Update", cnn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@maga", hdtest.Value);
                    cmd.Parameters.AddWithValue("@tenga", txtga.Text);
                    cmd.Parameters.AddWithValue("@matp", ddtp.SelectedValue);
                    cnn.Open();
                    cmd.ExecuteNonQuery();
                }
                cnn.Close();
            }
            lbSuccess.Text = "Sửa thành công";

            HienGa();
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
                    HienGa();
                }
            }
            else
            {
                Response.Write("<script>alert('Bạn chưa nhập từ khóa tìm kiếm !')</script>");
            }
        }
    }
}