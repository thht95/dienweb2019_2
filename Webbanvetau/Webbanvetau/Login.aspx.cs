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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                Session.Abandon();
            }
        }

        protected void btdangnhap_Click(object sender, EventArgs e)
        {
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            SqlConnection cnn = new SqlConnection(conString);
            try
            {
                cnn.Open();
            }
            catch (SqlException ex)
            {
                Response.Write("<script> alert('Kết nối thất bại!')</script>");
            }
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = cnn;
            cmd.CommandText = "SELECT * FROM tbltaikhoan where taikhoan = '" + txtdangnhap.Text + "' AND matkhau ='" + txtmatkhau.Text + "'";
            SqlDataAdapter dt = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            dt.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Session["TAIKHOAN"] = ds.Tables[0].Rows[0]["taikhoan"].ToString();
                Session["MATKHAU"] = ds.Tables[0].Rows[0]["matkhau"].ToString();
                Session["QUYENHAN"] = ds.Tables[0].Rows[0]["maquyenhan"].ToString();
                if ((Session["QUYENHAN"].Equals("1")))
                {
                    Session["TAIKHOAN"] = txtdangnhap.Text.Trim();
                    Response.Redirect("Admin.aspx");
                }
                if ((Session["QUYENHAN"].Equals("4")))
                {
                    Session["TAIKHOAN"] = txtdangnhap.Text.Trim();
                    Response.Redirect("Admin_chuyentau.aspx");
                }
                if ((Session["QUYENHAN"].Equals("3")))
                {
                    Session["TAIKHOAN"] = txtdangnhap.Text.Trim();
                    Response.Redirect("Admin_tau.aspx");
                }
                if ((Session["QUYENHAN"].Equals("2")))
                {
                    Session["TAIKHOAN"] = txtdangnhap.Text.Trim();
                    Response.Redirect("Admin.aspx");
                }
            }
            else
            {
                lbBaoLoi.Text = "<script>alert('Tên đăng nhập hoặc mật khẩu sai!')</script>";
            }
        }
    }
}
