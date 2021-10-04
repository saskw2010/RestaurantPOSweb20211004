using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class Bootstrap : System.Web.UI.MasterPage
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
	if (!IsPostBack)
        { 
			if (Request.Cookies["POSCookies"] != null)
			{
			    // lbDate.Text = DateTime.Now.ToString("ddd dd-MMM-yyyy hh:mm");
			  //  lblusername.Text = Request.QueryString["userID"];
			 

			    //For Multiple values in single cookie
			    string cookiesValues;
			    cookiesValues 			= Request.Cookies["POSCookies"]["UserID"];
			    cookiesValues 			= cookiesValues + " " + Request.Cookies["POSCookies"]["ShopID"];
			    lblusername.Text 		= Request.Cookies["POSCookies"]["UserID"];

			    string pageName = Page.Request.Url.Segments[Page.Request.Url.Segments.Length - 1];
			   UserRole(lblusername.Text, pageName);
			}
			else
			{
			   Response.Redirect("../Login.aspx", true);
			}
	}
     
    }

    protected void UserRole(string UserName, string PageName)
    {

        //User Role Page Access Permission
        string ChkExist = "";
        using (SqlConnection con = new SqlConnection(ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("SP_POS_UserRole_Access", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserName", UserName);
                cmd.Parameters.AddWithValue("@PageName", PageName);

                //outPut Parameter 
                cmd.Parameters.Add("@OutPut", SqlDbType.VarChar, 5).Direction = ParameterDirection.Output;

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                ChkExist = cmd.Parameters["@OutPut"].Value.ToString();
            }
        }

             //Access Yes or Not
                if ((String.Compare(ChkExist, "Y") == 0))
                {
                    //Access Allow
                }
                else
                {
                    //Access Deny
                    // lblusername.Text = "Access Deny";
                  Response.Redirect("~/ErrorPage/404.aspx");  
                }
    }

    protected void LinklogOut_Click(object sender, EventArgs e)
    {
     //   Session.Clear();
      ////  Response.Redirect("Login.aspx");

        if (Request.Cookies["POSCookies"] != null)
        {
            Response.Cookies["POSCookies"].Expires = DateTime.Now.AddDays(-1);
            Response.Redirect("../Login.aspx");  //to refresh the page
        }
    }
}
