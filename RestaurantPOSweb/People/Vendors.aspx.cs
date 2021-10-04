using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Vendors : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            VendorsListDataBind();
            lblmsg.Visible = false;            
        }
    }


    public void VendorsListDataBind()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RPOS_Databind_Vendors", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();

            grdCategoryList.DataSource = cmd.ExecuteReader();
            grdCategoryList.EmptyDataText = "No Records Found";
            grdCategoryList.DataBind();
            cn.Close();
            lbtotalRow.Text = "Total : " + Convert.ToString(grdCategoryList.Rows.Count) + " Results" + "<br />";
        }
        catch
        {
            lbtotalRow.Text = "No Records Found";
        }
    }


    // /////// open popup window Add Category 
    protected void btnCategoryLink_Click(object sender, EventArgs e)
    {
        //  txtCategory.Text = string.Empty;
        lblmsg.Visible = false;
        txtVendor.Focus();
        this.MpeAddCategoryShow.Show();
    }


    // /////// Add vendor 
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RPOS_Add_vendor", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@vendorname", txtVendor.Text); 
            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
            lblmsg.Visible = true;
            lblmsg.Text = "Successfully Inserted";
            VendorsListDataBind(); 
        }
        catch
        {
            lblmsg.Visible = true;
            lblmsg.Text = "Error";
        }
    }

    /// ////    Open vendor Delete   
    protected void LinkDelete_Click(object sender, EventArgs e)
    {
       
        try
        {
            LinkButton Linkdetails = sender as LinkButton;
            GridViewRow gvrow = (GridViewRow)Linkdetails.NamingContainer;

            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RPOS_Delete_vendor", cn);
            cmd.CommandType = CommandType.StoredProcedure;           

            cmd.Parameters.AddWithValue("@ID", gvrow.Cells[1].Text);

            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
            VendorsListDataBind();
            lbtotalRow.ForeColor = System.Drawing.Color.Red;
            lbtotalRow.Text = "Deleted";
            
        }
        catch
        {

            lbtotalRow.Text = "Error";
        }
    }

   
}