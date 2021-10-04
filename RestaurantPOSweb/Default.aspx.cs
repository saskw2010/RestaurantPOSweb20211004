using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxControlToolkit;
using System.Text;

public partial class _Default : Page
{
   // List<string> lv = new List<string>();
    String ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    DataTable table = new DataTable();
    String sauceoptions;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        { 
            try
            {   
                 
                loadItemList(); 
                txtSearch.Focus();      
    
 
            }
            catch
            {

            }
   
        }
    }
    
   

    protected void lnkCategory_Onclick(object sender, EventArgs e)
    {
        try
        {
            LinkButton btn = sender as LinkButton;
            DataListItem item = (DataListItem)btn.NamingContainer;
            Label lblcategid = (Label)item.FindControl("lblcategid");
            Label lblcategory = (Label)item.FindControl("lblcategory");

            txtSearch.Text = lblcategory.Text;
           // Categoryfilter(lblcategid.Text);

            SqlConnection con = new SqlConnection(ConnectionString);
            string sql = "";
            if (lblcategid.Text == "ALL")
            {
                sql = " select top 12 * from purchase ";
            }
            else
            {
                sql = " select top 15 * from purchase where category like '" + lblcategid.Text + "%' ";
            }
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Connection = con;
            con.Open();
             
            dtlistgrid.Visible = true;
            dtlistgrid.DataSource = cmd.ExecuteReader();
            dtlistgrid.DataBind();
            con.Close();

        }
        catch
        {
        }

    }
 

    //Datalist  Item List
    protected void loadItemList()
    {
        try
        {
            SqlConnection con = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_Item_public");
            cmd.Connection = con;
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();

            dtlistgrid.DataSource = cmd.ExecuteReader();
            dtlistgrid.DataBind();
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
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_Item_public_search");
            cmd.Connection = con;
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            cmd.Parameters.AddWithValue("@value", txtSearch.Text);

            //dtlistgrid.Visible = false;  
            //dtlisthoristyle.Visible = true;
            //dtlisthoristyle.DataSource = cmd.ExecuteReader();
            //dtlisthoristyle.DataBind(); 

            dtlistgrid.DataSource = cmd.ExecuteReader();
            dtlistgrid.DataBind();
            con.Close();
            txtSearch.Focus();
        }
        catch
        {
            // DTusers.Visible = true;
        }
    }
     
    protected void btnviewmore_click(object sender, EventArgs e)
    {
        string number = DateTime.Now.ToString("yyyyMMddhhmmss");
        Response.Redirect("~/itemmoreview.aspx?Customerinquiry=" + number, false);
    }
     
   
}