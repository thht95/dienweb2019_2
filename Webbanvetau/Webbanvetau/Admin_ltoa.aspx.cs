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

    public partial class Admin_ltoa : System.Web.UI.Page
    {
        public string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
        string currentLink = HttpContext.Current.Request.Url.PathAndQuery;
        protected void Page_Load(object sender, EventArgs e)
        {
            lbSuccess.Text = "";
            if (!this.IsPostBack)
            {
                string session = Convert.ToString(Session["TAIKHOAN"]);
                if (session != null && (session == "qltau" || session == "admin"))
                {
                    HienLToa();
                    btnsua.Enabled = false;
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        public void HienLToa()
        {
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlCommand Cmd = new SqlCommand("select * from tblloaitoa", con))
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
                int mat = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection Cnnxoa = new SqlConnection(conString))
                {
                    using (SqlCommand Cmd1 = new SqlCommand("spLoaitoa_Delete", Cnnxoa))
                        try
                        {
                            Cmd1.CommandType = CommandType.StoredProcedure;
                            Cmd1.Parameters.AddWithValue("@maloaitoa", mat);
                            Cnnxoa.Open();
                            Cmd1.ExecuteNonQuery();
                            Response.Write("<script> alert('Xóa thành công!')</script>");
                        }
                        catch (Exception) { Response.Write("<script> alert('Không xóa được!')</script>"); }
                    HienLToa();
                }//cnn
            }//xoa  
            if (e.CommandName == "sua")
            {
                btnthem.Enabled = false;
                btnsua.Enabled = true;
                ImageButton ib = (ImageButton)e.CommandSource;
                int index = Convert.ToInt32(ib.CommandArgument);
                GridViewRow row = grv_sp.Rows[index];

                Label lLt = (Label)row.FindControl("lTenloai");
                Label lMaloai = (Label)row.FindControl("lMaloai");
                Label lGiatien = (Label)row.FindControl("lGiatien");

                txtLoaitoa.Text = lLt.Text;
                txtGia.Text = lGiatien.Text;
                hdtest.Value = lMaloai.Text;
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
            HienLToa();
        }

        protected void grv_sp_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            /*Hide*/
            //e.Row.Cells[0].Visible = false;
            //grv_sp.Columns[0].Visible = false;
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
                    string sql = "select * from tblloaitoa where tenloaitoa like '%" + txtTimkiem.Text + "%' OR giatien like '%" + txtTimkiem.Text + "%'";
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
                    HienLToa();
                }
            }
            else
            {
                Response.Write("<script>alert('Bạn chưa nhập từ khóa tìm kiếm !')</script>");
            }
        }

        protected void btnthem_Click(object sender, EventArgs e)
        {
            using (SqlConnection cnn = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand("spLoaitoa_Insert", cnn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@maloaitoa", SqlDbType.Int).Direction = ParameterDirection.Output;
                    cmd.Parameters.AddWithValue("@tenloaitoa", txtLoaitoa.Text);
                    cmd.Parameters.AddWithValue("@giatien", txtGia.Text);
                    cnn.Open();
                    cmd.ExecuteNonQuery();
                }
                cnn.Close();

            }
            lbSuccess.Text = "Nhập hàng thành công";
            HienLToa();
        }

        protected void grv_sp_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnsua_Click(object sender, EventArgs e)
        {
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection cnn = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand("spLoaitoa_Update", cnn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@maloaitoa", hdtest.Value);
                    cmd.Parameters.AddWithValue("@tenloaitoa", txtLoaitoa.Text);
                    cmd.Parameters.AddWithValue("@giatien", txtGia.Text);
                    cnn.Open();
                    cmd.ExecuteNonQuery();
                }
                cnn.Close();
            }
            txtLoaitoa.Text = "";
            txtGia.Text = "";
            lbSuccess.Text = "Sửa thành công";
            HienLToa();
        }
    }
}