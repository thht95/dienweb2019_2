using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Webbanvetau
{
    public partial class Admin1 : System.Web.UI.Page
    {
        string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
        DataTable dt = new DataTable();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            Getvetau();
            /*ToTalLoaiTin();
            ToTalTour();
            ToTalTinh();
            ToTalTin();
            ToTalLienHe();
            ToTalVe();
            ToTalQC();*/
        }

        private void Getvetau()
        {
            SqlConnection cnn = new SqlConnection(conString);
            cnn.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("Select count(*) from tblvetau", cnn);
            sqlDa.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                lbToTalMenu.Text = Convert.ToString(dt.Rows[0].ItemArray[0]);
            }
            cnn.Close();
        }

        private void ToTalMenu()
        {
            SqlConnection cnn = new SqlConnection(conString);
            cnn.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("Select count(*) from tblvetau", cnn);
            sqlDa.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                lbToTalMenu.Text = Convert.ToString(dt.Rows[0].ItemArray[0]);
            }
            cnn.Close();
        }

        /*
        public void ToTalMenu()
        {
            
            SqlCommand cmd = new SqlCommand("spGa_Insert", cnn);
            DataTable dt = Database.ExecuteQuery("Select count(*) from menu");
            lbToTalMenu.Text = Convert.ToString(dt.Rows[0].ItemArray[0]);
        }
        public void ToTalLoaiTin()
        {
            DataTable dt1 = Database.ExecuteQuery("Select count(*) from loaitin");
            lbToTalLoaiTin.Text = Convert.ToString(dt1.Rows[0].ItemArray[0]);
        }
        public void ToTalTour()
        {
            DataTable dt2 = Database.ExecuteQuery("Select count(*) from tour");
            lbToTalTour.Text = Convert.ToString(dt2.Rows[0].ItemArray[0]);
        }
        public void ToTalTinh()
        {
            DataTable dt3 = Database.ExecuteQuery("Select count(*) from tinh");
            lbToTalTinh.Text = Convert.ToString(dt3.Rows[0].ItemArray[0]);
        }
        public void ToTalTin()
        {
            DataTable dt4 = Database.ExecuteQuery("Select count(*) from tin");
            lbToTalTin.Text = Convert.ToString(dt4.Rows[0].ItemArray[0]);
        }
        public void ToTalLienHe()
        {
            DataTable dt5 = Database.ExecuteQuery("Select count (*) from lienhe");
            lbToTalLienHe.Text = Convert.ToString(dt5.Rows[0].ItemArray[0]);
        }
        public void ToTalVe()
        {
            DataTable dt6 = Database.ExecuteQuery("Select count (*) from dattour");
            lbToTalVeDat.Text = Convert.ToString(dt6.Rows[0].ItemArray[0]);
        }
        public void ToTalQC()
        {
            DataTable dt7 = Database.ExecuteQuery("Select count (*) from quangcao");
            lbToTalQC.Text = Convert.ToString(dt7.Rows[0].ItemArray[0]);
        }*/
    }
}