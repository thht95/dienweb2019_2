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
    public partial class Admin : System.Web.UI.Page
    {
        public string connectionString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
        string currentLink = HttpContext.Current.Request.Url.PathAndQuery;
        protected void Page_Load(object sender, EventArgs e)
        {
            lbSuccess.Text = "";
            if (!this.IsPostBack)
            {
                string session = Convert.ToString(Session["TAIKHOAN"]);
                if (session == "admin" || session == "qlve")
                {
                    fillGadi();
                    fillGaden();
                    fillTau();
                    fillToa();
                    fillGhe();
                    fillTinhtrang();
                    fillKhach();
                    HienVeTau();
                    btnsua.Enabled = false;
                    //cvSSngay.ValueToCompare = DateTime.Now.ToShortDateString();
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        private void Capnhat(string sql)
        {
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    con.Open();
                    cmd.CommandText = sql;
                    cmd.Connection = con;
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
        }

        private void Capnhat_add(string sql)
        {
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    con.Open();
                    cmd.CommandText = sql;
                    cmd.Connection = con;
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
        }

        public void HienVeTau()
        {
            using (SqlConnection CnnHiensp = new SqlConnection(connectionString))
            {
                using (SqlCommand CmdHiensp = new SqlCommand("spVetau", CnnHiensp))
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

        private void fillKhach()
        {
            ddKhach.Items.Clear();
            ddKhach.Items.Add("--Chọn khách--");
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conString))
            {
                string cmdString = "Select * from tblkhachhang";
                using (SqlCommand cmd = new SqlCommand(cmdString, con))
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            ListItem imageItem = new ListItem();
                            imageItem.Value = dr["makh"].ToString();
                            imageItem.Text = dr["hoten"].ToString();
                            ddKhach.Items.Add(imageItem);
                        }
                        dr.Close();
                    }
                    else
                    {
                        ListItem error = new ListItem();
                        error.Text = "Lỗi";
                        ddKhach.Items.Add(error);
                    }
                }
                con.Close();
            }
        }

        private void fillTinhtrang()
        {
            ddTinhtrang.Items.Clear();
            ddTinhtrang.Items.Add("--Chọn tình trạng vé--");
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conString))
            {
                string cmdString = "Select * from tbltinhtrangve";
                using (SqlCommand cmd = new SqlCommand(cmdString, con))
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            ListItem imageItem = new ListItem();
                            imageItem.Value = dr["matinhtrang"].ToString();
                            imageItem.Text = dr["tinhtrang"].ToString();
                            ddTinhtrang.Items.Add(imageItem);
                        }
                        dr.Close();
                    }
                    else
                    {
                        ListItem error = new ListItem();
                        error.Text = "Lỗi";
                        ddTinhtrang.Items.Add(error);
                    }
                }
                con.Close();
            }
        }

        private void fillTau()
        {
            ddtau.Items.Clear();
            ddtau.Items.Add("--Chọn tàu--");
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conString))
            {
                string cmdString = "select tbllichtrinh.matau, tentau from tbltau, tbllichtrinh where tbltau.matau = tbllichtrinh.matau and malichtrinh = '" + hdmalichtrinh.Value + "'";
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
                        error.Text = "Vui lòng chọn ga đi - ga đến !";
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

                string cmdString = "Select * from tbltoatau where matau = '" + ddtau.SelectedValue + "'";
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
                        error.Text = "Vui lòng chọn tàu";
                        ddToa.Items.Add(error);
                    }
                }
                con.Close();
            }

        }

        private void fillGhe()
        {
            ddGhe.Items.Clear();
            ddGhe.Items.Add("--Chọn ghế--");
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conString))
            {
                string cmdString = "Select * from tbltoaghe where matoa = '" + ddToa.SelectedValue + "'";

                using (SqlCommand cmd = new SqlCommand(cmdString, con))
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            ListItem imageItem = new ListItem();
                            String matinhtrang = dr["tinhtrangghe"].ToString();
                            imageItem.Value = dr["maghe"].ToString();
                            imageItem.Text = dr["tenghe"].ToString();
                            ddGhe.Items.Add(imageItem);
                            if (matinhtrang == "1")
                            {
                                imageItem.Attributes.Add("style", "color:red;");
                                //imageItem.Attributes.Add("style", "background:green;");
                                imageItem.Attributes.Add("disabled", "true");
                                //imageItem.Value = "-1";
                            }
                        }
                        dr.Close();
                    }
                    else
                    {
                        ListItem error = new ListItem();
                        error.Text = "Vui lòng chọn toa!";
                        ddGhe.Items.Add(error);
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
                string cmdString = "select magadi, tenga from tbllichtrinh, tblgatau where tbllichtrinh.magadi = tblgatau.maga group by magadi, tenga";
                using (SqlCommand cmd = new SqlCommand(cmdString, con))
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            ListItem imageItem = new ListItem();
                            imageItem.Value = dr["magadi"].ToString();
                            imageItem.Text = dr["tenga"].ToString();
                            ddlGadi.Items.Add(imageItem);
                        }
                        dr.Close();
                    }
                    else
                    {
                        ListItem error = new ListItem();
                        error.Text = "Vui lòng chọn ga đi";
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
                string cmdString = "select magaden, tenga from tbllichtrinh, tblgatau where tbllichtrinh.magaden = tblgatau.maga and magadi = '" + ddlGadi.SelectedValue + "' group by magaden, tenga";
                using (SqlCommand cmd = new SqlCommand(cmdString, con))
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            ListItem imageItem = new ListItem();
                            imageItem.Value = dr["magaden"].ToString();
                            imageItem.Text = dr["tenga"].ToString();
                            ddlGaden.Items.Add(imageItem);
                        }
                        dr.Close();
                    }
                    else
                    {
                        ListItem error = new ListItem();
                        error.Text = "Vui lòng chọn ga đi";
                        ddlGaden.Items.Add(error);
                    }
                }
                con.Close();
            }
        }

        protected void grv_sp_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.ToLower().Equals("thanhtoan"))
            {
                ImageButton imb = (ImageButton)e.CommandSource;
                int mave = Convert.ToInt32(imb.CommandArgument);
                GridViewRow row = grv_sp.Rows[mave];

                Label lmaghe = (Label)row.FindControl("lMaghe");
                Label lmave = (Label)row.FindControl("lMave");

                Response.Write(lmaghe.Text.Trim());

                Capnhat("UPDATE tbltoaghe SET tinhtrangghe = '0' WHERE maghe='" + lmaghe.Text.Trim() + "'");
                Capnhat_add("UPDATE tblvetau SET matinhtrang = '2' WHERE mave='" + lmave.Text.Trim() + "'");
                lbSuccess.Text = "Thanh toán thành công";
                HienVeTau();
            }
            else if (e.CommandName == "sua")
            {
                btnthem.Enabled = false;
                btnsua.Enabled = true;
                ImageButton ib = (ImageButton)e.CommandSource;
                int index = Convert.ToInt32(ib.CommandArgument);
                GridViewRow row = grv_sp.Rows[index];

                Label lmatau = (Label)row.FindControl("lMatau");
                Label lgiatau = (Label)row.FindControl("lGiatau");
                Label lmatoa = (Label)row.FindControl("lMatoa");
                Label lmagadi = (Label)row.FindControl("lMagadi");
                Label lmagaden = (Label)row.FindControl("lMagaden");
                Label lgialichtrinh = (Label)row.FindControl("lGialichtrinh");
                Label lgiatoa = (Label)row.FindControl("lGiatoa");
                Label lkh = (Label)row.FindControl("lMakhach");
                Label lphantram = (Label)row.FindControl("lPhantram");
                Label lmatt = (Label)row.FindControl("lMaTT");
                Label lngayban = (Label)row.FindControl("lNgayban");
                Label lngaytra = (Label)row.FindControl("lNgaytra");
                Label lmave = (Label)row.FindControl("lMave");
                Label lmalt = (Label)row.FindControl("lMalichtrinh");
                Label lmaghe = (Label)row.FindControl("lMaghe");

                txtGiatau.Text = lgiatau.Text;
                txtGialichtrinh.Text = lgialichtrinh.Text;
                txtGiatoa.Text = lgiatoa.Text;
                ddKhach.Text = lkh.Text;
                txtPhantram.Text = lphantram.Text;
                ddTinhtrang.Text = lmatt.Text;
                txtNgayban.Text = lngayban.Text;
                hdtest.Value = lmave.Text;
                ddlGadi.Text = lmagadi.Text;
                hdmalichtrinh.Value = lmalt.Text;
                Hdmaghe.Value = lmaghe.Text;

                fillGaden();
                ddlGaden.Text = lmagaden.Text;
                fillTau();
                ddtau.Text = lmatau.Text;
                fillToa();
                ddToa.Text = lmatoa.Text;
                fillGhe();
                ddGhe.Text = lmaghe.Text;
                tinhTien();
            }//sua
            else if (e.CommandName.ToLower().Equals("xoa"))
            {
                int mak = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection Cnnxoa = new SqlConnection(connectionString))
                {
                    using (SqlCommand Cmd1 = new SqlCommand("spVetau_Delete", Cnnxoa))
                        try
                        {
                            Cmd1.CommandType = CommandType.StoredProcedure;
                            Cmd1.Parameters.AddWithValue("@mave", mak);
                            Cnnxoa.Open();
                            Cmd1.ExecuteNonQuery();
                            Response.Write("<script> alert('Xóa thành công!')</script>");
                        }
                        catch (Exception) { Response.Write("<script> alert('Không xóa được!')</script>"); }
                    HienVeTau();
                }//cnn
            }//xoa  


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
            HienVeTau();
        }


        protected void btnsua_Click(object sender, EventArgs e)
        {
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection cnn = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand("spVetau_Update", cnn))
                {
                    string strNgayban = Convert.ToDateTime(txtNgayban.Text).ToString("dd/MM/yyyy");
                    //string strNgaytra = Convert.ToDateTime(txtNgaytra.Text).ToString("dd/MM/yyyy");
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@mave", hdtest.Value);
                    cmd.Parameters.AddWithValue("@makh", ddKhach.SelectedValue);
                    cmd.Parameters.AddWithValue("@matau", ddtau.SelectedValue);
                    //cmd.Parameters.AddWithValue("@soluong", txtSoluong.Text);
                    cmd.Parameters.AddWithValue("@thanhtien", txtThanhtien.Text);
                    cmd.Parameters.AddWithValue("@matinhtrang", 1);
                    cmd.Parameters.Add("@ngayban", SqlDbType.DateTime);
                    //cmd.Parameters.Add("@ngaytra", SqlDbType.DateTime);
                    cmd.Parameters["@ngayban"].Value = strNgayban;
                    //cmd.Parameters["@ngayden"].Value = strNgaytra;
                    cmd.Parameters.AddWithValue("@malichtrinh", hdmalichtrinh.Value);
                    cmd.Parameters.AddWithValue("@matoa", ddToa.SelectedValue);
                    cmd.Parameters.AddWithValue("@maghe", ddGhe.SelectedValue);
                    cnn.Open();
                    cmd.ExecuteNonQuery();
                }
                cnn.Close();
            }
            lbSuccess.Text = "Sửa thành công";
            HienVeTau();
        }

        float total = 0;
        protected void grv_sp_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            int sl = this.grv_sp.Rows.Count;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblqy = (Label)e.Row.FindControl("lTTien");
                float qty = float.Parse(lblqy.Text);
                total = total + qty;
            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                Label lbSoluongve = (Label)e.Row.FindControl("lbSoluongve");
                Label lblTotalqty = (Label)e.Row.FindControl("lblTotalqty");
                lblTotalqty.Text = "Tổng tiền: " + total.ToString();
                lbSoluongve.Text = "Số lượng vé: " + sl.ToString();
            }
            /*Hide*/
            //e.Row.Cells[0].Visible = false;
            grv_sp.Columns[0].Visible = false;
            grv_sp.Columns[1].Visible = false;
            grv_sp.Columns[2].Visible = false;
            grv_sp.Columns[3].Visible = false;
            grv_sp.Columns[4].Visible = false;
            grv_sp.Columns[5].Visible = false;
            grv_sp.Columns[6].Visible = false;
            grv_sp.Columns[7].Visible = false;
            grv_sp.Columns[8].Visible = false;
            grv_sp.Columns[9].Visible = false;
            grv_sp.Columns[10].Visible = false;
            grv_sp.Columns[11].Visible = false;
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
                    HienVeTau();
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
                using (SqlCommand cmd = new SqlCommand("spVetau_Insert", cnn))
                {

                    string strNgayban = Convert.ToDateTime(txtNgayban.Text).ToString("dd/MM/yyyy");
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@mave", SqlDbType.Int).Direction = ParameterDirection.Output;
                    cmd.Parameters.AddWithValue("@makh", ddKhach.SelectedValue);
                    cmd.Parameters.AddWithValue("@matau", ddtau.SelectedValue);
                    cmd.Parameters.AddWithValue("@thanhtien", txtThanhtien.Text);
                    cmd.Parameters.AddWithValue("@matinhtrang", 1);
                    cmd.Parameters.Add("@ngayban", SqlDbType.DateTime);
                    cmd.Parameters["@ngayban"].Value = strNgayban;
                    cmd.Parameters.AddWithValue("@malichtrinh", hdmalichtrinh.Value);
                    cmd.Parameters.AddWithValue("@matoa", ddToa.SelectedValue);
                    cmd.Parameters.AddWithValue("@maghe", ddGhe.SelectedValue);
                    cnn.Open();
                    cmd.ExecuteNonQuery();
                }
                cnn.Close();

            }
            Capnhat("UPDATE tbltoaghe SET tinhtrangghe = '1' WHERE maghe='" + ddGhe.SelectedValue.Trim() + "'");
            lbSuccess.Text = "Nhập thành công";
            HienVeTau();
        }

        protected void ddtau_SelectedIndexChanged(object sender, EventArgs e)
        {
            String conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            SqlConnection con = new SqlConnection(conString);
            /*SqlCommand cmd = new SqlCommand();
            con.Open();
            cmd.CommandText = "select giatien from tbltau where matau = @mt";
            cmd.Parameters.AddWithValue("@mt", ddtau.SelectedValue);
            cmd.Connection = con;
            SqlDataReader rd = cmd.ExecuteReader();
            while (rd.Read())
            {
                txtGiatau.Text = rd["giatien"].ToString();
            }
            rd.Close();
            con.Close();*/
            String strQuery = "select giatien from tbltau where matau = @mt";
            SqlCommand cmd = new SqlCommand();
            cmd.Parameters.AddWithValue("@mt", ddtau.SelectedItem.Value);
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = strQuery;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    txtGiatau.Text = sdr["giatien"].ToString();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Vui lòng chọn tàu !')</script>");
                fillToa();
                txtGiatau.Text = "0";
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            fillToa();
            txtGiatoa.Text = "0";
            fillTinhtrang();
            tinhTien();
        }

        protected void ddToa_SelectedIndexChanged(object sender, EventArgs e)
        {
            String conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            SqlConnection con = new SqlConnection(conString);
            String strQuery = "select giatien from tbltoatau, tblloaitoa where tbltoatau.maloaitoa = tblloaitoa.maloaitoa and matoa = @mt";
            SqlCommand cmd = new SqlCommand();
            cmd.Parameters.AddWithValue("@mt", ddToa.SelectedItem.Value);
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = strQuery;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    txtGiatoa.Text = sdr["giatien"].ToString();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Vui lòng chọn toa hoặc tàu khác !')</script>");
                txtGiatoa.Text = "0";
                fillToa();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            fillGhe();
            tinhTien();
        }

        protected void ddKhach_SelectedIndexChanged(object sender, EventArgs e)
        {
            String conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            SqlConnection con = new SqlConnection(conString);
            String strQuery = "select phantramgiam from tblkhachhang, tblloaikhach where tblkhachhang.maloaikhach = tblloaikhach.maloaikhach and makh = @mk";
            SqlCommand cmd = new SqlCommand();
            cmd.Parameters.AddWithValue("@mk", ddKhach.SelectedItem.Value);
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = strQuery;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    txtPhantram.Text = sdr["phantramgiam"].ToString();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Vui lòng chọn khách')</script>");
                fillKhach();
                txtPhantram.Text = "0";
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            tinhTien();
        }

        protected void ddlGadi_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlGadi.Text == "Vui lòng chọn tàu khác!")
            {
                Response.Write("<script>alert('Vui lòng chọn ga đi !')</script>");
                fillGadi();
            }
            txtGialichtrinh.Text = "0";
            txtGiatoa.Text = "0";
            txtPhantram.Text = "0";
            txtThanhtien.Text = "0";
            txtGiatau.Text = "0";
            fillToa();
            fillKhach();
            fillGaden();
        }

        protected void ddlGaden_SelectedIndexChanged(object sender, EventArgs e)
        {
            String conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            SqlConnection con = new SqlConnection(conString);
            String strQuery = "select giatien, malichtrinh from tbllichtrinh where magadi = @gadi and magaden = @gaden";
            SqlCommand cmd = new SqlCommand();
            cmd.Parameters.AddWithValue("@gadi", ddlGadi.SelectedItem.Value);
            cmd.Parameters.AddWithValue("@gaden", ddlGaden.SelectedItem.Value);
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = strQuery;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    txtGialichtrinh.Text = sdr["giatien"].ToString();
                    hdmalichtrinh.Value = sdr["malichtrinh"].ToString();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Vui lòng chọn ga đi - ga đến !')</script>");
                txtGialichtrinh.Text = "0";
                hdmalichtrinh.Value = "";
                txtGiatau.Text = "0";
                txtGiatoa.Text = "0";
                fillGaden();
                fillTau();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            txtGiatoa.Text = "0";
            //txtPhantram.Text = "0";
            fillTau();
            fillToa();
            //fillKhach();
            tinhTien();
        }

        private void tinhTien()
        {
            float giatau = float.Parse(txtGiatau.Text);
            float gialichtrinh = float.Parse(txtGialichtrinh.Text);
            float giatoa = float.Parse(txtGiatoa.Text);
            float phantram = float.Parse(txtPhantram.Text);
            float thanhtien = (giatau + gialichtrinh + giatoa) * phantram;
            txtThanhtien.Text = thanhtien.ToString();
        }

        protected void txtSoluong_TextChanged(object sender, EventArgs e)
        {

        }

        protected void ddGhe_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}