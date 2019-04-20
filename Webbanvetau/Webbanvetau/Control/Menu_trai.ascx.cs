using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Webbanvetau.Control
{
    public partial class Menu_trai : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadTinh();
            caleNgaydi.SelectedDate = DateTime.Today;
        }

        protected void LoadTinh()
        {
            dropGadi.Items.Clear();
            dropGaden.Items.Clear();
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conString))
            {
                string cmdString = "Select * from tblloaikhach";
                using (SqlCommand cmd = new SqlCommand(cmdString, con))
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            ListItem imageItem = new ListItem();
                            imageItem.Value = dr["maloaikhach"].ToString();
                            imageItem.Text = dr["tenloaikhach"].ToString();
                            dropGaden.Items.Add(imageItem);
                        }
                        dr.Close();
                    }
                    else
                    {
                        //ListItem error = new ListItem();
                        //error.Text = "Lỗi";
                        //ddlNhomHang.Items.Add(error);
                    }
                }
                con.Close();
            }
        }

        protected void btTimKiem_Click(object sender, EventArgs e)
        {
            int gaden = 0;
            if (dropGaden.SelectedValue != "0")
            {
                gaden = int.Parse(dropGaden.SelectedValue);
                Response.Redirect("~/AoBeGai.aspx?id=" + gaden);
            }
            else
            {
                Response.Redirect("~/AoBeGai.aspx?id=");
            }
        }
    }
}