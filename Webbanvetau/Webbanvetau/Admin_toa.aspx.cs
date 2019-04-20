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
    public partial class Admin_toa : System.Web.UI.Page
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
                    fillLoaiToa();
                    fillTau();
                    HienToa();
                    btnsua.Enabled = false;
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }

            }
        }

        public void HienToa()
        {

            string sql = "select * from tbltau, tbltoatau, tblloaitoa where tbltau.matau = tbltoatau.matau and tblloaitoa.maloaitoa = tbltoatau.maloaitoa";
            mf.showByGrid(grv_sp,sql);   
        }
        private void fillLoaiToa()
        {
                string sql = "Select * from tblloaitoa";
                mf.fillDropdownList(ddltoa, sql,"maloaitoa","tenloaitoa","--Chọn Loại toa--");
        }

        private void fillTau()
        {
            string sql = "Select * from tbltau";
            mf.fillDropdownList(ddTau,sql,"matau","tentau","--Chọn Tàu--");
            
        }
        protected void grv_sp_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.ToLower().Equals("xoa"))
            {
                int mak = Convert.ToInt32(e.CommandArgument);
                SortedList param = new SortedList();
                param.Add("@matoa", mak);
                bool kq = mf.exeProc("spToa_Delete", param);
                if (kq) { lbSuccess.Text = "Xóa thành công"; }
                else lberror.Text = "Có lỗi!";
                HienToa();
            }
            if (e.CommandName == "sua")
            {
                btnthem.Enabled = false;
                btnsua.Enabled = true;
                ImageButton ib = (ImageButton)e.CommandSource;
                int index = Convert.ToInt32(ib.CommandArgument);
                GridViewRow row = grv_sp.Rows[index];

                Label lmatoa = (Label)row.FindControl("lMatoa");
                Label ltentoa = (Label)row.FindControl("lTentoa");
                Label lmaloaitoa = (Label)row.FindControl("lMaloaitoa");
                Label lmatau = (Label)row.FindControl("lMatau");
                txtToa.Text = ltentoa.Text;
                ddltoa.Text = lmaloaitoa.Text;
                ddTau.Text = lmatau.Text;
                hdtest.Value = lmatoa.Text;
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
            HienToa();
        }


        protected void btnsua_Click(object sender, EventArgs e)
        {
            if (ddltoa.Text == "--Chọn Loại Toa--")
            {
                Response.Write("<script> alert('Bạn chưa chọn loại toa')</script>");
            }
            if (ddltoa.Text == "--Chọn Tàu--")
            {
                Response.Write("<script> alert('Bạn chưa chọn tàu')</script>");
            }
            else
            {
                SortedList param = new SortedList();
                param.Add("@matoa", hdtest.Value);
                param.Add("@tentoa", txtToa.Text);
                param.Add("@maloaitoa", ddltoa.SelectedValue);
                param.Add("@matau", ddTau.SelectedValue);
                bool kq = mf.exeProc("spToa_Update", param);
                if (kq) { lbSuccess.Text = "Sửa thành công"; }
                else lberror.Text = "Có lỗi!";
                HienToa();
            }
        }

        protected void grv_sp_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            /*Hide*/
            //e.Row.Cells[0].Visible = false;
            //grv_sp.Columns[0].Visible = false;
            grv_sp.Columns[1].Visible = false;
            grv_sp.Columns[2].Visible = false;
            /*Show*/
            //e.Row.Cells[3].Visible = true;
        }

        protected void btnTimkiem_Click(object sender, EventArgs e)
        {
            if (txtTimkiem.Text != string.Empty)
            {
                //string sql = "SELECT * FROM tbltoatau as toa JOIN  tbltau as tau ON toa.matau = tau.matau JOIN  tblloaitoa as loaitoa ON toa.maloaitoa = loaitoa.maloaitoa WHERE tentoa like '%" + txtTimkiem.Text + "%' OR tentau like '%"+ txtTimkiem.Text +"%' OR tenloaitoa like N'%"+ txtTimkiem.Text +"%'";
                //mf.showByGrid(grv_sp,sql);
                SortedList param = new SortedList();
                param.Add("@searchkey", txtTimkiem.Text);
                mf.exeProcToShow("spToa_Search",grv_sp,param);
                if (grv_sp.Rows.Count == 0)
                {
                    Response.Write("<script> alert('Không có dữ liệu')</script>");
                    HienToa();
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
            if (ddltoa.Text == "--Chọn Loại Toa--")
            {
                Response.Write("<script> alert('Bạn chưa chọn loại toa')</script>");
            }
            if (ddltoa.Text == "--Chọn Tàu--")
            {
                Response.Write("<script> alert('Bạn chưa chọn tàu')</script>");
            }
            else
            {
                SortedList param = new SortedList();
                param.Add("@tentoa", txtToa.Text);
                param.Add("@maloaitoa", ddltoa.SelectedValue);
                param.Add("@matau", ddTau.SelectedValue);
                bool kq=mf.exeProc("spToa_Insert", param);
                if (kq) { lbSuccess.Text = "Thêm thành công"; }
                else lberror.Text = "Có lỗi!";
                HienToa();
            }
        }
    }
}