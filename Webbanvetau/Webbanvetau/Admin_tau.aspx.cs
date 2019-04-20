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
    public partial class Admin_tau : System.Web.UI.Page
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
                    HienTau();
                    btnsua.Enabled = false;
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        public void HienTau()
        {
            string sql = "select * from tbltau";
            mf.showByGrid(grv_sp,sql);
        }

        protected void grv_sp_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.ToLower().Equals("xoa"))
            {
                int mat = Convert.ToInt32(e.CommandArgument);
                SortedList param = new SortedList();
                param.Add("@matau", mat);
                bool kq = mf.exeProc("spTau_Delete",param);
                if (kq) { lbSuccess.Text = "Xóa thành công"; }
                else lberror.Text = "Có lỗi!";
                HienTau();//cnn
            }//xoa  
            if (e.CommandName == "sua")
            {
                btnthem.Enabled = false;
                btnsua.Enabled = true;
                ImageButton ib = (ImageButton)e.CommandSource;
                int index = Convert.ToInt32(ib.CommandArgument);
                GridViewRow row = grv_sp.Rows[index];
                Label lt = (Label)row.FindControl("lTentau");
                Label lMatau = (Label)row.FindControl("lMatau");
                Label lgia = (Label)row.FindControl("lGiatien");
                txtGia.Text = lgia.Text;
                txtTau.Text = lt.Text;
                message.Value = lMatau.Text;
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
            HienTau();
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
                string sql = "select * from tbltau where tentau like '%" + txtTimkiem.Text + "%' OR giatien like '%"+ txtTimkiem.Text +"%'";
                mf.showByGrid(grv_sp, sql);
                if (grv_sp.Rows.Count == 0)
                {
                    Response.Write("<script> alert('Không có dữ liệu')</script>");
                    HienTau();
                }
            }
            else
            {
                Response.Write("<script>alert('Bạn chưa nhập từ khóa tìm kiếm !')</script>");
            }
        }

        protected void btnthem_Click(object sender, EventArgs e)
        {
            SortedList param = new SortedList();
            param.Add("@tentau", txtTau.Text);
            param.Add("@giatien", txtGia.Text);
            bool kq = mf.exeProc("spTau_Insert", param);
            if (kq) { lbSuccess.Text = "Thêm thành công"; }
            else { lberror.Text = "Có lỗi!"; }
            HienTau();
        }

        protected void grv_sp_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void btnsua_Click(object sender, EventArgs e)
        {
            SortedList param = new SortedList();
            param.Add("@matau", message.Value);
            param.Add("@tentau", txtTau.Text);
            param.Add("@giatien", txtGia.Text);
            bool kq = mf.exeProc("spTau_Update", param);
            if (kq){ lbSuccess.Text = "Sửa thành công";}
            else lberror.Text = "Có lỗi!";
            HienTau();
        }

    }
}