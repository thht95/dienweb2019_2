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
using Webbanvetau.App_Code;

namespace Webbanvetau
{
    public partial class Admin_ghe : System.Web.UI.Page
    {
        public string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
        string currentLink = HttpContext.Current.Request.Url.PathAndQuery;
        myfunction mf = new myfunction();
        protected void Page_Load(object sender, EventArgs e)
        {
            lbSuccess.Text = "";
            if (!this.IsPostBack)
            {
                string session = Convert.ToString(Session["TAIKHOAN"]);
                if (session != null && (session == "qltau" || session == "admin"))
                {
                    btnsua.Enabled = false;
                    fillTau();
                    fillTrangthai();
                    fillLoaiToa();
                    HienGhe();
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }
        public void fillTrangthai(){
            ddlTrangthai.Items.Clear();
            //ListItem item = new ListItem();
            //item.Text = "Còn Trống";
            //item.Value = "0";
            ddlTrangthai.Items.Insert(0, new ListItem("Mặc định-Còn trống", "0"));
            ddlTrangthai.Items.Insert(1, new ListItem("Đã có vé", "1"));

        }
        public void HienGhe()
        {
            mf.exeProcToShow("spGhe_View",grv_sp,null);
        }//Hien
        private void fillTau()
        {
            string sql = "Select * from tbltau";
            mf.fillDropdownList(ddlTau, sql, "matau", "tentau", "--Chọn Tàu--");
            mf.fillDropdownList(ddlTau_view, sql, "matau", "tentau", "--Chọn Tàu--");
            ddlToa.Text = "--Chọn Loại Toa--";
            ddlToa_view.Items.Add( "--Vui lòng chọn tàu trước--");

        }
        private void fillToa(string matau)
        {
            string sql = "Select matoa, tentoa from tbltoatau WHERE matau='" + matau + "'";
            mf.fillDropdownList(ddlToa,sql,"matoa","tentoa","--Chọn Toa--");
            txtGhe.Attributes.Add("placeholder","Nhập số ghế muốn thêm");

        }
        private void fillToa_view(string matau)
        {
            string sql = "Select matoa, tentoa from tbltoatau WHERE matau='" + matau + "'";
            mf.fillDropdownList(ddlToa_view, sql, "matoa", "tentoa", "--Chọn Toa--");

        }

        protected void grv_sp_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.ToLower().Equals("xoa"))
            {
                int mak = Convert.ToInt32(e.CommandArgument);
                mf.param.Add("@maghe", mak);
                bool kq = mf.exeProc("spGhe_Delete", mf.param);
                if (kq) { lbSuccess.Text = "Xóa thành công"; }
                else lberror.Text = "Có lỗi!";
                HienGhe();
            }//xoa  
            if (e.CommandName == "sua")
            {
                btnthem.Enabled = false;
                btnsua.Enabled = true;
                ImageButton ib = (ImageButton)e.CommandSource;
                int index = Convert.ToInt32(ib.CommandArgument);
                GridViewRow row = grv_sp.Rows[index];

              
                Label lmaghe = (Label)row.FindControl("lMaghe");
                Label ltenghe = (Label)row.FindControl("lTenghe");
                Label lmatoa = (Label)row.FindControl("lMatoa");
                Label lMatau = (Label)row.FindControl("lMatau");
                Label ltinhtrang = (Label)row.FindControl("lTinhtrangghe");
                fillToa(lMatau.Text);
                ddlTau.Text = lMatau.Text;
                ddlToa.Text = lmatoa.Text;
                ddlTrangthai.Text = ltinhtrang.Text;
                txtGhe.Text = ltenghe.Text;
                hdtest.Value = lmaghe.Text;
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
            HienGhe();
        }


        protected void btnsua_Click(object sender, EventArgs e)
        {
            using (SqlConnection cnn = new SqlConnection(conString))
                try
                {
                    cnn.Open();
                    SqlDataAdapter da = new SqlDataAdapter("Select * from tbltoaghe where tenghe = N'" + txtGhe.Text + "' and matoa = '" + ddlToa.SelectedValue + "'", cnn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        Response.Write("<script> alert('Toa đã có ghế này, Vui lòng chọn toa hoặc ghế khác!')</script>");
                    }
                    else if (dt.Rows.Count == 0)
                    {
                        SqlCommand cmd = new SqlCommand("spGhe_Update", cnn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@maghe", hdtest.Value);
                        cmd.Parameters.AddWithValue("@tenghe", txtGhe.Text);
                        cmd.Parameters.AddWithValue("@matoa", ddlToa.SelectedValue);
                        cmd.Parameters.AddWithValue("@tinhtrangghe", 0);
                        cmd.ExecuteNonQuery();
                        cmd.Dispose();
                        cnn.Close();
                        lbSuccess.Text = "Sửa thành công";
                    }
                }
                finally
                {
                    cnn.Close();
                }
            HienGhe();
        }

        protected void grv_sp_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            /*Hide*/
            //e.Row.Cells[0].Visible = false;
            grv_sp.Columns[2].Visible = false;
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
                    HienGhe();
                }
            }
            else
            {
                Response.Write("<script>alert('Bạn chưa nhập từ khóa tìm kiếm !')</script>");
            }
        }

        protected void btnthem_Click(object sender, EventArgs e)
        {

            using (SqlConnection con = new SqlConnection(conString))
                try
                {
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter("Select tenghe from tbltoaghe where tenghe = N'" + txtGhe.Text + "' and matoa = '" + ddlToa.SelectedValue + "'", con);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    if (dt.Rows.Count > 0)
                    {
                        Response.Write("<script> alert('Toa đã có ghế này, Vui lòng chọn toa hoặc ghế khác!')</script>");
                    }
                    else if (dt.Rows.Count == 0)
                    {
                        SqlDataAdapter da2 = new SqlDataAdapter("Select Count(maghe) as tong from tbltoaghe where  matoa ='" + ddlToa.SelectedValue + "'", con);
                        DataTable dt2 = new DataTable();
                        da2.Fill(dt2);
                        if (int.Parse(dt2.Rows[0][0].ToString()) < 30) {
                            SortedList param = new SortedList();
                            param.Add("@tenghe", txtGhe.Text);
                            param.Add("@matoa", ddlToa.SelectedValue);
                            param.Add("@tinhtrangghe", ddlTrangthai.SelectedValue);
                            bool kq = mf.exeProc("spGhe_Insert", param);
                            if (kq) { lbSuccess.Text = "Thêm thành công!"; }
                            else lberror.Text = "Có lỗi!";
                        }
                        else lberror.Text = "Tổng số ghế không vượt quá 30!";
                        
                    }
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
            HienGhe();
        }

        //protected void ddlTau_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    int matau = int.Parse(ddlTau.SelectedValue.ToString());
        //    fillToa(matau);
        //}

        protected void ddlTau_SelectedIndexChanged(object sender, EventArgs e)
        {
            string matau = ddlTau.SelectedIndex.ToString();
            fillToa(matau);
        }

        protected void ddlToa_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlTau_view_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlTau_view.Text == "--Chọn Tàu--")
            {
                mf.param.Add("@matau", null);
                mf.param.Add("@matoa", null);
            }
            else
            {
                string matau = ddlTau_view.SelectedIndex.ToString();
                fillToa_view(matau);
                mf.param.Add("@matau", matau);
                mf.param.Add("@matoa", null);
            }
            string tong =mf.exeProcToShow2("spGhe_View", grv_sp, mf.param);
            txtTong.Text = "Tìm thấy " + tong + " dòng dữ liệu!";

        }

        protected void ddlToa_view_SelectedIndexChanged(object sender, EventArgs e)
        {
            int matau = ddlTau_view.SelectedIndex;
            int matoa = ddlToa_view.SelectedIndex;
            mf.param.Add("@matau", matau);
            mf.param.Add("@matoa", matoa);
            string tong =mf.exeProcToShow2("spGhe_View", grv_sp,mf.param);
            txtTong.Text = "Tìm thấy " + tong + " dòng dữ liệu!";

        }
        private void fillLoaiToa()
        {
            string sql = "Select * from tblloaitoa";
            mf.fillDropdownList(ddlLoaicho, sql, "maloaitoa", "tenloaitoa", "--Chọn Loại toa--");
        }
        protected void ddlLoaicho_SelectedIndexChanged(object sender, EventArgs e)
        {
            mf.param.Add("@maloaitoa", ddlLoaicho.SelectedValue);
            string tong = mf.exeProcToShow2("spGhe_ViewBy", grv_sp, mf.param);
            txtTong.Text = "Tìm thấy " + tong + " dòng dữ liệu!";
        }

    }
}