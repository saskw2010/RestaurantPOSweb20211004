using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class ItemList : System.Web.UI.Page
{
    String ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            loadUserList();
            txtSearch.Focus();
        }
    }

    //Datalits Item List
    protected void loadUserList()
    {
        try
        {
            SqlConnection con = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_Item_SR");
            cmd.Connection = con;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@category", "All");
            con.Open();

            DTusers.DataSource = cmd.ExecuteReader();
            DTusers.DataBind();
            con.Close();
        }
        catch
        {
        }
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {

        try
        {
            SqlConnection con = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_ItemSearch", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@value", txtSearch.Text);
            con.Open();
             
            DTusers.DataSource = cmd.ExecuteReader();
            DTusers.DataBind();
            con.Close();
        }
        catch
        {
        }
    }
}