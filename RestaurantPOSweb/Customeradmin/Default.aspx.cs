using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Customeradmin_Default : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString; 
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                txtname.Text = Request.Cookies["RPOSTKCookies"]["name"].ToString();
                txtphone.Text = Request.Cookies["RPOSTKCookies"]["phone"].ToString();
                txtaddress.Text = Request.Cookies["RPOSTKCookies"]["CustAddress"].ToString(); 
            }
        }
        catch
        {
            // Response.Redirect("~/public");
        }

    }

    protected void btnsave_Click(object sender, EventArgs e)
    {
        try
        { 
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RPOS_Update_Customer", cn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@name", txtname.Text);
            cmd.Parameters.AddWithValue("@phone", txtphone.Text); 
            cmd.Parameters.AddWithValue("@passowrd", txtPassoword.Text);
            cmd.Parameters.AddWithValue("@address",  txtaddress.Text);
            cmd.Parameters.AddWithValue("@id", Request.Cookies["RPOSTKCookies"]["accountno"].ToString());

            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();

            lblmsg.Visible = true;
            lblmsg.Text = "Updated!";
        }
        catch
        {

        }
    }
}