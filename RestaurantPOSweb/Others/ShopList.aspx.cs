using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Settings_ShopList : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ShopIdListDataBind();
            lblmsg.Visible = false;            
        }
    }


    public void ShopIdListDataBind()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_TerminalList", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();

            grdShopList.DataSource = cmd.ExecuteReader();
            grdShopList.EmptyDataText = "No Records Found";
            grdShopList.DataBind();
            cn.Close();
            lbtotalRow.Text = "Total : " + Convert.ToString(grdShopList.Rows.Count) + " Records found" + "<br />";
        }
        catch
        {
            lbtotalRow.Text = "No Records Found";
        }
    }


    // /////// open popup window Add Terminal 
    protected void btnShopLink_Click(object sender, EventArgs e)
    {
        //  txtCategory.Text = string.Empty;
        lblmsg.Visible = false;
        txtTerminalID.Focus();
        this.MpeAddCategoryShow.Show();
    }


    // /////// Add Terminal 
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {  
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_Add_Terminal", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@TerminalID",      txtTerminalID.Text);
            cmd.Parameters.AddWithValue("@Location",        txtLocation.Text);
            cmd.Parameters.AddWithValue("@Phone",           txtPhone.Text);
            cmd.Parameters.AddWithValue("@EmailAddress",    txtEmailAddress.Text);
            cmd.Parameters.AddWithValue("@VatRate",         txtVatRate.Text);
            cmd.Parameters.AddWithValue("@VATRegistration", txtVATRegistration.Text);
            cmd.Parameters.AddWithValue("@logby",           Request.Cookies["POSCookies"]["UserID"].ToString());
            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();

            lblmsg.Visible = true;
            txtTerminalID.Text = string.Empty;
            lblmsg.Text = "Successfully Inserted";
            ShopIdListDataBind();            
            this.MpeAddCategoryShow.Show();

        }
        catch
        {
            lblmsg.Visible = true;
            lblmsg.Text = "Error";
        }
    }

    /// ////    Open Terminal Delete popup window  
    protected void LinkDelete_Click(object sender, EventArgs e)
    {
       
        try
        {
            LinkButton Linkdetails = sender as LinkButton;
            GridViewRow gvrow = (GridViewRow)Linkdetails.NamingContainer;

            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_Delete_Terminal", cn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@TerminalID", gvrow.Cells[1].Text);

            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
            ShopIdListDataBind();
            lbtotalRow.ForeColor = System.Drawing.Color.Red;
            lbtotalRow.Text = "Deleted";
            
        }
        catch
        {

            lbtotalRow.Text = "Error";
        }
    }

   
}