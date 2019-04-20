using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.MobileControls;
using System.Web.UI.WebControls;

namespace Webbanvetau.App_Code
{
    public class myfunction
    {
        public string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
        public SortedList param = new SortedList();
        //DataTable dt = new DataTable();
        //SqlDataAdapter da = new SqlDataAdapter();
        public void fillDropdownList(DropDownList listItem, string sql,string pValue,string pText,string defaultValue)
        {
            listItem.Items.Clear();
            listItem.Items.Add(defaultValue);
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            ListItem iItem = new ListItem();
                            iItem.Value = dr[pValue].ToString();
                            iItem.Text = dr[pText].ToString();
                            listItem.Items.Add(iItem);
                        }
                        dr.Close();
                    }
                    else
                    {
                        ListItem error = new ListItem();
                        error.Text = "Không có dữ liệu!";
                        listItem.Items.Add(error);
                    }
                    con.Close();
                }
            }
        }

        public void showByGrid(GridView gv,string sql)
        {
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlCommand Cmd = new SqlCommand(sql, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(Cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gv.DataSource = dt;
                        gv.DataBind();
                    }
                }
            }
            
        }

        public bool exeProc(string proc, SortedList param)
        {
            int i;
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlCommand Cmd1 = new SqlCommand(proc, con))
                    try
                    {
                        Cmd1.CommandType = CommandType.StoredProcedure;
                        if (param != null)
                        {
                            for (i = 0; i < param.Count; i++)
                            {
                                Cmd1.Parameters.AddWithValue(param.GetKey(i).ToString(), param.GetByIndex(i));
                            }
                        }
                        con.Open();
                        Cmd1.ExecuteNonQuery();
                        return true;
                    }
                    catch (Exception e)
                    {
                        return false;
                    }
                    finally
                    {
                        con.Close();
                        con.Dispose();
                    }
            }
        }

        public bool exeProcToShow(string proc, GridView gv, SortedList param)
        {
            int i;
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlCommand Cmd1 = new SqlCommand(proc, con))
                    try
                    {
                        Cmd1.CommandType = CommandType.StoredProcedure;
                        if (param != null)
                        {
                            for (i = 0; i < param.Count; i++)
                            {
                                Cmd1.Parameters.AddWithValue(param.GetKey(i).ToString(), param.GetByIndex(i));
                            }
                        }
                        con.Open();
                        Cmd1.ExecuteNonQuery();
                        using (SqlDataAdapter da = new SqlDataAdapter(Cmd1))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);
                            if (dt.Rows.Count >0)
                            {
                                gv.DataSource = dt;
                                gv.DataBind();

                            }
                            else return false;
                        
                        }
                        return true;
                    }
                    catch (Exception e)
                    {
                        return false;
                    }
                    finally
                    {
                        con.Close();
                        con.Dispose();
                    }
            }
        }

        public string exeProcToShow2(string proc, GridView gv, SortedList param)
        {
            int i;
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlCommand Cmd1 = new SqlCommand(proc, con))
                    try
                    {
                        Cmd1.CommandType = CommandType.StoredProcedure;
                        if (param != null)
                        {
                            for (i = 0; i < param.Count; i++)
                            {
                                Cmd1.Parameters.AddWithValue(param.GetKey(i).ToString(), param.GetByIndex(i));
                            }
                        }
                        con.Open();
                        Cmd1.ExecuteNonQuery();
                        using (SqlDataAdapter da = new SqlDataAdapter(Cmd1))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);
                            gv.DataSource = dt;
                            gv.DataBind();
                            if (dt.Rows.Count > 0)
                            {
                                return dt.Rows.Count.ToString();
                            }
                            else return "0";
                          

                        }
                    }
                    catch (Exception e)
                    {
                        return "0";
                    }
                    finally
                    {
                        con.Close();
                        con.Dispose();
                    }
            }
        }



    }
}