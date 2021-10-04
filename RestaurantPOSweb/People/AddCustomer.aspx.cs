using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class AddCustomer : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtCustName.Focus();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_Insert_Customers", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();

            cmd.Parameters.AddWithValue("@CustName", txtCustName.Text );
            cmd.Parameters.AddWithValue("@CustPhone", txtCustPhone.Text);
            cmd.Parameters.AddWithValue("@CustEmail", txtCustEmail.Text);
            cmd.Parameters.AddWithValue("@CustAddress", txtCustAddress.Text); 
            cmd.Parameters.AddWithValue("@CustType", DDLCustType.Text);
            cmd.Parameters.AddWithValue("@DiscountRate", "3");
            cmd.Parameters.AddWithValue("@passoword", txtPassoword.Text);
            cmd.Parameters.AddWithValue("@LogBy", Request.Cookies["POSCookies"]["UserID"].ToString());           
            cmd.ExecuteNonQuery();
            cn.Close();

            lblMessage.Text = "Successfully Saved";

            //Move to Customer List Page
            Response.Redirect("~/People/ManageCustomers.aspx");

        }
        catch
        {
            lblMessage.Text = "No Records Found";
        }
      
    }


}