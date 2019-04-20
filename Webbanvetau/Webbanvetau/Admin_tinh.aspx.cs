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
    public partial class Admin_tinh : System.Web.UI.Page
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
                    HienTP();
                    btnsua.Enabled = false;
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        public void HienTP()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand Cmd = new SqlCommand("select * from tblthanhpho", con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(Cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        grv_sp.DataSource = dt;
                        grv_sp.DataBind();
                    }
                }
            }
        }//Hien

        protected void grv_sp_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.ToLower().Equals("xoa"))
            {
                int mak = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection Cnnxoa = new SqlConnection(connectionString))
                {
                    using (SqlCommand Cmd1 = new SqlCommand("spThanhpho_Delete", Cnnxoa))
                        try
                        {
                            Cmd1.CommandType = CommandType.StoredProcedure;
                            Cmd1.Parameters.AddWithValue("@matp", mak);
                            Cnnxoa.Open();
                            Cmd1.ExecuteNonQuery();
                            Response.Write("<script> alert('Xóa thành công!')</script>");
                        }
                        catch (Exception) { Response.Write("<script> alert('Không xóa được!')</script>"); }
                    HienTP();
                }//cnn
            }//xoa  
            if (e.CommandName == "sua")
            {
                btnthem.Enabled = false;
                btnsua.Enabled = true;
                ImageButton ib = (ImageButton)e.CommandSource;
                int index = Convert.ToInt32(ib.CommandArgument);
                GridViewRow row = grv_sp.Rows[index];

                Label lma = (Label)row.FindControl("lMathanhpho");
                Label lten = (Label)row.FindControl("lTp");

                txtThanhpho.Text = lten.Text;
                hdtest.Value = lma.Text;
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
            HienTP();
        }

        protected void grv_sp_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            /*Hide*/
            //e.Row.Cells[0].Visible = false;
            grv_sp.Columns[0].Visible = false;
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
                    HienTP();
                }
            }
            else
            {
                Response.Write("<script>alert('Bạn chưa nhập từ khóa tìm kiếm !')</script>");
            }
        }

        protected void btnthem_Click(object sender, EventArgs e)
        {
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection cnn = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand("spThanhpho_Insert", cnn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@tentp", txtThanhpho.Text);
                    cnn.Open();
                    cmd.ExecuteNonQuery();
                }
                cnn.Close();

            }
            lbSuccess.Text = "Nhập thành công";
            HienTP();
        }

        protected void btnsua_Click(object sender, EventArgs e)
        {
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection cnn = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand("spThanhpho_Update", cnn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@matp", hdtest.Value);
                    cmd.Parameters.AddWithValue("@tentp", txtThanhpho.Text);
                    cnn.Open();
                    cmd.ExecuteNonQuery();
                }
                cnn.Close();
            }
            lbSuccess.Text = "Sửa thành công";
            HienTP();
        }
    }
}